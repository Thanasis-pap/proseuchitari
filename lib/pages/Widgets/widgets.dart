import 'package:proseuchitari/global_dirs.dart';

class Widgets {

  static Widget PrayerButton(String imageAsset, String text){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          width: 85,
          height: 85,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                  20) // Adjust the radius as needed
          ),
          child: Image.asset(
            imageAsset,
            fit: BoxFit.cover,
          ),
        ),
        const Spacer(),
        Expanded(
          flex: 10,
          child: AutoSizeText(
            text,
            style: TextStyle(fontSize: Global.fontSize),
            textAlign: TextAlign.center,
            minFontSize: Global.fontSize - 8,
            wrapWords: false,
            maxLines: 2,
          ),
        ),
        const Spacer(),
      ],
    );
  }
}