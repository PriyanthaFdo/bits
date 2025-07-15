import 'package:flutter/rendering.dart';

bool get hasMouse {
  return RendererBinding.instance.mouseTracker.mouseIsConnected;
}
