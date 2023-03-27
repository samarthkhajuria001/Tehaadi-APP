import 'package:flutter/material.dart';
import 'package:tehaadi/main.dart';
import 'package:tehaadi/screens/drawer_screen.dart';

import '../constants/colors.dart';
import 'my_task_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController _pageController;
  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void onBottomNavigationBarItemPressed(int page) {
    setState(() {
      current_page = page;
      _pageController.jumpToPage(page);
    });
  }

  int current_page = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        backgroundColor: secondaryBackgroundColor,
        title: const Text("Tehaadi"),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(addNewTaskScreen);
              },
              icon: Icon(Icons.add),
            ),
          )
        ],
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: pageNavigationScreens,
      ),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: secondaryBackgroundColor,
          onTap: onBottomNavigationBarItemPressed,
          items: [
            BottomNavigationBarItem(
                label: '',
                icon: Icon(
                  Icons.today_outlined,
                  color: current_page == 0 ? Colors.white : Colors.black,
                )),
            BottomNavigationBarItem(
                label: '',
                icon: Icon(
                  Icons.group,
                  color: current_page == 1 ? Colors.white : Colors.black,
                )),
          ]),
    );
  }
}

final List<Widget> pageNavigationScreens = [
  MyTaskListScreen(),
  Center(child: Text('other tasks')),
];
