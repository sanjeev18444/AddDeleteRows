import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DataTable with Add/Delete Rows',
      theme: ThemeData(
        colorScheme: ColorScheme.dark(brightness: Brightness.dark),
      ),
      home: DataTableWithCRUD(),
    );
  }
}
class DataTableWithCRUD extends StatefulWidget {
  const DataTableWithCRUD({super.key});

  @override
  State<DataTableWithCRUD> createState() => _DataTableWithCRUDState();
}

class _DataTableWithCRUDState extends State<DataTableWithCRUD> {
   List<Map<String, String>> data = [
    {'Name': 'Amit', 'Age': '20', 'Email': 'amit@email.com'},
    {'Name': 'Sanket', 'Age': '21', 'Email': 'sanket@email.com'},
  ];
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  void _addRow() {
    setState(() {
      data.add({
        'Name': '',
        'Age': '',
        'Email': '',
      });
    });
  }

  void _deleteRow(int index) {
    setState(() {
      data.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('DataTable with Add/Delete Rows'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: _addRow,
            child: Text('Add Row'),
          ),
          SizedBox(height: 20),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: [
                DataColumn(label: Text('Name')),
                DataColumn(label: Text('Age')),
                DataColumn(label: Text('Email')),
                DataColumn(label: Text('Actions')),
              ],
              rows: List.generate(data.length, (index) {
                var row = data[index];
                return DataRow(cells: [
                  DataCell(
                    TextFormField(
                      initialValue: row['Name'],
                      onChanged: (value) => _nameController.text = value,
                    ),
                  ),
                  DataCell(
                    TextFormField(
                      initialValue: row['Age'],
                      onChanged: (value) => _ageController.text = value,
                    ),
                  ),
                  DataCell(
                    TextFormField(
                      initialValue: row['Email'],
                      onChanged: (value) => _emailController.text = value,
                    ),
                  ),
                  DataCell(
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => _deleteRow(index),
                        ),
                      ],
                    ),
                  ),
                ]);
              }),
            ),
          ),
        ],
      ),
    );
  }
}
