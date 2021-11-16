import 'package:flutter/material.dart';
import 'package:movies/api/api.dart';
import 'package:movies/screens/details/details_screen.dart';
import 'package:movies/screens/home/components/header_search_box.dart';
import 'package:movies/tools/data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController scrollController = ScrollController();
  String searchText = "";
  int page = 0;
  List films = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: const Icon(Icons.menu),
        backgroundColor: const Color(0xFF27AA5A),
      ),
      body: Column(
        children:  <Widget>[
           HeaderWithSearchBox(onChangeState: (value, text, newPage){
            setState(() {
              films = value;
              searchText = text;
              page = newPage;
            });
          },),
          Expanded(
            child: NotificationListener(
              child: ListView.builder(
                controller: scrollController,
                itemCount: films.length,
                itemBuilder: (context, index){
                  return FilmItem(film: films[index]);
                }
              ),
              onNotification: (t){
                if(t is ScrollEndNotification){
                  if(scrollController.position.pixels==scrollController.position.maxScrollExtent) {
                    print("seasrch text:   "+searchText);
                    getFilmsFromApiWithSearchText(searchText, page+1).then((value){
                      if(value["results"]!=null) {
                        setState(() {
                          films = [...films,...value["results"]];
                          page = value["page"];
                        });
                      }
                    });
                    // showDialog(
                    //   context: context, 
                    //   builder: (context) {
                    //     return const AlertDialog(
                    //       content: Text("in end of list"),
                    //     );
                    //   }
                    // );
                  }
                }
                return true;
              },
            )
          )
        ],
      ),
    );
  }
}


class RecommandedPlant extends StatelessWidget {
  const RecommandedPlant({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:  <Widget>[
                 const Text("Recomonded"),
                 TextButton(
                  onPressed: (){},
                  child:  Container(
                    padding: const EdgeInsets.all(8),
                    decoration:  BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: const Color(0xFF8FE9B1)
                    ),
                    child: const Text("More")
                  )
                )
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 220,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const <Widget>[
                ItemFlowerRecommanded (),
                ItemFlowerRecommanded (),
                ItemFlowerRecommanded (),
                ItemFlowerRecommanded (),
                ItemFlowerRecommanded (),
                ItemFlowerRecommanded (),
              ],
            ),
          )
        ],
      )
    );
  }
}

class  ItemFlowerRecommanded extends StatelessWidget {
  const ItemFlowerRecommanded ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return    GestureDetector(
      onTap: (){
        Navigator.push(
          context, MaterialPageRoute(builder: (context)=>  DetailScreen(film: {}))
        );
      },
      child: Container(
        margin:  const EdgeInsets.only(right: 10),
        width: 180,
        decoration: const BoxDecoration(
          color:  Color(0xFFCBF7DC),
          borderRadius: BorderRadius.all(Radius.circular(5))
        ),
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 180,
            ),
            Expanded(
              child: Container( 
                decoration: const BoxDecoration(
                  color: Color(0xFFF1F5F8),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}

class FeaturedPlant extends StatelessWidget {
  const FeaturedPlant({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:  <Widget>[
                 const Text("Featured Plants"),
                 TextButton(
                  onPressed: (){},
                  child:  Container(
                    padding: const EdgeInsets.all(8),
                    decoration:  BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: const Color(0xFF8FE9B1)
                    ),
                    child: const Text("More")
                  )
                )
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 220,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const <Widget>[
                ItemFeaturedFlower (),
                ItemFeaturedFlower (),
                ItemFeaturedFlower (),
                ItemFeaturedFlower (),
                ItemFeaturedFlower (),
                ItemFeaturedFlower (),
              ],
            ),
          )
        ],
      )
    );
  }
}

class ItemFeaturedFlower extends StatelessWidget {
  const ItemFeaturedFlower({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:  const EdgeInsets.only(right: 10),
      width: 250,
      decoration: const BoxDecoration(
        color:  Color(0xFFCBF7DC),
        borderRadius: BorderRadius.all(Radius.circular(4))
      ),
    );
  }
}

class FilmItem extends StatelessWidget {
  final Map film;
  const FilmItem({Key? key, required this.film}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Future<String> _calculation = Future<String>.delayed(
      const Duration(seconds: 2),
      () => 'no image',
    );
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context, MaterialPageRoute(builder: (context)=>  DetailScreen(film: film))
        );
      },
      child: Container(
        padding: const EdgeInsets.all(5),
        width: width,
        height: 300,
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          children: [
            Container(
              width: width*0.4,
              color: Colors.blue,
              child: FutureBuilder(
                future: film['poster_path']!=null?getImageFromApi(film['poster_path']):_calculation,
                builder: (context, snapshot){
                  if(snapshot.hasData && snapshot.data!='no image'){
                    return Image.network('${snapshot.data}');
                  } else if(snapshot.data == 'no image'){
                    return Image.asset('assets/images/title.png');
                  }
                  return  const SizedBox(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator()
                  );
                },
              )
            ),
           const SizedBox(width: 10),
            Expanded(
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: Text(film["title"], style: const TextStyle(fontWeight: FontWeight.bold))),
                      Text(film["vote_average"].toString()),
                    ],
                  ),
                  const SizedBox(height: 30,),
                  Container(
                    height: 100,
                    child: Text(film["overview"],maxLines: 5,
                    ),
                  ),
                ],
              )
            )
          ],
        ),
      )
    );
  }
}