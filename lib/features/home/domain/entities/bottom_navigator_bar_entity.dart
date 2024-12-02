import 'package:civix_app/core/utils/app_images.dart';

class BottomNavigationBarEntity {
  final String activeImage, inActiveImage;
  final String name;
  BottomNavigationBarEntity({
    required this.inActiveImage,
    required this.activeImage,
    required this.name,
  });
}

// List<BottomNavigationBarEntity> get bottomNavigatorBarList => [
//       BottomNavigationBarEntity(
//           activeImage: Assets.imagesNavBarIconsActiveHome,
//           inActiveImage: Assets.imagesNavBarIconsInActiveHome,
//           name: 'الرئيسية'),
//       BottomNavigationBarEntity(
//           activeImage: Assets.imagesNavBarIconsActiveProducts,
//           inActiveImage: Assets.imagesNavBarIconsInActiveProducts,
//           name: 'المنتجات'),
//       BottomNavigationBarEntity(
//           activeImage: Assets.imagesNavBarIconsActiveShoppingCart,
//           inActiveImage: Assets.imagesNavBarIconsInActiveShoppingCart,
//           name: 'سلة التسوق'),
//       BottomNavigationBarEntity(
//           activeImage: Assets.imagesNavBarIconsActiveUser,
//           inActiveImage: Assets.imagesNavBarIconsInActiveUser,
//           name: 'حسابي'),
//     ];
