import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:photos_api/view_model/Home_model.dart';
import 'package:provider/provider.dart';

import '../utils/widget.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  Animation<double>? _animation;
  AnimationController? _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController!);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final val = Provider.of<HomeModel>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Upload App'),
        ),
        body: homeList[val.selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.send),
              label: 'Send ',
              backgroundColor: Colors.red,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.call_received_outlined),
              label: 'Receive',
              backgroundColor: Colors.green,
            ),
          ],
          currentIndex: val.selectedIndex,
          onTap: (i) {
            val.setIndex(i);
          },
        ),
        floatingActionButton: Visibility(
          visible: val.isVisible,
          child: FloatingActionBubble(
            items: <Bubble>[
              Bubble(
                title: "upload photos",
                iconColor: Colors.white,
                bubbleColor: Colors.blue,
                icon: Icons.photo,
                titleStyle: TextStyle(fontSize: 16, color: Colors.white),
                onPress: () {
                  val.uploadImage(context);
                  _animationController!.reverse();
                },
              ),
              Bubble(
                title: "upload videos",
                iconColor: Colors.white,
                bubbleColor: Colors.blue,
                icon: Icons.video_call,
                titleStyle: TextStyle(fontSize: 16, color: Colors.white),
                onPress: () {
                  val.selectVideoAndUpload(context);
                  _animationController!.reverse();
                },
              ),
            ],
            animation: _animation!,
            onPress: () => _animationController!.isCompleted
                ? _animationController!.reverse()
                : _animationController!.forward(),
            iconColor: Colors.blue,
            iconData: Icons.add,
            backGroundColor: Colors.white,
          ),
        ));
  }
}
