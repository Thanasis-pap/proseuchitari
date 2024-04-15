import 'package:proseuchitari/global_dirs.dart';
import 'package:calendar_timeline/calendar_timeline.dart';

class Proseuches extends StatefulWidget {
  final List prayerNames;

  const Proseuches(List this.prayerNames, {super.key});

  @override
  _Proseuches createState() => _Proseuches();
}

class _Proseuches extends State<Proseuches> {
  int currentPageIndex = 0;
  late DateTime _selectedDate;
  NavigationDestinationLabelBehavior labelBehavior =
      NavigationDestinationLabelBehavior.alwaysShow;

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

  void prayerSelector(int i) {
    switch (int.parse(widget.prayerNames[0])) {
      case 0:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => Akolouthia(akolouthiaNumber: i - 1)));
      case 1:
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => Prayer(prayerNumber: i - 1)));
      case 2:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => ShortPrayer(shortprayerNumber: i - 1)));
      case 3:
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => Psalm(psalmNumber: i - 1)));
      case 4:
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => Hymn(hymnNumber: i - 1)));
      case 5:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => SaintPrayer(saintprayerNumber: i - 1)));
    }
    ;
  }

  @override
  void initState() {
    super.initState();
    getDouble();
    _resetSelectedDate();
  }

  List<Widget> _getList() {
    List<Widget> temp = [];
    for (int i = 1; i < widget.prayerNames.length; i++) {
      temp.add(
        ElevatedButton(
          onPressed: () {
            prayerSelector(i);
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          child: AutoSizeText(
            widget.prayerNames[i],
            style: TextStyle(fontSize: Global.fontSize - 3),
            textAlign: TextAlign.center,
            minFontSize: Global.fontSize - 8,
            wrapWords: false,
            maxLines: 3,
          ),
        ),
      );
    }
    temp.add(
      const SizedBox(height: 30.0),
    );
    return temp;
  }

  void _resetSelectedDate() {
    _selectedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        toolbarHeight: 75,

        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text('Προσευχητάρι', style: TextStyle(fontSize: 28)),
        centerTitle: false,
      ),
      body: <Widget>[
        Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: CustomScrollView(
            primary: false,
            slivers: <Widget>[
              SliverPadding(
                padding: const EdgeInsets.all(14),
                sliver: SliverGrid.count(
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    crossAxisCount: 2,
                    childAspectRatio: (30 / 20),
                    children: _getList()),
              ),
            ],
          ),
        ),
      ][currentPageIndex],
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
