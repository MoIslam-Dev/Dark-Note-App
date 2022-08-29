// @dart=2.9
import 'package:flutter/material.dart';
import 'package:note_app/Models/notes.dart';
import 'package:note_app/Screens/update_note.dart';
import 'package:note_app/db/database_provider.dart';

class Display_Note extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Notes notes = ModalRoute.of(context).settings.arguments as Notes;
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
             Navigator.pushNamed(context, 'Update',arguments: notes);
             print(notes.toMap());
          },
          label: Text('Edit Note'),
          icon: Icon(
            Icons.edit_outlined,
          ),
          ),
      appBar: AppBar(
        title: Text('Note Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            color: Colors.white,
            iconSize: 40,
            onPressed: () {
              DatabaseProvider.db.deleteNote(notes.id);
               Navigator.pushNamedAndRemoveUntil(context, 'HomePage', (route) => false);
              
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              notes.title,
              style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
              child: SizedBox(
                height: 5,
                child: Container(color: Colors.grey.withOpacity(0.4)),
              ),
            ),
            Text(
              
              notes.body,
              style: TextStyle(fontSize: 18.0),
            )
          ],
        ),
      ),
    );
  }
}
