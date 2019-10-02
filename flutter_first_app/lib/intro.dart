import 'dart:math';

void main() {
  final bike1 = Bicycle(2, 0, 1);
  var bike2 = Bicycle(3, 0, 1);
  print(bike1.speed);
  bike1.speedUp(2);
  print(bike1.speed);
  print(bike1);

  final rect = Rectangle(height: 5);
  print(rect);

  final circle = Circle(2);
  final square = Square(3);
  print(circle.area);
  print(square.area);

  var shape = shapeFactory(Type.SQUARE);
  print(shape);
  shape = shapeFactory(Type.CIRCLE);
  print(shape);
  try {
    shape = shapeFactory(Type.WTF);
    print(shape);
  } catch (exception) {
    print(exception);
  }

  final values = [1, 2, 3, 5, 8, 13];
  for (var value in values) {
    print(scream(value)); //functions are objects and have a type, Function.
  }

  //Lists and Iterables, from dart:collection, support fold, where, join, skip, and more. Dart also has Maps and Sets.
  values.skip(1)
      .take(3)
      .map(scream)
      .forEach(print);

  print(values.skip(1)
      .fold(0, (prep, element) => prep + element)
      .toString());//2 + 3 + 5 + 8 + 13

  print(values.join(",").toString());
  print(values.where((input) => input % 2 == 0).toString());
  //Lists and Iterables, from dart:collection, support fold, where, join, skip, and more. Dart also has Maps and Sets.

}

class Bicycle {
  int cadence;
  int _speed = 0; //用_開頭命名為private
  int get speed => _speed;
  int gear;

  Bicycle(this.cadence, this._speed, this.gear); //constructor

  void applyBrake(int decrement) {
    _speed -= decrement;
  }

  void speedUp(int increment) {
    _speed += increment;
  }

  @override
  String toString() => 'Bicycle: $_speed mph';
}

class Rectangle {
  int width;
  int height;
  Point origin;

  Rectangle(
      {this.origin = const Point(1, 2),
      this.width = 3,
      this.height}); //建構子設定預設值

  @override
  String toString() => 'Origin: $origin width:$width height:$height';
}

abstract class Shape {
  num get area;
}

class Circle implements Shape {
  final num radius;

  Circle(this.radius);

  @override
  num get area => pi * pow(radius, 2);
}

//The Dart language doesn't include an interface keyword because every class defines an interface.
class CircleMock implements Circle {
  @override
  num get area => null;

  @override
  // TODO: implement radius
  num get radius => null;
}

enum Type { CIRCLE, SQUARE, WTF }

class Square implements Shape {
  final num side;

  Square(this.side);

  @override
  num get area => pow(side, 2);
}

Shape shapeFactory(Type type) {
  if (type == Type.CIRCLE) return Circle(2);
  if (type == Type.SQUARE) return Square(3);
  throw 'Can\'t create $type';
}

String scream(num length) => "A${'a' * length}h!";
