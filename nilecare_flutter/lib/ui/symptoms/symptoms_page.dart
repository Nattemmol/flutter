import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/symptom_service.dart';
import '../../services/auth_service.dart';

class SymptomsPage extends StatefulWidget {
  const SymptomsPage({Key? key}) : super(key: key);

  @override
  State<SymptomsPage> createState() => _SymptomsPageState();
}

class _SymptomsPageState extends State<SymptomsPage> {
  bool _isLoading = false;
  List<Map<String, dynamic>> _symptoms = [];
  String? _userId;
  final _formKey = GlobalKey<FormState>();
  final _symptomController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _severityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadSymptoms();
  }

  @override
  void dispose() {
    _symptomController.dispose();
    _descriptionController.dispose();
    _severityController.dispose();
    super.dispose();
  }

  Future<void> _loadSymptoms() async {
    setState(() => _isLoading = true);
    try {
      final symptomService =
          Provider.of<SymptomService>(context, listen: false);
      final authService = Provider.of<AuthService>(context, listen: false);
      final currentUser = await authService.getCurrentUser();
      _userId = currentUser.id;

      if (_userId == null) {
        throw Exception('User ID not found');
      }

      final symptoms = await symptomService.getSymptoms();
      setState(() {
        _symptoms = symptoms.cast<Map<String, dynamic>>();
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _addSymptom() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    try {
      final symptomService =
          Provider.of<SymptomService>(context, listen: false);
      await symptomService.createSymptom({
        'userId': _userId,
        'name': _symptomController.text,
        'description': _descriptionController.text,
        'severity': int.parse(_severityController.text),
        'status': 'active',
      });

      _symptomController.clear();
      _descriptionController.clear();
      _severityController.clear();
      _loadSymptoms();

      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _updateSymptomStatus(String id, String status) async {
    setState(() => _isLoading = true);
    try {
      final symptomService =
          Provider.of<SymptomService>(context, listen: false);
      await symptomService.updateSymptom(
        id: id,
        data: {'status': status},
      );
      _loadSymptoms();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showAddSymptomDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Symptom'),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _symptomController,
                decoration: const InputDecoration(labelText: 'Symptom Name'),
                validator: (value) => value?.isEmpty ?? true
                    ? 'Please enter a symptom name'
                    : null,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 3,
              ),
              TextFormField(
                controller: _severityController,
                decoration: const InputDecoration(labelText: 'Severity (1-10)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter severity level';
                  }
                  final severity = int.tryParse(value!);
                  if (severity == null || severity < 1 || severity > 10) {
                    return 'Please enter a number between 1 and 10';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: _addSymptom,
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Symptoms'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _symptoms.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.medical_services,
                        size: 64,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No symptoms recorded',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _symptoms.length,
                  itemBuilder: (context, index) {
                    final symptom = _symptoms[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  symptom['name'],
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                _buildStatusChip(symptom['status']),
                              ],
                            ),
                            if (symptom['description']?.isNotEmpty ??
                                false) ...[
                              const SizedBox(height: 8),
                              Text(
                                symptom['description'],
                                style: TextStyle(
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(Icons.warning, size: 16),
                                const SizedBox(width: 4),
                                Text(
                                  'Severity: ${symptom['severity']}/10',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  _formatDate(symptom['createdAt']),
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                if (symptom['status'] == 'active')
                                  TextButton(
                                    onPressed: () => _updateSymptomStatus(
                                        symptom['id'], 'resolved'),
                                    child: const Text('Mark as Resolved'),
                                  ),
                                if (symptom['status'] == 'resolved')
                                  TextButton(
                                    onPressed: () => _updateSymptomStatus(
                                        symptom['id'], 'active'),
                                    child: const Text('Mark as Active'),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddSymptomDialog,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color color;
    switch (status.toLowerCase()) {
      case 'active':
        color = Colors.orange;
        break;
      case 'resolved':
        color = Colors.green;
        break;
      default:
        color = Colors.grey;
    }

    return Chip(
      label: Text(
        status.toUpperCase(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
      ),
      backgroundColor: color,
    );
  }

  String _formatDate(String? dateString) {
    if (dateString == null) return '';
    final date = DateTime.parse(dateString);
    return '${date.day}/${date.month}/${date.year}';
  }
}
