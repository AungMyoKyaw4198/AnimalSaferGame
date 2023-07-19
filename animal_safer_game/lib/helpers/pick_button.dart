import 'package:flutter/material.dart';

class PickButton extends StatefulWidget {
  final Function onTap;
  PickButton({Key? key,required this.onTap}) : super(key: key);

  @override
  _PickButtonState createState() => _PickButtonState();
}

class _PickButtonState extends State<PickButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      width: 120,
      child: GestureDetector(
        onTap: widget.onTap(),
        child: Container(
          decoration: BoxDecoration(
              color: const Color(0x88ffffff),

            borderRadius: BorderRadius.circular(60),
          ),
          child: Center(
            child: Text('Pick Up'),)
        ),
      
      ),
    );
  }
}