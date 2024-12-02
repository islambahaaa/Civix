// import 'package:flutter/material.dart';
// import 'package:civix_app/core/utils/app_colors.dart';
// import 'package:civix_app/core/utils/app_images.dart';
// import 'package:google_nav_bar/google_nav_bar.dart';
// import 'package:svg_flutter/svg_flutter.dart';

// class GoogleNavBotoomBar extends StatefulWidget {
//   const GoogleNavBotoomBar({super.key});

//   @override
//   State<GoogleNavBotoomBar> createState() => _GoogleNavBotoomBarState();
// }

// class _GoogleNavBotoomBarState extends State<GoogleNavBotoomBar> {
//   int _selectedIndex = 0;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 375,
//       height: 70,
//       decoration: const ShapeDecoration(
//         color: Colors.white,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(30),
//             topRight: Radius.circular(30),
//           ),
//         ),
//         shadows: [
//           BoxShadow(
//             color: Color(0x19000000),
//             blurRadius: 7,
//             offset: Offset(0, -2),
//             spreadRadius: 0,
//           )
//         ],
//       ),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//         child: GNav(
//           selectedIndex: _selectedIndex,
//           onTabChange: (index) {
//             setState(() {
//               _selectedIndex = index;
//             });
//           },
//           backgroundColor: Colors.white,
//           // Inactive icon color
//           activeColor: AppColors.primaryColor, // Active icon color
//           tabBackgroundColor:
//               const Color(0xFFEEEEEE), // Active tab background color
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
//           gap: 8,
//           tabs: [
//             GButton(
//               padding: const EdgeInsets.all(0),
//               icon: Icons.home,
//               leading: _selectedIndex == 0
//                   ? Container(
//                       width: 30,
//                       height: 30,
//                       decoration: ShapeDecoration(
//                         color: AppColors.primaryColor,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(30),
//                         ),
//                       ),
//                       child: Center(
//                           child: SvgPicture.asset(
//                               Assets.imagesNavBarIconsActiveHome)),
//                     )
//                   : Container(
//                       width: 30,
//                       height: 30,
//                       decoration: ShapeDecoration(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(30),
//                         ),
//                       ),
//                       child: Center(
//                           child: SvgPicture.asset(
//                               Assets.imagesNavBarIconsInActiveHome)),
//                     ),
//               text: 'الرئيسية',
//               iconColor: Colors.grey,
//             ),
//             GButton(
//               padding: const EdgeInsets.all(0),
//               icon: Icons.home,
//               leading: _selectedIndex == 1
//                   ? Container(
//                       width: 30,
//                       height: 30,
//                       decoration: ShapeDecoration(
//                         color: AppColors.primaryColor,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(30),
//                         ),
//                       ),
//                       child: Center(
//                           child: SvgPicture.asset(
//                               Assets.imagesNavBarIconsActiveProducts)),
//                     )
//                   : Container(
//                       width: 30,
//                       height: 30,
//                       decoration: ShapeDecoration(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(30),
//                         ),
//                       ),
//                       child: Center(
//                           child: SvgPicture.asset(
//                               Assets.imagesNavBarIconsInActiveProducts)),
//                     ),
//               text: 'المنتجات',
//               iconColor: Colors.grey,
//             ),
//             GButton(
//               padding: const EdgeInsets.all(0),
//               icon: Icons.home,
//               leading: _selectedIndex == 2
//                   ? Container(
//                       width: 30,
//                       height: 30,
//                       decoration: ShapeDecoration(
//                         color: AppColors.primaryColor,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(30),
//                         ),
//                       ),
//                       child: Center(
//                           child: SvgPicture.asset(
//                               Assets.imagesNavBarIconsActiveShoppingCart)),
//                     )
//                   : Container(
//                       width: 30,
//                       height: 30,
//                       decoration: ShapeDecoration(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(30),
//                         ),
//                       ),
//                       child: Center(
//                           child: SvgPicture.asset(
//                               Assets.imagesNavBarIconsInActiveShoppingCart)),
//                     ),
//               text: 'سلة التسوق',
//               iconColor: Colors.grey,
//             ),
//             GButton(
//               padding: const EdgeInsets.all(0),
//               icon: Icons.home,
//               leading: _selectedIndex == 3
//                   ? Container(
//                       width: 30,
//                       height: 30,
//                       decoration: ShapeDecoration(
//                         color: AppColors.primaryColor,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(30),
//                         ),
//                       ),
//                       child: Center(
//                           child: SvgPicture.asset(
//                               Assets.imagesNavBarIconsActiveUser)),
//                     )
//                   : Container(
//                       width: 30,
//                       height: 30,
//                       decoration: ShapeDecoration(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(30),
//                         ),
//                       ),
//                       child: Center(
//                           child: SvgPicture.asset(
//                               Assets.imagesNavBarIconsInActiveUser)),
//                     ),
//               text: 'حسابي',
//               iconColor: Colors.grey,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
