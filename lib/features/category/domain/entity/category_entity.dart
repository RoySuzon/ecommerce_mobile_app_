// domain/entity/category_entity.dart

abstract class CategoryEntity {
  final int id;
  final String name;

  const CategoryEntity({
    required this.id,
    required this.name,
  });
}
