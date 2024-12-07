import 'package:flutter/material.dart';

import '../../../constants.dart';

class AlliumDropdown<T> extends StatelessWidget {
  final List<T> items;
  final T? selectedItem;
  final ValueChanged<T?> onChanged;
  final String hintText;

  const AlliumDropdown({
    super.key,
    required this.items,
    required this.onChanged,
    this.selectedItem,
    this.hintText = "select sample program",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300, width: 1.5),
        borderRadius: BorderRadius.circular(4),
        color: Colors.white,
      ),
      child: DropdownButton<T>(
        isExpanded: true,
        value: selectedItem,
        hint: Text(
          hintText, 
          style: font(
            color: Colors.grey.shade600,
            fontSize: 12
          )
        ),
        underline: const SizedBox(),
        items: items.map((T item) {
          return DropdownMenuItem<T>(
            value: item,
            child: Text(
              item.toString(), 
              style: font(
                fontSize: 14
              )
            ),
          );
        }).toList(),
        onChanged: onChanged,
        dropdownColor: Colors.white,
        style: font(
          color: Colors.black
        ),
        icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
      ),
    );
  }
}
