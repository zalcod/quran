import 'package:equatable/equatable.dart';
import 'package:fabrikod_quran/constants/constants.dart';
import 'package:fabrikod_quran/models/verse_model.dart';

class BookMarkModel extends Equatable {
  final EBookMarkType bookmarkType;
  final VerseModel verseModel;

  const BookMarkModel({required this.bookmarkType, required this.verseModel});

  factory BookMarkModel.fromJson(Map<String, dynamic> json) => BookMarkModel(
        bookmarkType: EBookMarkType.values[json['bookMarkType'] as int],
        verseModel: VerseModel.fromJson(json['verseModel']),
      );

  Map<String, dynamic> toJson() => {
        'bookMarkType': bookmarkType.index,
        'verseModel': verseModel.toJson(),
      };

  @override
  // TODO: implement props
  List<Object?> get props => [bookmarkType, verseModel.verseKey];
}
