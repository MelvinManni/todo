import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? id;
  final String? name;
  final String? email;

  const User({this.id, this.name, this.email});

  bool get isEmpty => id == null;
  

  @override
  List<Object?> get props => [id, name, email];
}
