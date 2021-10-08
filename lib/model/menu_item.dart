import 'package:barber_booking/config/assets.dart';

class MenuItem {
  final String? image;
  final String? title;
  final String? routeName;
  MenuItem({this.image, this.title, this.routeName});
}

final menuItem = [
  MenuItem(title: "Booking", image: Assets.booking, routeName: '/booking'),
  MenuItem(title: "Orders", image: Assets.orders, routeName: '/orders'),
  MenuItem(title: "Map", image: Assets.map, routeName: '/map'),
  MenuItem(title: "Message", image: Assets.message, routeName: '/message'),
  MenuItem(title: "Account", image: Assets.account, routeName: '/account'),
  MenuItem(title: "Setting", image: Assets.setting, routeName: '/setting')
];

List<MenuItem> getMenuItem() => List.generate(
    menuItem.length,
    (index) => MenuItem(
          title: menuItem[index].title,
          image: menuItem[index].image,
          routeName: menuItem[index].routeName,
        ));
