import 'package:flutter/material.dart';
import 'package:flutter_app_weather/model/city_info.dart';

class CitySearchScreen extends StatefulWidget {
  final List<CityInfo> cityList;
  const CitySearchScreen({Key? key, required this.cityList}) : super(key: key);

  @override
  _CitySearchScreenState createState() => _CitySearchScreenState();
}

class _CitySearchScreenState extends State<CitySearchScreen> {
  List<CityInfo> _cityList = [];
  bool _searchSelected = false;
  int _animMiliSeconds = 300;

  @override
  void initState() {
    _cityList = widget.cityList;
    _cityList.sort((a, b) => a.name!.compareTo(b.name!));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                      onChanged: (value) => _runFilter(value),
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
                        Navigator.pop(context, _cityList[index].id);
                      },
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  void _runFilter(String keyword) {
    List<CityInfo> results = [];
    if (keyword.isEmpty) {
      // if the search field is empty or with white spaces, we will display complete city list.
      results = widget.cityList;
    } else {
      results = widget.cityList
          .where((city) =>
              city.name!.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _cityList = results;
    });
  }
}
