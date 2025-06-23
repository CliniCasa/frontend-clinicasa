import 'package:flutter/material.dart';
import '../models/worker.dart';
import '../services/worker_service.dart';

class WorkersListScreen extends StatefulWidget {
  const WorkersListScreen({super.key});

  @override
  State<WorkersListScreen> createState() => _WorkersListScreenState();
}

class _WorkersListScreenState extends State<WorkersListScreen> {
  List<Worker> workers = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _loadWorkers();
  }

  Future<void> _loadWorkers() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = null;
      });

      final workersList = await WorkerService.getWorkers();

      setState(() {
        workers = workersList;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Erro ao carregar funcionários: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Funcionários'),
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: _loadWorkers),
        ],
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddWorkerDialog,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildBody() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              errorMessage!,
              style: const TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadWorkers,
              child: const Text('Tentar Novamente'),
            ),
          ],
        ),
      );
    }

    if (workers.isEmpty) {
      return const Center(child: Text('Nenhum funcionário encontrado'));
    }

    return ListView.builder(
      itemCount: workers.length,
      itemBuilder: (context, index) {
        final worker = workers[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: ListTile(
            title: Text(worker.name),
            subtitle: Text(worker.email),
            trailing: Chip(label: Text(worker.role)),
            onTap: () => _showWorkerDetails(worker),
          ),
        );
      },
    );
  }

  void _showWorkerDetails(Worker worker) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(worker.name),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Email: ${worker.email}'),
            Text('Cargo: ${worker.role}'),
            Text('ID: ${worker.id}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }

  void _showAddWorkerDialog() {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    String selectedRole = 'Enfermeira';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Adicionar Funcionário'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: selectedRole,
              decoration: const InputDecoration(labelText: 'Cargo'),
              items: const [
                DropdownMenuItem(
                  value: 'Enfermeira',
                  child: Text('Enfermeira'),
                ),
                DropdownMenuItem(
                  value: 'Massagista',
                  child: Text('Massagista'),
                ),
                DropdownMenuItem(
                  value: 'Fisioterapeuta',
                  child: Text('Fisioterapeuta'),
                ),
                DropdownMenuItem(value: 'Psicólogo', child: Text('Psicólogo')),
                DropdownMenuItem(value: 'Outros', child: Text('Outros')),
              ],
              onChanged: (value) {
                if (value != null) selectedRole = value;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () async {
              try {
                await WorkerService.createWorker(
                  name: nameController.text,
                  email: emailController.text,
                  role: selectedRole,
                );
                Navigator.pop(context);
                _loadWorkers();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Funcionário criado com sucesso!'),
                  ),
                );
              } catch (e) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('Erro: $e')));
              }
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }
}
