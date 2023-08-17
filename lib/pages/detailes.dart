import 'package:flower_app/item/item.dart';
import 'package:flower_app/shared/appbar.dart';
import 'package:flower_app/shared/colors.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  final Item product;
  const DetailsScreen({super.key, required this.product});
  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  bool isShowMore = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // ignore: prefer_const_literals_to_create_immutables
          actions: [
            const AppBarRow(),
          ],
          backgroundColor: appbarGreen,
          title: const Text("Details"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(widget.product.imgPath),
              const SizedBox(
                height: 11,
              ),
              Text(
                "${widget.product.price} LE",
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 11,
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(4)),
                    child: const Text(
                      "New",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Row(
                    children: [
                      Icon(
                        Icons.star,
                        size: 20,
                        color: Color.fromARGB(255, 187, 255, 0),
                      ),
                      Icon(
                        Icons.star,
                        size: 25,
                        color: Color.fromARGB(255, 187, 255, 0),
                      ),
                      Icon(
                        Icons.star,
                        size: 25,
                        color: Color.fromARGB(255, 187, 255, 0),
                      ),
                      Icon(
                        Icons.star,
                        size: 25,
                        color: Color.fromARGB(255, 187, 255, 0),
                      ),
                      Icon(
                        Icons.star,
                        size: 25,
                        color: Color.fromARGB(255, 187, 255, 0),
                      ),
                      SizedBox(
                        width: 85,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.edit_location,
                            size: 30,
                            color: Color.fromARGB(255, 22, 146, 119),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            "flower Shop",
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 10),
              const SizedBox(
                width: double.infinity,
                child: Text(
                  "Details : ",
                  style: TextStyle(fontSize: 23),
                  textAlign: TextAlign.start,
                ),
              ),
              const SizedBox(
                height: 11,
              ),
              Text(
                "datadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadata",
                style: const TextStyle(fontSize: 20),
                maxLines: isShowMore ? 3 : null,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: 5,
              ),
              TextButton(
                  onPressed: () {
                    setState(() {
                      isShowMore = !isShowMore;
                    });
                  },
                  child: Text(
                    isShowMore ? "Show Less" : "Show More",
                    style: const TextStyle(fontSize: 20),
                  )),
            ],
          ),
        ));
  }
}
