import 'package:final_flutter_project/class/CovidInfo.dart';
import 'package:final_flutter_project/class/custom_appbar.dart';
import 'package:final_flutter_project/covid_19/covid_item_widget.dart';
import 'package:final_flutter_project/covid_19/covid_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'covid_bloc.dart';
import 'covid_event.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CovidWidget extends StatefulWidget {
  @override
  _CovidWidgetState createState() => _CovidWidgetState();
}

class _CovidWidgetState extends State<CovidWidget> {
  late Bloc bloc;
  late TextEditingController keyWordController;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<CovidBloc>(context);
    keyWordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    keyWordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(180),
          child: Container(
            color: Color(0xFF4167B0),
            child: Padding(
              padding: EdgeInsets.fromLTRB(10.0, 35.0, 10.0, 5.0),
              child: Card(
                child: ListTile(
                  leading: Icon(Icons.search),
                  title: TextField(
                    controller: keyWordController,
                    onChanged: (text) async {
                      await Future.delayed(const Duration(milliseconds: 500));
                      bloc.add(SearchNameEvent(searchName: text));
                    },
                    decoration: InputDecoration(
                        hintText: "Search", border: InputBorder.none),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.cancel),
                    onPressed: () {
                      keyWordController.clear();
                      bloc.add(InitialEvent());
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () {
            bloc.add(InitialEvent());
            keyWordController.clear();
            return Future.value(false);
          },
          child: BlocBuilder<CovidBloc, CovidState>(builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Thế Giới:',
                        style: TextStyle(fontSize: 18, color: Colors.blue),
                      ),
                    ),
                    Center(
                      child: Card(
                        elevation: 5.0,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  'Tổng số ca nhiễm: ${state.totalConfirmed}',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                              Container(
                                child: Text(
                                  'Tổng số ca tử vong: ${state.totalDeaths}',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                              Container(
                                child: Text(
                                  'Tổng số ca hồi phục: ${state.totalRecovered}',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Việt Nam:',
                        style: TextStyle(fontSize: 18, color: Colors.blue),
                      ),
                    ),
                    Center(
                      child: Card(
                        elevation: 5.0,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  'Tổng số ca nhiễm: ${state.vnTotalConfirmed}',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                              Container(
                                child: Text(
                                  'Tổng số ca tử vong: ${state.vnTotalDeaths}',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                              Container(
                                child: Text(
                                  'Tổng số ca hồi phục: ${state.vnTotalRecovered}',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Các Nước Khác:',
                        style: TextStyle(fontSize: 18, color: Colors.blue),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: ListView(
                          children: [
                            for (var item in state.listCovidInfo!)
                              _buildItem(item),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  _buildItem(CovidInfo covidInfo) {
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
                  style: TextStyle(fontSize: 18),
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
