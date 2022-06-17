import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:yakit_takip_2022/utils/date_time_extension.dart';

import '../model/yakit_islem_model.dart';

class MyChart extends StatelessWidget {
  const MyChart({Key? key, required this.dataSource, required this.yValueMapper, this.name, required this.yValueMapper2, this.name2, this.chartTitle})
      : super(key: key);

  final List<YakitIslemModel?> dataSource;

  final num? Function(YakitIslemModel?, int) yValueMapper;
  final num? Function(YakitIslemModel?, int) yValueMapper2;
  final String? name;
  final String? name2;
  final String? chartTitle;

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        title: ChartTitle(text: chartTitle ?? "", textStyle: Theme.of(context).textTheme.headline5),
        // Chart title

        // Enable legend
        legend: Legend(isVisible: true, position: LegendPosition.bottom),

        // Enable tooltip
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <ChartSeries<YakitIslemModel?, String>>[
          LineSeries<YakitIslemModel?, String>(
              dataSource: dataSource,
              xValueMapper: (YakitIslemModel? sales, _) => sales!.alisTarihi!.stringValue,
              yValueMapper: yValueMapper,
              name: name,

              // Enable data label
              dataLabelSettings: const DataLabelSettings(isVisible: true)),
          LineSeries<YakitIslemModel?, String>(
              dataSource: dataSource,
              xValueMapper: (YakitIslemModel? sales, _) => sales!.alisTarihi!.stringValue,
              yValueMapper: yValueMapper2,
              name: name2,
              // Enable data label
              dataLabelSettings: const DataLabelSettings(
                isVisible: true,
              ))
        ]);
  }
}
