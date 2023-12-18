import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String? email;

  const User({required this.id, this.email});

  static const empty = User(id: '');

  bool get isEmpty => this == User.empty;

  @override
  List<Object?> get props => [id, email];
}
