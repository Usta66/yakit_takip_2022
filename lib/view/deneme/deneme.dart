import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:yakit_takip_2022/model/yakit_islem_model.dart';
import 'package:yakit_takip_2022/services/database_service.dart';

class MyHomePage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  MyHomePage({Key? key}) : super(key: key);

  List<YakitIslemModel?> data = [];

  DatabaseService dbServices = DatabaseService.instance!;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    widget.data = [
      YakitIslemModel(alisTarihi: DateTime(2021), fiyati: 20),
      YakitIslemModel(alisTarihi: DateTime.now(), fiyati: 11),
      YakitIslemModel(alisTarihi: DateTime(2023), fiyati: 15),
    ];
  }

  @override
  Widget build(BuildContext context) {
    print(widget.data);
    print(widget.data);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Syncfusion Flutter chart'),
        ),
        body: Column(children: [
          //Initialize the chart widget
          SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              // Chart title
              title: ChartTitle(text: 'Half yearly sales analysis'),
              // Enable legend
              legend: Legend(isVisible: true),
              // Enable tooltip
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <ChartSeries<YakitIslemModel?, String>>[
                LineSeries<YakitIslemModel?, String>(
                    dataSource: widget.data,
                    xValueMapper: (YakitIslemModel? sales, _) => sales!.alisTarihi!.year.toString(),
                    yValueMapper: (YakitIslemModel? sales, _) => sales!.fiyati,
                    name: 'Sales',
                    // Enable data label
                    dataLabelSettings: DataLabelSettings(isVisible: true))
              ]),
          /*     Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              //Initialize the spark charts widget
              child: SfSparkLineChart.custom(
                //Enable the trackball
                trackball: SparkChartTrackball(activationMode: SparkChartActivationMode.tap),
                //Enable marker
                marker: SparkChartMarker(displayMode: SparkChartMarkerDisplayMode.all),
                //Enable data label
                labelDisplayMode: SparkChartLabelDisplayMode.all,
                xValueMapper: (int index) => data[index].year,
                yValueMapper: (int index) => data[index].sales,
                dataCount: 5,
              ),
            ),
          ) */
        ]));
  }
}

/* class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
} */
