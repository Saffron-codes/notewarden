import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_warden/features/feature_collection/presentation/collection_search/collection_search_bloc/collection_search_bloc.dart';

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
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    BlocProvider.of<CollectionSearchBloc>(context, listen: false)
        .add(SearchCollectionEvent(query));

    return BlocBuilder<CollectionSearchBloc, CollectionSearchState>(
      builder: (context, state) {
        if (state is CollectionSearchLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is CollectionSearchLoaded) {
          return state.collections.isNotEmpty
              ? ListView.builder(
                  itemBuilder: (context, index) {
                    var result = state.collections[index];
                    return ListTile(
                      onTap: () => Navigator.pushNamed(context, '/media',
                          arguments: result),
                      title: Text(result.name),
                    );
                  },
                  itemCount: state.collections.length,
                )
              : const Center(
                  child: Text("Uh oh no matchs"),
                );
        } else {
          return const Center(
            child: Text("Start Searching"),
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
