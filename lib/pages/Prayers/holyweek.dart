import 'package:proseuchitari/global_dirs.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:proseuchitari/pages/Data/holyweeklist.dart';

class Holyweek extends StatefulWidget {
  final int holyweekNumber;

  const Holyweek({super.key, required this.holyweekNumber});

  @override
  _Holyweek createState() => _Holyweek();
}

class _Holyweek extends State<Holyweek> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        toolbarHeight: 75,
        backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(HollyweekList.holyweek[widget.holyweekNumber][0]),
        centerTitle: true,
      ),
      body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Scrollbar(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(30.0),
              primary: false,
              child: Column(children: <Widget>[
                const SizedBox(height: 10.0),
                HtmlWidget(
                  HollyweekList.holyweek[widget.holyweekNumber][1],
                  textStyle: TextStyle(fontSize: Global.fontSize),
                ),
                const SizedBox(height: 60.0),
              ]),
            ),
          ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/home', (Route<dynamic> route) => false);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.home),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
