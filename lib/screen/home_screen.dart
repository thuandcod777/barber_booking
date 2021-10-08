import 'package:barber_booking/model/menu_item.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final userId;

  const HomeScreen({this.userId, Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<MenuItem> itemMenu = [];

  /* List<MenuItem> listItem = List.generate(
      DataModel.menuItem.length, (index) => DataModel.menuItem[0]);*/

  @override
  void initState() {
    itemMenu = getMenuItem();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //theme menu1
      /*appBar: AppBar(
          elevation: 17,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0)),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(150),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          "Welcome",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 39,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Lionel Messi",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 27,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    CircleAvatar(
                      radius: 39.0,
                      child: Icon(Icons.circle),
                    ),
                  ],
                ),
                SizedBox(
                  height: 90.0,
                )
              ],
            ),
          ),
        ),
        body: buildGridViewMenu());*/

      //theme menu2
      /* body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 0,
            top: 0,
            right: 0,
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0)),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 50.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text(
                            "Welcome",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 39,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Lionel Messi",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 27,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      CircleAvatar(
                        radius: 39.0,
                        child: Icon(Icons.circle),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
              top: 170,
              left: 0,
              right: 0,
              bottom: 10,
              child: buildGridViewMenu())
        ],
      ),*/

      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            expandedHeight: 200,
          ),
          SliverToBoxAdapter(
            child: buildGridViewMenu(),
          )
        ],
      ),
    );
  }

  Widget buildGridViewMenu() {
    return Container(
      height: 600,
      child: GridView(
        physics: BouncingScrollPhysics(),
        primary: false,
        shrinkWrap: true,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        children: itemMenu.map((data) {
          return GestureDetector(
            child: Card(
              margin: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      child: Stack(
                        children: [
                          Image.asset(
                            data.image!,
                            width: 70.0,
                            height: 70.0,
                          )
                        ],
                      ),
                    ),
                  ),
                  Text(
                    data.title!,
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, data.routeName!);
            },
          );
        }).toList(),
      ),
    );
  }

  /*Widget getCardByTitle(String title) {
    String image = "";

    if (title == "Booking") {
      image = "assets/booking.png";
    } else if (title == "Orders") {
      image = "assets/orders.png";
    } else if (title == "Call") {
      image = "assets/phone.png";
    } else if (title == "Message") {
      image = "assets/message.png";
    } else if (title == "Account") {
      image = "assets/account.png";
    } else if (title == "Setting") {
      image = "assets/settings.png";
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Container(
            child: Stack(
              children: [
                Image.asset(
                  image,
                  width: 70.0,
                  height: 70.0,
                )
              ],
            ),
          ),
        ),
        Text(
          title,
          textAlign: TextAlign.center,
        )
      ],
    );
  }*/
}
