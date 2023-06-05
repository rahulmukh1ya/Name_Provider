import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider<NameData>(
      create: (context) => NameData(),
      child: const MyApp(),
    ),
  );
}

class NameData with ChangeNotifier {
  String _name = 'Initial Name';
  String get name => _name;

  void updateName(String newName) {
    _name = newName;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Name Provider',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // final nameData = Provider.of<NameData>(context);
    final TextEditingController nameController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Name Change using Provider')),
      ),
      body: Center(
        child: Consumer<NameData>(
          builder: (context, nameData, child) => Text(
            nameData.name, 
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Change Name'),
              content: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Add new name'),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    final nameData = context.read<NameData>();
                    nameData.updateName(nameController.text.toString());
                    Navigator.pop(context);
                  },
                  child: const Text('Save'),
                )
              ],
            ),
          );
        },
        child: const Icon(Icons.edit),
      ),
    );
  }
}
