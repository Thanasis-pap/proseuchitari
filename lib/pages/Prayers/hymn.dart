import 'package:proseuchitari/global_dirs.dart';
import 'package:proseuchitari/pages/Data/hymnlist.dart';

class Hymn extends StatefulWidget {
  final int hymnNumber;

  const Hymn({super.key, required this.hymnNumber});

  @override
  _Hymn createState() => _Hymn();
}

class _Hymn extends State<Hymn> {
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
        title: Text(HymnsList.hymns[widget.hymnNumber][0]),
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
              AutoSizeText(
                HymnsList.hymns[widget.hymnNumber][1],
                style: TextStyle(fontSize: Global.fontSize),
                textAlign: TextAlign.left,
                minFontSize: Global.fontSize - 8,
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
