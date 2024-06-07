import 'package:equatable/equatable.dart';

class TrendItem extends Equatable {
  String id;
  final String title;
  final String image;

  TrendItem({required this.title, required this.image, required this.id});

  TrendItem.empty()
      : id = "",
        title = "",
        image = "";

  TrendItem copyWith({String? title, String? id, String? image}) {
    return TrendItem(
        id: id ?? this.id,
        title: title ?? this.title,
        image: image ?? this.image);
  }

  @override
  List<Object?> get props => [id, title, image];
}
