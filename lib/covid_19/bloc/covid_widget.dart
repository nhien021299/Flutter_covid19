import 'package:final_flutter_project/model/covid_model.dart';
import 'package:final_flutter_project/covid_19/bloc/covid_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'covid_bloc.dart';
import 'covid_event.dart';

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
                    onChanged: (text) =>
                        bloc.add(SearchNameEvent(searchName: text)),
                    decoration: InputDecoration(
                        hintText: "Search", border: InputBorder.none),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.cancel),
                    onPressed: () {
                      keyWordController.clear();
                      bloc.add(
                          SearchNameEvent(searchName: keyWordController.text));
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
          child: BlocBuilder<CovidBloc, CovidState>(
            builder: (context, state) {
              if (state.searchedCovidInfos?.isNotEmpty ?? false) {
                final globalInfo = state.globalInfo;
                final vnInfo = state.listCovidInfo
                    ?.firstWhere((element) => element.country == "Viet Nam");
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Text(
                                      'Tổng số ca nhiễm: ${globalInfo?.totalConfirmed}',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      'Tổng số ca tử vong: ${globalInfo?.totalDeaths}',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      'Tổng số ca hồi phục: ${globalInfo?.totalRecovered}',
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Text(
                                      'Tổng số ca nhiễm: ${vnInfo?.totalConfirmed}',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      'Tổng số ca tử vong: ${vnInfo?.totalDeaths}',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      'Tổng số ca hồi phục: ${vnInfo?.totalRecovered}',
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
                            child: ListView.builder(
                              itemCount: state.searchedCovidInfos!.length,
                              itemBuilder: (context, index) {
                                final item = state.searchedCovidInfos![index];
                                return _buildItem(item);
                              },
                              cacheExtent:
                                  MediaQuery.of(context).size.height * 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }

  _buildItem(CovidModel covidInfo) {
    return Container(
      width: double.infinity,
      child: ExpansionTile(
        leading: Icon(Icons.coronavirus),
        title: Text('${covidInfo.country}'),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
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
