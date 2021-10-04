import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipsb_visitor_app/src/widgets/rounded_button.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class CustomSelect<T> extends StatefulWidget {
  /// Type of select single
  final String singleType = "single";

  /// Type of select
  final String type;

  /// Label of select
  final String label;

  /// Data source to show
  final List<T>? items;

  /// Callback for data api
  final Future<List<T>?> Function([String?])? dataCallback;

  /// Background color
  final Color color;

  final bool required;

  /// Item in dropdown builder
  final Widget Function(T item, bool selected, Function(bool) changeSelected)
      itemBuilder;

  /// Item selected builder
  final Widget Function(T item, Function remove) selectedItemBuilder;

  /// on submitted item
  final Function(List<T>? items)? onSubmittedMultiple;

  final Function(T? item)? onSubmitted;

  final List<T>? selectedItems;

  final T? selectedItem;

  const CustomSelect({
    Key? key,
    required this.label,
    this.items,
    this.color = Colors.black12,
    required this.required,
    required this.selectedItemBuilder,
    this.selectedItems,
    required this.itemBuilder,
    this.type = "single",
    this.selectedItem,
    this.onSubmitted,
    this.onSubmittedMultiple,
    this.dataCallback,
  }) : super(key: key);

  @override
  _CustomSelectState<T> createState() => _CustomSelectState<T>();
}

class _CustomSelectState<T> extends State<CustomSelect<T>> {
  /// Selected items
  List<T>? selectedItems;

  /// Selected item
  T? selectedItem;

  final FocusNode _focusNodeText = FocusNode();

  @override
  void initState() {
    super.initState();
    if (widget.selectedItems != null) {
      setState(() {
        selectedItems = widget.selectedItems;
      });
    }
    if (widget.selectedItem != null) {
      setState(() {
        selectedItem = widget.selectedItem;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.color,
        // border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      child: Stack(
        children: [
          Container(
            height: 42,
            child: TextFormField(
              focusNode: _focusNodeText,
              onTap: () => showDialog(),
              showCursor: false,
              readOnly: true,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(
                  top: 10,
                  left: 10,
                  right: 10,
                ),
                labelText:
                    widget.type == widget.singleType && selectedItem != null
                        ? ""
                        : widget.label,
                suffixIcon:
                    widget.type == widget.singleType && selectedItem != null
                        ? Container()
                        : Container(
                            margin: const EdgeInsets.only(left: 10),
                            child: Icon(
                              Icons.chevron_right_outlined,
                              size: 30,
                            ),
                          ),
                border: InputBorder.none,
              ),
              validator: widget.required
                  ? (value) => validator(widget.label.toLowerCase())
                  : null,
            ),
          ),
          showSingle(),
          // Container(
          //   height: determineHeight(selectedItems?.length ?? 0),
          //   width: 300,
          //   child: showMutilple(),
          // )
        ],
      ),
    );
  }

  Widget showSingle() {
    if (widget.type != "single" || selectedItem == null) {
      return Container();
    }
    return widget.selectedItemBuilder(selectedItem!, () {
      removeSingle();
    });
  }

  Widget showMutilple() {
    if (widget.type == "single" ||
        selectedItems == null ||
        selectedItems?.length == 0) {
      return Container();
    }
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      mainAxisSpacing: 10,
      childAspectRatio: determineRatio(selectedItems?.length ?? 0),
      physics: ScrollPhysics(),
      scrollDirection: Axis.horizontal,
      children: selectedItems == null
          ? []
          : selectedItems!
              .map((e) => Container(
                  width: 300,
                  child: widget.selectedItemBuilder(e, () => remove(e))))
              .toList(),
    );
  }

  String? validator(String fieldName) {
    if (selectedItems == null) return 'Vui lòng chọn $fieldName';
    return null;
  }

  double determineHeight(int items) {
    if (items == 0) return 0;
    if (items == 1) return 60;
    return 100;
  }

  double determineRatio(int items) {
    if (items == 0) return 1;
    if (items == 1) return 1 / 6;
    return 1 / 4.2;
  }

  void remove(e) {
    setState(() {
      selectedItems?.remove(e);
      selectedItem = null;
    });
  }

  void removeSingle() {
    setState(() {
      selectedItem = null;
    });
    widget.onSubmitted!(null);
  }

  Future<void> showDialog() async {
    final result = await showCupertinoModalBottomSheet(
      context: context,
      topRadius: Radius.circular(30),
      elevation: 100,
      builder: (context) => DialogWidget<T>(
        type: "single",
        items: widget.items,
        itemBuilder: widget.itemBuilder,
        selectedItems: selectedItems ?? [],
        dataCallback: widget.dataCallback,
      ),
    );
    if (widget.type == widget.singleType) {
      widget.onSubmitted!(result);
    } else {
      widget.onSubmittedMultiple!(result);
    }

    FocusScope.of(context).requestFocus(FocusNode());
    if (widget.type == "single") {
      setState(() {
        selectedItem = result;
      });
    } else {
      setState(() {
        selectedItems = result;
      });
    }
  }
}

