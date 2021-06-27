import 'package:flutter/material.dart';

class TextSearch extends StatelessWidget {
  final Function(String)? onFieldSubmitted;

  const TextSearch({Key? key, this.onFieldSubmitted}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onFieldSubmitted: onFieldSubmitted,
      cursorColor: Colors.black,
      cursorHeight: 22,
      cursorWidth: 1,
      decoration: new InputDecoration(
        prefixIcon: Icon(Icons.search_rounded, color: Color(0xff0DB5B4)),
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        contentPadding: EdgeInsets.only(left: 15, top: 9, right: 15),
        hintText: 'Tìm kiếm ...',
        hintStyle: TextStyle(color: Colors.grey),
        labelStyle: TextStyle(color: Colors.black),
        // suffixIcon: IconButton(
        //   icon: Icon(Icons.clear, color: Color(0xff0DB5B4)),
        //   onPressed: () {
        //     controller.changeSearchValue("");
        //   },
        // ),
      ),
    );
  }
}
