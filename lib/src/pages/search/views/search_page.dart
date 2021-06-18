import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/pages/home/controllers/home_controller.dart';
import 'package:indoor_positioning_visitor/src/pages/home/views/home_page.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

// class SearchPage extends GetView<HomeController> {
//   final String searchQuery;
//   final int floorNum;
//   const SearchPage({Key? key, required this.searchQuery, required this.floorNum}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//         primarySwatch: Colors.purple,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: MyHomePage(searchQuery:searchQuery, floorNum: floorNum,),
//     );
//   }
// }
  class Store {
  final int id;
  final String name;
  final String des;
  final String image;
  final String floorNum;
  final String status;

  Store({
    required this.id,
    required this.name,
    required this.des,
    required this.image,
    required this.floorNum,
    required this.status,
  });
}
  class Floor{
    var name;
    var floorNum;

  Floor({
    this.name,
    this.floorNum,
  });
}
  class MyHomeSearchPage extends StatefulWidget {
    final String searchQuery;
    final int floorNum;
    const MyHomeSearchPage({Key? key, required this.searchQuery, required this.floorNum}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
  }

  class _MyHomePageState extends State<MyHomeSearchPage> {
    List<Floor> list = [
      Floor(name: "Chọn tầng", floorNum: 0),
      Floor(name: "Tầng 1", floorNum: 1),
      Floor(name: "Tầng 2", floorNum: 2),
      Floor(name: "Tầng 3", floorNum: 3),
      Floor(name: "Tầng 4", floorNum: 4),
      Floor(name: "Tầng 5", floorNum: 5),
      Floor(name: "Tầng 5", floorNum: 6),
    ];
    int possition = 0;
    final panelController = PanelController();
    final double tabBarHeight = 80;
    var searchValue = null;

    @override
    void initState() {
      super.initState();
    }

    @override
    Widget build(BuildContext context) {
      Object? keySearch = ModalRoute.of(context)!.settings.arguments;
      final screenSize = MediaQuery.of(context).size;
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leadingWidth: 0,
          title: Container(
            width: screenSize.width*0.93,
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 12),
                  height: 40,
                  width: screenSize.width * 0.63,
                  color: Color(0xffF2F2F2),
                  child: TextFormField(
                    onFieldSubmitted: (value) {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                            settings: RouteSettings(arguments: value),
                          ),
                        );
                      print("test search nè: $value");
                    },
                    cursorColor: Colors.black,
                    cursorHeight: 30,
                    cursorWidth: 1,
                    initialValue: keySearch.toString(),
                    decoration: new InputDecoration(
                      prefixIcon: Icon(Icons.search_rounded, color: Color(0xff0DB5B4)),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 15, bottom: 17, top: 11, right: 15),
                      hintText: 'Tìm kiếm ...',
                      hintStyle: TextStyle(color: Colors.grey),
                      labelStyle: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 12, left: 10),
                  height: 40,
                  width: screenSize.width * 0.27,
                  color: Color(0xffF2F2F2),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: DropdownButton<Floor>(
                      icon: Icon(Icons.arrow_drop_down, size: 25,),
                      value: list[possition],
                      onChanged: (newValue) {
                        for (int i = 0; i < list.length; i++) {
                          if (list[i].name.contains(newValue!.name)) {
                            setState(() {
                              possition = i;
                            });
                          }
                        }
                      },
                      items: list.map((index) {
                        return DropdownMenuItem<Floor>(
                          value: index,
                          child: Text(index.name),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: SlidingUpPanel(
          controller: panelController,
          maxHeight: MediaQuery.of(context).size.height - tabBarHeight,
          panelBuilder: (scrollController) =>
              buildSlidingPanel(
                scrollController: scrollController,
                panelController: panelController,
              ),
          body: Container(
            margin: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('https://genk.mediacdn.vn/2018/3/14/photo-1-1521033482343809363991.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          unselectedLabelStyle: TextStyle(color: Colors.grey),
          selectedLabelStyle: TextStyle(color: Color(0xff0DB5B4)),
          type: BottomNavigationBarType.fixed,
          currentIndex: 0,
          selectedItemColor: Color(0xff0DB5B4),
          unselectedItemColor: Color(0xffC4C4C4),
          items: [
            BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(
                Icons.home,
              ),
            ),
            BottomNavigationBarItem(
              label: 'My Coupons',
              icon: Icon(
                Icons.view_list,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Messenges',
              icon: Icon(
                Icons.notifications_active,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Account',
              icon: Icon(
                Icons.account_circle,
              ),
            ),
          ],
        ),
      );
    }
    Widget buildSlidingPanel({required PanelController panelController, required ScrollController scrollController,}) {
       return DefaultTabController(
        length: 1,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(tabBarHeight - 20),
            child: GestureDetector(
              onTap: panelController.open,
              child: AppBar(
                backgroundColor: Colors.white,
                title: Container(
                  margin: EdgeInsets.only(top: 5),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  width: 60,
                  height: 8,
                ),
                centerTitle: true,
                bottom: TabBar(
                  indicatorColor: Colors.black12,
                  tabs: [
                    Tab(child: Container(margin: EdgeInsets.only(right: 200),child: Text('Kết quả tìm kiếm', style: TextStyle(color: Colors.black, fontSize: 22),))),
                  ],
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child:
            Column(
              children: [
                    ListView.separated(
                      //physics: NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) {
                        return Divider(
                          height: 20,
                          thickness: 0.5,
                          color: Colors.grey,
                          indent: 12,
                          endIndent: 12,
                        );
                      },
                      shrinkWrap: true,
                      itemCount: listStoreSearch.length,
                      itemBuilder: (context, index) {
                        return StoreModel(model: listStoreSearch[index]);
                      },
                    ),
              ],
            ),
          ),
        ),
      );
    }

  }
class StoreModel extends StatelessWidget {
  final Store model;

  StoreModel({
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String imageUrl = model.image;
    return GestureDetector(
      // onTap: () {
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => StoreDetailScreen(id: model.id.toString()),
      //     ),
      //   );
      // },
      child: Container(
        color: Colors.white,
        margin: EdgeInsets.only(top: 13),
        padding: EdgeInsets.only(left: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 90,
              child: imageUrl == null
                  ? Align(alignment: Alignment.center,)
                  : ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(6),
                ),
                child: Image.network(
                  imageUrl,
                  width: 110,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: size.width * 0.60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          model.name  + " - L" + model.floorNum,
                          style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Container(
                          child: Icon(Icons.directions, size: 33,)
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 20,
                    child: Text(
                      model.des == null
                          ? "Phục vụ nhiệt tình, chuyên nghiệp"
                          : model.des,
                      style: TextStyle(color: Colors.black87),
                    ),
                  ),
                  Text (model.status ,
                    style: TextStyle(color: Colors.green, fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
List<Store> listStoreSearch = List.from(<Store>[
  Store(id: 1, name: 'Phúc Long', des: 'Trà ngon vì sức khỏe', floorNum: '1', status: 'Mở cả ngày',
      image: 'https://edu2review.com/upload/article-images/2016/07/843/768x768_phuc-long-logo.jpg'),
  Store(id: 2, name: 'Highlands Coffee', des: 'Trà ngon vì sức khỏe', floorNum: '2', status: 'Mở cả ngày',
      image: 'http://niie.edu.vn/wp-content/uploads/2017/09/highlands-coffee.jpg'),
  Store(id: 3, name: 'Bobapop', des: 'Trà ngon vì sức khỏe', floorNum: '3', status: 'Mở cả ngày',
      image: 'https://static.mservice.io/placebrand/s/momo-upload-api-191028114319-637078597998163085.jpg'),
  Store(id: 4, name: 'Tocotoco', des: 'Trà ngon vì sức khỏe', floorNum: '1', status: 'Mở cả ngày',
      image: 'https://1office.vn/wp-content/uploads/2020/02/36852230_419716301836700_6088975431891943424_n-1.png'),
  Store(id: 3, name: 'Bobapop', des: 'Trà ngon vì sức khỏe', floorNum: '3', status: 'Mở cả ngày',
      image: 'https://static.mservice.io/placebrand/s/momo-upload-api-191028114319-637078597998163085.jpg'),
  Store(id: 1, name: 'Phúc Long', des: 'Trà ngon vì sức khỏe', floorNum: '1', status: 'Mở cả ngày',
      image: 'https://edu2review.com/upload/article-images/2016/07/843/768x768_phuc-long-logo.jpg'),
  Store(id: 5, name: 'Gong Cha', des: 'Trà ngon vì sức khỏe', floorNum: '1', status: 'Mở cả ngày',
      image: 'https://edu2review.com/upload/article-images/2016/07/843/768x768_phuc-long-logo.jpg'),
]);



