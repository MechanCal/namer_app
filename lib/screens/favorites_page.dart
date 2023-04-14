import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:namer_app/main.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    //screen displays this if there are no favorited words in the list
    if (appState.favorites.isEmpty) {
      return Center(
        child: Text(
          'No favorites yet.',
          style: TextStyle(
            color: Theme.of(context).colorScheme.tertiary,
            fontSize: 25,
          ),
        ),
      );
    }
    //screen displays this if there are words in the favorites list
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            'You have '
            '${appState.favorites.length} favorites:',
            style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
          ),
        ),
        //list reversed to show most recent favorited words at the top and oldest at bottom
        for (var pair in appState.favorites.reversed)
          //Dismissible(
          //key: ValueKey(key),
          //direction: DismissDirection.startToEnd,
          //child:

          //list shows wordpairs and an option to delete each one individually from the list
          ListTile(
            leading: Icon(
              Icons.local_fire_department,
              color: Theme.of(context).colorScheme.tertiary,
            ),
            title: Text(
              pair.asLowerCase,
              style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
            ),
            //delete button users can press to remove a wordpair
            trailing: IconButton(
              icon: Icon(
                Icons.delete_outline,
                semanticLabel: 'Delete',
                color: Colors.red,
              ),
              //updates the list to remove the selected wordpair from the list
              onPressed: () {
                appState.removeFavorite(pair);
              },
            ),
          ),
        //),
      ],
    );
  }
}
