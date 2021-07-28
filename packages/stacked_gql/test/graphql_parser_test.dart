import 'package:flutter_test/flutter_test.dart';
import 'package:stacked_gql/src/graph_ql_result_type.dart';
import 'package:stacked_gql/stacked_gql.dart';
import 'app_models.dart';
import 'fake_data.dart';
import 'type_converters.dart';

void main() {
  group('GraphQLResultParser', () {
    group('parseResponse -', () {
      test(
          'When GQL response has requested data should returned serialised response',
          () {
        var parser =
            GraphQLResponseParser(mapTypeConverters: maptypeConverters);
        var result = parser.parseSingleResponse<Company>(company['data']);
        expect(Company.fromJson(company['data']), result);
      });

      test('Post - When posts response should serialise all posts properly',
          () {
        var parser =
            GraphQLResponseParser(mapTypeConverters: maptypeConverters);
        var result = parser.parseListResponse<Post>(postLits['data']);
        expect(result.isNotEmpty, true);
      });

      test(
          'When GQL response data is paginated serialise edge nodes as list of Type',
          () {
        var parser =
            GraphQLResponseParser(mapTypeConverters: maptypeConverters);
        var result = parser.parseListResponse<Album>(albums['data']);
        expect([
          Album.fromJson(albums['data']['albums']['edges'][0]['node']),
          Album.fromJson(albums['data']['albums']['edges'][1]['node']),
        ], result);
      });
    });

    group('determinQueryType -', () {
      test('Given a non query request, return Plain as query type', () {
        var parser =
            GraphQLResponseParser(mapTypeConverters: maptypeConverters);
        var result = parser.determineQueryType(company['data']);
        expect(result, GqlResultType.Plain);
      });
      test('Given a paged query result, return PaginatedQuery as query type',
          () {
        var parser =
            GraphQLResponseParser(mapTypeConverters: maptypeConverters);
        var result = parser.determineQueryType(albums['data']);
        expect(result, GqlResultType.PaginatedQuery);
      });
      test('Given a plain query result, return PlainQuery as query type', () {
        var parser =
            GraphQLResponseParser(mapTypeConverters: maptypeConverters);
        var result = parser.determineQueryType(posts['data']);
        expect(result, GqlResultType.PlainQuery);
      });

      test(
          'Given a plan query list result, return PlainQueryList as query type',
          () {
        var parser =
            GraphQLResponseParser(mapTypeConverters: maptypeConverters);
        var result = parser.determineQueryType(postLits['data']);
        expect(result, GqlResultType.PlainQueryList);
      });
    });
  });
}
