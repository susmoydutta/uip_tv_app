import 'package:flutter/material.dart';
import 'package:uip_tv_app/presentation/utils/asset_colors_path.dart';

class CategoriesText extends StatelessWidget {
  const CategoriesText({
    super.key,
    required this.title,
    required this.subTitle,
  });

  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {

    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            color: AssetColorsPath.textBoldColors,
          ),
        ),
        Spacer(),
        GestureDetector(
          onTap: () {},
          child: Text(
            subTitle,
            style:TextStyle(
              color: AssetColorsPath.textBoldColors,
            ),
          ),
        ),
      ],
    );
  }
}
