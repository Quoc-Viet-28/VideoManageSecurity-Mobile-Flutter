import 'dart:developer';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class TimeLinePainter extends CustomPainter {
  final double hourWidth;
  TimeLinePainter({required this.hourWidth});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.amberAccent
      ..strokeWidth = 2;
    for (double i = 0; i <= size.width; i += hourWidth) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class LiveViewPage extends StatefulWidget {
  const LiveViewPage({Key? key}) : super(key: key);

  @override
  _LiveViewPageState createState() => _LiveViewPageState();
}

class _LiveViewPageState extends State<LiveViewPage> {
  late VlcPlayerController _vlcController;

  String url = 'rtsp://admin:Oryza%40123@192.168.103.225:554/cam/realmonitor?channel=1&subtype=0';
  DateTime timeInput = DateTime(2024, 1, 1, 20, 00, 45);
  Duration timeInterval = const Duration(hours: 1, minutes: 0, seconds: 0);
  DateTime startTime = DateTime(2024, 1, 1, 12, 0, 0);
  double screenWidth = 0;
  double screenHeight = 0;
  double currentValue = 0;
  double tempValue = 0;
  double scrollPosition = 0;
  double result = 0;
  double secondTotal = 0;
  (double, DateTime, double) listCheckTime = (0, DateTime(2024, 1, 1, 12, 0, 0), 0);
  double numberOfInterval = 0;
  double targetPosition = 0;
  late double minTimeLine;
  final ScrollController _scrollController = ScrollController();
  Timer? autoScrollTimer;
  double autoPosition = 0;
  late Ticker _ticker;
  final Duration timeStep = const Duration(milliseconds: 17);
  late DateTime timeAtPosition;
  late int secondsAtPosition;
  late double secondsPerPixel;
  bool isDragging = false;
  bool isDraggingCurrent = false;


  @override
  void initState() {
    super.initState();
    final ui.Size size = ui.window.physicalSize / ui.window.devicePixelRatio;
    screenWidth = size.width;
    screenHeight = size.height;
    currentValue = screenWidth / 2;
    listCheckTime = findMinIndex(startTime, timeInterval, timeInput);
    startTime = listCheckTime.$2;
    numberOfInterval = listCheckTime.$1;
    secondTotal = listCheckTime.$3;
    timeAtPosition = timeInput;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      tempValue = currentValue;
      targetPosition = (timeInput.difference(startTime).inSeconds * ((screenWidth / 4) / 3600)) - currentValue;
      _scrollController.jumpTo(targetPosition);
      _ticker = Ticker((Duration elapsed) {
        setState(() {
          targetPosition += screenWidth / 4 / 3600 ;
          currentValue += screenWidth / 4 / 3600 ;

          if(isDragging) {
            targetPosition = scrollPosition;
            isDragging = false;
          }
          if(currentValue >= screenWidth / 2) {
            currentValue = screenWidth / 2;
          }
          _scrollController.jumpTo(targetPosition);
          timeAtPosition = timeAtPosition.add(timeStep);
        });

      });
      _ticker.start();
    });
    initVlcVideo();

  }

  initVlcVideo() {
    if (url.isEmpty) return;
    final options = VlcPlayerOptions(
      advanced: VlcAdvancedOptions(['--network-caching=10000']),
      audio: VlcAudioOptions(['--no-audio-time-stretch']),
      rtp: VlcRtpOptions(['--rtsp-tcp']),
      video: VlcVideoOptions(['--drop-late-frames', '--skip-frames']),
    );
    _vlcController = VlcPlayerController.network(
      url,
      hwAcc: HwAcc.full,
      autoPlay: true,
      options: options,
      allowBackgroundPlayback: false,
    );
    _vlcController.addListener(() {});
  }
  String _formatTime(DateTime time) {
    return DateFormat('HH:mm:ss').format(time);
  }

  findMinIndex(DateTime startTime, Duration timeInterval, DateTime timeInput) {
    double totalSeconds = (timeInput.difference(startTime).inSeconds).toDouble();
    double minIndex = totalSeconds / timeInterval.inSeconds;
    int? minIndexInt_2;
    minIndex = minIndex.abs();
    minIndexInt_2 = minIndex.ceil();
    if(minIndexInt_2 < 2) {
      minTimeLine = 0;
    }
    else {
      minTimeLine = (-screenWidth / 2);
    }
    if (minIndex % 1 != 0) {
      startTime = startTime.subtract(const Duration(seconds: 7200));
      minIndexInt_2=minIndexInt_2+minIndexInt_2+2+1;
    }
    else {
      startTime = startTime.subtract(const Duration(seconds: 7200));
      minIndexInt_2 = minIndexInt_2+minIndexInt_2+2;
    }
    log("MIN INDEX: $minIndexInt_2");
    log("START TIME: $startTime");
    return (minIndexInt_2.toDouble(), startTime, totalSeconds);
  }
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double totalSeconds = timeInput.difference(startTime).inSeconds.toDouble();
    final screenSize = MediaQuery.of(context).size;


    return Scaffold(
      appBar: AppBar(
        title: const Text('ANPR'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Video Player
          Expanded(
            child: VlcPlayer(
              controller: _vlcController,
              aspectRatio: screenSize.height / screenSize.width,
              placeholder: Container(color: Colors.black),
            ),
          ),
          // Controls and Timeline
          Column(
            children: [
              Container(
                height: 40,
                color: Colors.grey,
                child: ListView.builder(
                  controller: _scrollController,
                  // physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: numberOfInterval.floor(),
                  itemBuilder: (context, index) {
                    final time = startTime.add(timeInterval * index);
                    return SizedBox(
                      width: screenSize.width / 4,
                      child:
                          Text(
                            _formatTime(time),
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                              backgroundColor: Colors.red,
                            ),
                          ),
                      );
                  },
                ),
              ),
              SizedBox(
                height: 40,
                width: screenSize.width,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Background Line
                    Container(
                      height: 16,
                      color: Colors.grey.shade700,
                    ),
                    // Progress Green Line
                    Positioned(
                      left: 0,
                      right: currentValue,
                      child: Container(
                        height: 16,
                        color: Colors.green,
                        child: CustomPaint(
                          painter: TimeLinePainter(
                            hourWidth: screenSize.width / 4,
                            ),
                          child: Container(
                            height: 16,
                          ),
                        ),
                      ),
                    ),
                    // Red Line
                    Positioned(
                      left: screenSize.width / 2,
                      child: Container(
                        width: 2,
                        height: 16,
                        color: Colors.redAccent,
                      ),
                    ),
                    //time at position
                    Positioned(
                      left: screenSize.width / 2,
                      bottom: 20,
                      child: Text(
                        _formatTime(timeAtPosition),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    // Gesture handling for zoom
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onHorizontalDragStart: (details) {
                        setState(() {
                          isDragging = true;
                        });
                        _ticker.stop();
                      },
                      onHorizontalDragUpdate: (details) {
                        setState(() {
                          final oldValue = currentValue;
                          tempValue = (tempValue + details.primaryDelta!).clamp(screenWidth/2, (timeInput.difference(startTime)* ((screenWidth/4) / 3600)).inSeconds.toDouble());
                          currentValue = (currentValue - details.primaryDelta!).clamp(minTimeLine, screenSize.width/2);
                          scrollPosition =(timeInput.difference(startTime).inSeconds * ((screenWidth/4) / 3600) - tempValue);
                          log("SCROLL POSITION: $scrollPosition");
                          if (oldValue != currentValue && currentValue != screenSize.width / 2) {
                            _scrollController.jumpTo(scrollPosition);
                          }
                          secondsAtPosition = (scrollPosition * (3600/(screenWidth/4))).toInt();
                          timeAtPosition = startTime.add(Duration(seconds: secondsAtPosition + 7200));
                          log("SECONDS AT POSITION: $secondsAtPosition");
                          log("TIME AT POSITION: $timeAtPosition");
                          log("CURRENT VALUE: $currentValue");
                        });
                      },
                      onHorizontalDragEnd: (details) {
                        _ticker.start();
                      },
                    )
                  ],
                ),
              ),
              // Timeline Slider
              // Playback Controls
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                      onPressed: () {
                        print("Tua trái");
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.add, color: Colors.white),
                      onPressed: () {
                        print("ZOOM IN");
                      },
                    ),
                    IconButton(
                      icon: _vlcController.value.isPlaying
                          ? const Icon(Icons.pause, color: Colors.white)
                          : const Icon(Icons.play_arrow, color: Colors.white),
                      onPressed: () {
                        setState(() {
                          if (_vlcController.value.isPlaying) {
                            _vlcController.pause();
                          } else {
                            _vlcController.play();
                          }
                        });
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.remove, color: Colors.white),
                      onPressed: (){
                        print("ZOOM OUT");
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_forward_ios, color: Colors.white),
                      onPressed: () {
                        print("Tua phải");
                        // setState(() {
                        //   currentValue = (currentValue + 50).clamp(0, 1000);
                        //   _scrollController.jumpTo(
                        //     (currentValue / 1000) *
                        //         _scrollController.position.maxScrollExtent,
                        //   );
                        // });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      backgroundColor: Colors.black,
    );
  }
}
