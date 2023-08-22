// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:lottie/lottie.dart';
import 'login.dart';
import 'model/product.dart';
import 'model/products_repository.dart';


final Uri _url = Uri.parse('https://www.handong.edu/');
List<bool> favoriteList=List.generate(6,(_)=>false);

Future<void> _launchUrl() async {
  if (await canLaunch(_url.toString())) {
    await launch(_url.toString());
  } else {
    throw Exception('Could not launch $_url');
  }
}
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  List<Card> _buildGridCards(BuildContext context) {
    List<Product> products = ProductsRepository.loadProducts(Category.all);

    if (products.isEmpty) {
      return const <Card>[];
    }

    final ThemeData theme = Theme.of(context);
    final NumberFormat formatter = NumberFormat.simpleCurrency(
        locale: Localizations.localeOf(context).toString());

  return products.map((product) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailPage(product:product),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Hero(
              tag: product.name,
              child: AspectRatio(
                aspectRatio: 18 / 11,
                child: Image.asset(
                  product.assetName,
                  package: product.assetPackage,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 10.0, 16.0, 3.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 32.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Row(
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(height: 10.0),
                                    Row(
                                      children: <Widget>[
                                        for (var i = 0; i < product.starnum; i++)
                                          Icon(Icons.star, color: Colors.yellow, size: 15),
                                      ],
                                    ),
                                    SizedBox(height: 8.0),
                                    Hero(
                                      tag: "${product.name} animated",
                                      child: Material(
                                        color: Colors.transparent,
                                        child: Text(
                                          product.name,
                                          style: theme.textTheme.headline6,
                                          maxLines: 1,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 20),
                              ],
                            ),
                          ),
                          SizedBox(width: 20),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(Icons.location_on, color: Colors.blue),
                        SizedBox(width: 8.0),
                        Expanded(
                          child: Text(
                            product.location,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                        TextButton(
                          child: Text('More'),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailPage(product:product),
                              ),
                            );
                          },
                        ), 
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }).toList();
  }

  @override
  Widget build(BuildContext context) {
   List<Product> products = ProductsRepository.loadProducts(Category.all); 
    List<Product> favoriteHotels;
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.menu,
                semanticLabel: 'menu'
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: Center(child: const Text('Main')),
        actions: <Widget>[
        IconButton(
          icon: const Icon(
            Icons.search,
            semanticLabel: 'search',
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SearchPage()),);
          },
        ),
        IconButton(
                icon: const Icon(
                  Icons.language,
                  semanticLabel: 'language',
                ),
                onPressed: //(){print("sdf");},
                _launchUrl,
              )
              ], // 가운데 정렬
      ),
     drawer: Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Padding(
              padding: EdgeInsets.only(left:20, top:80),
              child: Text(
                'Pages',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left:25, bottom: 10),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.home,
                    color: Colors.blue,
                    semanticLabel: 'Home',
                  ),
                  onPressed: () {
                    print('Home');
                  },
                ),
                const SizedBox(width: 8), 
                Text(
                  'Home',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15.0,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left:25, bottom: 10),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.search,
                    color: Colors.blue,
                    semanticLabel: 'Search',
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SearchPage()),);
                  },
                ),
                const SizedBox(width: 8), 
                Text(
                  'Search',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15.0,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left:25, bottom: 10),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.location_city,
                    color: Colors.blue,
                    semanticLabel: 'Favorite Hotel',
                  ),
                  onPressed: () {
                    var product;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FavoriteHotelPage(
                          products: products, 
                          favoriteList: favoriteList,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(width: 8), 
                Text(
                  'Favorite Hotel',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15.0,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left:25, bottom: 10),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.person,
                    color: Colors.blue,
                    semanticLabel: 'My Page',
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfilePage(
                          products: products, 
                          favoriteList: favoriteList,
                        )),
                    );
                  },
                ),
                const SizedBox(width: 8), 
                Text(
                  'My Page',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15.0,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left:25, bottom: 10),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.blue,
                    semanticLabel: 'Log Out',
                  ),
                  onPressed: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),);
                  },
                ),
                const SizedBox(width: 8), 
                Text(
                  'Log Out',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    body: Column(
      children: [
        Padding(padding: const EdgeInsets.only(top: 15.0, left:5.0, bottom:5.0)),
        Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Color.fromARGB(255, 233, 228, 228)),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5.0),
                    topRight: Radius.circular(0.0),
                    bottomLeft: Radius.circular(5.0),
                    bottomRight: Radius.circular(0.0),
                  ),
                ),
                child: IconButton(
                  icon: const Icon(Icons.list),
                  onPressed: () {
                   
                  },
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Color.fromARGB(255, 233, 228, 228)),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(0.0),
                    topRight: Radius.circular(5.0),
                    bottomLeft: Radius.circular(0.0),
                    bottomRight: Radius.circular(5.0),
                  ),
                ),
                child: IconButton(
                  icon: const Icon(Icons.grid_view),
                  onPressed: () {
                  
                  },
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: OrientationBuilder(
            builder: (context, orientation) {
              return GridView.count(
                crossAxisCount: orientation == Orientation.portrait ? 2 : 3,                  
                padding: const EdgeInsets.all(16.0),
                childAspectRatio: 8.0 / 9.0,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                children: _buildGridCards(context),
              );
            },
          ),
        ),
      ],
    ),
    resizeToAvoidBottomInset: false,
    );
  }
}

