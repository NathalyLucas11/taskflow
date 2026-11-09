import 'package:flutter/material.dart';

// 1. Modelo de datos Task y lista demoTasks
class Task {
  const Task({
    required this.id,
    required this.title,
    required this.description,
    required this.priority,
    required this.isCompleted,
  });

  final int id;
  final String title;
  final String description;
  final String priority;
  final bool isCompleted;
}

final List<Task> demoTasks = [
  const Task(
    id: 1,
    title: 'Leer documentación',
    description: 'Revisar ListView.builder',
    priority: 'Alta',
    isCompleted: false,
  ),
  const Task(
    id: 2,
    title: 'Diseñar la pantalla',
    description: 'Definir la tarjeta de tarea',
    priority: 'Media',
    isCompleted: false,
  ),
  const Task(
    id: 3,
    title: 'Preparar evidencia',
    description: 'Tomar captura del avance',
    priority: 'Baja',
    isCompleted: true,
  ),
  const Task(
    id: 4,
    title: 'Organizar el backlog',
    description: 'Priorizar pendientes',
    priority: 'Alta',
    isCompleted: false,
  ),
  const Task(
    id: 5,
    title: 'Revisar código',
    description: 'Ejecutar flutter analyze',
    priority: 'Media',
    isCompleted: false,
  ),
];

void main() {
  runApp(const TaskFlowApp());
}

class TaskFlowApp extends StatelessWidget {
  const TaskFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TaskFlow',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final String studentName = 'Nathaly Lucas';
  static const dailyGoal = 5;

  List<Task> tasks = List.from(demoTasks);

  int get pendingTasks => tasks.where((t) => !t.isCompleted).length;
  int get completedTasks => tasks.where((t) => t.isCompleted).length;

  void _completeTask() {
    final index = tasks.indexWhere((t) => !t.isCompleted);
    if (index != -1) {
      setState(() {
        tasks[index] = Task(
          id: tasks[index].id,
          title: tasks[index].title,
          description: tasks[index].description,
          priority: tasks[index].priority,
          isCompleted: true,
        );
      });
    }
  }

  void _addTask() {
    setState(() {
      final newId = tasks.isEmpty ? 1 : tasks.last.id + 1;
      tasks.add(
        Task(
          id: newId,
          title: 'Nueva tarea #$newId',
          description: 'Descripción autogenerada',
          priority: 'Media',
          isCompleted: false,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final statusMessage = pendingTasks == 0
        ? '¡Excelente! No tienes tareas pendientes.'
        : 'Aún tienes tareas por organizar.';

    return Scaffold(
      appBar: AppBar(title: const Text('TaskFlow'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.rocket_launch, size: 56, color: Colors.indigo),
            const SizedBox(height: 24),
            Text(
              '¡Hola, $studentName!',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 12),
            Text(
              statusMessage,
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            const SizedBox(height: 8),
            Text(
              'Completadas hoy: $completedTasks de $dailyGoal',
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),

            // Botones de acción principales
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                ElevatedButton.icon(
                  onPressed: _addTask,
                  icon: const Icon(Icons.add),
                  label: const Text('Agregar tarea'),
                ),
                OutlinedButton.icon(
                  onPressed: pendingTasks == 0 ? null : _completeTask,
                  icon: const Icon(Icons.done),
                  label: const Text('Completar una tarea'),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // 2. Nuevo botón para navegar a la pantalla "TaskListScreen"
            FilledButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TaskListScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.list_alt),
              label: const Text('Ver todas las tareas'),
            ),
          ],
        ),
      ),
    );
  }
}

// 3. Tu nueva pantalla TaskListScreen agregada
class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mis tareas')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: demoTasks.length,
        itemBuilder: (context, index) {
          final task = demoTasks[index];
          return TaskCard(task: task);
        },
      ),
    );
  }
}

// 4. Tu componente TaskCard
class TaskCard extends StatelessWidget {
  const TaskCard({super.key, required this.task});

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(
          task.isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
          color: task.isCompleted ? Colors.green : null,
        ),
        title: Text(task.title),
        subtitle: Text('${task.priority} · ${task.description}'),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
