import 'package:flutter/material.dart';

import 'package:hear2learn/helpers/dash.dart' as dash;

enum TogglingWidgetPairValue { initial, loading, active }

class TogglingWidgetPair extends StatefulWidget {
  final TogglingWidgetPairController controller;

  final Widget activeWidget;
  final dynamic loadingWidget;
  final Widget initialWidget;

  const TogglingWidgetPair({
    Key key,
    this.activeWidget,
    this.controller,
    this.initialWidget,
    this.loadingWidget,
  }) : super(key: key);

  @override
  TogglingWidgetPairState createState() => TogglingWidgetPairState();
}

class TogglingWidgetPairController {
  Function listener;
  TogglingWidgetPairValue value;
  double progressValue;

  TogglingWidgetPairController({
    this.value,
  });

  void setListener(Function newListener) {
    listener = newListener;
  }

  TogglingWidgetPairController setValues(TogglingWidgetPairValue newValue, {double updatedProgressValue}) {
    value = newValue;
    progressValue = updatedProgressValue;
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

  void setProgressValue(double updatedProgressValue) {
    progressValue = updatedProgressValue;
    listener(value, progressValue: progressValue);
  }
}

class TogglingWidgetPairState extends State<TogglingWidgetPair> {
  TogglingWidgetPairController get controller => widget.controller;

  @override
  Widget build(BuildContext context) {
    final TogglingWidgetPairValue currValue = controller.value ?? TogglingWidgetPairValue.initial;
    controller.setListener((TogglingWidgetPairValue nextValue, {double progressValue}) {
      setState(() {
        controller.setValues(nextValue, updatedProgressValue: progressValue);
      });
    });

    final Function loadingWidget = widget.loadingWidget is Function
        ? widget.loadingWidget
        : ({ double progressValue }) => widget.loadingWidget;

    return currValue == TogglingWidgetPairValue.loading
        ? dash.apply(loadingWidget, <dynamic>[], <String, dynamic>{ 'progressValue': controller.progressValue })
        : currValue == TogglingWidgetPairValue.active
          ? widget.activeWidget
          : widget.initialWidget;
  }
}
