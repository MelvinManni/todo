import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/data/models/todo_item_model.dart';

class TodoRepository {
  final FirebaseFirestore _firestore;

  TodoRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<List<TodoItem>> todos({required String userId}) async {
    final docSnapshot = await _firestore
        .collection('users')
        .doc(userId)
        .collection('todos').get();

    final todos =
        docSnapshot.docs.map((doc) => TodoItem.fromData(doc.data())).toList();

    return todos;
  }

  Future<TodoItem> add({required String userId, required String task}) async {
    final docRef = await _firestore
        .collection('users')
        .doc(userId)
        .collection('todos')
        .add({'task': task, 'user': userId});

    final doc = docRef.id;
    return TodoItem(id: doc, user: userId, task: task);
  }

  Future<void> delete({required String userId, required String todoId}) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('todos')
        .doc(todoId)
        .delete();
  }
}
