import 'package:flutter/material.dart';

void main() {
  runApp(const NotesApp());
}

class NotesApp extends StatelessWidget {
  const NotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 15, 109, 81)),
        useMaterial3: true,
      ),
      home: const NotesHomePage(),
    );
  }
}

class NotesHomePage extends StatefulWidget {
  const NotesHomePage({super.key});

  @override
  State<NotesHomePage> createState() => _NotesHomePageState();
}

class _NotesHomePageState extends State<NotesHomePage> {
  final List<String> _notes = [];

  void _addNote() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController controller = TextEditingController();
        return AlertDialog(
          title: const Text('추가하기'),
          content: TextField(
            controller: controller,
            autofocus: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: '노트를 입력하세요',
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('취소'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _notes.add(controller.text);
                });
                Navigator.of(context).pop();
              },
              child: const Text('저장'),
            ),
          ],
        );
      },
    );
  }

  void _deleteNote(int index) {
    setState(() {
      _notes.removeAt(index);
    });
  }

  Color _getNoteColor(int index) {
    int baseRed = 210; 
    int baseGreen = 180; 
    int baseBlue = 140;
    int colorStep = 20;
    int red = (baseRed - index * colorStep).clamp(100, 255);
    int green = (baseGreen - index * colorStep).clamp(70, 255);
    int blue = (baseBlue - index * colorStep).clamp(50, 255);
    return Color.fromARGB(255, red, green, blue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NOTES'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: _notes.length,
        itemBuilder: (context, index) {
          return Center(
            child: Card(
              color: _getNoteColor(index),
              elevation: 5,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 5,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
                title: Text(_notes[index]),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _deleteNote(index),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNote,
        tooltip: '추가하기',
        child: const Icon(Icons.add),
      ),
    );
  }
}
