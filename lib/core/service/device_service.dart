import 'dart:developer';

import 'dio_congig.dart';
import '/shared/models/device_model.dart';

class DeviceService {
  final DioConfig _dioConfig = DioConfig();

  Future<List<Device>> fetchData() async {
    try {
      final result = await _dioConfig.dio.get(
        '/device/get-all',
        queryParameters: {"device_type": 'BOX_AI_DAHUA'},
      );
      log('RESULT $result');
      if (result.data is List) {
        List<dynamic> devices = result.data;
        return devices.map((device) => Device.fromJson(device)).toList();
      } else if (result.data is Map) {
        return [Device.fromJson(result.data)];
      } else {
        return [];
      }
    } catch (e) {
      print('ERR $e');
      return [];
    }
  }
}