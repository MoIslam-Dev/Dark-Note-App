// ignore_for_file: prefer_const_constructors

// @dart=2.9
import 'package:flutter/material.dart';
import 'package:note_app/Models/notes.dart';
import 'package:note_app/Screens/add_notes.dart';
import 'package:note_app/Screens/display_note.dart';
import 'package:note_app/Screens/update_note.dart';
import 'package:note_app/db/database_provider.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
     initialRoute: 'HomePage',
      routes: {
        'HomePage': (context) => HomePage(),
        'Display': (context) => Display_Note(),
        'Update' : (context)=> UpdateNote()
      },
      
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Getting All Notes
  getNotes() async {
    final notes = await DatabaseProvider.db.getNotes();
    return notes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Notes'),
      ),
      body: FutureBuilder(
          future: getNotes(),
          // ignore: missing_return
          builder: (context, noteData) {
            switch (noteData.connectionState) {
              case ConnectionState.waiting:
                {
                  return Center(child: CircularProgressIndicator());
                }
              case ConnectionState.done:
                {
                  if (noteData.data == Null) {
                    return Center(
                      child:
                          Text('You Donts Have any Notes Yet , Create Some ! '),
                    );
                  } else {
                    return Padding(
                      padding: EdgeInsets.all(10),
                      child: ListView.builder(
                        itemCount: noteData.data.length,
                        itemBuilder: (context, index) {
                          int id = noteData.data[index]['id'];
                          String title = noteData.data[index]['title'];
                          String body = noteData.data[index]['body'];
                          DateTime creation_date =
                          DateTime.tryParse(noteData.data[index]['creation_date']);
                          return Card(
                            
                            child: ListTile(
                              
                              trailing: Text(noteData.data[index]['creation_date']), 
                              onTap: (){
                               Navigator.pushNamed(context, 'Display',arguments: Notes(
                                 id: id,
                                 title:title ,
                                 body: body,
                                 creation_date:  creation_date
                               ));
                              },
                              title: Text(title,style: TextStyle(color: Colors.white,fontWeight : FontWeight.bold,fontSize: 25,overflow: TextOverflow.ellipsis)),
                              subtitle: Text(body,overflow: TextOverflow.ellipsis,),
                              
                            ),
                          );
                        },
                      ),
                    );
                  }
                  break;
                }
              case ConnectionState.none:
                // TODO: Handle this case.
                break;
              case ConnectionState.active:
                // TODO: Handle this case.
                break;
            }
          }),
          floatingActionButton: FloatingActionButton(
            onPressed :(){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return AddNotes();

              }));

            },
            child: Icon(Icons.note_add),
          ),
    );
  }
}
