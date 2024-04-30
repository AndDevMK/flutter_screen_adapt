import 'package:flutter/material.dart';

/// 参考https://github.com/OpenFlutter/flutter_screenutil
class WHRadioAdapt {
  static WHRadioAdapt? _instance;
  static const Size defaultSize = Size(375, 667);

  Size uiSize = defaultSize;

  static late double _pixelRatio;
  static late double _screenWidth;
  static late double _screenHeight;
  static late double _statusBarHeight;
  static late double _bottomBarHeight;
  static late double _textScaleFactor;

  WHRadioAdapt._();

  factory WHRadioAdapt() {
    assert(
      _instance != null,
      '\nEnsure to initialize WHRadioAdapt before accessing it.\nPlease execute the init method : WHRadioAdapt.init()',
    );
    return _instance!;
  }

  static void init(
    BuildContext context, {
    Size designSize = defaultSize,
    bool allowFontScaling = false,
  }) {
    _instance ??= WHRadioAdapt._();
    _instance!.uiSize = designSize;
    MediaQueryData mediaQuery = MediaQuery.of(context);
    _pixelRatio = mediaQuery.devicePixelRatio;
    _screenWidth = mediaQuery.size.width;
    _screenHeight = mediaQuery.size.height;
    _statusBarHeight = mediaQuery.padding.top;
    _bottomBarHeight = mediaQuery.padding.bottom;
    _textScaleFactor = mediaQuery.textScaleFactor;
  }

  /// 字体缩放比
  double get textScaleFactor => _textScaleFactor;

  /// 设备像素比
  double get pixelRatio => _pixelRatio;

  /// 逻辑设备宽度
  double get screenWidth => _screenWidth;

  /// 逻辑设备高度
  double get screenHeight => _screenHeight;

  /// 物理设备宽度
  double get screenWidthPx => _screenWidth * _pixelRatio;

  /// 物理设备高度
  double get screenHeightPx => _screenHeight * _pixelRatio;

  /// 逻辑状态栏高度
  double get statusBarHeight => _statusBarHeight;

  /// 逻辑底部导航高度
  double get bottomBarHeight => _bottomBarHeight;

  /// 逻辑设备宽度与UI设计宽度的比例
  double get scaleWidth => _screenWidth / uiSize.width;

  double get scaleHeight => _screenHeight / uiSize.height;

  double get scaleText => scaleWidth;

  /// 根据UI设计的宽度适配
  double setWidth(num width) => width * scaleWidth;

  /// 根据UI设计的高度适配
  double setHeight(num height) => height * scaleHeight;

  /// 根据UI设计的字体大小适配
  double setSp(num fontSize) => fontSize * scaleText / _textScaleFactor;
}
