// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'model/product.dart';
import 'model/products_repository.dart';
import 'supplemental/asymmetric_view.dart';

class HomePage extends StatelessWidget {

  final Category category;

  const HomePage({this.category: Category.all});

  @override
  Widget build(BuildContext context) {
    // TODO: Pass Category variable to AsymmetricView (104)
    return AsymmetricView(products: ProductsRepository.loadProducts(category));
    /*return Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark, //可以調整status bar的顏色
          leading: IconButton(
              icon: Icon(
                Icons.menu,
                semanticLabel: "menu",
              ),
              onPressed: () {
                print("menu");
              }),
          title: Text("SHRINE"),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.search,
                  semanticLabel: "search button",
                ),
                onPressed: () {
                  print("search");
                }),
            IconButton(
                icon: Icon(
                  Icons.filter_list,
                  semanticLabel: "filter button",
                ),
                onPressed: () {
                  print("settings");
                })
          ],
        ),
        body: AsymmetricView(products: ProductsRepository.loadProducts(Category.all)),
        *//*body: GridView.count(
          crossAxisCount: 2,
          //設定有幾行
          childAspectRatio: 1 / 1,
          //寬和高的比例
          crossAxisSpacing: 5,
          //項目橫向間距
          mainAxisSpacing: 5,
          //項目直向間距
          padding: EdgeInsets.all(16.0),
          //GridView四邊的padding
          children: generateCards(context),)*//*
        );*/
  }

  List<Card> generateCards(BuildContext context) {
    List<Product> products = ProductsRepository.loadProducts(Category.all);
    if (products == null || products.isEmpty) {
      print(products.toString());
      return const <Card>[];
    }

    final ThemeData themeData = Theme.of(context);
    final NumberFormat numberFormat = NumberFormat.simpleCurrency(
        locale: Localizations.localeOf(context).toString());

    return products.map((product) {
      return Card(
          elevation: 1,
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              AspectRatio(
                aspectRatio: 18.0 / 11.0,
                child: Image.asset(
                  product.assetName,
                  package: product.assetPackage,
                  fit: BoxFit.fill,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      product == null ? '' : product.name,
                      style: themeData.textTheme.button,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      numberFormat.format(product.price),
                      style: themeData.textTheme.caption,
                    ),
                  ],
                ),
              )
            ],
          ));
    }).toList();
  }
}
