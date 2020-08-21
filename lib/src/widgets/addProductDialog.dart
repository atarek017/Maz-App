
import 'package:flutter/material.dart';
import 'package:ms_app_round3/src/core/provider/product_provider.dart';
import 'package:provider/provider.dart';

class AddProductDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddProductDialogState();
  }
}

class _AddProductDialogState extends State<AddProductDialog> {
  ProductProvider _productProvider;

  @override
  Widget build(BuildContext context) {
    _productProvider = Provider.of<ProductProvider>(context);


    return Container(
      height: 250,
      child: ListView(

        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          row("Name", _productProvider.nameTextEditorField, TextInputType.text),
          SizedBox(
            height: 20,
          ),
          row("Price", _productProvider.priceTextEditorField, TextInputType.number),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Type"),
              DropdownButton<String>(
                items: _productProvider.productTypes.map((String dropDowenItem) {
                  return DropdownMenuItem<String>(
                    value: dropDowenItem,
                    child: Text(dropDowenItem),
                  );
                }).toList(),
                onChanged: (String newValue) {
                  setState(() {
                    _productProvider.selectedType = newValue;
                  });
                },
                value: _productProvider.selectedType,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget row(String text, TextEditingController textEditingController,
      TextInputType textInputType) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
            child: Text(
              "$text :",
              style: TextStyle(color: Colors.black, fontSize: 16),
            )),
        Container(
          height: 35,
          width: 100,
          child: TextField(
            style: TextStyle(
              fontSize: 18,
            ),
            controller: textEditingController,
            keyboardType: textInputType,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
                hintText: "$text",
                hintStyle: TextStyle(
                  fontSize: 13,
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.white))),
          ),
        ),
      ],
    );
  }
}
