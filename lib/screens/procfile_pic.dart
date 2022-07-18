import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfilePic extends StatelessWidget {
  final String text_image;

  const ProfilePic({Key? key, required this.text_image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 115,
        width: 115,
        child: Stack(fit: StackFit.expand, clipBehavior: Clip.none, children: [
          CircleAvatar(
            backgroundImage: NetworkImage(text_image),
          ),
          Positioned(
              right: -12,
              bottom: 0,
              child: SizedBox(
                height: 46,
                width: 46,
                child: FlatButton(
                  padding: EdgeInsets.symmetric(vertical: 13, horizontal: 13),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide(color: Colors.white),
                  ),
                  color: Colors.grey,
                  onPressed: () {},
                  child: SvgPicture.asset("assets/images/camera_icon.svg"),
                ),
              )),
        ]));
  }
}
