import 'app_models.dart';

Map<Type, dynamic Function(Map<String, dynamic>)> maptypeConverters = {
  Company: (data) => Company.fromJson(data),
  Post: (data) => Post.fromJson(data),
  Album: (data) => Album.fromJson(data),
};
