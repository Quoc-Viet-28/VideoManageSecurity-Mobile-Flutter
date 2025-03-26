import 'dart:developer';

import 'package:box_alarm/shared/layout/main_layout.dart';
import 'package:flutter/material.dart';
import '../../../core/service/dio_congig.dart';
import '/core/service/device_service.dart';
import '/shared/models/device_model.dart';
import '/features/home/views/list_server.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  late Future<List<Device>> _futureDeviceList;

  @override
  void initState() {
    super.initState();
    _futureDeviceList = fetchDeviceList();
  }
  Future<List<Device>> fetchDeviceList() async {
    return await DeviceService().fetchData();
  }
  Future<void> fetchData_tesssst() async {
    const String url =
        "http://192.168.103.75:8001/api/v1/device/get-all?device_type=BOX_AI_DAHUA";

    DioConfig dioconfig = DioConfig();

    try {
      final result = await dioconfig.dio.get(
        '/device/get-all',
        queryParameters: {"device_type": "BOX_AI_DAHUA"},
      );
      log("RES: ${result.data}");
      log("URL: ${result.statusCode}");
      log("URL222: ${result.statusMessage}");
    } catch (e) {
      print('ERR $e');
    }
  }

  void _refreshDeviceList() {
    setState(() {
      fetchData_tesssst();
      _futureDeviceList = fetchDeviceList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Device>>(
              future: _futureDeviceList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text('Có lỗi xảy ra'),
                  );
                } else {
                  final devices = snapshot.data ?? [];
                  return ListView.builder(
                    itemCount: devices.length,
                    itemBuilder: (context, index) {
                      final device = devices[index];
                      return Container(
                        margin: EdgeInsets.fromLTRB(
                          16,
                          index == 0 ? 16 : 1,
                          16,
                          1,
                        ),
                        child: ListServer(
                          name: device.name,
                          ip: device.ipWithPort,
                          username: device.userName,
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2B3840),
              foregroundColor: Colors.white,
            ),
            onPressed: _refreshDeviceList,
            child: const Text('Refresh List Device'),
          ),
          _buildConnectToOtherServersButton(),
        ],
      ),
    );
  }
  _buildConnectToOtherServersButton() {
    return GestureDetector(
      onTap: () async {},
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Color(0xFF111518),
              width: 1,
            ),
          ),
        ),
        child: BottomAppBar(
          padding: const EdgeInsets.fromLTRB(16, 13, 16, 48),
          height: 100,
          color: const Color(0xFF171C1F),
          child: Container(
            alignment: Alignment.center,
            color: const Color(0xFF2B3840),
            child: const Center(
              child: Text(
                'Kết nối đến các máy chủ khác...',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Inter',
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
