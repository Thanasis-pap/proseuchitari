import 'package:proseuchitari/global_dirs.dart';
import 'package:proseuchitari/pages/home.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    /*var routes = <String, WidgetBuilder>{
      PrayersList.routeName: (BuildContext context) => new PrayersList(title: "MyItemsPage"),
    };*/
    return GetMaterialApp(
      initialRoute: '/home',
      routes: {
        '/home' : (context) => const MyHomePage(title: 'Προσευχητάρι',),
      },
      debugShowCheckedModeBanner: false,
      title: 'Προσευχητάρι',
      //themeMode: chosenTheme,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal.shade50),
        floatingActionButtonTheme: FloatingActionButtonThemeData(

        backgroundColor: Colors.teal.shade300,
      ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue.shade300,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),

    );

  }
}

