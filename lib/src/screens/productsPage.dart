import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ms_app_round3/src/core/models/failedRequest.dart';
import 'package:ms_app_round3/src/core/provider/product_provider.dart';
import 'package:ms_app_round3/src/widgets/addButton.dart';
import 'package:ms_app_round3/src/widgets/addProductDialog.dart';
import 'package:ms_app_round3/src/widgets/dialog.dart';
import 'package:provider/provider.dart';

class ProductsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProductsPageState();
  }
}

class _ProductsPageState extends State<ProductsPage> {
  String sundries = "1";

  ProductProvider _productProvider;

  @override
  Widget build(BuildContext context) {
    _productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Products"),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          ListView.builder(
            itemCount: _productProvider.allProducts.length,
            itemBuilder: (context, index) {
              if (_productProvider.allProducts[index].sundries == "0") {
                return productCard(index);
              } else {
                if (sundries == "1") {
                  sundries = "0";
                  return productCard2(index);
                }
                return productCard(index);
              }
            },
          ),
          AddButton(
            function: () {
              addProductDialog(context);
            },
          ),
        ],
      ),
    );
  }

  Widget productCard(int index) {
    return Dismissible(
      background: Container(
        color: Colors.greenAccent,
      ),
      key: Key(_productProvider.allProducts[index].toString()),
      onDismissed: (direction) {
        // todo call api to remove from data base
        _productProvider.allProducts.removeAt(index);
      },
      child: Container(
        margin: EdgeInsets.only(left: 20, right: 20, top: 10),
        height: 50,
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(_productProvider.allProducts[index].name),
            SizedBox(
              width: 20,
            ),
            Text(_productProvider.allProducts[index].price + " LE"),
          ],
        ),
      ),
    );
  }
  Widget productCard2(int index) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Text(
          "sundries",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        productCard(index),
      ],
    );
  }

  Widget addProductDialog(context) {
    showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: new Text('Please Enter Data'),
          actions: <Widget>[
            CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: () async {
                var res = await _productProvider.addProduct();

                if (res is FailedRequest) {
                  Dialogs.showErrorDialog(context,
                      message: res.message, code: res.code);
                  print('results ${res.toString()}');
                }

                await _productProvider.getAllProducts();
                sundries = "1";

                Navigator.of(context).pop();
              },
              child: new Text('Done'),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: new Text('Cancel'),
            ),
          ],
          content: Material(
            color: Colors.white10,
            child: AddProductDialog(),
          ),
        );
      },
    );
  }
}
