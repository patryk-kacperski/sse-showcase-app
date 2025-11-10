import 'package:equatable/equatable.dart';

class WikimediaChangeItem extends Equatable {
  const WikimediaChangeItem({
    required this.user,
    required this.title,
    required this.timestamp,
    required this.comment,
  });

  final String user;
  final String title;
  final int timestamp;
  final String comment;

  @override
  List<Object?> get props => [user, title, timestamp, comment];
}
