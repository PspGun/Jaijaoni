import 'package:flutter/material.dart';

import 'friend_list_check.dart';
import 'selected_friend.dart';

class FriendList extends StatefulWidget {
  final String searchText;
  const FriendList(
      {super.key,
      required this.peopleList,
      required this.handleSelectPeople,
      required this.searchText});
  final List<SelectedFirend> peopleList;
  final Function handleSelectPeople;

  @override
  State<FriendList> createState() => _FriendListState();
}

class _FriendListState extends State<FriendList> {
  List<SelectedFirend> friendList = [
    SelectedFirend("001", "images/profile/dazai", "muaymi", 100),
    SelectedFirend("002", "images/profile/dazai", "tine", 100),
    SelectedFirend("003", "images/profile/dazai", "ri", 100),
    SelectedFirend("004", "images/profile/dazai", "fah", 100),
    SelectedFirend("005", "images/profile/dazai", "gun", 100),
    SelectedFirend("006", "images/profile/dazai", "dazai", 100),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Wrap(
          children: friendList
              .where((element) => element.name.contains(widget.searchText))
              .map((e) => ListOfFriend(
                  id: e.id,
                  imagePath: "images/profile/dazai.jpg",
                  name: e.name,
                  check: widget.peopleList
                          .indexWhere((element) => element.id == e.id) !=
                      -1,
                  handleCheck: (check) {
                    if (check) {
                      widget.handleSelectPeople([...widget.peopleList, e]);
                    } else {
                      widget.handleSelectPeople(widget.peopleList
                          .where((element) => element.id != e.id)
                          .toList());
                    }
                  }))
              .toList()),
    );
  }
}