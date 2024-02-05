import 'package:hive/hive.dart';
part 'dog_model.g.dart';

@HiveType(typeId: 0)
class Dog {
  @HiveField(0)
  final String image;

  Dog(
    this.image,
  );
}
