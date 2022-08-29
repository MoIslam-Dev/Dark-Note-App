// @dart=2.9
import 'package:flutter/material.dart';
import 'package:note_app/Models/notes.dart';
import 'package:note_app/db/database_provider.dart';
import 'package:note_app/main.dart';

class AddNotes extends StatefulWidget {
  @override
  _AddNotesState createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  String title;
  String body;
  DateTime date;
  // The Inputs Controller
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  // Add Note Method
  addNote(Notes notes) {
    DatabaseProvider.db.addNewNote(notes);
    print('Note Add Succesfully');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Note Screen'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: 'Note Title'),
              style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
            ),
            Expanded(
                child: TextField(
              controller: bodyController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: 'Your Note'),
            ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          setState(() {
            title = titleController.text;
            body = bodyController.text;
            date = DateTime.now();
            // String
//var dtStr = date.toIso8601String();
//date = DateTime.tryParse(dtStr);
          });

          Notes notes = Notes(title: title, body: body, creation_date: date);
          addNote(notes);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        },
        label: Text('Save Note'),
        icon: Icon(Icons.save),
      ),
    );
  }
}
