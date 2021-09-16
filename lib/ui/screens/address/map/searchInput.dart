import 'dart:async';

import 'package:flutter/material.dart';
import 'package:funfy/components/navigation.dart';
import 'package:funfy/utils/colors.dart';
import 'package:funfy/utils/langauge_constant.dart';

/// Custom Search input field, showing the search and clear icons.
class SearchInputB extends StatefulWidget {
  final ValueChanged<String> onSearchInput;

  SearchInputB(this.onSearchInput);

  @override
  State<StatefulWidget> createState() => SearchInputBState();
}

class SearchInputBState extends State<SearchInputB> {
  TextEditingController editController = TextEditingController();

  Timer? debouncer;

  bool hasSearchEntry = false;

  SearchInputBState();

  @override
  void initState() {
    super.initState();
    this.editController.addListener(this.onSearchInputChange);
  }

  @override
  void dispose() {
    this.editController.removeListener(this.onSearchInputChange);
    this.editController.dispose();

    super.dispose();
  }

  void onSearchInputChange() {
    if (this.editController.text.isEmpty) {
      this.debouncer?.cancel();
      widget.onSearchInput(this.editController.text);
      return;
    }

    if (this.debouncer?.isActive ?? false) {
      this.debouncer!.cancel();
    }

    this.debouncer = Timer(Duration(milliseconds: 500), () {
      widget.onSearchInput(this.editController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.065,
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        children: <Widget>[
          IconButton(
              onPressed: () {
                navigatePopFun(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: AppColors.blackBackground,
                // color: Colors.white,
              )),
          SizedBox(width: 8),
          Expanded(
            child: TextField(
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                  hintText: "${getTranslated(context, 'searchplace')}",
                  border: InputBorder.none),
              controller: this.editController,
              onChanged: (value) {
                setState(() {
                  this.hasSearchEntry = value.isNotEmpty;
                });
              },
            ),
          ),

          SizedBox(width: 8),
          this.editController.text.length > 0
              ? IconButton(
                  onPressed: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    this.editController.clear();
                  },
                  icon: Icon(
                    Icons.clear,
                    color: AppColors.blackBackground,
                    // color: Colors.white,
                  ))
              : IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.search,
                    color: AppColors.blackBackground,
                    // color: Colors.white,
                  ))

          // Icon(Icons.search, color: Theme.of(context).textTheme.body1!.color),
          // if (this.hasSearchEntry)
          //   GestureDetector(
          //     child: Icon(Icons.clear),
          //     onTap: () {
          //       this.editController.clear();
          //       setState(() {
          //         this.hasSearchEntry = false;
          //       });
          //     },
          //   ),
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size.width * 0.08),
        color: Theme.of(context).canvasColor,
      ),
    );
  }
}
