// import 'package:animations/animations.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:shop/constants.dart';
// import 'package:shop/route/screen_export.dart';

// class EntryPoint extends StatefulWidget {
//   const EntryPoint({super.key});

//   @override
//   State<EntryPoint> createState() => _EntryPointState();
// }

// class _EntryPointState extends State<EntryPoint> {
//   final List _pages = const [
//     HomeScreen(),
//     DiscoverScreen(),
//     BookmarkScreen(),
//     // EmptyCartScreen(), // if Cart is empty
//     CartScreen(),
//     // ProfileScreen(),
//     LoginScreen()
//   ];
//   int _currentIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     SvgPicture svgIcon(String src, {Color? color}) {
//       return SvgPicture.asset(
//         src,
//         height: 24,
//         colorFilter: ColorFilter.mode(
//             color ??
//                 Theme.of(context).iconTheme.color!.withOpacity(
//                     Theme.of(context).brightness == Brightness.dark ? 0.3 : 1),
//             BlendMode.srcIn),
//       );
//     }

//     return Scaffold(
//       appBar: AppBar(
//         // pinned: true,
//         // floating: true,
//         // snap: true,
//         backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//         leading: const SizedBox(),
//         leadingWidth: 0,
//         centerTitle: false,
//         title: SvgPicture.asset(
//           "assets/logo/Shoplon.svg",
//           colorFilter: ColorFilter.mode(
//               Theme.of(context).iconTheme.color!, BlendMode.srcIn),
//           height: 20,
//           width: 100,
//         ),
//         actions: [
//           IconButton(
//             onPressed: () {
//               Navigator.pushNamed(context, searchScreenRoute);
//             },
//             icon: SvgPicture.asset(
//               "assets/icons/Search.svg",
//               height: 24,
//               colorFilter: ColorFilter.mode(
//                   Theme.of(context).textTheme.bodyLarge!.color!,
//                   BlendMode.srcIn),
//             ),
//           ),
//           IconButton(
//             onPressed: () {
//               Navigator.pushNamed(context, notificationsScreenRoute);
//             },
//             icon: SvgPicture.asset(
//               "assets/icons/Notification.svg",
//               height: 24,
//               colorFilter: ColorFilter.mode(
//                   Theme.of(context).textTheme.bodyLarge!.color!,
//                   BlendMode.srcIn),
//             ),
//           ),
//         ],
//       ),
//       // body: _pages[_currentIndex],
//       body: PageTransitionSwitcher(
//         duration: defaultDuration,
//         transitionBuilder: (child, animation, secondAnimation) {
//           return FadeThroughTransition(
//             animation: animation,
//             secondaryAnimation: secondAnimation,
//             child: child,
//           );
//         },
//         child: _pages[_currentIndex],
//       ),
//       bottomNavigationBar: Container(
//         padding: const EdgeInsets.only(top: defaultPadding / 2),
//         color: Theme.of(context).brightness == Brightness.light
//             ? Colors.white
//             : const Color(0xFF101015),
//         child: BottomNavigationBar(
//           currentIndex: _currentIndex,
//           onTap: (index) {
//             if (index != _currentIndex) {
//               setState(() {
//                 _currentIndex = index;
//               });
//             }
//           },
//           backgroundColor: Theme.of(context).brightness == Brightness.light
//               ? Colors.white
//               : const Color(0xFF101015),
//           type: BottomNavigationBarType.fixed,
//           // selectedLabelStyle: TextStyle(color: primaryColor),
//           selectedFontSize: 12,
//           selectedItemColor: primaryColor,
//           unselectedItemColor: Colors.transparent,
//           items: [
//             BottomNavigationBarItem(
//               icon: svgIcon("assets/icons/Shop.svg"),
//               activeIcon: svgIcon("assets/icons/Shop.svg", color: primaryColor),
//               label: "Shop",
//             ),
//             BottomNavigationBarItem(
//               icon: svgIcon("assets/icons/Category.svg"),
//               activeIcon:
//                   svgIcon("assets/icons/Category.svg", color: primaryColor),
//               label: "Discover",
//             ),
//             BottomNavigationBarItem(
//               icon: svgIcon("assets/icons/Bookmark.svg"),
//               activeIcon:
//                   svgIcon("assets/icons/Bookmark.svg", color: primaryColor),
//               label: "Bookmark",
//             ),
//             BottomNavigationBarItem(
//               icon: svgIcon("assets/icons/Bag.svg"),
//               activeIcon: svgIcon("assets/icons/Bag.svg", color: primaryColor),
//               label: "Cart",
//             ),
//             BottomNavigationBarItem(
//               icon: svgIcon("assets/icons/Profile.svg"),
//               activeIcon:
//                   svgIcon("assets/icons/Profile.svg", color: primaryColor),
//               label: "Profile",
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop/constants.dart';
import 'package:shop/route/screen_export.dart';
import 'package:shop/services/login_service.dart'; // Import LoginService

