import 'package:box_alarm/shared/constants/shared_constants_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SwitchButton extends StatefulWidget {
  const SwitchButton(
      {super.key,
      required this.isFirstOptionSelected,
      required this.onToggle,
      this.icon = false,
      this.colorBg});

  final bool isFirstOptionSelected;
  final Function(bool) onToggle;
  final bool? icon;
  final Color? colorBg;

  @override
  State<SwitchButton> createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<SwitchButton> {
  late bool _isFirstOptionSelected; // Biến trạng thái cho switch

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isFirstOptionSelected = widget.isFirstOptionSelected;
    print('init state');
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _isFirstOptionSelected = !_isFirstOptionSelected;
              widget.onToggle(_isFirstOptionSelected);
            });
          },
          child: Container(
            width: 60,
            height: 30,
            padding: EdgeInsets.all(3),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              // color: _isFirstOptionSelected ? Color(0xffEFEFEF) : vibrantOrange,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: Offset(0, 1),
                  blurStyle: BlurStyle.inner,
                  spreadRadius: 1,
                  blurRadius: 1,
                ),
              ],
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    !_isFirstOptionSelected
                        ? Color(0xffEFEFEF)
                        : widget.colorBg ?? vibrantOrange,
                    !_isFirstOptionSelected
                        ? Color(0xffEFEFEF).withOpacity(0.5)
                        : widget.colorBg?.withOpacity(0.5) ??
                            vibrantOrange.withOpacity(0.5),
                  ]),
            ),
            child: Stack(
              children: [
                AnimatedPositioned(
                  duration: Duration(milliseconds: 200),
                  left: !_isFirstOptionSelected ? 4 : 26,
                  child: Container(
                    width: 24,
                    height: 24,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: widget.icon!
                        ? Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                          )
                        : SvgPicture.asset(
                            'assets/icons/home/device_manage_toggle_button.svg',
                            width: 16,
                            height: 16,
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
