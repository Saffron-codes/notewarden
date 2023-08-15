import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class AppReleaseInfoSheet extends StatelessWidget {
  final String version;
  final String md;
  final void Function() onclick;
  const AppReleaseInfoSheet(this.version, this.md, this.onclick, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: Wrap(
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              'Update Available',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // SizedBox(height: 16),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              version,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Divider(),
          // SizedBox(height: 16),
          MarkdownBody(
            data: md.substring(md.indexOf("\n"), md.length),
            styleSheet: MarkdownStyleSheet(),
          ),
          // SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Ignore'),
              ),
              ElevatedButton(
                onPressed: onclick,
                child: Text("Let's Go"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
