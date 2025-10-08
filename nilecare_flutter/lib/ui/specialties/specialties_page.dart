import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/specialties_service.dart';

class SpecialtiesPage extends StatefulWidget {
  const SpecialtiesPage({Key? key}) : super(key: key);

  @override
  State<SpecialtiesPage> createState() => _SpecialtiesPageState();
}

class _SpecialtiesPageState extends State<SpecialtiesPage> {
  bool _isLoading = false;
  List<dynamic> _specialties = [];
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadSpecialties();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _loadSpecialties() async {
    setState(() => _isLoading = true);
    try {
      final specialtiesService =
          Provider.of<SpecialtiesService>(context, listen: false);
      final specialties = await specialtiesService.getSpecialties();
      setState(() {
        _specialties = specialties;
      });
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

  Future<void> _createSpecialty() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      final specialtiesService =
          Provider.of<SpecialtiesService>(context, listen: false);
      await specialtiesService.createSpecialty({
        'name': _nameController.text,
        'description': _descriptionController.text,
      });
      _nameController.clear();
      _descriptionController.clear();
      _loadSpecialties();
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
    }
  }

  Future<void> _updateSpecialty(
      String id, String name, String description) async {
    try {
      final specialtiesService =
          Provider.of<SpecialtiesService>(context, listen: false);
      await specialtiesService.updateSpecialty(
        id: id,
        data: {
          'name': name,
          'description': description,
        },
      );
      _loadSpecialties();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _deleteSpecialty(String id) async {
    try {
      final specialtiesService =
          Provider.of<SpecialtiesService>(context, listen: false);
      await specialtiesService.deleteSpecialty(id);
      _loadSpecialties();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _showAddEditDialog([Map<String, dynamic>? specialty]) {
    if (specialty != null) {
      _nameController.text = specialty['name'];
      _descriptionController.text = specialty['description'];
    } else {
      _nameController.clear();
      _descriptionController.clear();
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(specialty == null ? 'Add Specialty' : 'Edit Specialty'),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
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
          TextButton(
            onPressed: () {
              if (specialty == null) {
                _createSpecialty();
              } else {
                _updateSpecialty(
                  specialty['id'],
                  _nameController.text,
                  _descriptionController.text,
                );
                Navigator.pop(context);
              }
            },
            child: Text(specialty == null ? 'Add' : 'Update'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medical Specialties'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadSpecialties,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _specialties.isEmpty
              ? const Center(
                  child: Text('No specialties found'),
                )
              : ListView.builder(
                  itemCount: _specialties.length,
                  itemBuilder: (context, index) {
                    final specialty = _specialties[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: ListTile(
                        title: Text(specialty['name']),
                        subtitle: Text(specialty['description']),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () => _showAddEditDialog(specialty),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Delete Specialty'),
                                  content: Text(
                                    'Are you sure you want to delete ${specialty['name']}?',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        _deleteSpecialty(specialty['id']);
                                      },
                                      child: const Text('Delete'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddEditDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
