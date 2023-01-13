import 'package:beauty_station/Config/config.dart';
import 'package:flutter/material.dart';

Widget teamView(team, context, baseUrl) {
  return Container(
    height: 215.0,
    width: double.infinity,
    padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
    child: team.length == 0
        ? Center(
            child: CircularProgressIndicator(),
          )
        : new ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: team.length,
            itemBuilder: (BuildContext ctxt, int index) {
              return Container(
                margin: EdgeInsets.only(right: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10.0),
                      padding: EdgeInsets.all(5.0),
                      width: 100.0,
                      height: 60.0,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(
                            team[index]['staff_image'] != null
                                ? baseUrl + team[index]['staff_image']
                                : '',
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    hBox(8.0),
                    Text(
                      team[index]['name'],
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    hBox(8.0),
                    // Row(
                    //   children: [
                    //     Icon(
                    //       Icons.star,
                    //       color: Colors.orange,
                    //     ),
                    //     Text(
                    //       team[index]['rating'],
                    //       style: TextStyle(
                    //         fontSize: 15,
                    //         color: Colors.orange,
                    //       ),
                    //       textAlign: TextAlign.center,
                    //     ),
                    //   ],
                    // ),
                    // hBox(8.0),
                    // Text(
                    //   '${team[index]['review'] ?? "0"} Reviews',
                    //   style: TextStyle(
                    //     fontSize: 14,
                    //     fontWeight: FontWeight.w500,
                    //   ),
                    //   textAlign: TextAlign.center,
                    // ),
                    hBox(15.0),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          backgroundColor: Colors.transparent,
                          context: context,
                          isScrollControlled: true,
                          isDismissible: true,
                          builder: (BuildContext context) {
                            return StatefulBuilder(
                              builder: (context, setState) {
                                return Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.85,
                                  width: double.infinity,
                                  padding: EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ListTile(
                                        contentPadding:
                                            EdgeInsets.only(top: 1.0),
                                        leading: Container(
                                          width: 100.0,
                                          height: 60.0,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[100],
                                            shape: BoxShape.circle,
                                            // image: DecorationImage(
                                            // image: NetworkImage(
                                            //   coursesGet[index]['img_url'] != null
                                            //       ? coursesGet[index]['img_url'] +
                                            //       '/' +
                                            //       coursesGet[index]['image']
                                            //       : '',
                                            // ),
                                            // fit: BoxFit.fill,
                                            // ),
                                          ),
                                        ),
                                        title: Text(
                                          team[index]['name'],
                                          style: TextStyle(
                                            color: Colors.black54,
                                          ),
                                        ),
                                        // trailing: Column(
                                        //   children: [
                                        //     Icon(
                                        //       Icons.star,
                                        //       color: Colors.orange,
                                        //     ),
                                        //     Text(
                                        //       team[index]['rating'],
                                        //       style: TextStyle(
                                        //         fontSize: 15,
                                        //         color: Colors.orange,
                                        //       ),
                                        //       textAlign: TextAlign.center,
                                        //     ),
                                        //   ],
                                        // ),
                                      ),
                                      hBox(10.0),
                                      divider(1.0, 1.0, 0.0, 0.0),
                                      hBox(10.0),
                                      Text(
                                        'About',
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      hBox(8.0),
                                      Text(
                                        team[index]['about'] ?? '',
                                        style: TextStyle(
                                          color: Colors.black54,
                                        ),
                                      ),
                                      hBox(10.0),
                                      Text(
                                        'Services',
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 30,
                        width: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: whiteColor,
                          border: Border.all(
                            width: 2.5,
                            color: themeColor,
                          ),
                        ),
                        child: Text(
                          'View',
                          style: TextStyle(
                            color: themeColor,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
  );
}

Widget openingDay(openingTime) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Opening Hours',
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
      hBox(8.0),
      for (var i = 0; i < openingTime.length ?? 0; i++) ...[
        ListTile(
          contentPadding: EdgeInsets.only(
            top: 1.0,
            bottom: 1.0,
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                openingTime[i]['day'],
                style: TextStyle(
                  color: openingTime[i]['time'] != null
                      ? Colors.black
                      : Colors.black38,
                ),
              ),
              Text(
                openingTime[i]['time'] != null
                    ? openingTime[i]['time']
                    : "closed",
                style: TextStyle(
                  color: openingTime[i]['time'] != null
                      ? Colors.black
                      : Colors.black38,
                ),
              ),
            ],
          ),
          leading: Icon(
            Icons.circle,
            size: 20.0,
            color: openingTime[i]['time'] != null
                ? Colors.redAccent
                : Colors.black38,
          ),
        ),
      ],
    ],
  );
}
