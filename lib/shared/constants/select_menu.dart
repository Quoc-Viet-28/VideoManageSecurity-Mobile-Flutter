import '../layout/interface/item_drawer.dart';

List<ItemDrawer> drawersAdmin = [
  ItemDrawer(
      title: 'Báo cáo tổng quan',
      route: '/home-admin',
      icon: 'item_drawer_1.svg'),
  ItemDrawer(
      title: 'Bảng điều khiển',
      route: '/control-panel-admin',
      icon: 'item_drawer_2.svg'),
  ItemDrawer(
      title: 'Quản lý danh sách đen',
      route: '/settings',
      icon: 'item_drawer_3.svg'),
  ItemDrawer(
      title: 'Quản lý thiết bị',
      route: '/device-management-admin',
      icon: 'item_drawer_4.svg'),
  ItemDrawer(title: 'Bản đồ số', route: '/settings', icon: 'item_drawer_5.svg'),
  ItemDrawer(
      title: 'Lịch sử hoạt động', route: '/logout', icon: 'item_drawer_6.svg'),
  ItemDrawer(
      title: 'Quản lý admin', route: '/settings', icon: 'item_drawer_7.svg'),
  ItemDrawer(title: 'Cài đặt', route: '/logout', icon: 'item_drawer_8.svg'),
];

ItemDrawer selectedItemDrawerAdmin = drawersAdmin[0];

// User

List<ItemDrawer> drawersUser = [
  ItemDrawer(
      title: 'Báo cáo tổng quan',
      route: '/home-user',
      icon: 'item_drawer_1.svg'),
  ItemDrawer(
      title: 'Bảng điều khiển',
      route: '/control-panel-user',
      icon: 'item_drawer_2.svg'),
  ItemDrawer(
      title: 'Quản lý thiết bị', route: '/logout', icon: 'item_drawer_4.svg'),
  ItemDrawer(title: 'Bản đồ số', route: '/settings', icon: 'item_drawer_5.svg'),
  ItemDrawer(title: 'Cài đặt', route: '/logout', icon: 'item_drawer_8.svg'),
];

ItemDrawer selectedItemDrawerUser = drawersUser[0];
