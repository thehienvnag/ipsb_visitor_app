import 'package:flutter/material.dart';
import 'package:ipsb_visitor_app/src/models/product.dart';
import 'package:ipsb_visitor_app/src/utils/formatter.dart';
import 'package:ipsb_visitor_app/src/widgets/custom_select.dart';

class SelectProduct extends StatelessWidget {
  final String label;
  final Function(Product?) onSubmitted;
  final Product? selected;
  final bool required;
  final Future<List<Product>?> Function([String?]) dataCallback;
  final Function(int?)? goToDetails;
  const SelectProduct({
    Key? key,
    required this.label,
    required this.onSubmitted,
    this.required = false,
    this.selected,
    required this.dataCallback,
    this.goToDetails,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomSelect<Product>(
      dataCallback: dataCallback,
      label: label,
      type: "single",
      listType: "product",
      itemBuilder: (item, selected, changeSelected) => ListTile(
        leading: Image.network(
          item.imageUrl!,
          width: 80,
        ),
        title: Text(
          Formatter.shorten(item.name),
          style: TextStyle(fontSize: 14),
        ),
        subtitle: Text(
          Formatter.price(item.price),
          style: TextStyle(fontSize: 14),
        ),
        onTap: () {
          if (goToDetails != null) {
            goToDetails!(item.id);
          }
        },
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
        title: Text(Formatter.shorten(item.name)),
        trailing: IconButton(
          onPressed: () => remove(),
          icon: Icon(Icons.close),
        ),
      ),
      onSubmitted: onSubmitted,
      required: required,
      selectedItem: selected,
    );
  }
}