class SelectItemWrapper<T> {
  final T? value;
  bool selected;

  SelectItemWrapper({
    this.value,
    this.selected = false,
  });
}

class DialogWidget<T> extends StatefulWidget {
  final List<T>? items;
  final String type;
  final List<T>? selectedItems;
  final T? selectedItem;
  final Future<List<T>?> Function([String?])? dataCallback;

  /// Item in dropdown builder
  final itemBuilder;
  DialogWidget({
    Key? key,
    this.items,
    required this.itemBuilder,
    this.selectedItem,
    this.selectedItems,
    required this.type,
    this.dataCallback,
  }) : super(key: key);
  @override
  _DialogWidgetState<T> createState() => _DialogWidgetState<T>();
}

class _DialogWidgetState<T> extends State<DialogWidget> {
  ///Text field controller
  final TextEditingController _textController = TextEditingController();

  ///Focus node
  final FocusNode _inputNode = FocusNode();

  /// items
  List<SelectItemWrapper<T>> wrapperItems = [];

  /// Loading
  bool loading = false;

  @override
  void initState() {
    super.initState();
    widget.itemBuilder.runtimeType;
    if (widget.items != null) {
      wrapperItems = widget.items!.map((e) {
        bool selected = false;
        if (widget.type == "single") {
          selected = e == widget.selectedItem;
        } else {
          selected = widget.selectedItems?.contains(e) ?? false;
        }
        return SelectItemWrapper<T>(value: e, selected: selected);
      }).toList();
    } else {
      loadDataByCallback();
    }
  }

  void loadDataByCallback([String? search]) {
    setState(() {
      loading = true;
    });
    widget.dataCallback!.call(search).then((value) {
      if (value != null) {
        setState(() {
          wrapperItems = value.map((e) {
            bool selected = false;
            if (widget.type == "single") {
              selected = e == widget.selectedItem;
            } else {
              selected = widget.selectedItems?.contains(e) ?? false;
            }
            return SelectItemWrapper<T>(value: e, selected: selected);
          }).toList();
        });
      }
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        leading: RoundedButton(
          radius: 28,
          onPressed: () => _inputNode.requestFocus(),
          color: Colors.transparent,
          icon: Icon(Icons.search, size: 25, color: Colors.grey),
        ),
        backgroundColor: Colors.white,
        middle: Container(
          height: 45,
          margin: const EdgeInsets.only(bottom: 8),
          child: TextFormField(
            controller: _textController,
            onChanged: (value) => loadDataByCallback(value),
            focusNode: _inputNode,
            decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
            ),
          ),
        ),
        trailing: RoundedButton(
          radius: 28,
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.close,
            size: 25,
            color: Colors.grey,
          ),
          color: Colors.grey.withOpacity(0.2),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 25.0, // soften the shadow
            spreadRadius: 5.0, //extend the shadow
            offset: Offset(
              5.0, // Move to right 10  horizontally
              5.0, // Move to bottom 10 Vertically
            ),
          )
        ]),
        child: Column(
          children: [
            Expanded(
              child: loading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.separated(
                      itemBuilder: (context, index) {
                        final item = wrapperItems[index];
                        return GestureDetector(
                          onTap: () => setSelected(wrapperItems, item),
                          child: widget.itemBuilder(
                            item.value,
                            item.selected,
                            (value) => setSelected(wrapperItems, item, value),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => Divider(
                        thickness: 1,
                        indent: 20,
                        endIndent: 20,
                      ),
                      itemCount: wrapperItems.length,
                    ),
            ),
            ElevatedButton(
              onPressed: () {
                if (widget.type == "single") {
                  Get.back(
                    result: wrapperItems
                        .firstWhere(
                          (e) => e.selected,
                          orElse: () => SelectItemWrapper<T>(value: null),
                        )
                        .value,
                  );
                } else {
                  Get.back(
                    result: wrapperItems
                        .where((e) => e.selected)
                        .map((e) => e.value)
                        .toList(),
                  );
                }
              },
              child: Text('XÁC NHẬN'),
            ),
          ],
        ),
      ),
    );
  }

  void setSelected(List<SelectItemWrapper<T>> items, SelectItemWrapper<T> item,
      [bool? value]) {
    if (widget.type == "single") {
      setState(() {
        if (value != null) {
          items.forEach((e) {
            if (e == item) {
              e.selected = true;
            } else {
              e.selected = false;
            }
          });
        } else {
          item.selected = !item.selected;
        }
      });
    } else {
      setState(() {
        if (value != null) {
          item.selected = value;
        } else {
          item.selected = !item.selected;
        }
      });
    }
  }
}
