class TodoItem {
  String? id;
  String? user;
  String? task;

  TodoItem({this.id, this.user, this.task});

  bool get isEmpty => id == null;
}
