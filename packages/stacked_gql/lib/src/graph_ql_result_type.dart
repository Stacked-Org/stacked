enum GqlResultType {
  /// When the results returned is at the root of the data child
  Plain,

  /// when the result returned is in a child with the query as the title
  PlainQuery,

  // When the result returned as the query title is a list of objects
  PlainQueryList,

  /// When the result returned has edges and nodes for traversal
  PaginatedQuery,
}
