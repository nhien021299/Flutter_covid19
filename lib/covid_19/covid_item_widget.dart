import 'package:final_flutter_project/class/CovidInfo.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CovidItemWidget extends StatelessWidget {
  final CovidInfo covidInfo;
  const CovidItemWidget({Key? key, required this.covidInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ExpansionTile(
        leading: Icon(FontAwesomeIcons.globeAmericas),
        title: Text('${covidInfo.country}'),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 3),
                child: Text(
                  'Tổng số ca nhiễm: ${covidInfo.totalConfirmed}',
                  style: TextStyle(fontSize: 13),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 3),
                child: Text(
                  'Số ca nhiễm mới: ${covidInfo.newConfirmed}',
                  style: TextStyle(fontSize: 13),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 3),
                child: Text(
                  'Tổng số ca tử vong: ${covidInfo.totalDeaths}',
                  style: TextStyle(fontSize: 13),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 3),
                child: Text(
                  'Số ca tử vong: ${covidInfo.newDeaths}',
                  style: TextStyle(fontSize: 13),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 3),
                child: Text(
                  'Tổng số ca hồi phục: ${covidInfo.totalRecovered}',
                  style: TextStyle(fontSize: 13),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 3),
                child: Text(
                  'Số ca hồi phục: ${covidInfo.newRecovered}',
                  style: TextStyle(fontSize: 13),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Text(
                  'Ngày: ${covidInfo.dateTime}',
                  style: TextStyle(fontSize: 13),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
