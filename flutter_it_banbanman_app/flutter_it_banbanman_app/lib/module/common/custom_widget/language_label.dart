import 'package:flutter/cupertino.dart';
import 'package:flutter_it_banbanman_app/module/common/hex_color.dart';
import 'package:flutter_it_banbanman_app/module/common/utils.dart';

// ignore: must_be_immutable
class GitHubLanguageColorLabel extends StatefulWidget {
  final String language;

  GitHubLanguageColorLabel({Key key, this.language}) : super(key: key);

  @override
  _GitHubLanguageColorLabelState createState() => _GitHubLanguageColorLabelState();
}

class _GitHubLanguageColorLabelState extends State<GitHubLanguageColorLabel> {

  Color languageColor;

  @override
  void initState() {
    super.initState();
    searchLanguageColorHexString(widget.language).then((colorHexString) {
      setState(() {
        languageColor = HexColor(colorHexString);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (languageColor == null || widget.language == null) {
      return SizedBox();
    } else {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            "● ",
            style: TextStyle(color: languageColor, fontSize: 14.0),
          ),
          Text(widget.language)
        ],
      );

    }
  }
}
