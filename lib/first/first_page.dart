import 'package:flutter/material.dart';
import 'package:flutter_screen_adapt/first/wh_radio_adapt.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  void printScreenInfo() {
    debugPrint('设备像素比：${WHRadioAdapt().pixelRatio}');
    debugPrint('逻辑底部导航高度：${WHRadioAdapt().bottomBarHeight}');
    debugPrint('逻辑状态栏高度：${WHRadioAdapt().statusBarHeight}');
    debugPrint('逻辑设备宽度：${WHRadioAdapt().screenWidth}');
    debugPrint('逻辑设备高度：${WHRadioAdapt().screenHeight}');
    debugPrint('逻辑设备宽度与UI设计宽度的比例:${WHRadioAdapt().scaleWidth}');
    debugPrint('逻辑设备高度与UI设计高度的比例：${WHRadioAdapt().scaleHeight}');
    debugPrint('字体缩放比：${WHRadioAdapt().textScaleFactor}');
  }

  @override
  Widget build(BuildContext context) {
    WHRadioAdapt.init(context);
    printScreenInfo();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('屏幕宽高等比换算'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              /// 375/2
              width: WHRadioAdapt().setWidth(187.5),

              /// 667/2
              height: WHRadioAdapt().setHeight(333.5),
              color: Colors.blueAccent,
              child: Text(
                '1/2宽度大小：${WHRadioAdapt().setWidth(187.5)}，1/2高度大小：${WHRadioAdapt().setHeight(333.5)}，\n14字号大小：${WHRadioAdapt().setSp(14)}',
                style: TextStyle(
                  fontSize: WHRadioAdapt().setSp(14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
