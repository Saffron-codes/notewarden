import 'package:flutter/material.dart';
import 'package:note_warden/providers/report_provider.dart';
import 'package:note_warden/utils/enums.dart';
import 'package:provider/provider.dart';

class ReportView extends StatefulWidget {
  const ReportView({Key? key}) : super(key: key);

  @override
  _ReportViewState createState() => _ReportViewState();
}

class _ReportViewState extends State<ReportView> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  bool isBug = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final title = _titleController.text;
      final description = _descriptionController.text;


      Provider.of<ReportProvider>(context,listen: false).uploadReport(title,description,isBug);

      _titleController.clear();
      _descriptionController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Submitted Successfully')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final title = ModalRoute.of(context)!.settings.arguments as String;
    isBug = ModalRoute.of(context)!.settings.arguments as String == "Bug";

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 16),
              TextFormField(
                controller: _titleController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: 'Title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              Spacer(),
              Consumer<ReportProvider>(
                builder: (context,viewModel,child) {
                  return ElevatedButton(
                    onPressed: viewModel.reportUploadTaskState == TaskState.loading?null: _submitForm,
                    child: const Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Text('Submit'),
                    ),
                  );
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
