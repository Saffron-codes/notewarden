import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DeveloperStorySheet extends StatelessWidget {
  const DeveloperStorySheet({super.key});

  final String story = '''
As a developer, I created this app with the vision of providing students with a convenient and organized way to save their notes. Recognizing the importance of keeping track of valuable information, I designed the app to allow users to create and manage multiple collections of notes.

Each collection serves as a dedicated space for students to categorize their notes based on subjects, courses, or any other relevant criteria. Users can easily add, edit, and delete notes within each collection, ensuring that their valuable study materials are readily accessible.

To enhance the user experience, I focused on creating a clean and intuitive interface, allowing students to navigate the app effortlessly. With a simple and straightforward design, users can quickly find their desired notes and efficiently manage their collections.

My goal with this app is to empower students to stay organized and never miss out on important information. Whether it's preparing for exams, revisiting lecture materials, or keeping track of research findings, this app is designed to be a reliable companion throughout their academic journey.

I hope this app proves to be a valuable tool for students, helping them stay organized, focused, and ultimately succeed in their studies.

Thank you for using this app, and I wish you all the best in your educational endeavors!


''';

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        initialChildSize: 0.5,
        expand: false,
        minChildSize: 0.25,
        maxChildSize: 1.0,
        builder: (context, controller) {
          return Container(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              controller: controller,
              children: [
                const Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://avatars.githubusercontent.com/u/82256689?v=4'),
                      radius: 40,
                    ),
                    SizedBox(width: 16.0),
                    Text(
                      'Saffron Dionysius',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'Story',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 8.0),
                Text(
                  story,
                  style: TextStyle(fontSize: 16.0),
                ),
                // Text("Catch me on",style: TextStyle(fontWeight: FontWeight.bold),),
                // SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed: () {
                        final uri =
                            Uri.parse("https://instagram.com/sdiony116");
                        launchUrl(uri);
                        // launchUrlString(uri.path)
                      },
                      child: Text("Instagram"),
                    ),
                    TextButton(
                      onPressed: () {
                        final uri =
                            Uri.parse("https://github.com/saffron-codes");
                        launchUrl(uri);
                        // launchUrlString(uri.path)
                      },
                      child: Text("Github"),
                    ),
                    TextButton(
                      onPressed: () {
                        final uri = Uri.parse("https://twitter.com/sdionysius");
                        launchUrl(uri);
                        // launchUrlString(uri.path)
                      },
                      child: Text("Twitter"),
                    )
                  ],
                )
              ],
            ),
          );
        });
  }
}
