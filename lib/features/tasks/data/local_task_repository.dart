import '../domain/task.dart';
import 'task_repository.dart';

class LocalTaskRepository implements TaskRepository {
  final List<Task> _tasks = [
    const Task(
      id: 1,
      title: 'Leer documentación',
      description: 'Revisar el material de Flutter',
      priority: 'Alta',
      isCompleted: false,
      userId: 1,
    ),
    const Task(
      id: 2,
      title: 'Diseñar pantalla',
      description: 'Dibujar la lista de tareas',
      priority: 'Media',
      isCompleted: false,
      userId: 1,
    ),
    const Task(
      id: 3,
      title: 'Preparar evidencia',
      description: 'Tomar capturas del avance',
      priority: 'Baja',
      isCompleted: true,
      userId: 1,
    ),
  ];

  @override
  Future<List<Task>> getTasks() async => List.unmodifiable(_tasks);

  @override
  void save(Task task) {
    final index = _tasks.indexWhere((item) => item.id == task.id);
    if (index == -1) return;
    _tasks[index] = task;
  }

  @override
  Future<Task> createTask(
    String title,
    String description,
    String priority,
  ) async {
    final nextId = _tasks.isEmpty
        ? 1
        : _tasks.map((task) => task.id).reduce((a, b) => a > b ? a : b) + 1;
    final task = Task(
      id: nextId,
      title: title,
      description: description,
      priority: priority,
      isCompleted: false,
      userId: 1,
    );
    _tasks.add(task);
    return task;
  }

  @override
  Future<void> updateTask(Task task) async => save(task);

  @override
  Future<void> deleteTask(int id) async {
    _tasks.removeWhere((task) => task.id == id);
  }
}
