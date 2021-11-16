

import 'package:flutter/material.dart';
import 'package:movies/api/api.dart';

class HeaderWithSearchBox extends StatefulWidget {
  final Function onChangeState;
  const HeaderWithSearchBox({Key? key, required this.onChangeState}) : super(key: key);

  @override
  _HeaderWithSearchBoxState createState() => _HeaderWithSearchBoxState();
}

class _HeaderWithSearchBoxState extends State<HeaderWithSearchBox> {
  TextEditingController searchController = TextEditingController();
  List films = [];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 235,
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.height,
            height: 200,
            decoration: const BoxDecoration(
                color: Color(0xFF27AA5A),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Text(
                  "The Movies and Me",
                  style: TextStyle(color: Colors.white, fontSize: 25),
                )
              ],
            ),
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                alignment: Alignment.center,
                height: 60,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(5, 5),
                          blurRadius: 20,
                          color: Color(0xFFD8E2DC))
                    ]),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: "Search",
                    hintStyle: const TextStyle(color: Color(0xFF93EBB6)),
                    suffixIcon: IconButton(
                        onPressed: ()  {
                          debugPrint(searchController.text);
                          if (searchController.text.isNotEmpty) {
                            getFilmsFromApiWithSearchText(searchController.text,1).then((value){
                                if(value["results"] != null) {
                                  print(value["page"]);
                                  widget.onChangeState(value["results"],searchController.text,value["page"]);
                                  searchController.text = "";
                                } 
                            });
                          }
                        },
                        icon: const Icon(Icons.search)),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
