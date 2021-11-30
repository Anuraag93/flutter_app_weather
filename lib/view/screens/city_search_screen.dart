import 'package:flutter/material.dart';
import 'package:flutter_app_weather/model/city_info.dart';
import 'package:flutter_app_weather/view_model/search_cities_view_model.dart';
import 'package:provider/provider.dart';

class CitySearchScreen extends StatefulWidget {
  const CitySearchScreen({Key? key}) : super(key: key);

  @override
  _CitySearchScreenState createState() => _CitySearchScreenState();
}

class _CitySearchScreenState extends State<CitySearchScreen> {
  List<CityInfo> _cityList = [];
  bool _searchSelected = false;
  int _animMiliSeconds = 300;

  @override
  Widget build(BuildContext context) {
    _cityList = Provider.of<SearchCitiesViewModel>(context).cityList!;

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            AnimatedContainer(
              padding: EdgeInsets.only(top: 20),
              width: MediaQuery.of(context).size.width,
              height: _searchSelected ? 0 : 80,
              duration: Duration(milliseconds: _animMiliSeconds),
              curve: Curves.fastOutSlowIn,
              child: Row(
                children: [
                  IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.arrow_back)),
                  Text(
                    "City Search",
                    style: TextStyle(fontSize: 40),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      onTap: () {
                        setState(() {
                          _searchSelected = true;
                        });
                      },
                      onChanged: (value) => Provider.of<SearchCitiesViewModel>(
                              context,
                              listen: false)
                          .runFilter(value),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          labelText: 'Search City',
                          prefixIcon: Icon(Icons.search)),
                    ),
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: _animMiliSeconds),
                    width: _searchSelected ? 70 : 0,
                    height: _searchSelected ? 40 : 0,
                    alignment: Alignment.center,
                    // color: Colors.grey[300],
                    child: InkWell(
                      child: Text(
                        "cancel",
                        style: Theme.of(context).textTheme.button,
                      ),
                      onTap: () {
                        setState(() {
                          _searchSelected = false;
                        });
                      },
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                  itemCount: _cityList.length,
                  itemBuilder: (context, index) {
                    String cityName = _cityList[index].name!;
                    if (_cityList[index].state != null &&
                        _cityList[index].state!.isNotEmpty) {
                      cityName += ", ${_cityList[index].state}";
                    }
                    if (_cityList[index].country != null) {
                      cityName += ", ${_cityList[index].country}";
                    }

                    return ListTile(
                      key: ValueKey(_cityList[index].id),
                      title: Text(cityName),
                      onTap: () {
                        var id = _cityList[index].id;
                        Provider.of<SearchCitiesViewModel>(context,
                                listen: false)
                            .addSearchedCity(
                                _cityList[index].id?.toString() ?? "");
                        Navigator.pop(context, id);
                      },
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  // void _runFilter(String keyword) {

  //   setState(() {
  //     _cityList = results;
  //   });
  // }
}
