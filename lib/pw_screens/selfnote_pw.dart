import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelfNotesPage extends StatefulWidget {
  const SelfNotesPage({super.key});

  @override
  State<SelfNotesPage> createState() => _SelfNotesPageState();
}

class _SelfNotesPageState extends State<SelfNotesPage> {
  late PageController _pageController;
  List<Note> _notes = [];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _loadNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Self Notes",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: _addNote,
            child: const Icon(
              Icons.add,
              size: 35.0,
            ),
          ),
          const SizedBox(width: 12.0),
        ],
        backgroundColor: const Color.fromARGB(255, 249, 76, 102),
        toolbarHeight: 60.0,
        foregroundColor: Colors.white,
      ),
      body: _notes.isNotEmpty
          ? PageView.builder(
              controller: _pageController,
              itemCount: _notes.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(20.0),
                  margin: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.red.shade100,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Stack(children: [
                          Center(
                            child: Opacity(
                              opacity: 0.18,
                              child: Image.asset(
                                "assets/images/selfnote.png",
                              ),
                            ),
                          ),
                          SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${_notes[index].title}\t📓",
                                  style: const TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 16.0),
                                Text(
                                  _notes[index].text,
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    // decoration: TextDecoration.underline,
                                    decorationThickness: 1.3,
                                  ),
                                ),
                                const Gap(25.0),
                              ],
                            ),
                          ),
                        ]),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.red.shade50,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(
                          12.0,
                        ),
                        child: GestureDetector(
                          onTap: () => _deleteNote(index),
                          child: Center(
                            child: Text(
                              "Delete",
                              style: TextStyle(
                                color: Colors.red.shade500,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            )
          : const Center(
              child: Text("Add Your note ..."),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _enableEditing,
        backgroundColor: const Color.fromARGB(255, 249, 76, 102),
        child: const Icon(Icons.edit),
      ),
    );
  }

  void _addNote() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String title = "A Special Note";
    String text =
        "Dear Moms-to-Be,\nAs you embark on this incredible journey of motherhood, I want to take a moment to express my heartfelt gratitude for the beauty and strength you bring to the world. Your unwavering love for your little one, even before they arrive, is nothing short of miraculous. In the midst of the excitement, anticipation, and perhaps a touch of nervousness, remember that you are capable of incredible things. Each flutter, kick, and hiccup from your baby is a reminder of the amazing bond you share. With the self-note feature in our app, I hope to provide you with a space to capture your thoughts, feelings, and dreams as you navigate this extraordinary time. These notes will be a precious treasure, capturing the essence of your journey into motherhood, filled with moments of joy, wonder, and perhaps a few challenges along the way. So, take a moment to reflect, to celebrate, and to connect with the miracle growing within you. Your journey is unique, and every step of the way, know that you are supported, cherished, and deeply admired.";
    Note newNote = Note(title: title, text: text);
    List<String> notes = prefs.getStringList('notes') ?? [];
    notes.add("$title|$text");
    await prefs.setStringList('notes', notes);
    setState(() {
      _notes.add(newNote);
    });

    _pageController.animateToPage(
      _notes.length - 1,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOutCirc,
    );
  }

  void _enableEditing() {
    String title = '';
    String message = '';

    showDialog(
      context: context,
      barrierColor: Colors.white,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter Note'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Title'),
                onChanged: (value) {
                  title = value;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Message'),
                // maxLines: null,
                onChanged: (value) {
                  message = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                _saveNote(title, message);
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _saveNote(String title, String message) async {
    // Save note to SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> notes = prefs.getStringList('notes') ?? [];
    notes.add("$title|$message");
    await prefs.setStringList('notes', notes);

    // Update UI
    setState(() {
      _notes.add(Note(title: title, text: message));
    });
  }

  Future<void> _loadNotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> notes = prefs.getStringList('notes') ?? [];
    List<Note> loadedNotes = [];
    for (String note in notes) {
      List<String> parts = note.split('|');
      if (parts.length == 2) {
        loadedNotes.add(Note(title: parts[0], text: parts[1]));
      }
    }
    setState(() {
      _notes = loadedNotes;
    });
  }

  void _deleteNote(int index) async {
    _pageController.animateToPage(
      index - 1,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeIn,
    );

    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> notes = prefs.getStringList('notes') ?? [];
    notes.removeAt(index);
    await prefs.setStringList('notes', notes);
    setState(() {
      _notes.removeAt(index);
    });
  }
}

class Note {
  final String title;
  final String text;

  Note({required this.title, required this.text});
}
