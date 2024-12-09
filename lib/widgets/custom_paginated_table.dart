import 'package:flutter/material.dart';
import 'package:paginatedtable_example/utils/app_colors.dart';
import 'package:paginatedtable_example/widgets/data_table_content_component.dart';
import 'package:paginatedtable_example/widgets/data_table_header_component.dart';

class CustomPaginatedTable extends StatefulWidget {
  final List<Map<String, dynamic>> columns;
  final List<dynamic> data;
  final int currentPage;
  final int totalDataCount;
  final bool sortAscending;
  final int? sortColumnIndex;
  final int rowsPerPage;
  final String Function(dynamic, int) getCellValue;
  final Widget Function(dynamic, int)? getCellValueForAction;
  final Future<void> Function(int)? onNewPageFetched;
  final void Function(int) onPageChanged;
  final Function(int?)? onRowsPerPageChanged;
  final Function(int, bool)? onSort;
  const CustomPaginatedTable(
      {super.key,
      required this.columns,
      required this.data,
      // this.showAction,
      required this.totalDataCount,
      required this.rowsPerPage,
      required this.getCellValue,
      this.getCellValueForAction,
      this.onNewPageFetched,
      required this.currentPage,
      required this.onPageChanged,
      this.onRowsPerPageChanged,
      this.sortAscending = true,
      this.sortColumnIndex,
      this.onSort});

  @override
  State<CustomPaginatedTable> createState() => _CustomPaginatedTableState();
}

class _CustomPaginatedTableState extends State<CustomPaginatedTable> {
  late CustomPaginatedTableSource source;

  @override
  void initState() {
    source = CustomPaginatedTableSource(
      columns: widget.columns,
      data: widget.data,
      getCellValue: widget.getCellValue,
      getCellValueForAction: widget.getCellValueForAction,
      totalDataCount: widget.totalDataCount,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          cardTheme: const CardTheme(
            elevation: 0,
            color: AppColors.whiteColor,
          ),
          dividerTheme:
              const DividerThemeData(color: Colors.transparent, thickness: 0.5),
          dataTableTheme: DataTableThemeData(
              dataRowColor: WidgetStateProperty.all(AppColors.whiteColor))),
      child: PaginatedDataTable(
        initialFirstRowIndex: (widget.currentPage - 1) * widget.rowsPerPage,
        rowsPerPage: widget.data.length < widget.rowsPerPage
            ? widget.data.length
            : widget.rowsPerPage,
        availableRowsPerPage: const [10, 20, 50, 100],
        onRowsPerPageChanged: widget.onRowsPerPageChanged,
        sortAscending: widget.sortAscending,
        sortColumnIndex: widget.sortColumnIndex,
        onPageChanged: (pageStartIndex) {
          int page = (pageStartIndex ~/ widget.rowsPerPage) + 1;
          if (pageStartIndex == widget.data.length) {
            widget.onNewPageFetched!(page);
          } else {
            widget.onPageChanged(page);
          }
        },
        columns: [
          for (int i = 0; i < widget.columns.length; i++)
            DataColumn(
              onSort: widget.onSort,
              label: DataTableHeaderComponent(
                headerTitle: widget.columns[i]['headerTitle'],
                width: widget.columns[i]['headerWidth'],
                isCenter: widget.columns[i]["center"] ?? false,
                isTopLeftRound: (i == 0) ? true : false,
                isTopRightRound:
                    (i == widget.columns.length - 1) ? true : false,
              ),
            ),
        ],
        source: source,
      ),
    );
  }
}

class CustomPaginatedTableSource extends DataTableSource {
  late List<Map<String, dynamic>> _columns;
  late List<dynamic> _data;
  late String Function(dynamic, int) _getCellValue;
  late Widget Function(dynamic, int)? _getCellValueForAction;
  late int _totalDataCount;

  CustomPaginatedTableSource({
    required List<Map<String, dynamic>> columns,
    required List<dynamic> data,
    required String Function(dynamic, int) getCellValue,
    required Widget Function(dynamic, int)? getCellValueForAction,
    required int totalDataCount,
  }) {
    _columns = columns;
    _data = data;
    _getCellValue = getCellValue;
    _getCellValueForAction = getCellValueForAction;
    _totalDataCount = totalDataCount;
  }

  @override
  DataRow? getRow(int index) {
    return DataRow.byIndex(index: index, cells: [
      for (int i = 0; i < _columns.length; i++)
        (_columns[i]["action"] ?? false)
            ? DataCell(_getCellValueForAction!(_data[index], i))
            : DataCell(DataTableContentComponent1(
                width: _columns[i]["headerWidth"],
                contentText: _getCellValue(_data[index], i),
                toolTipText: _getCellValue(_data[index], i),
              ))
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _totalDataCount;

  @override
  int get selectedRowCount => 0;
}