class EntryPoint extends StatefulWidget {
  const EntryPoint({super.key});

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint> {
  final List<Widget> _pages = [
    const HomeScreen(),
    const DiscoverScreen(),
    const BookmarkScreen(),
    // const EmptyCartScreen(), // if Cart is empty
    const CartScreen(),
    // const ProfileScreen(),
    const LoginScreen()
  ];
  int _currentIndex = 0;
  final LoginService _loginService = LoginService(); // Initialize LoginService

  @override
  Widget build(BuildContext context) {
    SvgPicture svgIcon(String src, {Color? color}) {
      return SvgPicture.asset(
        src,
        height: 24,
        colorFilter: ColorFilter.mode(
            color ?? Theme.of(context).iconTheme.color!.withOpacity(
                Theme.of(context).brightness == Brightness.dark ? 0.3 : 1),
            BlendMode.srcIn),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: const SizedBox(),
        leadingWidth: 0,
        centerTitle: false,
        title: const Text(
          "Interior",   
          style: TextStyle(
            color: Colors.blue,
            fontSize: 23,
            fontWeight: FontWeight.bold,
            // fontFamily: 'Music',
            
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, searchScreenRoute);
            },
            icon: SvgPicture.asset(
              "assets/icons/Search.svg",
              height: 24,
              colorFilter: ColorFilter.mode(
                  Theme.of(context).textTheme.bodyLarge!.color!,
                  BlendMode.srcIn),
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, notificationsScreenRoute);
            },
            icon: SvgPicture.asset(
              "assets/icons/Notification.svg",
              height: 24,
              colorFilter: ColorFilter.mode(
                  Theme.of(context).textTheme.bodyLarge!.color!,
                  BlendMode.srcIn),
            ),
          ),
        ],
      ),
      body: PageTransitionSwitcher(
        duration: defaultDuration,
        transitionBuilder: (child, animation, secondAnimation) {
          return FadeThroughTransition(
            animation: animation,
            secondaryAnimation: secondAnimation,
            child: child,
          );
        },
        child: _pages[_currentIndex],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(top: defaultPadding / 2),
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : const Color(0xFF101015),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) async {
            if (index == 4) { // Check if the Profile icon is tapped
              bool loggedIn = await _loginService.isLoggedIn();
              if (loggedIn) {
                setState(() {
                  _pages[4] =  ProfileScreen(); // Update to ProfileScreen if logged in
                });
              } else {
                setState(() {
                  _pages[4] = const LoginScreen(); // Update to LoginScreen if not logged in
                });
              }
            }
            if (index != _currentIndex) {
              setState(() {
                _currentIndex = index;
              });
            }
          },
          backgroundColor: Theme.of(context).brightness == Brightness.light
              ? Colors.white
              : const Color(0xFF101015),
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 12,
          selectedItemColor: primaryColor,
          unselectedItemColor: Colors.transparent,
          items: [
            BottomNavigationBarItem(
              icon: svgIcon("assets/icons/Shop.svg"),
              activeIcon: svgIcon("assets/icons/Shop.svg", color: primaryColor),
              label: "Shop",
            ),
            BottomNavigationBarItem(
              icon: svgIcon("assets/icons/Category.svg"),
              activeIcon:
                  svgIcon("assets/icons/Category.svg", color: primaryColor),
              label: "Discover",
            ),
            BottomNavigationBarItem(
              icon: svgIcon("assets/icons/Bookmark.svg"),
              activeIcon:
                  svgIcon("assets/icons/Bookmark.svg", color: primaryColor),
              label: "Bookmark",
            ),
            BottomNavigationBarItem(
              icon: svgIcon("assets/icons/Bag.svg"),
              activeIcon: svgIcon("assets/icons/Bag.svg", color: primaryColor),
              label: "Cart",
            ),
            BottomNavigationBarItem(
              icon: svgIcon("assets/icons/Profile.svg"),
              activeIcon:
                  svgIcon("assets/icons/Profile.svg", color: primaryColor),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}