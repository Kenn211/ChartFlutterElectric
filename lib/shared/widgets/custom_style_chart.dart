import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:test_chart/core.dart';

class StyleChartCustom {
  const StyleChartCustom();

  TrackballBehavior trackball(String format) {
    return TrackballBehavior(
      enable: true,
      lineWidth: 3,
      tooltipDisplayMode: TrackballDisplayMode.groupAllPoints,
      lineColor: AppColors.secondColor,
      activationMode: ActivationMode.singleTap,
      markerSettings: const TrackballMarkerSettings(
          markerVisibility: TrackballVisibilityMode.visible),
      tooltipSettings: InteractiveTooltip(
        canShowMarker: false,
        format: format,
        color: const Color.fromARGB(255, 181, 180, 180),
        textStyle: TextStyle(color: AppColors.secondColor),
      ),
    );
  }

  Legend legend() {
    return Legend(
        isVisible: true,
        isResponsive: true,
        shouldAlwaysShowScrollbar: true,
        alignment: ChartAlignment.center,
        position: LegendPosition.bottom);
  }
}
