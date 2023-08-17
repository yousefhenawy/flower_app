

import 'package:flower_app/provider/cart.dart';
import 'package:flower_app/shared/appbar.dart';
import 'package:flower_app/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckOut extends StatelessWidget {
  const CheckOut({super.key});

  @override
  Widget build(BuildContext context) {
    final classInstancee = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbarGreen,
        title: const Text("Check out"),
        actions: const [AppBarRow()],
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            child: SizedBox(
              height: 300,
              child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: classInstancee.selectedproducts.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: ListTile(
                        title:
                            Text(classInstancee.selectedproducts[index].name),
                        subtitle: Text(
                            "${classInstancee.selectedproducts[index].price}"),
                        leading: CircleAvatar(
                          backgroundImage: AssetImage(
                              "${classInstancee.selectedproducts[index].imgPath}"),
                        ),
                        trailing: IconButton(
                            onPressed: () {
                              classInstancee.remove(classInstancee.selectedproducts[index]);
                            },
                            icon: const Icon(Icons.remove)),
                      ),
                    );
                  }),
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ButtonStyle(
                padding: MaterialStateProperty.all(const EdgeInsets.all(12)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)))),
            child: Text(
              "Pay ${classInstancee.price} LE",
              style: const TextStyle(fontSize: 18),
            ),
          )
        ],
      ),
    );
  }
}
