import 'package:flutter/material.dart';
import 'package:ipsb_visitor_app/src/models/building.dart';
import 'package:ipsb_visitor_app/src/utils/formatter.dart';
import 'package:ipsb_visitor_app/src/widgets/custom_select.dart';

class SelectBuilding extends StatelessWidget {
  final String label;
  final Function(Building?) onSubmitted;
  final Building? selected;
  final bool required;
  final Future<List<Building>?> Function([String?]) dataCallback;
  const SelectBuilding({
    Key? key,
    required this.label,
    required this.onSubmitted,
    this.required = false,
    this.selected,
    required this.dataCallback,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomSelect<Building>(
      dataCallback: dataCallback,
      label: label,
      type: "single",
      listType: "building",
      itemBuilder: (item, selected, changeSelected) => ListTile(
        leading: Image.network(
          item.imageUrl!,
          width: 80,
        ),
        title: Text(Formatter.shorten(item.name)),
        subtitle: Text(
            '${Formatter.shorten(item.address)} ${Formatter.distanceFormat(item.distanceTo, buildingId: item.id)}'),
        trailing: Checkbox(
          value: selected,
          onChanged: (value) => changeSelected(value!),
        ),
      ),
      selectedItemBuilder: (item, remove) => ListTile(
        leading: Image.network(
          item.imageUrl!,
          height: 40,
        ),
        title: Text(Formatter.shorten(item.name, 20)),
        trailing:
            IconButton(onPressed: () => remove(), icon: Icon(Icons.close)),
      ),
      onSubmitted: onSubmitted,
      required: required,
      selectedItem: selected,
    );
  }
}
