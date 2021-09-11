import 'package:flutter/material.dart';
import 'package:smartsfv/views/components/MyText.dart';

class MyDataTable extends StatefulWidget {
  final List<String> columns;
  final List<List<String>> rows;
  static int? selectedRowIndex;
  final bool? hasRowSelectable;
  final void Function()? onCellLongPress;
  MyDataTable({
    Key? key,
    required this.columns,
    this.rows = const [],
    this.onCellLongPress,
    this.hasRowSelectable,
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
            selected: (widget.hasRowSelectable != null &&
                    widget.hasRowSelectable! &&
                    MyDataTable.selectedRowIndex != null &&
                    MyDataTable.selectedRowIndex == widget.rows.indexOf(row))
                ? true
                : false,
            cells: [
              // ? Iterate all cells
              for (var cell in row)
                DataCell(
                  MyText(
                    text: cell,
                    fontSize: 14,
                  ),
                  onLongPress: () {
                    if (widget.hasRowSelectable != null &&
                        widget.hasRowSelectable!)
                      setState(() {
                        // ? Set selected row index
                        MyDataTable.selectedRowIndex = widget.rows.indexOf(row);
                        print("Index du tableau sélectionné -> " +
                            MyDataTable.selectedRowIndex!.toString());
                        // ? Call on long press function
                        if (widget.onCellLongPress != null) {
                          widget.onCellLongPress!();
                          print("DataTable long press !!!");
                        } else {
                          print("DataTable long press null");
                        }
                      });
                  },
                ),
            ],
          ),
      ],
    );
  }
}
