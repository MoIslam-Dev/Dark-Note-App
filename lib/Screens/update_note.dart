// @dart=2.9
import 'package:flutter/material.dart';
import 'package:note_app/Models/notes.dart';
import 'package:note_app/db/database_provider.dart';
import 'package:note_app/main.dart';

class UpdateNote extends StatefulWidget {
  

  @override
  _UpdateNoteState createState() => _UpdateNoteState();
}

class _UpdateNoteState extends State<UpdateNote> {
   String title;
   String body;
   DateTime date;
  // Update Note
  Update(Notes notes) {
    DatabaseProvider.db.updateNote(notes);
    print('Note Updated Succesfully');
  }

  @override
  Widget build(BuildContext context) {
     Notes notes = ModalRoute.of(context).settings.arguments as Notes;
     // The Inputs Controller
  TextEditingController titleController = TextEditingController(text: notes.title);
  TextEditingController bodyController = TextEditingController(text: notes.body);
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Note Screen'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                  border: InputBorder.none),
              style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
            ),
            Expanded(
                child: TextField(
              
              controller: bodyController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                  border: InputBorder.none,  ),
            ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          setState(() {
            
            title = titleController.text;
            body = bodyController.text;
            date = DateTime.tryParse(DateTime.now().toString());
                      // String
//var dtStr = date.toIso8601String();
//date = DateTime.tryParse(dtStr);
          });

           notes = Notes(id: notes.id,title: title,body: body,creation_date: date);
          Update(notes);
          print(notes.toMap());
          Navigator.pushNamedAndRemoveUntil(context, 'HomePage', (route) => false);
        },
        label: Text('Save Note'),
        icon: Icon(Icons.save),
      ),
    );
  }
}
