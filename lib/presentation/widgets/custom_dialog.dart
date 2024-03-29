import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({Key? key, required this.child, required this.image, this.onClose}) : super(key: key);

  final Widget child;
  final String image;
  final void Function()? onClose;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      content: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: <Widget>[
          _buildCard(context),
          Positioned(
            left: 110,
            right: 110,
            child: Image(
              height: MediaQuery.of(context).size.height * 0.13,
              image: AssetImage(image),
            ),
          ),
          Positioned(
            right: 10,
            top: 10,
            child: onClose != null
                ? GestureDetector(
                    onTapUp: (settings) {
                      onClose!();
                    },
                    child: const Icon(Icons.close),
                  )
                : Container(),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context) {
    final imageHeight = (MediaQuery.of(context).size.height * 0.20) / 2;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).dialogBackgroundColor,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          const BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: Offset(0.0, 10.0),
          ),
        ],
      ),
      child: Container(
        padding: EdgeInsets.only(
          top: imageHeight + 16.0,
          bottom: 14.0,
          left: 14.0,
          right: 14.0,
        ),
        child: child,
      ),
    );
  }
}
