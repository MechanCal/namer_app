import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:namer_app/main.dart';

class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    IconData icon;
    //determines icons for favorited/unfavorited
    if (appState.favorites.contains(pair)) {
      icon = Icons.local_fire_department;
    } else {
      icon = Icons.local_fire_department_outlined;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //contains wordpair info
          BigCard(pair: pair),
          SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size.fromWidth(100),
                  //color of the text on the button
                  foregroundColor: Theme.of(context).colorScheme.tertiary,
                  //color of the button itself
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  //gives button the rounded sides
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.elliptical(10, 20),
                    ),
                  ),
                ),
                //snackbar notification for favoriting a wordpair
                onPressed: () {
                  //if favorited, display snackbar notification
                  if (!appState.favorites.contains(pair)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Favorited',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary),
                        ),
                        //snackbar notification is dismissed after set time
                        duration: Duration(milliseconds: 500),
                      ),
                    );
                  }
                  //toggles between favorited/unfavorited
                  appState.toggleFavorite();
                },
                icon: Icon(icon),
                label: Text('Like'),
              ),
              SizedBox(width: 40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size.fromWidth(100),
                  //color of the text on the button
                  foregroundColor: Theme.of(context).colorScheme.tertiary,
                  //color of the button itself
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  //gives button the rounded sides
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.elliptical(10, 20),
                    ),
                  ),
                ),
                //generates the next wordpair when 'next' is pressed
                onPressed: () {
                  appState.getNext();
                },
                child: Text('Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
