import 'package:flutter/material.dart';
import 'package:smart_sfv_mobile/views/components/MyText.dart';

class MyDataTable extends StatefulWidget {
  final List<String> columns;
  final List<List<String>> rows;
  MyDataTable({
    Key? key,
    required this.columns,
    this.rows = const [],
  }) : super(key: key);
  @override
  MyDataTableState createState() => MyDataTableState();
}

class MyDataTableState extends State<MyDataTable> {
  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: [
        // Generate column in function on the columns list length
        for (var column in widget.columns)
          DataColumn(
            label: MyText(
              text: column,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
      ],
      rows: [
        // ? Iterate all rows
        for (var row in widget.rows)
          DataRow(
            cells: [
              // ? Iterate all cells
              for (var cell in row)
                DataCell(
                  MyText(
                    text: cell,
                    fontSize: 14,
                  ),
                ),
            ],
          ),
      ],
    );
  }
}
