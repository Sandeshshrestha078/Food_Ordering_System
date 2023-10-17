import 'package:flutter/material.dart';
import 'package:food_admin/constant/values.dart';

class TabelCellname extends StatefulWidget {
  final String cellname;
  const TabelCellname({super.key, required this.cellname});

  @override
  State<TabelCellname> createState() => _TabelCellnameState();
}

class _TabelCellnameState extends State<TabelCellname> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: TableCell(
          child: Text(widget.cellname, style: titleStyle2),
        ),
      ),
    );
  }
}
