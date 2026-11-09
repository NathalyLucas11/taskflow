import 'package:flutter/material.dart';

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
  // Datos del estudiante y estado de las tareas
  final String studentName = 'Nathaly Lucas';
  int pendingTasks = 3;

  // 1. Nuevas variables agregadas según la guía
  static const dailyGoal = 5;
  int completedTasks = 0;

  void _completeTask() {
    if (pendingTasks == 0) {
      return;
    }

    // 2. setState actualizado con la lógica del objetivo diario
    setState(() {
      pendingTasks--;
      if (completedTasks < dailyGoal) {
        completedTasks++;
      }
    });
  }

  void _addTask() {
    setState(() {
      pendingTasks++;
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
            // 3. Nuevo texto para mostrar las tareas completadas vs la meta
            Text(
              'Completadas hoy: $completedTasks de $dailyGoal',
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 28),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    const Icon(Icons.pending_actions),
                    const SizedBox(width: 12),
                    Text('Tareas pendientes: $pendingTasks'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
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
          ],
        ),
      ),
    );
  }
}
