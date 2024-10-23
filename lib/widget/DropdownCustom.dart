

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../core/base/base_view_view_model.dart';

class BottomSelectionWidget extends StatelessWidget {
  var header;
  var list;
  var valueName;
  var displayNAme;
  var height;
  BottomSelectionWidget({required this.header,required this.list,required this.valueName,required this.displayNAme,this.height});
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(width: 40),
        Text(header, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Container(
          width: 40,
          child: IconButton(
            icon: Icon(Icons.close, color: Colors.grey),
            onPressed: () {
              Get.back();
            },
          ),
        ),
      ],
    );
  }


  _listItem(context) {
    List<Widget> listWidget=[];
    for(var v in list)
    {
      listWidget.add(_Item(context, v));
    }
    return Column(children:listWidget);
  }
  onTap(item)
  { Navigator.pop(Get.context!, item);
  }
  _Item(context,item) {
    return
      GestureDetector(onTap: ()
      {onTap(item);},child:
      Container(
          padding: EdgeInsets.only(bottom: 6),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(bottom: 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.withOpacity(0.7)),
            ),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                      child: Column(children: [
                        Container(
                            alignment: Alignment.centerLeft,
                            child: Text(item[displayNAme]??'',
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold))),
                      ])),
                ],
              ),
            ),
          )),
      );
  }


  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus(); // Unfocus any focused widget
        },
        child: Container(
          decoration: BoxDecoration(),
          child: LayoutBuilder(
            builder: (context, constraints) {
              double bottomPadding = MediaQuery.of(context).viewInsets.bottom;
              return Container(
                height: height,
                decoration: BoxDecoration(),
                padding: EdgeInsets.only(bottom: bottomPadding),
                child: SingleChildScrollView(
                  child: Container(
                    height: height,
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min, // Ensure column takes only needed height
                      children: [
                        SizedBox(height: 16),
                        _buildHeader(),
                        SizedBox(height: 12),
                        Expanded(
                            child: Container(
                              child: ListView(
                                children: [_listItem(context)],
                              ),
                            )),
                        SizedBox(height: 12),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),

        )
    );
  }
}
class BottomSelection extends StatefulWidget {
  var height;
  var header;
  var list;
  var valueController;
  var valueNAme;
  var displayNAme;
  String hintText;
  Color hintTextColor;
  Color textColor;
  Color backgroundColor;
  double? borderRadius;
  String prefixIcon;
  var suffixIcon;
  Function()? onChange;
  Color iconBackgroundColor;
  Color iconFocusedIconColor;
  Color iconColor;
  double iconSize;
  bool readonly;
  var fontSize;
  BottomSelection({
    this.fontSize=14.0,
    this.iconSize=22.0,
    this.height=500.0,
    this.valueNAme,
    this.displayNAme,
    this.header='',
    this.hintText='',
    this.valueController,
    this.readonly=false,
    this.hintTextColor = Colors.grey,
    this.onChange,
    this.list,
    this.backgroundColor = Colors.transparent,
    this.borderRadius = 12,
    this.textColor = Colors.black,
    this.prefixIcon='',
    this.suffixIcon,
    this.iconColor = Colors.grey,
    this.iconBackgroundColor = Colors.transparent,
    this.iconFocusedIconColor = Colors.blue,
  });

  @override
  _BottomSelection createState() => _BottomSelection();
}

class _BottomSelection extends State<BottomSelection> {
  TextEditingController _controller = TextEditingController();
  late FocusNode _focusNode;
  getCurrentDisplay(id)
  {try {
    for (var v in widget.list)
      if (v[widget.valueNAme].toString() == id)
        return v[widget.displayNAme].toString();
  }
  catch (e) {}
  return '';
  }
  @override
  void initState() {
    _controller.text = getCurrentDisplay(widget.valueController.value??'');
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {}); // Ensure the widget rebuilds on focus change
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }


  Future<void> onTap() async {print(widget.list);
  var result = await showModalBottomSheet(
    backgroundColor: Colors.white,
    context: Get.context!,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(25.0),
        topRight: Radius.circular(25.0),
      ),
    ),
    isScrollControlled: true,
    builder: (context) {
      return BottomSelectionWidget(header: widget.header, list: widget.list,valueName: widget.valueNAme,displayNAme: widget.displayNAme,height: widget.height);
    },
  );
  print(result);
  if (result != null)
  {widget.valueController.value=result[widget.valueNAme]??'';
  _controller.text = getCurrentDisplay(result[widget.valueNAme]??'');
  setState(() {});
  } else {
    print('no action');
  }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      focusNode: _focusNode, // Attach the FocusNode
      onTap: () async {
        await onTap();
      },
      readOnly: true,
      decoration: InputDecoration(
        prefixIcon:
        ((widget.prefixIcon??'')=='')?SizedBox():
        Container(
            width: widget.iconSize,
            height: widget.iconSize,
            child:widget.prefixIcon.isEmpty?SizedBox(): Center(child: Image.asset(
              width: widget.iconSize,
              height: widget.iconSize,
              widget.prefixIcon,
              fit: BoxFit.contain,
              color: _focusNode.hasFocus ? widget.iconFocusedIconColor : widget.iconColor,
            ),
            )),
        suffixIcon: widget.suffixIcon ?? null,
        hintText: _controller.text.isEmpty ? widget.hintText: _controller.text,
        hintStyle: TextStyle(fontSize:  widget.fontSize, color: widget.hintTextColor),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0), // Set border radius
          borderSide: BorderSide(
            color: Colors.grey.withOpacity(0.7), // Specify the border color here
            width: 1.0, // Border width
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0), // Set border radius
          borderSide: BorderSide(
            color: Colors.grey.withOpacity(0.7), // Specify the border color here
            width: 1.0, // Border width
          ),
        ),

        fillColor:widget.backgroundColor,
        filled: true,
        contentPadding: EdgeInsets.only(top: 12.0),
      ),
      style: TextStyle(fontSize: widget.fontSize, color: widget.textColor),
    );
  }
}
