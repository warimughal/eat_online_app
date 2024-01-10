// ignore_for_file: file_names, prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, unnecessary_string_interpolations, dead_code, deprecated_member_use, unused_element

import 'package:flutter/material.dart';

class PickedUpDetailsScreen extends StatefulWidget {
  const PickedUpDetailsScreen({super.key});

  @override
  State<PickedUpDetailsScreen> createState() => _PickedUpDetailsScreenState();
}

class _PickedUpDetailsScreenState extends State<PickedUpDetailsScreen> {
  // Function to show the DECLINE dialog
  Future<void> _showDeclineDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Text(
              "DECLINE",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          ),
          content: Text("Are you sure you want to decline this order?"),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.grey,
              ),
              child: Text(
                "DECLINE",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
              ),
              child: Text(
                "ACCEPT",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Function to show the ACCEPT dialog
  Future<void> _showAcceptDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Text(
              "ACCEPT",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          ),
          content: Text("Are you sure you want to accept this order?"),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.grey,
              ),
              child: Text(
                "DECLINE",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
              ),
              child: Text(
                "ACCEPT",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Orders Details",
          style: TextStyle(fontWeight: FontWeight.w900, color: Colors.white),
        ),
        automaticallyImplyLeading: true,
        backgroundColor: Colors.red,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 7),
            child: Card(
              elevation: 4,
              child: Container(
                width: 130,
                height: 50,
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "ORDER TYPE",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                        color: Colors.red,
                      ),
                    ),
                    Text(
                      "Picked Up",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 9),
          Card(
            elevation: 4,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      "ITEMS",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          "Name",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          "Quantity",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          "Total",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                  _buildItem("Burgers", "2", "\$10"),
                  _buildItem("Pizza", "3", "\$12"),
                  _buildItem("Fries", "4", "\$12"),
                  Container(
                    height: 1,
                    color: Colors.black,
                  ),
                  _buildItem("3", "9", "\$24"),
                ],
              ),
            ),
          ),
          SizedBox(height: 9),
          Card(
            elevation: 4,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      "DETAILS",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        "Shipping: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                      Text("\$12"),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Date: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                      Text("27-05-2022"),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Time: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                      Text("10:30 PM"),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Total: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                      Text("\$46"),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 9),
          Card(
            elevation: 4,
            child: Container(
              color: Colors.red,
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      "CUSTOMER DETAILS",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        "Name: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Nisar",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Address: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Pasrur Road",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Phone: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "+9200900000",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Note: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "this is....",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _showDeclineDialog();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                        ),
                        child: Text(
                          "DECLINE",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _showAcceptDialog();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                        ),
                        child: Text(
                          "ACCEPT",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(String name, String quantity, String total) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              name,
              style: TextStyle(fontSize: 10),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              quantity,
              style: TextStyle(fontSize: 10),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              total,
              style: TextStyle(fontSize: 10),
            ),
          ),
        ],
      ),
    );
  }
}
