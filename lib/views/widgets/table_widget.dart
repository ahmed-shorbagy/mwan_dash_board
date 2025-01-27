import 'package:dash_board/core/theme/theme_constants.dart';
import 'package:flutter/material.dart';

class CustomTable extends StatelessWidget {
  final List<String> headers;
  final List<List<String>> rows;

  const CustomTable({
    super.key,
    required this.headers,
    required this.rows,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400, // Fixed height for the table
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: DataTable(
            border: TableBorder(
              verticalInside: BorderSide(color: Color(0xff2E2E2E)),
            ),
            columnSpacing: 20,
            horizontalMargin: 12,
            columns: headers.map((header) {
              return DataColumn(
                label: Expanded(
                  child: Text(
                    header,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center, // Center-align header text
                  ),
                ),
              );
            }).toList(),
            rows: List<DataRow>.generate(
              rows.length,
              (index) {
                // Apply alternating row colors
                final backgroundColor = index.isEven
                    ? Colors.transparent // Default background (transparent)
                    : kPrimaryColor.withOpacity(0.3); // Example primary color

                return DataRow(
                  color: WidgetStateProperty.resolveWith<Color>(
                    (Set<WidgetState> states) => backgroundColor,
                  ),
                  cells: rows[index].map((cell) {
                    return DataCell(
                      Center(
                        child: Text(
                          cell,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
