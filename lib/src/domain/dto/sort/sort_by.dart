enum SortBy {
  publishedDate("publishedAt"),
  popularity("popularity"),
  relevancy("relevancy");

  final String value;

  const SortBy(this.value);
}
