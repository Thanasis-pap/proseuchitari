import 'package:proseuchitari/global_dirs.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final List akolouthies = Names.akolouthiesNames.sublist(1);
  final List proseuches = Names.proseuchesNames.sublist(1);
  final List shortproseuches = Names.shortproseuchesNames.sublist(1);
  final List psalms = Names.psalmNames.sublist(1);
  final List hymns = Names.hymnNames.sublist(1);
  final List saintproseuches = Names.saintprayerNames.sublist(1);

  String searchText = '';
  List searchResults = [];

  void findItemIndex(String buttonTitle) {    // Check if the button title exists in list1
    if (akolouthies.contains(buttonTitle)) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => Akolouthia(akolouthiaNumber: akolouthies.indexOf(buttonTitle))));
    }

    // Check if the button title exists in list2
    if (proseuches.contains(buttonTitle)) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => Prayer(prayerNumber: proseuches.indexOf(buttonTitle))));
    }

    // Check if the button title exists in list3
    if (shortproseuches.contains(buttonTitle)) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => ShortPrayer(shortprayerNumber: shortproseuches.indexOf(buttonTitle))));
    }

    // Check if the button title exists in list4
    if (psalms.contains(buttonTitle)) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => Psalm(psalmNumber: psalms.indexOf(buttonTitle))));
    }

    // Check if the button title exists in list5
    if (hymns.contains(buttonTitle)) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => Hymn(hymnNumber: hymns.indexOf(buttonTitle))));
    }

    if (saintproseuches.contains(buttonTitle)) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => SaintPrayer(saintprayerNumber: saintproseuches.indexOf(buttonTitle))));
    }
  }

  @override
  void initState() {
    super.initState();
    searchResults = akolouthies + proseuches + saintproseuches + shortproseuches + psalms + hymns;
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Αναζήτηση',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0),),

              ),
              onChanged: (text) {
                setState(() {
                  searchText = text;
                  searchResults = searchText.isEmpty
                      ? akolouthies + proseuches + shortproseuches + psalms +
                      hymns
                      : akolouthies
                      .where((akolouthia) =>
                      akolouthia
                          .toLowerCase()
                          .contains(searchText.toLowerCase()))
                      .toList() +
                      proseuches
                          .where((prayer) =>
                          prayer
                              .toLowerCase()
                              .contains(searchText.toLowerCase()))
                          .toList() +
                      shortproseuches
                          .where((shortprayer) =>
                          shortprayer
                              .toLowerCase()
                              .contains(searchText.toLowerCase()))
                          .toList() +
                      psalms
                          .where((psalm) =>
                          psalm
                              .toLowerCase()
                              .contains(searchText.toLowerCase()))
                          .toList() +
                      hymns
                          .where((hymn) =>
                          hymn.toLowerCase().contains(searchText.toLowerCase()))
                          .toList() +
                      saintproseuches
                          .where((saintprayer) =>
                          saintprayer.toLowerCase().contains(searchText.toLowerCase()))
                          .toList();
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                return Padding(padding: const EdgeInsets.symmetric(vertical:5.0,horizontal: 15.0),
                  child: ElevatedButton(

                    onPressed: () {
                      findItemIndex(searchResults[index]);
                      // Handle button press
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),

                      ),

                    ),
                    child: AutoSizeText(
                      searchResults[index],
                      style: TextStyle(fontSize: Global.fontSize),
                      textAlign: TextAlign.center,
                      minFontSize: Global.fontSize - 6,
                      wrapWords: false,
                      maxLines: 1,
                    ),
                  ),);

              },
            ),
          ),
        ],
      ),
    );
  }
}
