import 'package:biocountermobile/core/utils/constants.dart';
import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final Function onPressed;
  final Widget child;
  final Color? btnColor;
  final double? btnWidth;
  final double? btnHeight;
  final Color? borderColor;

  const DefaultButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.btnColor,
    this.btnWidth,
    this.btnHeight,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: btnWidth ?? double.infinity,
      height: btnHeight,
      child: RawMaterialButton(
        onPressed: () {
          onPressed();
        },
        fillColor: btnColor,
        elevation: 1,
        padding: EdgeInsets.symmetric(
          vertical: btnHeight != null ? 0 : 15,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(defaultRadius * 3),
          ),
          side: BorderSide(
            color: borderColor ?? Colors.transparent,
            width: borderColor != null ? 2.0 : 0.0,
          ),
        ),
        child: child,
      ),
    );
  }
}


// class DefaultButton extends StatelessWidget {
//   final Function onPressed;
//   final Widget child;
//   final Color? btnColor;
//   final double? btnPadding;
//   const DefaultButton(
//       {super.key,
//       required this.onPressed,
//       required this.child,
//       this.btnColor,
//       this.btnPadding});

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       child: RawMaterialButton(
//         onPressed: () {
//           onPressed();
//         },
//         fillColor: btnColor,
//         elevation: 1,
//         padding: EdgeInsets.symmetric(
//           vertical: btnPadding ?? 14,
//         ),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(
//             Radius.circular(defaultRadius * 3),
//           ),
//         ),
//         child: child,
        
//       ),
//     );
//   }
// }
