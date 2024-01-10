// ignore_for_file: file_names, avoid_print, prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, deprecated_member_use, unused_local_variable, unnecessary_brace_in_string_interps

import 'dart:convert';

import 'package:eat_online_app/detailsScreen.dart';
import 'package:eat_online_app/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedTabIndex = 0;
  String selectedFilter = '';

  List<dynamic> restaurantData = [];

  // Function to fetch restaurant data from the API
  Future<void> fetchRestaurantData() async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://eatexpressdev.se/selfordering_levels/apis/t_orders.php?restaurant_id=53&loc_id=90'),
      );

      if (response.statusCode == 200) {
        setState(() {
          restaurantData = jsonDecode(response.body);
        });
      } else {
        throw Exception('Failed to load restaurant data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();

    fetchRestaurantData();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Text(
              "Orders",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Container(
                height: 45,
                width: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: Colors.red,
                  ),
                ),
                child: TabBar(
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.red,
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorWeight: 4.0,
                  isScrollable: true,
                  labelPadding: EdgeInsets.symmetric(horizontal: 39.2),
                  tabs: [
                    Tab(
                      child: Text(
                        "Today's Order",
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: _selectedTabIndex == 0
                              ? Colors.white
                              : Colors.red,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "All Order's",
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: _selectedTabIndex == 1
                              ? Colors.white
                              : Colors.red,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                  onTap: (index) {
                    setState(() {
                      _selectedTabIndex = index;
                    });
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5, left: 12.0),
                    child: Text(
                      "Filters",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _showFilterOptions(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: Icon(
                        Icons.filter_list,
                        color: selectedFilter.isNotEmpty
                            ? Colors.red
                            : Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    _buildOrderList(restaurantData),
                    _buildOrderList(restaurantData),
                  ],
                ),
              ),
            ],
          ),
        ),
        endDrawer: Drawer(
          backgroundColor: Colors.red,
          child: ListView(
            children: [
              Container(
                color: Colors.red,
                width: double.infinity,
                height: 200,
                padding: EdgeInsets.only(top: 20.0),
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.red,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 140,
                        width: double.infinity,
                        child: Image.asset(
                          'assets/splashScreen.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  "Home",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                leading: Icon(
                  Icons.home,
                  color: Colors.white,
                ),
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ),
                    (route) => false,
                  );
                },
              ),
              SizedBox(height: 440),
              Container(
                child: ListTile(
                  title: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(child: Icon(Icons.logout, color: Colors.white)),
                        Text(
                          "LogOut",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                      (route) => false,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderList(List<dynamic> data) {
    if (selectedFilter.isEmpty) {
      return data.isNotEmpty
          ? ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final order = data[index];
                final orderStatus = order['order_status'];
                Color statusColor;
                switch (orderStatus) {
                  case 'Pending':
                    statusColor = Colors.orange;
                    break;
                  case 'Accepted':
                    statusColor = Colors.green;
                    break;
                  case 'Rejected':
                    statusColor = Colors.red;
                    break;
                  case 'Missed':
                    statusColor = Colors.blue;
                    break;
                  default:
                    statusColor = Colors.black;
                    break;
                }
                return ListTile(
                  leading: Container(
                    width: 70,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: statusColor,
                    ),
                    child: Center(
                      child: Text(
                        orderStatus,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 9,
                        ),
                      ),
                    ),
                  ),
                  trailing: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailsScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                    child: Text(
                      "Details",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  title: Text(
                    'Customer Id: ${order['customer_id']}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
                  ),
                  subtitle: Text(
                    'Order Amount: ${order['order_amount']}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
                  ),
                );
              },
            )
          : Center(
              child: Text(
                'No orders available.',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            );
    } else {
      final filteredOrders = data.where((order) {
        return order['order_status'] == selectedFilter;
      }).toList();

      return filteredOrders.isNotEmpty
          ? ListView.builder(
              itemCount: filteredOrders.length,
              itemBuilder: (context, index) {
                final order = filteredOrders[index];
                final orderStatus = order['order_status'];
                Color statusColor;
                switch (orderStatus) {
                  case 'Pending':
                    statusColor = Colors.orange;
                    break;
                  case 'Accepted':
                    statusColor = Colors.green;
                    break;
                  case 'Rejected':
                    statusColor = Colors.red;
                    break;
                  case 'Missed':
                    statusColor = Colors.yellow;
                    break;
                  default:
                    statusColor = Colors.black;
                    break;
                }
                return ListTile(
                  leading: Container(
                    width: 70,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: statusColor,
                    ),
                    child: Center(
                      child: Text(
                        orderStatus,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 9,
                        ),
                      ),
                    ),
                  ),
                  trailing: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailsScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                    child: Text(
                      "Details",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  title: Text(
                    'Customer Id: ${order['customer_id']}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
                  ),
                  subtitle: Text(
                    'Order Amount: ${order['order_amount']}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
                  ),
                );
              },
            )
          : Center(
              child: Text(
                'No ${selectedFilter} orders available.',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            );
    }
  }

  void _showFilterOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 6),
                            child: Text(
                              "Filter",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          SizedBox(width: 210),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              print("Selected Filter: $selectedFilter");
                            },
                            child: Text(
                              "Done",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      RadioListTile(
                        title: Text("None"),
                        value: '',
                        groupValue: selectedFilter,
                        onChanged: (value) {
                          setState(() {
                            selectedFilter = value.toString();
                          });
                        },
                      ),
                      RadioListTile(
                        title: Text("Pending"),
                        value: 'Pending',
                        groupValue: selectedFilter,
                        onChanged: (value) {
                          setState(() {
                            selectedFilter = value.toString();
                          });
                        },
                      ),
                      RadioListTile(
                        title: Text("Accepted"),
                        value: 'Accepted',
                        groupValue: selectedFilter,
                        onChanged: (value) {
                          setState(() {
                            selectedFilter = value.toString();
                          });
                        },
                      ),
                      RadioListTile(
                        title: Text("Missed"),
                        value: 'Missed',
                        groupValue: selectedFilter,
                        onChanged: (value) {
                          setState(() {
                            selectedFilter = value.toString();
                          });
                        },
                      ),
                      RadioListTile(
                        title: Text("Rejected"),
                        value: 'Rejected',
                        groupValue: selectedFilter,
                        onChanged: (value) {
                          setState(() {
                            selectedFilter = value.toString();
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
