import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/data/models/todo_item_model.dart';

class TodoRepository {
  final FirebaseFirestore _firestore;

  TodoRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Stream<List<TodoItem>> todos({required String userId}) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('todos')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => TodoItem.fromData({...doc.data(), "id": doc.id}))
          .toList();
    });
  }

  Future<TodoItem> add({required String userId, required TodoItem todo}) async {
    final docRef = await _firestore
        .collection('users')
        .doc(userId)
        .collection('todos')
        .add(todo.toData());

    final doc = docRef.id;
    return TodoItem(id: doc, user: userId, task: todo.task);
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
