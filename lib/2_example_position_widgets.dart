import 'package:flutter/material.dart';

import 'utils/example_pad.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Demo'),
          ),
          body: const SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _CenterExample(),
                  _ContainerExample(),
                  _PaddingExample(),
                  _ColumnExample(),
                  _RowExample(),
                  _ListViewVerticalExample(),
                  _ListViewHorizontalExample(),
                  _ListViewBuilderExample(),
                ],
              ),
            ),
          ),
        ),
      );
}

class _ListViewVerticalExample extends StatelessWidget {
  const _ListViewVerticalExample();

  @override
  Widget build(BuildContext context) {
    return ExamplePad(
      title: 'ListView vertical',
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Container(
            margin: const EdgeInsets.all(8),
            height: 100,
            color: Colors.amber,
          ),
          Container(
            margin: const EdgeInsets.all(8),
            height: 100,
            color: Colors.amber,
          ),
          Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.symmetric(vertical: 8),
            height: 100,
            color: Colors.amber,
          ),
        ],
      ),
    );
  }
}

class _ListViewHorizontalExample extends StatelessWidget {
  const _ListViewHorizontalExample();

  @override
  Widget build(BuildContext context) {
    return ExamplePad(
      title: 'ListView horizontal',
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            margin: const EdgeInsets.all(8),
            width: 100,
            color: Colors.amber,
          ),
          Container(
            margin: const EdgeInsets.all(8),
            width: 100,
            color: Colors.amber,
          ),
          Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.symmetric(vertical: 8),
            width: 100,
            color: Colors.amber,
          ),
        ],
      ),
    );
  }
}

class _ListViewBuilderExample extends StatelessWidget {
  const _ListViewBuilderExample();

  @override
  Widget build(BuildContext context) {
    return ExamplePad(
      title: 'ListView.builder',
      child: ListView.builder(
        itemCount: 100,
        itemBuilder: (context, index) => Container(
          margin: const EdgeInsets.all(8),
          height: 100,
          color: Colors.amber,
          alignment: Alignment.center,
          child: Text('Item $index'),
        ),
      ),
    );
  }
}

class _PaddingExample extends StatelessWidget {
  const _PaddingExample();

  @override
  Widget build(BuildContext context) {
    return ExamplePad(
      title: 'Padding',
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        // padding: const EdgeInsets.fromLTRB(6, 8, 12, 0),
        // padding: const EdgeInsets.symmetric(horizontal: 16),
        // padding: const EdgeInsets.symmetric(vertical: 16),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.amber,
            border: Border.all(width: 2),
          ),
        ),
      ),
    );
  }
}

class _ContainerExample extends StatelessWidget {
  const _ContainerExample();

  @override
  Widget build(BuildContext context) {
    return ExamplePad(
      title: 'Container',
      child: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            child: Container(
              width: 10,
              height: 10,
              color: Colors.amber,
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Container(
              width: 10,
              height: 10,
              color: Colors.grey,
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            child: Container(
              width: 10,
              height: 10,
              color: Colors.grey,
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: 10,
              height: 10,
              color: Colors.grey,
            ),
          ),
          Container(
            alignment: Alignment.bottomLeft,
            child: Container(
              width: 10,
              height: 10,
              color: Colors.grey,
            ),
          ),
          Container(
            alignment: Alignment.bottomRight,
            child: Container(
              width: 10,
              height: 10,
              color: Colors.grey,
            ),
          ),
          Container(
            alignment: Alignment.topCenter,
            child: Container(
              width: 10,
              height: 10,
              color: Colors.grey,
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            child: Container(
              width: 10,
              height: 10,
              color: Colors.grey,
            ),
          ),
          Container(
            alignment: Alignment.topRight,
            child: Container(
              width: 10,
              height: 10,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

class _RowExample extends StatelessWidget {
  const _RowExample();

  @override
  Widget build(BuildContext context) {
    return ExamplePad(
      title: 'Row',
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.amber,
              border: Border.all(width: 2),
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            width: 40,
            height: 40,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.amber,
              border: Border.all(width: 2),
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            width: 40,
            height: 40,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.amber,
              border: Border.all(width: 2),
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            width: 40,
            height: 40,
          )
        ],
      ),
    );
  }
}

class _ColumnExample extends StatelessWidget {
  const _ColumnExample();

  @override
  Widget build(BuildContext context) {
    return ExamplePad(
      title: 'Column',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.amber,
              border: Border.all(width: 2),
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            width: 40,
            height: 40,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.amber,
              border: Border.all(width: 2),
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            width: 40,
            height: 40,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.amber,
              border: Border.all(width: 2),
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            width: 40,
            height: 40,
          )
        ],
      ),
    );
  }
}

class _CenterExample extends StatelessWidget {
  const _CenterExample();

  @override
  Widget build(BuildContext context) {
    return ExamplePad(
      title: 'Center',
      child: Center(
        child: Container(
          width: 10,
          height: 10,
          color: Colors.amber,
        ),
      ),
    );
  }
}
