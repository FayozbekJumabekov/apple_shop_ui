import 'package:apple_shop_ui/pages/newpage.dart';
import 'package:flutter/material.dart';
import 'package:shake/shake.dart';
import 'itemClass.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static final String id = "/home_page";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int itemCount = 0;
  List<Items> listItems = List.generate(
      20,
      (index) => Items(
          image: 'assets/images/image_${index % 5}.png', changeIcon: false));

   List<Items> favourites=[];
   late ShakeDetector detector;

   @override
  void initState() {
    super.initState();
    detector = ShakeDetector.autoStart(onPhoneShake: (){
      Navigator.pushReplacementNamed(context, Newpage.id);
    });
  }
  @override
  void dispose() {
    super.dispose();
    detector.stopListening();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: false,
        appBar: AppBar(
          title: Text("Apple Products"),
          centerTitle: true,
          backgroundColor: Colors.black,
          elevation: 0,
          actions: [
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              width: 35,
              height: 35,
              child: Text(
                itemCount.toString(),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              decoration: BoxDecoration(
                  color: Colors.grey.shade700,
                  borderRadius: BorderRadius.circular(8)),
            )
          ],
        ),
        drawer: buildDrawer(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // #Header
              Container(
                margin: EdgeInsets.all(20),
                height: 230,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/images/image_3.png")),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.center,
                        colors: [
                          Colors.black.withOpacity(0.5),
                          Colors.black.withOpacity(0.3),
                          Colors.black.withOpacity(0.1),
                        ]),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                          child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          "LifeStyle safe",
                          style: TextStyle(fontSize: 30, color: Colors.white),
                        ),
                      )),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20, top: 25),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              fixedSize: Size(250, 60),
                              primary: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          onPressed: () {},
                          child: Text(
                            "Shop now",
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // #body

              GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.all(20),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                  ),
                  itemCount: listItems.length,
                  itemBuilder: (context, index) {
                    return _itemOfGrids(index);
                  })
            ],
          ),
        ));
  }

  Drawer buildDrawer() => Drawer(
    child: NestedScrollView(

      floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
        return   [
          SliverAppBar(
            backgroundColor: Colors.black,
            leading: SizedBox.shrink(),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.notifications),
              )
            ],
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              title: Text("Fayozbek"),
              centerTitle: true,
              background: Padding(
                padding: const EdgeInsets.symmetric(vertical: 60,horizontal: 90),
                child: Container(
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/images/account_im.png"),
                    )

                  ),

                ),
              )
            ),
          )

        ];
        },

        body:  ListView(
          children: List.generate(favourites.length, (index) => buildCard(index)),

        ) ),

  );

  Card buildCard(int index) {
    return Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(

              leading: Icon(Icons.check_box),
              title: Text("Added cart"),
              trailing: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(favourites[index].image)
                    )
                ),
              ),
            ),
          ),
        );
  }

  Widget _itemOfGrids(int index) {
    return Container(
        alignment: Alignment.bottomRight,
        padding: EdgeInsets.all(20),
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage(listItems[index].image))),
        child: IconButton(
            onPressed: () {
              setState(() {
                listItems[index].changeIcon = !listItems[index].changeIcon;
                (listItems[index].changeIcon) ? itemCount++ : itemCount--;
                (listItems[index].changeIcon) ? favourites.add(listItems[index]) : favourites.remove(listItems[index]);
              });
            },
            icon: (listItems[index].changeIcon)
                ? Icon(
                    Icons.star,
                    size: 30,
                    color: Colors.yellowAccent,
                  )
                : Icon(
                    Icons.star_outline_outlined,
                    size: 30,
                    color: Colors.yellowAccent,
                  )));
  }
}
