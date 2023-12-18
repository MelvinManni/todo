class TodoItem {
  String id = "";
  String user = "";
  String task = "";

  TodoItem({ this.id = "", required this.user, required this.task});

  TodoItem.fromData(Map<String, dynamic> data) {
    id = data['id'] ?? "";
    user = data['user'] ?? "";
    task = data['task'] ?? "";
  }

  Map<String, dynamic> toData() {
    return {
      'id': id,
      'user': user,
      'task': task,
    };
  }
}
