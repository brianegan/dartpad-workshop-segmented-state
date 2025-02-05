// TODO (5): Remove this line
// ignore_for_file: unused_import
import 'dart:math' as math show Random;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  BlocOverrides.runZoned(
    () => runApp(
      const SegmentedStateApp(
        shapeRepository: ShapeRepository(),
      ),
    ),
    blocObserver: SegmentedStateBlocObserver(),
  );
}

class SegmentedStateApp extends StatelessWidget {
  const SegmentedStateApp({
    required this.shapeRepository,
  });

  final ShapeRepository shapeRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: shapeRepository,
      child: MaterialApp(
        title: 'Segmented State Pattern',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const ShapePage(
          title: 'Segmented State Pattern using flutter_bloc',
        ),
      ),
    );
  }
}

class ShapePage extends StatelessWidget {
  const ShapePage({
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return ShapeView(title: title);
  }
}

class ShapeView extends StatelessWidget {
  const ShapeView({
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: const Center(
        child: Shape(),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.refresh),
        onPressed: () {},
      ),
    );
  }
}

class Shape extends StatelessWidget {
  const Shape({
    this.shapeData,
  });

  final ShapeData? shapeData;

  @override
  Widget build(BuildContext context) {
    return shapeData == null
        ? const SizedBox(
            height: 250.0,
            width: 250.0,
            child: Placeholder(),
          )
        : Container(
            color: shapeData!.color,
            height: shapeData!.height,
            width: shapeData!.width,
          );
  }
}

// --------------------------------------------
// Below this line are BLoC and data classes

// BLoC classes will be added here

// --------------------------------------------
// BLoC observer

class SegmentedStateBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('BLoC created');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('BLoC state changed: $change');
  }
}

// --------------------------------------------
// Shape data

class ShapeDataException implements Exception {
  @override
  String toString() => 'Error while loading shape data.';
}

class ShapeRepository {
  const ShapeRepository();

  Future<ShapeData> getShapeData() async {
    // TODO (1): Create an instance of math.Random()

    // Simulate asynchronous data loading
    await Future.delayed(const Duration(seconds: 1));

    // TODO (2): If random.nextBool() returns true, throw ShapeDataException

    // TODO (3): Generate color, height and width values

    // TODO (4): Use generated values to create a ShapeData object
    return const ShapeData(color: Colors.blue, height: 200.0, width: 200.0);
  }
}

@immutable
class ShapeData {
  const ShapeData({
    required this.color,
    required this.height,
    required this.width,
  });

  final Color color;
  final double height;
  final double width;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ShapeData &&
        other.color == color &&
        other.height == height &&
        other.width == width;
  }

  @override
  int get hashCode => color.hashCode ^ height.hashCode ^ width.hashCode;

  @override
  String toString() {
    return 'ShapeData(color: $color, height: $height, width: $width)';
  }
}
