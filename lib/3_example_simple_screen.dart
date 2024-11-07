import 'package:demo/utils/post_data.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  final _items = MockItems.items;

  MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('My App'),
          ),
          body: ListView.builder(
            itemCount: _items.length,
            itemBuilder: (context, index) => Container(
              margin: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 32,
              ),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.amber,
                border: Border.all(width: 5),
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Это виджет, который позволяет пропорцианально разбить виджеты в списке.
                    // Например, здесь пространство разбивается на 4 части, 3, из которых, занимает первый элемент,
                    // и 1-у часть занимает второй элемент
                    Flexible(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              _items[index].message,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              child: Text(_items[index].author),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          icon: const Icon(
                            Icons.thumb_up,
                            color: Colors.deepPurpleAccent,
                          ),
                          onPressed: () {
                            // do action for like post
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'User',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
          ),
        ),
      );
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
