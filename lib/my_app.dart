import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:warehouse_prop_testing/warehouse.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product Inventory',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: const MyHomePage(title: 'Product Inventory'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Warehouse items = Warehouse({"shoes": 5, "hats": 10, "umbrellas": 15});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        toolbarHeight: 150,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50), child: CupertinoSearchTextField()),
            ListView.builder(
              shrinkWrap: true,
              itemCount: items.stock.entries.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    horizontalTitleGap: 2.0,
                    shape: Border.all(color: Colors.grey, width: 1.0),
                    leading: const Icon(Icons.add_sharp),
                    title: Text(items.stock.entries.elementAt(index).toString()),
                    iconColor: Colors.amber,
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: const FloatingActionButton(
        onPressed: null,
        tooltip: 'Add',
        child: Icon(Icons.new_label),
      ),
    );
  }
}
