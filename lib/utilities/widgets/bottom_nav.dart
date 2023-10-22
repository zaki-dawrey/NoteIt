import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/notes/notes_view.dart';
import 'package:flutter_application_1/views/todo_view.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomnavBar extends StatefulWidget {
  const BottomnavBar({super.key});

  @override
  State<BottomnavBar> createState() => _BottomnavBarState();
}

class _BottomnavBarState extends State<BottomnavBar> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildSelectedScreen(),
      bottomNavigationBar: Container(
        color: const Color.fromRGBO(140, 162, 217, 1),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 50,
            vertical: 8,
          ),
          child: GNav(
            iconSize: 23,
            rippleColor: Colors.grey,
            hoverColor: Colors.blueGrey,
            backgroundColor: const Color.fromRGBO(140, 162, 217, 1),
            duration: const Duration(milliseconds: 400),
            color: Colors.white,
            activeColor: Colors.black,
            tabBackgroundColor: Colors.white,
            gap: 8,
            padding: const EdgeInsets.all(12),
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            tabs: const [
              GButton(
                icon: Icons.note_add,
                text: 'Notes',
              ),
              GButton(
                icon: Icons.today_outlined,
                text: 'Todos',
              ),
              // GButton(
              //   icon: Icons.settings,
              //   text: 'Settings',
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSelectedScreen() {
    switch (_selectedIndex) {
      case 0:
        return const NotesView();
      case 1:
        return const TodoListView();
      default:
        return const SizedBox.shrink();
    }
  }
}
