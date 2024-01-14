import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyBagScreen(),
    );
  }
}

class MyBagScreen extends StatefulWidget {
  const MyBagScreen({Key? key}) : super(key: key);

  @override
  State<MyBagScreen> createState() => _MyBagScreenState();
}

class _MyBagScreenState extends State<MyBagScreen> {
  List<Map<String, dynamic>> cartItems = [
    {
      'itemName': 'Pullover',
      'itemColor': 'Black',
      'itemSize': 'L',
      'itemCount': 1,
      'itemPrice': 51,
      'imagePath': 'images/pullover.png',
    },
    {
      'itemName': 'T-Shirt',
      'itemColor': 'Gray',
      'itemSize': 'L',
      'itemCount': 1,
      'itemPrice': 30,
      'imagePath': 'images/tshirt.png',
    },
    {
      'itemName': 'Sport Dress',
      'itemColor': 'Blue',
      'itemSize': 'M',
      'itemCount': 1,
      'itemPrice': 43,
      'imagePath': 'images/sportdress.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "    My Bag",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: cartItems.length,
              itemBuilder: (BuildContext context, int index) {
                var item = cartItems[index];
                return Card(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 120,
                          child: AspectRatio(
                            aspectRatio: 1.0,
                            child: Image(
                              width: double.infinity,
                              height: double.infinity,
                              image: AssetImage(item['imagePath']),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    item['itemName'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.more_horiz),
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                              Text(
                                'Color: ${item['itemColor']} Size: ${item['itemSize']}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 15),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      FloatingActionButton(
                                        onPressed: () {
                                          setState(() {
                                            if (item['itemCount'] > 0) {
                                              item['itemCount']--;
                                            }
                                            if (item['itemCount'] == 5) {
                                              _showItemAddedDialog(
                                                  item['itemName']);
                                            }
                                          });
                                        },
                                        mini: true,
                                        heroTag: null,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        child: const Icon(Icons.remove),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(item['itemCount']
                                          .toString()), // Item count
                                      const SizedBox(width: 8),
                                      FloatingActionButton(
                                        onPressed: () {
                                          setState(() {
                                            item['itemCount']++;
                                            if (item['itemCount'] == 5) {
                                              _showItemAddedDialog(
                                                  item['itemName']);
                                            }
                                          });
                                        },
                                        mini: true,
                                        heroTag: null,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        child: const Icon(Icons.add),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '\$${(item['itemPrice'] * item['itemCount']).toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total Amount:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '\$${_calculateTotalAmount().toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ElevatedButton(
              onPressed: _checkout,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text(
                'CHECK OUT',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  void _showItemAddedDialog(String itemName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(
            child: Text(
              'Congratulations!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('You have added'),
              const Text('   5  '),
              Text('$itemName on your bag!'),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: const Size(double.infinity, 40),
              ),
              child: const Text(
                'OKAY',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _checkout() {
    double totalAmount = _calculateTotalAmount();
    final snackBar = SnackBar(
      content: Text(
          'Congratulations! Your total amount is \$${totalAmount.toStringAsFixed(2)}'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  double _calculateTotalAmount() {
    return cartItems.fold(
        0,
        (previousValue, item) =>
            previousValue + item['itemPrice'] * item['itemCount']);
  }
}
