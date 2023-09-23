import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/routes.dart';
import 'package:flutter_application_1/services/auth/auth_service.dart';
import 'package:flutter_application_1/services/cloud/cloud_note.dart';
import 'package:flutter_application_1/services/cloud/firebase_cloud_storage.dart';
import 'package:flutter_application_1/views/notes/notes_list_view.dart';

class NotesSearchDelegate extends SearchDelegate {
  get notesService => FirebaseCloudStorage();
  get userId => AuthService.firebase().currentUser!.id;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
          // ignore: avoid_print
          print('query: $query');
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        // ignore: avoid_print
        print('close');
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return StreamBuilder(
      stream: notesService.allNotes(ownerUserId: userId),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
          case ConnectionState.active:
            if (snapshot.hasData) {
              final allNotes = snapshot.data as Iterable<CloudNote>;
              final filteredNotes = allNotes.where((note) {
                return note.text.toLowerCase().contains(query.toLowerCase());
              });
              return NotesListView(
                notes: filteredNotes,
                onDeleteNote: (note) async {
                  await notesService.deleteNote(
                    documentId: note.documentId,
                  );
                },
                onTap: (note) {
                  Navigator.of(context).pushNamed(
                    createOrUpdateNoteRoute,
                    arguments: note,
                  );
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          default:
            return const Center(
              child: CircularProgressIndicator(),
            );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return StreamBuilder(
      stream: notesService.allNotes(ownerUserId: userId),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
          case ConnectionState.active:
            if (snapshot.hasData) {
              final allNotes = snapshot.data as Iterable<CloudNote>;
              final filteredNotes = allNotes.where((note) {
                return note.text.toLowerCase().contains(query.toLowerCase());
              });
              return NotesListView(
                notes: filteredNotes,
                onDeleteNote: (note) async {
                  await notesService.deleteNote(
                    documentId: note.documentId,
                  );
                },
                onTap: (note) {
                  Navigator.of(context).pushNamed(
                    createOrUpdateNoteRoute,
                    arguments: note,
                  );
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          default:
            return const Center(
              child: CircularProgressIndicator(),
            );
        }
      },
    );
  }
}
