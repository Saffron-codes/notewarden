import 'package:flutter/material.dart';
import 'package:note_warden/models/collection_model.dart';
import 'package:note_warden/view/providers/collection_provider.dart';
import 'package:provider/provider.dart';

class CollectionSearchDelegate extends SearchDelegate {

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final collections =
        Provider.of<CollectionProvider>(context, listen: false).collections;
    List<Collection> matchedCollections = [];
    

    for (var collection in collections) {
      if (collection.name.toLowerCase().contains(query.toLowerCase())) {
        matchedCollections.add(collection);
      }
    }

    if (matchedCollections.isNotEmpty) {
      return ListView.builder(
        itemBuilder: (context, index) {
          var result = matchedCollections[index];
          return ListTile(
            onTap: () => Navigator.pushNamed(context, '/collection',arguments: result),
            title: Text(result.name),
          );
        },
        itemCount: matchedCollections.length,
      );
    } else {
      return const Center(child: Text("Uh oh no matchs"));
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final collections =
        Provider.of<CollectionProvider>(context, listen: false).collections;
    List<Collection> matchedCollections = [];
    

    for (var collection in collections) {
      if (collection.name.toLowerCase().contains(query.toLowerCase())) {
        matchedCollections.add(collection);
      }
    }

    if (matchedCollections.isNotEmpty && query.isNotEmpty) {
      return ListView.builder(
        itemBuilder: (context, index) {
          var result = matchedCollections[index];
          return ListTile(
            onTap: () => Navigator.pushNamed(context, '/collection',arguments: result),
            title: Text(result.name),
          );
        },
        itemCount: matchedCollections.length,
      );
    }
    else if(matchedCollections.isEmpty){
      return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Text(
        "No Match Found",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    );
    } 
    else {
      return const Center(child: Text("Start Searching"));
    }
  }
}
