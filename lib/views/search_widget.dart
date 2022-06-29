import 'package:flutter/material.dart';
import 'package:mvvm_demo/resources/colors_manager.dart';
import 'package:mvvm_demo/resources/values_manager.dart';

class SearchWidget extends StatefulWidget {
  final String text;
  final ValueChanged<String> onChanged;
  final String hintText;

  const SearchWidget({
    Key? key,
    required this.text,
    required this.onChanged,
    required this.hintText,
  }) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var styleActive = TextStyle(color:ColorManager.black);
    var styleHint =  TextStyle(color:ColorManager.black);
    final style = widget.text.isEmpty ? styleHint : styleActive;

    return Container(
      height: AppSize.s40,
      margin: const EdgeInsets.fromLTRB(
          AppSize.s16, AppSize.s16, AppSize.s16, AppSize.s16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.s12),
        color: ColorManager.white,
        border: Border.all(color: Colors.black26),
      ),
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
      child: TextField(
        cursorColor: ColorManager.yellow,
        controller: controller,
        decoration: InputDecoration(
          icon: Icon(Icons.search, color: ColorManager.black),
          suffixIcon: widget.text.isNotEmpty
              ? GestureDetector(
                  child: Icon(Icons.close, color: ColorManager.black),
                  onTap: () {
                    controller.clear();
                    widget.onChanged('');
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                )
              : null,
          hintText: widget.hintText,
          hintStyle: style,
          border: InputBorder.none,
        ),
        style:  TextStyle(color: ColorManager.black, fontSize: AppSize.s16),
        onChanged: widget.onChanged,
      ),
    );
  }
}