class DetailPage extends StatefulWidget {
  final Product product;

  const DetailPage({required this.product});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    List<Product> products =ProductsRepository.loadProducts(Category.all);
    bool isFavorite=favoriteList[widget.product.id];
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                Image.asset(
                  widget.product.assetName,
                  package: widget.product.assetPackage,
                  height: MediaQuery.of(context).size.width,
                  fit: BoxFit.contain,
                ),
             IconButton(
                onPressed: () {
                  setState(() {
                    favoriteList[widget.product.id] = !favoriteList[widget.product.id];
                  });
                },
                icon: Icon(
                  favoriteList[widget.product.id] ? Icons.favorite : Icons.favorite_border,
                  color: favoriteList[widget.product.id] ? Colors.red : null,
                ),
              ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Container(
                child: Row(
                  children: <Widget>[
                    for (var i = 0; i < widget.product.starnum; i++)
                      Icon(Icons.star,
                          color: Colors.yellow, size: 30),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 20, top: 5, bottom: 5),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  widget.product.name,
                  style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 20, top: 5, bottom: 5),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  widget.product.location,
                  style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 20, top: 5, bottom: 5),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  widget.product.phone_number,
                  style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 20, top: 5),
              child: Text(
                widget.product.description,
                style: TextStyle(fontSize: 16),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 20, top: 5),
              child: Text(
                widget.product.description,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class FavoriteHotelPage extends StatelessWidget {
  final List<Product> products;
  final List<bool> favoriteList;

  const FavoriteHotelPage({required this.products, required this.favoriteList});

  @override
  Widget build(BuildContext context) {
    // true인 값들만 필터링하여 리스트 생성
    final List<Product> favoriteProducts =
        products.where((product) => favoriteList[product.id]).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Hotels'),
      ),
      body: ListView.builder(
        itemCount: favoriteProducts.length,
        itemBuilder: (context, index) {
          final product = favoriteProducts[index];
          return ListTile(
            title: Text(product.name),
            // subtitle: Text(product.description),
            // leading: Image.asset(
            //   product.assetName,
            //   package: product.assetPackage,
            //   height: 80,
            //   width: 80,
            // ),
          );
        },
      ),
    );
  }
}

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<String> selectedFilters = []; // 선택된 필터 목록
  bool noKidsZone = false;
  bool petFriendly = false;
  bool freeBreakfast = false;
  DateTime? _selectedDate;

  Future<void> _showDatePicker() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }
  void _showAlertDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Selected Filters'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.filter_list, color: Colors.blue, size: 15),
                  SizedBox(width: 5),
                  Text('${selectedFilters.join(' / ')}'),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.calendar_today, color: Colors.blue, size: 15),
                  SizedBox(width: 5),
                  Text('${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'),
                ],
              ),
            ],
        ),
        actions: [
          TextButton(
            child: Text('Search'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ), 
        ],
       );
      },
   );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: ListView(
        children: [
          ExpansionPanelList(
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                if (index == 0) {
                  noKidsZone = !noKidsZone;
                } else if (index == 1) {
                  petFriendly = !petFriendly;
                } else if (index == 2) {
                  freeBreakfast = !freeBreakfast;
                }
              });
            },
            children: [
              ExpansionPanel(
                canTapOnHeader: true,
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left:20.0,right:10.0),
                        child: Text(
                          'Filter',
                          style: TextStyle(
                            fontSize:17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            noKidsZone = false;
                            petFriendly = false;
                            freeBreakfast = false;
                          });
                        },
                      child: Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: const Text(
                            'Select Filters',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                      ),
                    ],
                  );
                },
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text('No Kids Zone'),
                      value: selectedFilters.contains('noKidsZone'),
                      onChanged: (bool? value) {
                        setState(() {
                          if (value!) {
                            selectedFilters.add('noKidsZone');
                          } else {
                            selectedFilters.remove('noKidsZone');
                          }
                        });
                      },
                    ),
                    CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text('Pet-Friendly'),
                      value: selectedFilters.contains('pet-Friendly'),
                      onChanged: (bool? value) {
                        setState(() {
                          if (value!) {
                            selectedFilters.add('pet-Friendly');
                          } else {
                            selectedFilters.remove('pet-Friendly');
                          }
                        });
                      },
                    ),
                    CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text('Free breakfast'),
                      value: selectedFilters.contains('freeBreakfast'),
                      onChanged: (bool? value) {
                        setState(() {
                          if (value!) {
                            selectedFilters.add('freeBreakfast');
                          } else {
                            selectedFilters.remove('freeBreakfast');
                          }
                        });
                      },
                    ),
                    ListTile(
                      title: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          'Date',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 5),
                            child: Text(
                              'Check-In',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Text(_selectedDate == null ? 'Select date' : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'),
                          ),
                        ],
                      ),
                      trailing: TextButton(
                        child: Text('Select date'),
                        onPressed: () {
                          _showDatePicker();
                        },
                      ),
                    )
                  ],
                ),
                isExpanded: selectedFilters.isNotEmpty || noKidsZone || petFriendly || freeBreakfast,
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            _showAlertDialog();
          },
          child: Text('Search'),
        ),
      ),
    );
  }
}


class ProfilePage extends StatelessWidget {
  final List<Product> products;
  final List<bool> favoriteList;

  const ProfilePage({required this.products, required this.favoriteList});

  @override
  Widget build(BuildContext context) {
    // true인 값들만 필터링하여 리스트 생성
    final List<Product> favoriteProducts =
        products.where((product) => favoriteList[product.id]).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipOval(
              child: SizedBox(
                width: 200,
                height: 200,
                child: Lottie.network(
                  'https://assets8.lottiefiles.com/packages/lf20_HX0isy.json',
                  repeat: false,
                  reverse: false,
                  animate: false,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'KimMinkyoung',
              style: Theme.of(context).textTheme.headline5,
            ),
            const SizedBox(height: 10),
            Text(
              '22100090',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: favoriteProducts.length,
                itemBuilder: (context, index) {
                  final product = favoriteProducts[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(product: product),
                        ),
                      );
                    },
                    child: ListTile(
                      title: Text(product.name),
                      leading: Image.asset(
                        product.assetName,
                        package: product.assetPackage,
                        height: 200,
                        width: 200,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
