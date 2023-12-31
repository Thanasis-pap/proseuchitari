import 'package:proseuchitari/global_dirs.dart';
import 'package:proseuchitari/pages/PrayersList/proseuches.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:proseuchitari/pages/searchpage.dart';

class MyHomePage extends StatefulWidget {
  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.light);

  final String title;

  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void getDouble() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      Global.fontSize = (prefs.getDouble('fontsize') ?? 18);
      Global.screen = (prefs.getBool('screen') ?? false);
    });
  }

  void setDouble(double size) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setDouble('fontsize', size);
    });
  }

  void setBool(bool screen) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (screen == true) {
      KeepScreenOn.turnOn();
    } else {
      KeepScreenOn.turnOff();
    }
    setState(() {
      prefs.setBool('screen', screen);
    });
  }

  late DateTime _selectedDate;
  static Brightness brightness =
      WidgetsBinding.instance.platformDispatcher.platformBrightness;
  static bool click = brightness == Brightness.dark;
  int currentPageIndex = 0;
  NavigationDestinationLabelBehavior labelBehavior =
      NavigationDestinationLabelBehavior.alwaysShow;

  @override
  void initState() {
    super.initState();
    _resetSelectedDate();
    getDouble();
  }

  void _resetSelectedDate() {
    _selectedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        toolbarHeight: 100,

        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title, style: TextStyle(fontSize: Global.fontSize+10)),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: ElevatedButton(
              child: click
                  ? const Icon(Icons.light_mode)
                  : const Icon(Icons.dark_mode),
              onPressed: () {
                setState(() {
                  click = !click;
                });
                Get.isDarkMode
                    ? Get.changeThemeMode(ThemeMode.light)
                    : Get.changeThemeMode(ThemeMode.dark);
              },
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => const SearchPage()));
        },
        child: const Icon(Icons.search),
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.book),
            icon: Icon(Icons.book),
            label: 'Προσευχές',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.calendar_month),
            icon: Icon(Icons.calendar_month_outlined),
            label: 'Εορτολόγιο',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.settings),
            icon: Icon(Icons.settings),
            label: 'Ρυθμίσεις',
          ),
        ],
      ),
      body: <Widget>[
        Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: CustomScrollView(
            primary: false,
            slivers: <Widget>[
              SliverPadding(
                padding: const EdgeInsets.all(20),
                sliver: SliverGrid.count(
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  crossAxisCount: 2,
                  childAspectRatio: (30 / 20),
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    Proseuches(Names.proseuchesNames)));
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: AutoSizeText(
                        'Βασικές Προσευχές',
                        style: TextStyle(fontSize: Global.fontSize),
                        textAlign: TextAlign.center,
                        minFontSize: Global.fontSize - 8,
                        wrapWords: false,
                        maxLines: 2,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    Proseuches(Names.saintprayerNames)));
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: AutoSizeText(
                        'Προσευχές Αγίων & Γερόντων',
                        style: TextStyle(
                          fontSize: Global.fontSize,
                        ),
                        textAlign: TextAlign.center,
                        minFontSize: 12,
                        maxLines: 3,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    Proseuches(Names.shortproseuchesNames)));
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: AutoSizeText(
                        'Σύντομες Προσευχές',
                        style: TextStyle(fontSize: Global.fontSize),
                        textAlign: TextAlign.center,
                        minFontSize: 12,
                        wrapWords: false,
                        maxLines: 2,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    Proseuches(Names.akolouthiesNames)));
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: AutoSizeText(
                        'Ακολουθίες',
                        style: TextStyle(
                          fontSize: Global.fontSize,
                        ),
                        textAlign: TextAlign.center,
                        minFontSize: 12,
                        wrapWords: false,
                        maxLines: 2,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => Proseuches(Names.psalmNames)));
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: AutoSizeText(
                        'Ψαλμοί',
                        style: TextStyle(
                          fontSize: Global.fontSize,
                        ),
                        textAlign: TextAlign.center,
                        minFontSize: 12,
                        maxLines: 2,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => Proseuches(Names.hymnNames)));
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: AutoSizeText(
                        'Ύμνοι',
                        style: TextStyle(
                          fontSize: Global.fontSize,
                        ),
                        textAlign: TextAlign.center,
                        minFontSize: 12,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        ListView(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CalendarTimeline(
              showYears: false,
              initialDate: _selectedDate,
              firstDate: DateTime(DateTime.now().year, 1, 1),
              lastDate: DateTime(DateTime.now().year, 12, 31),
              onDateSelected: (date) => setState(() => _selectedDate = date),
              leftMargin: 20,
              monthColor: Colors.blueGrey,
              dayNameColor: Colors.transparent,
              locale: 'el',
            ),
            //const SizedBox(height: 20),
            Center(
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: ElevatedButton.icon(
                    icon: const Icon(
                      // <-- Icon
                      Icons.keyboard_return,
                      size: 24.0,
                    ),
                    label: const Text('Σήμερα'), // <-- Text

                    onPressed: () => setState(() => _resetSelectedDate()),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Card(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: AutoSizeText(
                      CalendarList.returnNames(_selectedDate),
                      style: TextStyle(fontSize: Global.fontSize),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 60),
          ],
        ),
        Center(
          //color: Colors.blue,
          //
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Μέγεθος Γραμματοσειράς',
                      style: TextStyle(fontSize: Global.fontSize),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                      child: Text(
                        Global.fontSize.toInt().toString(),
                        style: TextStyle(
                            fontSize: Global.fontSize,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20.0),
                Slider(
                  value: Global.fontSize,
                  min: 14,
                  max: 24,
                  divisions: 5,
                  label: Global.fontSize.round().toString(),
                  onChanged: (double value) {
                    setState(() {
                      setDouble(value);
                      Global.fontSize = value;
                    });
                  },
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Οθόνη μόνιμα αναμμένη',
                      style: TextStyle(fontSize: Global.fontSize),
                    ),
                    Switch(
                      // This bool value toggles the switch.
                      value: Global.screen,
                      onChanged: (bool value) {
                        // This is called when the user toggles the switch.
                        setState(() {
                          setBool(value);
                          Global.screen = value;
                        });
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ][currentPageIndex],
    );
  }
}
