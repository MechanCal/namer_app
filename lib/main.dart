import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/favorites_page.dart';
import './screens/generator_page.dart';
import './screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        //removes debug banner in top right corner
        debugShowCheckedModeBanner: false,
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          //defining color pallette to use throughout the entire app
          colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: Colors.grey[800],
              secondary: Colors.orange,
              tertiary: Colors.white),
        ),
        //app starts with splashscreen page, then redirects to generator page
        home: SplashScreen(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  //generates a random wordpair
  var current = WordPair.random();

  //generates a new random wordpair
  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  //list of favorited wordpairs
  var favorites = <WordPair>[];

  //toggles between favorited/unfavorited, if it exists already remove it, else add it
  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }

  //removes wordpair from favorited list
  void removeFavorite(WordPair pair) {
    favorites.remove(pair);
    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  //checks to see what page to redirect to
  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      //the page where wordpairs are generated
      case 0:
        page = GeneratorPage();
        break;
      //the page where favorited wordpairs are shown
      case 1:
        page = FavoritesPage();
        break;
      //incase of invalid route
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        body: Row(
          children: [
            SafeArea(
              //sidebar with icons to navigate the app
              child: NavigationRail(
                indicatorColor: Theme.of(context).colorScheme.primary,
                backgroundColor: Theme.of(context).colorScheme.secondary,
                //affects the amount of space needed to display the full contents of the navigation rail
                extended: constraints.maxWidth >= 600,
                destinations: [
                  //for generator page
                  NavigationRailDestination(
                    icon: Icon(Icons.home),
                    label: Text('Home'),
                  ),
                  //for favorites page
                  NavigationRailDestination(
                    icon: Icon(Icons.local_fire_department),
                    label: Text('Favorites'),
                  ),
                ],
                //redirects to selected page based on input
                selectedIndex: selectedIndex,
                onDestinationSelected: (value) {
                  setState(() {
                    selectedIndex = value;
                  });
                },
              ),
            ),
            Expanded(
              child: Container(
                //changes the color of the background for the page
                color: Theme.of(context).colorScheme.primary,
                child: page,
              ),
            ),
          ],
        ),
      );
    });
  }
}

//class to show the currently generated wordpair
class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Card(
      color: theme.colorScheme.secondary,
      child: Padding(
        //rounded corners on the card
        padding: const EdgeInsets.all(20.0),
        child: Text(
          //text style for the displayed wordpair
          pair.asLowerCase,
          style: style,
          semanticsLabel: "${pair.first} ${pair.second}",
        ),
      ),
    );
  }
}
