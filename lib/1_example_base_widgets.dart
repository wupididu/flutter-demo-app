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
                  _TextExample(),
                  _IconExample(),
                  _ButtonsExample(),
                  _ContainerExample(),
                ],
              ),
            ),
          ),
        ),
      );
}

class _ContainerExample extends StatelessWidget {
  const _ContainerExample();

  @override
  Widget build(BuildContext context) {
    return ExamplePad(
      title: 'Container',
      center: true,
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          color: Colors.amber,
          border: Border.all(width: 5),
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        transform: Matrix4.rotationZ(0.2),
      ),
    );
  }
}

class _ButtonsExample extends StatelessWidget {
  const _ButtonsExample();

  @override
  Widget build(BuildContext context) {
    return ExamplePad(
      title: 'Buttons',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
            onPressed: () {
              // do some action
            },
            child: const Text('Elevated Button'),
          ),
          TextButton(
            onPressed: () {
              // do some action
            },
            child: const Text('Text Button'),
          ),
          IconButton(
            onPressed: () {
              // do some action
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}

class _IconExample extends StatelessWidget {
  const _IconExample();

  @override
  Widget build(BuildContext context) {
    return const ExamplePad(
      title: 'Icon',
      child: Icon(Icons.thumb_up),
    );
  }
}

class _TextExample extends StatelessWidget {
  const _TextExample();

  @override
  Widget build(BuildContext context) {
    return const ExamplePad(
      title: 'Text',
      center: true,
      child: Text(
        'Hello World',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
