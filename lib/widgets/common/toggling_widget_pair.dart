import 'package:flutter/material.dart';

enum TogglingWidgetPairValue { initial, loading, active }

class TogglingWidgetPair extends StatefulWidget {
  final TogglingWidgetPairController controller;
  //bool debug;

  final Widget activeWidget;
  final Widget loadingWidget;
  final Widget initialWidget;

  const TogglingWidgetPair({
    Key key,
    this.activeWidget,
    this.controller,
    //this.debug = false,
    this.initialWidget,
    this.loadingWidget,
  }) : super(key: key);

  @override
  TogglingWidgetPairState createState() => TogglingWidgetPairState();
}

class TogglingWidgetPairController {
  Function listener;
  TogglingWidgetPairValue value;

  TogglingWidgetPairController({
    this.value,
  });

  void setListener(Function newListener) {
    listener = newListener;
  }

  TogglingWidgetPairController setValue(TogglingWidgetPairValue newValue) {
    value = newValue;
    return this;
  }

  void setInitialValue() {
    value = TogglingWidgetPairValue.initial;
    listener(value);
  }

  void setLoadingValue() {
    value = TogglingWidgetPairValue.loading;
    listener(value);
  }

  void setActiveValue() {
    value = TogglingWidgetPairValue.active;
    listener(value);
  }
}

class TogglingWidgetPairState extends State<TogglingWidgetPair> {
  TogglingWidgetPairController get controller => widget.controller;

  @override
  Widget build(BuildContext context) {
    final TogglingWidgetPairValue currValue = controller.value ?? TogglingWidgetPairValue.initial;
    controller.setListener((TogglingWidgetPairValue nextValue) {
      setState(() {
        controller.setValue(nextValue);
      });
    });

    return currValue == TogglingWidgetPairValue.loading
        ? widget.loadingWidget
        : currValue == TogglingWidgetPairValue.active
          ? widget.activeWidget
          : widget.initialWidget;
  }
}
