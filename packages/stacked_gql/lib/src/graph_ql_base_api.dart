import 'package:graphql/client.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:logger/logger.dart';

import 'graph_ql_parser.dart';

abstract class GraphQlBaseApi {
  GraphQLClient get client;
  GraphQLResponseParser get responseParser;
  Logger? get baseLogger => null;

  Future<bool> ensureAuthCookieIsSet();

  /// Runs a GqlQuery and parses the response with the assumption of it being a single
  /// result and NOT a collection. For fetching and parsing a collection use [runGqlListQuery]
  Future<RT> runGqlQuery<RT>({
    required String query,
    String? actionName,
    bool logResponseData = false,
    Map<String, dynamic> variables = const {},
    Function(QueryResult response)? onRawResponse,
  }) async {
    return _runGQLRequest<RT>(
      query: query,
      parseData: (data) => responseParser.parseSingleResponse<RT>(data),
      actionName: actionName,
      variables: variables,
      logResponseData: logResponseData,
      onRawResponse: onRawResponse,
    );
  }

  /// Runs a gql query and parses the response with the assumption that it will return a
  /// list of information.
  ///
  /// The list can be in 1 of two forms:
  /// - [GqlResultType.PaginatedQuery]: This provides you with a response structure contains edges
  /// with the nodes being the actual objects
  /// - [GqlResultType.PlainQueryList]: This is a response where the first entry in the data object
  /// is the list of results.
  Future<List<RT>> runGqlListQuery<RT>({
    required String query,
    String? actionName,
    bool logResponseData = false,
    Map<String, dynamic> variables = const {},
    Function(QueryResult response)? onRawResponse,
  }) async {
    return _runGQLRequest<List<RT>>(
      query: query,
      parseData: (data) => responseParser.parseListResponse<RT>(data),
      actionName: actionName,
      logResponseData: logResponseData,
      variables: variables,
      onRawResponse: onRawResponse,
    );
  }

  Future<T> _runGQLRequest<T>({
    required String query,
    required T Function(Map<String, dynamic>?) parseData,
    String? actionName,
    bool logResponseData = false,
    Map<String, dynamic> variables = const {},
    Function(QueryResult response)? onRawResponse,
  }) async {
    final functionIdentity = actionName ?? query;
    if (await (ensureAuthCookieIsSet())) {
      baseLogger?.v('REQUEST:$actionName - query:$query');
      var response = await client.query(
        QueryOptions(
          document: gql(query),
          variables: variables,
          fetchPolicy: FetchPolicy.networkOnly,
          cacheRereadPolicy: CacheRereadPolicy.ignoreAll,
        ),
      );
      onRawResponse?.call(response);
      baseLogger?.v(
          'RESPONSE:$actionName - hasData: ${response.data != null} ${logResponseData ? "data:${response.data}" : ''}');

      if (!response.hasException) {
        try {
          return parseData(response.data);
        } catch (e, stacktrace) {
          baseLogger?.e('$functionIdentity failed: $e');

          return Future.error(GraphQlException(
            message: e.toString(),
            query: query,
            queryName: functionIdentity,
            stackTrace: stacktrace,
          ));
        }
      } else {
        return Future.error(_getErrorExceptionFromResponse(
          functionIdentity: functionIdentity,
          mutation: query,
          response: response,
        ));
      }
    } else {
      var error = 'Cookies are invalid';
      baseLogger?.e(error);
      return Future.error(GraphQlException(
        message: error,
        query: query,
        queryName: functionIdentity,
      ));
    }
  }

  Future<T> runGqlMutation<T>({
    required String mutation,
    required T Function(Map<String, dynamic>?) parseData,
    Map<String, dynamic> variables = const {},
    String? actionName,
    bool logResponseData = false,
    Function(QueryResult response)? onRawResponse,
  }) async {
    final functionIdentity = actionName ?? mutation;
    if (await (ensureAuthCookieIsSet())) {
      final MutationOptions options = MutationOptions(
        document: gql(mutation),
        variables: variables,
        cacheRereadPolicy: CacheRereadPolicy.ignoreAll,
      );

      final QueryResult response = await client.mutate(options);
      onRawResponse?.call(response);

      baseLogger?.v(
          'RESPONSE:$actionName - hasData: ${response.data != null} ${logResponseData ? "data:${response.data}" : ''}');

      if (!response.hasException) {
        try {
          baseLogger?.i(response.data!);
          final data = responseParser.parseMutationResponse(response.data!);
          return parseData(data);
        } catch (e, stackTrack) {
          baseLogger?.e('$functionIdentity failed: $e');

          return Future.error(GraphQlException(
            message: e.toString(),
            query: mutation,
            queryName: functionIdentity,
            stackTrace: stackTrack,
          ));
        }
      } else {
        if (response.exception != null) {
          return Future.error(_getErrorExceptionFromResponse(
            functionIdentity: functionIdentity,
            mutation: mutation,
            response: response,
          ));
        }

        return Future.error(
          GraphQlException(
            message: 'Unkown error has occured',
            query: mutation,
            queryName: functionIdentity,
            stackTrace: StackTrace.current,
          ),
        );
      }
    } else {
      var error = 'Cookies are invalid';
      baseLogger?.e(error);
      return Future.error(GraphQlException(
        message: error,
        query: mutation,
        queryName: functionIdentity,
      ));
    }
  }

  GraphQlException _getErrorExceptionFromResponse({
    required QueryResult response,
    required String functionIdentity,
    required String mutation,
  }) {
    final gqlException = response.exception!;
    var finalErrorMessage = '';

    if (gqlException.linkException != null) {
      finalErrorMessage +=
          'CLIENT_EXCEPTION: ${gqlException.linkException.toString()}\n';
    }

    if (gqlException.graphqlErrors.isNotEmpty) {
      for (final gqlError in gqlException.graphqlErrors) {
        var statusCode = 0;
        var extentionError;
        final errorMessage = gqlError.message;

        if (gqlError.extensions != null) {
          statusCode = gqlError.extensions!['code'] ?? 0;
          extentionError = gqlError.extensions!['error'];
        }
        baseLogger?.e(
            '$functionIdentity: StatusCode:$statusCode - $errorMessage, ${extentionError ?? ''}');

        finalErrorMessage = errorMessage;
        baseLogger?.v(finalErrorMessage);
      }
    }

    return GraphQlException(
      message: finalErrorMessage,
      query: mutation,
      queryName: functionIdentity,
      response: response.data,
      stackTrace: StackTrace.current,
    );
  }
}

class GraphQlException implements Exception {
  final String message;
  final String? query;
  final String? queryName;
  final StackTrace? stackTrace;
  final Map<String, dynamic>? response;

  GraphQlException({
    required this.message,
    this.stackTrace,
    this.query,
    this.queryName,
    this.response,
  });

  @override
  String toString() {
    return 'GraphQlException: $message\nqueryName:$queryName\nquery:$query\stackTrace:$stackTrace\nresponse:$response';
  }
}
