import 'package:flutter/material.dart';

class AddFolderDialog extends StatelessWidget {
  const AddFolderDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buat folder'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.title),
                  label: Text('Nama folder'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
