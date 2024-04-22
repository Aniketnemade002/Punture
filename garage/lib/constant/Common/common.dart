import 'package:flutter/material.dart';

class OutlinedTextFieldExample extends StatelessWidget {
  const OutlinedTextFieldExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const TextField(
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search),
        labelText: 'Outlined',
        hintText: 'hint text',
        helperText: 'supporting text',
        border: OutlineInputBorder(),
      ),
    );
  }
}

class CustomOutlinedTextField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final String helperText;

  const CustomOutlinedTextField({
    Key? key,
    required this.labelText,
    required this.hintText,
    required this.helperText,
  }) : super(key: key);

  @override
  _CustomOutlinedTextFieldState createState() =>
      _CustomOutlinedTextFieldState();
}

class _CustomOutlinedTextFieldState extends State<CustomOutlinedTextField> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: _focusNode,
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          labelText: widget.labelText,
          hintText: widget.hintText,
          helperText: widget.helperText,
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: _isFocused ? Colors.red : Colors.black,
              width: _isFocused ? 2.0 : 1.0,
            ),
          ),
        ),
      ),
    );
  }
}



  // RichText(
  //                   textAlign: TextAlign.left,
  //                   text: TextSpan(
  //                     children: [
  //                       WidgetSpan(
  //                         alignment: PlaceholderAlignment.middle,
  //                         child: Icon(Icons.person,
  //                             size: 30,
  //                             color: Kcolor.button), // Icon on the left side
  //                       ),
  //                       TextSpan(
  //                         text: 'Personal Informaion ', // Text next to the icon
  //                         style: TextStyle(
  //                           color: Kcolor.TextB,
  //                           fontFamily: fontstyles.Gpop,
  //                           fontWeight: FontWeight.w500,
  //                           fontSize: 25,
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),