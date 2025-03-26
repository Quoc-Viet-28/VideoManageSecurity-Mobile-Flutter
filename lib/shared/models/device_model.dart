class Device {
  final String ipWithPort;
  final String userName;
  final String name;

  Device({
    required this.ipWithPort,
    required this.userName,
    required this.name,
  });

  factory Device.fromJson(Map<String, dynamic> json) {
    final ipDevice = json['ip_device'] ?? 'Không có IP';
    final port = json['port']?.toString() ?? 'Không có port';
    final userName = json['user_name'] ?? 'Không có username';
    final name = json['name'] ?? 'Không có tên';

    return Device(
      ipWithPort: '$ipDevice:$port',
      userName: userName,
      name: name,
    );
  }
}