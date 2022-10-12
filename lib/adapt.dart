import 'dart:ui';
import 'package:flutter/material.dart';

//设备基本信息对象
final MediaQueryData mediaQuery = MediaQueryData.fromWindow(window);
//屏幕像素倍率
final double ratio = mediaQuery.devicePixelRatio;

//屏幕宽度dp
final double width = mediaQuery.size.width;
//屏幕高度dp
final double height = mediaQuery.size.height;
final double dp2pxRatio = width / 750;

//方便外边调用，不用模块化导出了，打出类名就能拿出变量了
class AdaptUtil {
  //屏幕宽度dp
  static final double width = width;
  //屏幕高度dp
  static final double height = height;
  //padding，例如：x 以及以上底部是 34 (.bottom)，使用其可以避免底部按钮点不到的问题
  static final EdgeInsets padding = mediaQuery.padding;
}

//为了方便使用，我们伪装成属性调用(实际应该是伪属性，不存在该字段)
extension Adapt on num {
  //使用扩展方便调用,以边距750为例
  double get sp => this * dp2pxRatio;
  //将dp、pt转化为px
  double get px => this / ratio;
}