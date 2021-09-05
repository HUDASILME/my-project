import 'package:flutter/material.dart';
import 'package:newproject/provider/categioryProduct_provider.dart';
import 'package:provider/provider.dart';

class search extends StatefulWidget {
  @override
  _searchState createState() => _searchState();
}

class _searchState extends State<search> {
  @override
  List<String> _history, searchItems;
  String query;

  @override
  void initState() {
    super.initState();
    query = '';
    searchItems = Provider.of<CategioryProductProvider>(context, listen: false)
        .getCategories();
    _history = List<String>();
    _history = ['men', 'women'];
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      // Background(),
      Scaffold(
          appBar: AppBar(
            title: Hero(
              tag: 'search',
              child: TextFormField(
                onChanged: (value) {
                  setState(() {
                    query = value;
                  });
                },
              ),
            ),
            elevation: 0.0,
          ),
          body: buildSuggestions())
    ]);
  }

  Widget buildSuggestions() {
    final List<String> suggestions = query.isEmpty
        ? _history
        : searchItems.where((word) => word.contains(query)).toList();

    return _WordSuggestionList(
      query: this.query,
      suggestions: suggestions,
    );
  }
}

class _WordSuggestionList extends StatelessWidget {
  final List<String> suggestions;
  final String query;

  const _WordSuggestionList({
    this.suggestions,
    this.query,
  });

  @override
  Widget build(BuildContext context) {
    final categoriesProvider =
        Provider.of<CategioryProductProvider>(context, listen: false);

    return suggestions.length == 0
        ? null //NotFound()
        : ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: suggestions.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: index == 0
                    ? const EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0)
                    : index == suggestions.length - 1
                        ? const EdgeInsets.only(
                            bottom: 5.0, left: 5.0, right: 5.0)
                        : const EdgeInsets.only(left: 5.0, right: 5.0),
                // child: Category(
                //   categoriesProvider.getCategory(categoriesProvider.allCategoriesName.indexOf(suggestions[index])),
                // ),
              );
            });
  }
}
