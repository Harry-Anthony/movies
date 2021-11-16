import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies/api/api.dart';

class DetailScreen extends StatelessWidget {
  final Map film;
  const DetailScreen({Key? key, required this.film}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back)),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  SizedBox(
                    height: 320,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const <Widget>[
                        IconCard(pathImage: "assets/images/title.png"),
                        IconCard(pathImage: "assets/images/info-button.png"),
                        IconCard(pathImage: "assets/images/research.png"),
                      ],
                    ),
                  ),
                ],
              )),
              Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  height: MediaQuery.of(context).size.height * 0.80,
                  decoration: const BoxDecoration(
                    color: Color(0xFF68EEE7),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(63),
                        bottomLeft: Radius.circular(63)),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 8),
                        blurRadius: 20,
                        color: Color(0xFF8CF3C0),
                      )
                    ],
                  ),
                  child: FutureBuilder(
                    future: getImageFromApi(film['poster_path']),
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data != 'no image') {
                        return Image.network('${snapshot.data}');
                      } else {
                        return const CircularProgressIndicator();
                      }
                    },
                  ))
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Center(
              child: Text(
                film["original_title"],
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold
                ),
                textAlign: TextAlign.center,
                maxLines: 5,
              ),
            ),
          )
        ],
      ),
    ));
  }
}

class IconCard extends StatelessWidget {
  final String pathImage;
  const IconCard({Key? key, required this.pathImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        height: 62,
        width: 62,
        decoration: BoxDecoration(
            color: const Color(0xFFE2FAEF),
            borderRadius: BorderRadius.circular(6),
            boxShadow: const [
              BoxShadow(
                  offset: Offset(0, 8),
                  blurRadius: 22,
                  color: Color(0x86737473)),
              BoxShadow(
                  offset: Offset(-15, -15),
                  blurRadius: 15,
                  color: Color(0xFFF0EFEF))
            ]),
        child: Image.asset(
          pathImage,
          width: 40,
          height: 40,
        ));
  }
}
