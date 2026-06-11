class ReusableTableRow {
  final List<String> cells;
  final String? expandedTitle;
  final String? expandedDescription;

  ReusableTableRow({
    required this.cells,
    this.expandedTitle,
    this.expandedDescription,
  });
}
