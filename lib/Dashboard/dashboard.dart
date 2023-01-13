import 'package:beauty_station/Config/config.dart';
import 'package:beauty_station/Home/home.dart';
import 'package:beauty_station/MyBookings/bookings.dart';
import 'package:beauty_station/MyFavorites/myFavorites.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  final selectedLocation;
  dynamic currentTab;

  Widget currentPage = Home();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  Dashboard({
    Key key,
    this.currentTab,
    this.selectedLocation,
  }) {
    if (currentTab != null) {
      currentTab = currentTab;
    } else {
      currentTab = 0;
    }
  }

  @override
  _DashboardState createState() {
    return _DashboardState(currentTab);
  }
}

class _DashboardState extends State<Dashboard> {
  final currentTab;
  _DashboardState(this.currentTab);
  @override
  initState() {
    setState(() {
      getLang();
    });
    super.initState();
    _selectTab(widget.currentTab);
  }

  @override
  void didUpdateWidget(Dashboard oldWidget) {
    _selectTab(oldWidget.currentTab);
    super.didUpdateWidget(oldWidget);
  }

  void _selectTab(int tabItem) {
    setState(
      () {
        widget.currentTab = tabItem;
        switch (tabItem) {
          case 0:
            widget.currentPage = Home();
            break;
          case 1:
            widget.currentPage =
                MyFavorites(selectedLocation: widget.selectedLocation);
            break;
          case 2:
            widget.currentPage = Booking(
              selectedLocation: widget.selectedLocation,
            );
            break;
        }
      },
    );
  }

  bool isArabic = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  void getLang() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isArabic = prefs.getBool('isArabic') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        key: widget.scaffoldKey,
        body: Stack(
          children: <Widget>[
            widget.currentPage,
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: themeColor,
                ),
                child: BottomNavigationBar(
                  showUnselectedLabels: true,
                  backgroundColor: whiteColor,
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: themeColor,
                  unselectedItemColor: greyColor,
                  currentIndex: widget.currentTab,
                  onTap: (int i) {
                    this._selectTab(i);
                  },
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.home,
                        color: widget.currentTab == 0 ? themeColor : greyColor,
                      ),
                      label: isArabic ? 'يكتشف' : 'Explore',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.favorite_border_outlined,
                        color: widget.currentTab == 1 ? themeColor : greyColor,
                      ),
                      label: isArabic ? 'مفضلتي' : 'My Favorites',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.calendar_today_sharp,
                        color: widget.currentTab == 2 ? themeColor : greyColor,
                      ),
                      label: isArabic ? 'حجوزاتي' : 'My Bookings',
                    ),
                  ],
                ),
              ),
            ),
            progressHUD,
          ],
        ),
      ),
    );
  }
}
