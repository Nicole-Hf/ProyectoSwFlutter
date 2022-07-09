import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String btnText;
  final Function onBtnPressed;

  const RoundedButton ({Key? key, required this.btnText, required this.onBtnPressed}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      color: const Color.fromARGB(255, 1, 87, 21),
      borderRadius: BorderRadius.circular(30),
      child: MaterialButton(
        onPressed: () {
          onBtnPressed();
        },
        minWidth: 320,
        height: 40,
        child: Text(
          btnText,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}

TextButton kTextButton(String label, Function onPressed) {
  return TextButton(
    onPressed: () => onPressed(),
    style: ButtonStyle(
      backgroundColor: MaterialStateColor.resolveWith((states) => Colors.green),
      padding: MaterialStateProperty.resolveWith((states) => const EdgeInsets.symmetric(vertical: 10)),
    ), 
    child: const Text('Login', style: TextStyle(color: Colors.white),),
  );
}