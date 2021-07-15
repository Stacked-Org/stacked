import 'package:flutter/foundation.dart';
import 'graph_ql_result_type.dart';

typedef StringTypeConverters = Map<Type, dynamic Function(String)>;
typedef MapTypeConverters = Map<Type, dynamic Function(Map<String, dynamic>)>;

/// A parser that contains helper functions for turning your graphQL response into domain specific models
class GraphQLResponseParser {
  final MapTypeConverters mapTypeConverters;
  final StringTypeConverters? stringTypeConverters;

  const GraphQLResponseParser({
    this.mapTypeConverters = const {},
    this.stringTypeConverters,
  });

  /// Takes in a raw GraphQL Query and seriealises it to the type passed in.
  T parseSingleResponse<T>(Map<String, dynamic>? data) {
    var typeConverter = mapTypeConverters[T];

    if (typeConverter == null) {
      throw Exception(
          'No type converter defined for $T register one in GraphQLResponseParser');
    }

    if (data == null) {
      throw Exception('Data to parse cannot be null');
    }

    data = typeNameRemover(data);

    var dataType = determineQueryType(data);

    switch (dataType) {
      case GqlResultType.PlainQuery:
        return typeConverter(data[data.keys.first]) as T;
      case GqlResultType.Plain:
      default:
        return typeConverter(data) as T;
    }
  }

  /// Takes in a raw GraphQl ressponse and parses it into a list of results of [T]
  List<T> parseListResponse<T>(data) {
    data = typeNameRemover(data);

    var mapTypeConverter = mapTypeConverters[T];
    var stringTypeConverter = stringTypeConverters?[T];

    if (mapTypeConverter == null && stringTypeConverter == null) {
      throw Exception(
          'No type converter defined for $T register one in GraphQLResponseParser');
    }

    var dataType = determineQueryType(data);

    switch (dataType) {
      case GqlResultType.PaginatedQuery:
        var edges = data[data.keys.first]['edges'];
        List<T> results = [];
        for (var edge in edges) {
          var node = edge['node'];
          results.add(mapTypeConverter?.call(node) as T);
        }
        return results;
      case GqlResultType.PlainQueryList:
      default:
        var resultsAsList = data[data.keys.first] as List;
        List<T> results = [];
        for (var result in resultsAsList) {
          final convertedValue = mapTypeConverter != null
              ? mapTypeConverter(result) as T
              : stringTypeConverter!(result) as T;

          results.add(convertedValue);
        }
        return results;
    }
  }

  @visibleForTesting
  GqlResultType determineQueryType(Map<String, dynamic> data) {
    var isQueryResponse = _checkIfQuery(data);

    if (isQueryResponse) {
      var isPaginated =
          (data[data.keys.first] as Map<String, dynamic>).containsKey('edges');
      if (isPaginated) {
        return GqlResultType.PaginatedQuery;
      }
      return GqlResultType.PlainQuery;
    }

    var isListQuery = _checkIfListQuery(data);
    if (isListQuery) {
      return GqlResultType.PlainQueryList;
    }

    return GqlResultType.Plain;
  }

  Map<String, dynamic> typeNameRemover(Map<String, dynamic> data) {
    if (data.containsKey('__typename')) {
      data.removeWhere((key, value) => key == '__typename');
      return data;
    } else {
      return data;
    }
  }

  /// A response from a query will always have at the least the first child as the map
  /// with the actual response. If it's not a map it's most likely not a query
  bool _checkIfQuery(Map<String, dynamic> data) {
    try {
      // ignore: unnecessary_statements
      (data[data.keys.first] as Map<String, dynamic>?);
      return true;
    } catch (_) {
      return false;
    }
  }

  bool _checkIfListQuery(Map<String, dynamic> data) {
    try {
      // ignore: unnecessary_statements
      (data[data.keys.first] as List?);
      return true;
    } catch (_) {
      return false;
    }
  }

  bool _mutationResponseIsUnderMutationName(Map<String, dynamic> data) {
    try {
      // ignore: unnecessary_statements
      (data[data.keys.first] as Map?);
      return true;
    } catch (_) {
      return false;
    }
  }

  /// Parses a response from a mutation and returns a clean version of the data without
  /// __typename. We also return only the data under the mutation name key.
  Map<String, dynamic> parseMutationResponse(Map<String, dynamic> data) {
    data = typeNameRemover(data);
    if (_mutationResponseIsUnderMutationName(data)) {
      return data[data.keys.first];
    }

    return data;
  }
}
