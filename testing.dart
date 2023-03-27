
// import 'dart:convert';
// import 'dart:io';

// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:intl/intl.dart';
// import 'package:jointcustomer/Lainnya/index.dart';
// import 'package:jointcustomer/Login/login.dart';
// import 'package:jointcustomer/Menu/cart.dart';
// import 'package:jointcustomer/Menu/detail_menu.dart';
// import 'package:jointcustomer/Object/darimenu.dart';
// import 'package:jointcustomer/Object/namevarian.dart';
// import 'package:jointcustomer/Object/varmenu.dart';
// import 'package:jointcustomer/Outlet/bigmost.dart';
// import 'package:jointcustomer/Outlet/daftar_order.dart';
// import 'package:jointcustomer/Outlet/daftar_outlet.dart';
// import 'package:jointcustomer/Outlet/detail_outlet.dart';
// import 'package:jointcustomer/Search/search.dart';
// import 'package:jointcustomer/Search/search_location.dart';
// import 'package:jointcustomer/favorit.dart';
// import 'package:jointcustomer/koneksi.dart';
// import 'package:jointcustomer/new_home.dart';
// import 'package:jointcustomer/testing.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import 'Profil/profil.dart';

// class Testing extends StatefulWidget {
//   String alamat = '';
//   Testing({this.alamat});
//   @override
//   State<Testing> createState() => _TestingState();
// }

// class _TestingState extends State<Testing> {
//   int _indicator = 0, hargatotal = 0, _cardPosition = 0;
//   var _harga = NumberFormat('###,000', 'de_DE'), lat, lng, gambar;
//   bool opcl = false, fav = false, loading = false, keranjang = false, showbtn = true;
//   List<dynamic> _listOpen = [
//     'assets/image/GambarAsli/terdekat.png',
//     'assets/image/GambarAsli/promo.png',
//     // 'assets/image/GambarProduk/budget.png',
//     'assets/image/GambarAsli/24jam.png',
//     // 'assets/image/GambarProduk/favorit.png',
//     // 'assets/image/GambarProduk/pickup.png'
//   ];
//   List<String> _listText = [
//     'Nearby',
//     'Promo',
//     // 'Budget',
//     '24 Hours',
//     // 'Favorit',
//     // 'Pickup'
//   ];
//   List<String> _listLink = [
//     '/terdekat',
//     '/promo',
//     // 'Budget',
//     '/24Jam',
//     // 'Favorit',
//     // 'Pickup'
//   ];
//   List<T> map<T>(List list, Function handler){
//     List<T> result = [];
//     for (var i = 0; i < list.length; i++) {
//       result.add(handler(i, list[i]));
//     }
//     return result;
//   }
//   List<Color> _colorGrid = [
//     Color(0xFFFFEFED),
//     Color(0xFFFFF3EC),
//     Color(0xFFF6F8FD)
//   ];
//   List<Color> _colorText = [
//     Color(0xFFE23C23),
//     Color(0xFFFE9814),
//     Color(0xFF1A83FE)
//   ];

//   var scrollController = ScrollController();
//   var scrollbaru = ScrollController();
//   ScrollController scrollM;
//   final scrollPage = PageController(viewportFraction: 0.5);
//   GlobalKey widgetKey = GlobalKey();
//   Offset widgetOffset;
//   double _currentPosition;
//   double opacity = 1, _page = 0;
//   int get _firstitem => _page.toInt();

//   String _dataUrl = Connect().dataurl(), _token = '', _nama = '', location = '', array = '';
//   List<dynamic> slide = [];
//   // List<dynamic> discount = [];
//   List<dynamic> resto = [];
//   List<dynamic> most = [];
//   List<DariMenu> dari = [];
//   List<VarianMenu> varianMenu = [], vamenu = [];
//   List<NamaVarian> nama_varian = [], read_var = [];
//   DateTime currentBackPressTime;

//   void home() async {
//     setState(() {
//       loading = true;
//     });
//     // _token = preferences.getString('');
//     var data = {'lat': lat, 'lng': lng};
//     print(data);

//     var res = await Connect().authData(data, 'home');
//     var body = json.decode(res.body);
//     // print(body.toString());
//     if (body['is_success'] == true) {
//       setState(() {
//         slide = body['slide_show'];
//         // discount = body['diskon_list'];
//         resto = body['resto_list'];
//         most = body['laku_list'];
//         for (var i = 0; i < resto.length; i++) {
//           resto[i]['isopen'] = checkOpen(resto[i]['jam_buka'], resto[i]['jam_tutup']);
//           // print(resto[i]['nama_outlet']);
//         }
//         total();
//         loading = false;
//       });
//     }
//   }

//   checkOpen(time_open, time_close) {
//     final stamp = DateTime.now().millisecondsSinceEpoch;
//     DateTime t = DateTime.fromMillisecondsSinceEpoch(stamp);
//     // print('open Hasil : ' + t.day.toString());
//     var th = DateFormat('yyyy');
//     var thn = th.parse(t.year.toString());
//     var tahun = DateFormat('yyyy').format(thn);
//     print('OK: ' + tahun);
//     var ok = DateFormat('MM');
//     var input = ok.parse(t.month.toString());
//     var bulan = DateFormat('MM').format(input);
//     print('OK: ' + bulan);
//     var h = DateFormat('dd');
//     var hri = h.parse(t.day.toString());
//     var hari = DateFormat('dd').format(hri);
//     print('OK: ' + hari);
//     String hasil = tahun + '-' + bulan + '-' + hari;
//     print('open Hasil : ' + hasil);
//     String hasil2 = hasil + ' ' + time_open + ':' + '00';
//     print('open : ' + hasil2);
//     DateTime dates = DateTime.parse(hasil2);
//     int open_stamp = dates.millisecondsSinceEpoch;
//     String hasil3 = hasil + ' ' + time_close + ':' + '00';
//     DateTime dates2 = DateTime.parse(hasil3);
//     int close_stamp = dates2.millisecondsSinceEpoch;
    
//     // print('open : ' + open_stamp.toString());
//     // print('cek : ' + time_open.toString());
//     print('close : ' + hasil3);
//     // print(t);

//     if (stamp >= open_stamp && stamp <= close_stamp) {
//       // setState(() {
//         opcl = true;
//         // print(opcl);
//         return opcl;
//       // });
//     } else {
//       // setState(() {
//         opcl = false;
//         // print(opcl);
//         return opcl;
//       // });
//     }
//   }

//   void favourite_list(var id_o, id_m, fav) async {
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     var data = {'id_outlet': id_o, 'id_menu': id_m, 'is_favorite': fav};
//     print(data);

//     var res = await Connect().authData(data, 'menu/add-to-favorite');
//     var body = json.decode(res.body);
//     // print(body.toString());
//     if (body['is_success'] == true) {
//       setState(() {
//         final scaffold = ScaffoldMessenger.of(context);
//         scaffold.showSnackBar(SnackBar(content: Text(body['message'])));
//         // listfavourite = body['data'];
//       });
//     }
//   }

//   void getAlamat() async {
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     setState(() {
//       // _nama = preferences.getString('nama_member');
//       location = preferences.getString('alamat');
//       lat = preferences.getDouble('lat');
//       lng = preferences.getDouble('lng');
//       // location ??= 'Input your location!';
//       print(location);
//     });
//     return;
//   }
//   void getProfile() async {
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     var data = {};
//     var res = await Connect().authData(data, 'profile');
//     var body = json.decode(res.body);
//     print(body.toString());
//     if (body['is_success'] == true) {
//     setState(() {
//       _nama = body['data']['nama'];
//       gambar = body['data']['foto'];
//     print(_nama);
//     });
//     }
//   }
//   // void getGambar() async {
//   //   SharedPreferences preferences = await SharedPreferences.getInstance();
//   //   setState(() {
//   //     // _nama = preferences.getString('nama_member');
//   //     gambar = preferences.getString('m_foto');
//   //     print(gambar);
//   //   });
//   //   // return;
//   // }
//   Future<String> get getdir async {
//       final dir = await getApplicationDocumentsDirectory();
//       // print(dir.path);
//       return dir.path;
//     }
//   Future<File> get localeFile async {
//       final p = await getdir;
//       return File('$p/count.txt');
//     }
//   Future<String> readC() async {
//       array = '';
//       vamenu = [];
//       varianMenu = [];
//       nama_varian = [];
//       // var listWidget = dari.where((element) => element.id_outlet == widget.id).toList();
//       try {
//         final fill = await localeFile;
//         array = await fill.readAsString();
//         for (int i = 0; i < dari.length; i++) {
//           DariMenu dm = dari[i];
//           var d = dm.toJson();
//           if (array != '') {
//             array += '\n';
//           }
//           array += jsonEncode(d);
//         }
//         print('Array  array : ' + array);
//         if (array != '') {
//           print('Keranjang Ada');
//           keranjang = true;
//         } else {
//           print('Keranjang Tidak Ada');
//           keranjang = false;
//         }
//         return array;
//       } catch (e) {
//         print('Error');
//       }
//       return '';
//   }

//   baca() {
//     readC().then((String nilai) {
//       print('Nilai' + nilai);
//         if (nilai != null && nilai != '' && nilai != 'null') {
//           List<String> item = nilai.split("\n");
//           // cek_warning = false;
//           for (int k = 0; k < item.length; k++) {
//             vamenu = [];
//             read_var = [];
//             varianMenu = [];
//             nama_varian = [];
//             Map<String, dynamic> _json = jsonDecode(item[k]);
//             // if (_json['id_outlet'] != widget.id) {
//               // cek_warning = true;
//               // cek_ada = false;
//             // } else {
//               for (int i = 0; i < _json['detail_varian'].length; i++) {
//                 vamenu.add(VarianMenu(_json['detail_varian'][i]['id_varian'], _json['detail_varian'][i]['harga'], _json['detail_varian'][i]['qty'], _json['detail_varian'][i]['namavar'], _json['detail_varian'][i]['id_detail'], _json['detail_varian'][i]['kategori']));
//                 var c = read_var.indexWhere((element) => element.namavar == _json['detail_varian'][i]['kategori']);
//                 print(_json['detail_varian'][i]['kategori']);
//                 if(c >= 0) {
//                   read_var[c].varianmenu.add(_json['detail_varian'][i]['namavar']);
//                 } else {
//                   read_var.add(NamaVarian(_json['detail_varian'][i]['kategori'], [_json['detail_varian'][i]['namavar']]));
//                 }
//               }
//               var find = dari.indexWhere((element) => element.session == _json['session']);
//               if (find < 0) {
//                 dari.add(DariMenu(_json['id_outlet'], _json['id_menu'], _json['harga'], _json['qty'], _json['catatan'], _json['thumbnail'], _json['nama'], vamenu, read_var, _json['session'], _json['total'], _json['id_detail'], _json['discount'], _json['harga_diskon'], _json['satuan_discount'], _json['id_promo'], _json['nama_outlet'], _json['alamat'], _json['pajak'], _json['lat'], _json['lng']));
//               } else {
//                 dari[find].id_outlet = _json['id_outlet'];
//                 dari[find].id = _json['id_menu'];
//                 dari[find].harga = _json['harga'];
//                 dari[find].qty = _json['qty'];
//                 dari[find].catatan = _json['catatan'];
//                 dari[find].thumbnail = _json['thumbnail'];
//                 dari[find].nama = _json['nama'];
//                 dari[find].varianmenu = vamenu;
//                 dari[find].raw_varian = read_var;
//                 dari[find].session = _json['session'];
//                 dari[find].total = _json['total'];
//                 dari[find].id_detail = _json['id_detail'];
//                 dari[find].discount = _json['diskon'];
//                 dari[find].harga_diskon = _json['harga_diskon'];
//                 dari[find].satuan_discount = _json['satuan_diskon'];
//                 dari[find].id_promo = _json['id_promo'];
//                 dari[find].nama_outlet = _json['nama_outlet'];
//                 dari[find].alamat = _json['alamat'];
//                 dari[find].pajak = _json['pajak'];
//                 dari[find].lat = _json['lat'];
//                 dari[find].lng = _json['lng'];
//              }
//             //  cek_ada = true;
//             // }
//             read_var = [];
//            print('S : ' + _json['session'].toString());
//            print('Varian : ' + jsonEncode(read_var));
//            print('Read Dari : ' + json.encode(dari));
//           }
//         }
//     });
//   }

//   total(){
//     var total = 0;
//     // filter
//     for (int i = 0; i < dari.length; i++) {
//       var tvarian = 0;
//       var dari_index = dari.indexWhere((element) => element.session == dari[i].session);
//       for (int j = 0; j < dari[dari_index].varianmenu.length; j++) {
//         tvarian += dari[i].varianmenu[j].hargavar;
//       }
//       // dari[i].total = (dmenu[i].harga + tvarian) * dmenu[i].qty;
//       total += (dari[i].harga_diskon + tvarian) * dari[i].qty;
//       print('hargaVarian : ' + tvarian.toString());
//     }
//     setState(() {
//       hargatotal = total;
//       print('harga : ' + hargatotal.toString());
//       // print('hargaVarian : ' + tvarian.toString());
//       // print('Qty : ' + dmenu[0].qty.toString());
//     });
//   }

//   void scrollAll() {
//     int listmost = resto.length;
//     double scrolloffset = scrollM.position.pixels;
//     double viewportheight = scrollM.position.viewportDimension;
//     double scrollrange = scrollM.position.maxScrollExtent - scrollM.position.minScrollExtent;
//     int firstitem = (scrolloffset / (scrollrange + viewportheight) * listmost).floor();
//     RenderBox textFieldRenderBox = widgetKey.currentContext.findRenderObject();
//     // if(scrollM.position.atEdge) {
//     //   bool isTop = scrollM.position.pixels == 0;
//     //   if (isTop) {
//     //     _cardPosition = 0;
//     //   } else {
//     //     _cardPosition = firstitem + 1;
//     //   }
//     // } else {
//     //   _cardPosition = firstitem + 1;
//     // }
//     if (50 > scrollM.offset && scrollM.offset > 1) {
//       setState(() {
//         _cardPosition = (scrollM.offset / 50).round();
//       print('Shobtn1 ' + _cardPosition.toString());
//       });
//     } else if (scrollM.offset > 50 && _cardPosition != 1) {
//       _cardPosition = 1;
//       print('Shobtn2 ');
//     } else if (scrollM.offset < 0 && _cardPosition != 0) {
//       _cardPosition = 0;
//       print('Shobtn3 ');
//     }
//     print("opacity is: $_cardPosition");
//     setState(() {});
//   }

//   void all() async {
//     await getAlamat();
//     getProfile();
//     home();
//     baca();
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     all();
//     scrollPage.addListener(() {
//       setState(() {
//         _page = scrollPage.page;
//       });
//     });
//     scrollM = ScrollController();
//     scrollM.addListener(scrollAll);
//     scrollbaru.addListener(() {
//       double off = 10.0;
//       if (scrollbaru.offset > off) {
//         showbtn = false;
//         // print('Shobtn ' + showbtn.toString());
//         setState(() {});
//       } else {
//         showbtn = true;
//         setState(() {});
//       }
//       print('Shobtn ' + showbtn.toString());
//     });
//     // scrollController.addListener(_scrollListener);
//     // scrollController.addListener(() {
//     //   if (scrollController.position.pixels == scrollController.position.maxScrollExtent * 100) {
//     //     Text('See', style: TextStyle(color: Colors.black));
//     //   }
//     // });
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     scrollM.removeListener(scrollAll);
//   }

//   // _scrollListener() {
//   //   print('scrolling');

//     // RenderBox textFieldRenderBox = widgetKey.currentContext.findRenderObject();
//   //   // widgetOffset = textFieldRenderBox.localToGlobal(Offset.zero);
//   //   _currentPosition = scrollController.offset;

//   //   print("widget position: $_currentPosition against: 100");

//   //   if (100 > _currentPosition && _currentPosition > 1) {
//   //     setState(() {
//   //       opacity = _currentPosition / 100;
//   //     });
//   //   } else if (_currentPosition > 100 && opacity != 1) {
//   //     opacity = 1;
//   //   }
//   //   else if (_currentPosition < 0 && opacity != 0) {
//   //     opacity = 0;
//   //   }
//     // print("opacity is: $opacity");
//   // }

//   @override
//   Widget build(BuildContext context) {
//     // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(statusBarColor: Color(0xB0FFFFFF)));
//     // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
//     return WillPopScope(onWillPop: () async {
//       // await Future.value(true);
//       return Future.value(true);
//       // Navigator.push(context, MaterialPageRoute(builder: (_) => NewHome()));
//     },
//     child: Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(110),
//         child: AppBar(
//           elevation: 0,
//           leading: Text(''),
//           flexibleSpace: Container(
//             padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
//             child: Column(
//               children: [
//                 Row(
//                   children: [
//                     // Container(
//                     //   height: 30,
//                     //   width: 30,
//                     //   padding: EdgeInsets.all(5),
//                     //   decoration: BoxDecoration(
//                     //     shape: BoxShape.circle,
//                     //     color: Color(0xFF005542)
//                     //   ),
//                     //   child: Image.asset('assets/image/GambarAsli/pinmaps.png'),
//                     // ),
//                     // SizedBox(width: 10),
//                     InkWell(
//                       onTap: () {
//                         Navigator.push(context, MaterialPageRoute(builder: (_) => SearchLocation(title: 'Beranda')));
//                       },
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             children: [
//                               Text('Location', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w400)),
//                               SizedBox(width: 5),
//                               Icon(Icons.expand_more, size: 15, color: Colors.black)
//                             ],
//                           ),
//                           Container(
//                             width: MediaQuery.of(context).size.width - 150,
//                             child: Text(location ?? '', maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600))
//                           )
//                         ],
//                       )
//                     ),
//                     // Spacer(),
//                     SizedBox(width: 20),
//                     Container(
//                       height: 40,
//                       width: 40,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         // border: Border.all(width: 1, color: Color(0xFFECEFF1)),
//                         image: DecorationImage(
//                           image: gambar != null ? NetworkImage(_dataUrl + 'member/' + gambar) :
//                           const AssetImage('assets/image/GambarAsli/default.png'),
//                           fit: BoxFit.cover)
//                       ),
//                       child: InkWell(
//                         onTap: () async {
//                           SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//                           if ((sharedPreferences.containsKey('token_api')) && (sharedPreferences.getString('token_api') != '') && (sharedPreferences.getString('token_api') != null)) {
//                             Navigator.push(context, MaterialPageRoute(builder: (_) => Profile()));
//                           } else {
//                             Navigator.push(context, MaterialPageRoute(builder: (_) => Login()));
//                           }
//                         },
//                       ),
//                     ),
//                     SizedBox(width: 10),
//                     Container(
//                       height: 40,
//                       width: 40,
//                       padding: EdgeInsets.all(5),
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         border: Border.all(width: 1, color: Color(0xFFECEFF1)),
//                       ),
//                       child: InkWell(
//                         onTap: () async {
//                           // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//                           // if ((sharedPreferences.containsKey('token_api')) && (sharedPreferences.getString('token_api') != '') && (sharedPreferences.getString('token_api') != null)) {
//                           //   Navigator.push(context, MaterialPageRoute(builder: (_) => Profile()));
//                           // } else {
//                             Navigator.push(context, MaterialPageRoute(builder: (_) => Testing()));
//                           // }
//                         },
//                         child: Image.asset('assets/image/GambarAsli/ScanIcon.png'),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 10),
//                 Container(
//                   height: 40,
//                     child: TextFormField(
//                       readOnly: true,
//                       textInputAction: TextInputAction.search,
//                       decoration: InputDecoration(
//                         hintText: 'Search food',
//                         hintStyle: TextStyle(color: Color(0xFF898989)),
//                         contentPadding: EdgeInsets.symmetric(horizontal: 15),
//                         border: OutlineInputBorder(
//                             borderSide: BorderSide(color: Color(0xFFECEFF1))),
//                         enabledBorder: OutlineInputBorder(
//                             borderSide:
//                                 BorderSide(width: 1, color: Color(0xFFECEFF1)),
//                             borderRadius: BorderRadius.circular(12)),
//                         focusedBorder: OutlineInputBorder(
//                             borderSide:
//                                 BorderSide(width: 1, color: Color(0xFFECEFF1)),
//                             borderRadius: BorderRadius.circular(12)),
//                             suffixIcon: IconButton(onPressed: () {
//                             }, icon: Icon(Icons.search), color: Color(0xFF909090)),
//                       ),
//                       onTap: () {
//                         Navigator.push(context, MaterialPageRoute(builder: (_) => Search()));
//                       },
//                   ),
//                 )
//               ],
//             )
//           ),
//         )),
//         body: loading ? loadings() : Stack(
//           children: [
//             SingleChildScrollView(
//               // controller: scrollbaru,
//           padding: EdgeInsets.only(top: 10, bottom: keranjang ? 80 : 20),
//           child: Container(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 GridView.builder(
//                   itemCount: _listOpen.length,
//                   shrinkWrap: true,
//                   padding: EdgeInsets.only(right: 20, left: 20),
//                   physics: NeverScrollableScrollPhysics(),
//                   reverse: false,
//                   primary: true,
//                   addAutomaticKeepAlives: true,
//                   addRepaintBoundaries: true,
//                   addSemanticIndexes: true,
//                   // controller: scrollbaru,
//                   // dragStartBehavior: DragStartBehavior.start,
//                   // clipBehavior: Clip.hardEdge,
//                   // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisSpacing: 10, crossAxisSpacing: 10, mainAxisExtent: 110),
//                   itemBuilder: (context, index){
//                     return Container(
//                       alignment: Alignment.center,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(7),
//                         image: DecorationImage(image: AssetImage(_listOpen[index]), fit: BoxFit.scaleDown)
//                       ),
//                       child: InkWell(
//                         onTap: (){
//                           Navigator.pushNamed(context, _listLink[index]);
//                         }
//                       )
//                     );
//                   }),
//                   SizedBox(height: 20),
//                 // AnimatedOpacity(opacity: showbtn ? 0.0 : 1.0, duration: Duration(milliseconds: 1000), child: Container(height: 50, width: 50, color: Colors.blue)),
//                   Container(
//                     padding: EdgeInsets.only(left: 20),
//                     child: Stack(
//                       children: [
//                         // Container(
//                         //   width: double.infinity,
//                         //   height: 212,
//                         //   margin: EdgeInsets.fromLTRB(20, 13, 20, 0),
//                         //   decoration: BoxDecoration(
//                         //     border: Border(
//                               // top: BorderSide(width: 1, color: Color(0xFF4FCFA8)),
//                               // // bottom: BorderSide(width: 1, color: Colors.white),
//                               // // right: BorderSide(width: 1, color: Colors.white),
//                               // left: BorderSide(width: 1, color: Color(0xFF4FCFA8))
//                         //     ),
//                         //     // borderRadius: BorderRadius.only(
//                         //     //   topRight: Radius.circular(0),
//                         //     //   topLeft: Radius.circular(7),
//                         //     //   bottomRight: Radius.circular(0),
//                         //     //   bottomLeft: Radius.circular(7),
//                         //     // )
//                         //   ),
//                         // ),
//                         Container(
//                           width: double.infinity,
//                           height: 212,
//                           margin: EdgeInsets.fromLTRB(20, 13, 20, 0),
//                           decoration: BoxDecoration(
//                             border: Border.all(width: 1, color: Color(0xFF4FCFA8)),
//                             // border: Border(
//                             //   top: BorderSide(width: 1, style: BorderStyle.none, color: Color(0xFF4FCFA8)),
//                             //   bottom: BorderSide(width: 1, style: BorderStyle.none, color: Colors.black),
//                             //   right: BorderSide(width: 1, style: BorderStyle.none, color: Colors.black),
//                             //   left: BorderSide(width: 1, style: BorderStyle.none, color: Color(0xFF4FCFA8))
//                             // ),
//                             borderRadius: BorderRadius.horizontal(
//                               // topRight: Radius.zero,
//                               // topLeft: Radius.circular(7),
//                               // bottomRight: Radius.zero,
//                               // bottomLeft: Radius.circular(7),
//                               left: Radius.circular(7),
//                               // right: Radius.circular(7)
//                             )
//                           ),
//                         ),
//                         Positioned(
//                           // top: 10,
//                           child: Container(
//                             width: double.infinity,
//                             height: 212,
//                             margin: EdgeInsets.fromLTRB(20, 13, 20, 0),
//                             decoration: const BoxDecoration(
//                               // border: Border.al/l(width: 1, color: Colors.blue),
//                               border: Border(
//                                 top: BorderSide(width: 1, color: Colors.transparent),
//                                 bottom: BorderSide(width: 2, color: Colors.white),
//                                 right: BorderSide(width: 2, color: Colors.white),
//                                 left: BorderSide(width: 1, color: Colors.transparent)
//                               ),
//                               // borderRadius: BorderRadius.only(
//                               //   topRight: Radius.zero,
//                               //   topLeft: Radius.circular(7),
//                               //   bottomRight: Radius.zero,
//                               //   bottomLeft: Radius.circular(7),
//                               //   // left: Radius.circular(30),
//                               //   // right: Radius.circular(7)
//                               // )
//                             ),
//                           ),
//                         ),
//                         Positioned(
//                           top: 55,
//                           left: 0,
//                           child: RotatedBox(
//                             quarterTurns: -1,
//                             child: Container(
//                               width: 170,
//                               color: Colors.white,
//                               alignment: Alignment.center,
//                               child: Text('Nearby Resto', style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600, backgroundColor: Colors.white)))
//                           )
//                         ),
//                         Positioned(
//                           top: 0,
//                           right: 20,
//                           child: InkWell(
//                             onTap: () {
//                               Navigator.push(context, MaterialPageRoute(builder: (_) => DaftarOutlet(title: 'Nearby Restaurant')));
//                             },
//                             child: Container(
//                               width: 60,
//                               color: Colors.white,
//                               alignment: Alignment.centerRight,
//                               child: Text('See All', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Color(0xFF005542))))
//                             )
//                         ),
//                         Positioned(
//                           top: resto.length == 0 ? 50 : 31,
//                           left: resto.length == 0 ? 0 : 30,
//                           child: resto.length == 0 ?
//                           Container(width: MediaQuery.of(context).size.width, child:
//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Container(
//                                 height: 100,
//                                 width: 100,
//                                 decoration: BoxDecoration(
//                                   image: DecorationImage(image: AssetImage('assets/image/GambarAsli/emptyresto.png'))
//                                 )
//                               ),
//                               SizedBox(height: 5),
//                               Container(width: 200, child: Text("Sorry, we couldn't find restaurants in your area", textAlign: TextAlign.center, maxLines: 2, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF909090))))
//                             ]
//                           ))
//                           :
//                           Stack(
//                             children: [
//                               Positioned.fill(
//                                 left: 10,
//                                 child: Align(
//                                   alignment: Alignment.centerLeft,
//                                   child: FractionallySizedBox(child:
//                                   Container(
//                                 width: 150,
//                                 // margin: EdgeInsets.only(right: 10),
//                                 // decoration: BoxDecoration(
//                                 //     border: Border.all(width: 1, color: Color(0xFFECEFF1)),
//                                 //     borderRadius: BorderRadius.circular(7)
//                                 //   ),
//                                 color: Colors.white,
//                                 // color: _cardPosition == index ? Colors.blue : Colors.black,
//                                 child: InkWell(
//                                   onTap: () {
//                                     Navigator.push(context, MaterialPageRoute(builder: (_) => DetailOutlet(id: resto[_firstitem]['id_outlet'].toString(), button: false, tutup: !resto[_firstitem]['isopen'] ? false : true )));
//                                   },
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Container(
//                                         height: 115,
//                                         padding: EdgeInsets.only(top: 90),
//                                         width: MediaQuery.of(context).size.width,
//                                         decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(7),
//                                           image: DecorationImage(image: NetworkImage(_dataUrl + "outlet/" + resto[_firstitem]['thumbnail']), fit: BoxFit.cover, colorFilter: ColorFilter.mode(Colors.black, !resto[_firstitem]['isopen'] ? BlendMode.hue : BlendMode.dst))
//                                         ),
//                                         child: resto[_firstitem]['promo'] == true ?
//                                         // ((){
//                                         //   if (resto[_firstitem]['promo'] == true) {
//                                         //     var diskon = (outletLength[_firstitem]['list'][0menu]['harga_online_max'] - outletLength[_firstitem]['list'][0menu]['harga_diskon']) / outletLength[_firstitem]['list'][0menu]['harga_online_max']*100;
//                                         //     return 
//                                             Container(
//                                               // height: 30,
//                                               // width: 20,
//                                               alignment: Alignment.center,
//                                               decoration: BoxDecoration(
//                                                 borderRadius: BorderRadius.only(bottomRight: Radius.circular(7), bottomLeft: Radius.circular(7)),
//                                                 color: !resto[_firstitem]['isopen'] ? Color(0xBF686868) : Color(0xBFFC6F33)
//                                               ),
//                                               child: Row(
//                                                 mainAxisAlignment: MainAxisAlignment.center,
//                                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                                 children: [
//                                                   Image.asset(!resto[_firstitem]['isopen'] ? 'assets/image/GambarAsli/getextradiscountoff.png' : 'assets/image/GambarAsli/discountutuh.png', height: 12, width: 12),
//                                                   SizedBox(width: 5),
//                                                   Text('Get Extra Discount', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.white))
//                                                 ],
//                                               )
//                                             )  : Container()
//                                         //   }
//                                         // }())
//                                       ),
//                                       Container(
//                                         padding: EdgeInsets.only(top: 5, right: 10),
//                                         child: Text(resto[_firstitem]['nama_outlet'], maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600))
//                                       ),
//                                       Container(
//                                         padding: EdgeInsets.only(right: 10),
//                                         child: Text(resto[_firstitem]['kecamatan'], style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: Color(0xFF909090))),
//                                       ),
//                                       Container(
//                                         padding: EdgeInsets.only(top: 5, right: 10),
//                                         child: Row(
//                                           mainAxisAlignment: MainAxisAlignment.start,
//                                           crossAxisAlignment: CrossAxisAlignment.center,
//                                           children: [
//                                             // SizedBox(width: 5),
//                                             Container(
//                                               padding: EdgeInsets.only(top: 3, bottom: 3, right: 7, left: 7),
//                                               decoration: BoxDecoration(
//                                                 borderRadius: BorderRadius.circular(7),
//                                                 color: Color(0xFFFF550D)
//                                               ),
//                                               child: Row(
//                                                 children: [
//                                                   Image.asset('assets/image/GambarAsli/bintang.png', height: 10, width: 10),
//                                                   SizedBox(width: 2),
//                                                   Text(resto[_firstitem]['rating'].toString(), style: TextStyle(fontSize: 11, fontWeight: FontWeight.w400, color: Colors.white))
//                                                 ],
//                                               )
//                                             ),
//                                             Container(
//                                               padding: EdgeInsets.only(bottom: 2, right: 10, left: 10),
//                                               child: Text(resto[_firstitem]['jarak'].toString() + ' km' ?? '', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400))
//                                             )
//                                           ],
//                                         )
//                                       ),
//                                     ]
//                                   )
//                                 )
//                               ),
//                                 )
//                               )),
//                               Container(
//                             height: 200,
//                             width: MediaQuery.of(context).size.width - 60,
//                             child: PageView.builder(
//                               itemCount: resto.length,
//                               scrollDirection: Axis.horizontal,
//                               controller: scrollPage,
//                               padEnds: false,
//                               itemBuilder: (context, index) {
//                                 return Opacity(
//                                   // duration: const Duration(microseconds: 800),
//                                   opacity: index <= _firstitem ? 0 : 1,
//                                   child: Container(
//                                 width: 150,
//                                 margin: EdgeInsets.only(right: 10),
//                                 color: Colors.white,
//                                 // decoration: BoxDecoration(
//                                 //     border: Border.all(width: 1, color: Color(0xFFECEFF1)),
//                                 //     borderRadius: BorderRadius.circular(7)
//                                 //   ),
//                                 // color: ,
//                                 // color: _cardPosition == index ? Colors.blue : Colors.black,
//                                 child: InkWell(
//                                   onTap: () {
//                                     Navigator.push(context, MaterialPageRoute(builder: (_) => DetailOutlet(id: resto[index]['id_outlet'].toString(), button: false, tutup: !resto[index]['isopen'] ? false : true )));
//                                   },
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Container(
//                                         height: 115,
//                                         padding: EdgeInsets.only(top: 90),
//                                         width: MediaQuery.of(context).size.width,
//                                         decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(7),
//                                           image: DecorationImage(image: NetworkImage(_dataUrl + "outlet/" + resto[index]['thumbnail']), fit: BoxFit.cover, colorFilter: ColorFilter.mode(Colors.black, !resto[index]['isopen'] ? BlendMode.hue : BlendMode.dst))
//                                         ),
//                                         child: resto[index]['promo'] == true ?
//                                         // ((){
//                                         //   if (resto[index]['promo'] == true) {
//                                         //     var diskon = (outletLength[index]['list'][indexmenu]['harga_online_max'] - outletLength[index]['list'][indexmenu]['harga_diskon']) / outletLength[index]['list'][indexmenu]['harga_online_max']*100;
//                                         //     return 
//                                             Container(
//                                               // height: 30,
//                                               // width: 20,
//                                               alignment: Alignment.center,
//                                               decoration: BoxDecoration(
//                                                 borderRadius: BorderRadius.only(bottomRight: Radius.circular(7), bottomLeft: Radius.circular(7)),
//                                                 color: !resto[index]['isopen'] ? Color(0xBF686868) : Color(0xBFFC6F33)
//                                               ),
//                                               child: Row(
//                                                 mainAxisAlignment: MainAxisAlignment.center,
//                                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                                 children: [
//                                                   Image.asset(!resto[index]['isopen'] ? 'assets/image/GambarAsli/getextradiscountoff.png' : 'assets/image/GambarAsli/discountutuh.png', height: 12, width: 12),
//                                                   SizedBox(width: 5),
//                                                   Text('Get Extra Discount', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.white))
//                                                 ],
//                                               )
//                                             )  : Container()
//                                         //   }
//                                         // }())
//                                       ),
//                                       Container(
//                                         padding: EdgeInsets.only(top: 5, right: 10),
//                                         child: Text(resto[index]['nama_outlet'], maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600))
//                                       ),
//                                       Container(
//                                         padding: EdgeInsets.only(right: 10),
//                                         child: Text(resto[index]['kecamatan'], style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: Color(0xFF909090))),
//                                       ),
//                                       Container(
//                                         padding: EdgeInsets.only(top: 5, right: 10),
//                                         child: Row(
//                                           mainAxisAlignment: MainAxisAlignment.start,
//                                           crossAxisAlignment: CrossAxisAlignment.center,
//                                           children: [
//                                             // SizedBox(width: 5),
//                                             Container(
//                                               padding: EdgeInsets.only(top: 3, bottom: 3, right: 7, left: 7),
//                                               decoration: BoxDecoration(
//                                                 borderRadius: BorderRadius.circular(7),
//                                                 color: Color(0xFFFF550D)
//                                               ),
//                                               child: Row(
//                                                 children: [
//                                                   Image.asset('assets/image/GambarAsli/bintang.png', height: 10, width: 10),
//                                                   SizedBox(width: 2),
//                                                   Text(resto[index]['rating'].toString(), style: TextStyle(fontSize: 11, fontWeight: FontWeight.w400, color: Colors.white))
//                                                 ],
//                                               )
//                                             ),
//                                             Container(
//                                               padding: EdgeInsets.only(bottom: 2, right: 10, left: 10),
//                                               child: Text(resto[index]['jarak'].toString() + ' km' ?? '', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400))
//                                             )
//                                           ],
//                                         )
//                                       ),
//                                     ]
//                                   )
//                                 )
//                               )
//                                 );
//                               }
//                             )
//                             // ListView.builder(
//                             // itemCount: resto.length,
//                             // shrinkWrap: true,
//                             // scrollDirection: Axis.horizontal,
//                             // controller: scrollM,
//                             // padding: EdgeInsets.only(left: 15),
//                             // itemBuilder: (context, index) {
//                             //   return
//                             //   // AnimatedOpacity(
//                             //   //   opacity: index == 0 ? 0 : opacity,
//                             //   //   // key: widgetKey,
//                             //   //   duration: Duration(milliseconds: 1),
//                             //   //   child:
//                               //   Container(
//                               //   width: 150,
//                               //   margin: EdgeInsets.only(right: 10),
//                               //   // decoration: BoxDecoration(
//                               //   //     border: Border.all(width: 1, color: Color(0xFFECEFF1)),
//                               //   //     borderRadius: BorderRadius.circular(7)
//                               //   //   ),
//                               //   // color: ,
//                               //   // color: _cardPosition == index ? Colors.blue : Colors.black,
//                               //   child: InkWell(
//                               //     onTap: () {
//                               //       Navigator.push(context, MaterialPageRoute(builder: (_) => DetailOutlet(id: resto[index]['id_outlet'].toString(), button: false, tutup: !resto[index]['isopen'] ? false : true )));
//                               //     },
//                               //     child: Column(
//                               //       mainAxisAlignment: MainAxisAlignment.start,
//                               //       crossAxisAlignment: CrossAxisAlignment.start,
//                               //       children: [
//                               //         Container(
//                               //           height: 115,
//                               //           padding: EdgeInsets.only(top: 90),
//                               //           width: MediaQuery.of(context).size.width,
//                               //           decoration: BoxDecoration(
//                               //             borderRadius: BorderRadius.circular(7),
//                               //             image: DecorationImage(image: NetworkImage(_dataUrl + "outlet/" + resto[index]['thumbnail']), fit: BoxFit.cover, colorFilter: ColorFilter.mode(Colors.black, !resto[index]['isopen'] ? BlendMode.hue : BlendMode.dst))
//                               //           ),
//                               //           child: resto[index]['promo'] == true ?
//                               //           // ((){
//                               //           //   if (resto[index]['promo'] == true) {
//                               //           //     var diskon = (outletLength[index]['list'][indexmenu]['harga_online_max'] - outletLength[index]['list'][indexmenu]['harga_diskon']) / outletLength[index]['list'][indexmenu]['harga_online_max']*100;
//                               //           //     return 
//                               //               Container(
//                               //                 // height: 30,
//                               //                 // width: 20,
//                               //                 alignment: Alignment.center,
//                               //                 decoration: BoxDecoration(
//                               //                   borderRadius: BorderRadius.only(bottomRight: Radius.circular(7), bottomLeft: Radius.circular(7)),
//                               //                   color: !resto[index]['isopen'] ? Color(0xBF686868) : Color(0xBFFC6F33)
//                               //                 ),
//                               //                 child: Row(
//                               //                   mainAxisAlignment: MainAxisAlignment.center,
//                               //                   crossAxisAlignment: CrossAxisAlignment.center,
//                               //                   children: [
//                               //                     Image.asset(!resto[index]['isopen'] ? 'assets/image/GambarAsli/getextradiscountoff.png' : 'assets/image/GambarAsli/discountutuh.png', height: 12, width: 12),
//                               //                     SizedBox(width: 5),
//                               //                     Text('Get Extra Discount', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.white))
//                               //                   ],
//                               //                 )
//                               //               )  : Container()
//                               //           //   }
//                               //           // }())
//                               //         ),
//                               //         Container(
//                               //           padding: EdgeInsets.only(top: 5, right: 10),
//                               //           child: Text(resto[index]['nama_outlet'], maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600))
//                               //         ),
//                               //         Container(
//                               //           padding: EdgeInsets.only(right: 10),
//                               //           child: Text(resto[index]['kecamatan'], style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: Color(0xFF909090))),
//                               //         ),
//                               //         Container(
//                               //           padding: EdgeInsets.only(top: 5, right: 10),
//                               //           child: Row(
//                               //             mainAxisAlignment: MainAxisAlignment.start,
//                               //             crossAxisAlignment: CrossAxisAlignment.center,
//                               //             children: [
//                               //               // SizedBox(width: 5),
//                               //               Container(
//                               //                 padding: EdgeInsets.only(top: 3, bottom: 3, right: 7, left: 7),
//                               //                 decoration: BoxDecoration(
//                               //                   borderRadius: BorderRadius.circular(7),
//                               //                   color: Color(0xFFFF550D)
//                               //                 ),
//                               //                 child: Row(
//                               //                   children: [
//                               //                     Image.asset('assets/image/GambarAsli/bintang.png', height: 10, width: 10),
//                               //                     SizedBox(width: 2),
//                               //                     Text(resto[index]['rating'].toString(), style: TextStyle(fontSize: 11, fontWeight: FontWeight.w400, color: Colors.white))
//                               //                   ],
//                               //                 )
//                               //               ),
//                               //               Container(
//                               //                 padding: EdgeInsets.only(bottom: 2, right: 10, left: 10),
//                               //                 child: Text(resto[index]['jarak'].toString() + ' km' ?? '', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400))
//                               //               )
//                               //             ],
//                               //           )
//                               //         ),
//                               //       ]
//                               //     )
//                               //   )
//                               // );
//                             // })
//                           )
//                             ],
//                           )
                          
//                         ),
//                         Positioned(
//                           top: 28,
//                           left: 30,
//                           child: AnimatedOpacity(
//                             key: widgetKey,
//                             opacity: _cardPosition == 0 ? 0 : 1,
//                             duration: Duration(milliseconds: 500),
//                             child: Container(
//                               height: 250,
//                               width: 50,
//                              decoration: BoxDecoration(
//                               gradient: LinearGradient(
//                                 begin: Alignment.centerRight,
//                                 end: Alignment(-0.6, 0.0),
//                                 colors: [
//                                   Color(0xA1FFFFFF).withOpacity(0.01),
//                                   Colors.blue,
//                                 ]
//                               )
//                             ),
//                         ))),
//                       ],
//                     ),
//                   ),
//                   Stack(
//                     children: [
//                       Positioned(
//                         top: 30,
//                         left: 20,
//                         child: Text('Most Sale', style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600
//                       ))),
//                       most.length == 0 ? 
//                       Container(margin: EdgeInsets.only(top: 60), width: MediaQuery.of(context).size.width, child:
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Container(
//                             height: 100,
//                             width: 100,
//                             decoration: BoxDecoration(
//                               image: DecorationImage(image: AssetImage('assets/image/GambarAsli/emptymosstsale.png'))
//                             )
//                           ),
//                           SizedBox(height: 5),
//                           Container(width: 200, child: Text("Sorry, the Most Sale doesn't available in your area", textAlign: TextAlign.center, maxLines: 2, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF909090))))
//                         ]
//                       )) :
//                       MasonryGridView.builder(
//                         itemCount: 6,
//                         shrinkWrap: true,
//                         padding: EdgeInsets.only(top: 30, right: 20, left: 20),
//                         physics: NeverScrollableScrollPhysics(),
//                         gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
//                         crossAxisSpacing: 20,
//                         mainAxisSpacing: 15,
//                         itemBuilder: (context, index) {
//                           return Container(
//                             height: 300,
//                             margin: EdgeInsets.only(top: index == 0 ? 50 : 0),
//                             child: InkWell(
//                               onTap: () {
//                                 Navigator.push(context, MaterialPageRoute(builder: (_) => DetailMenu(idmenu: most[index]['id_menu'].toString(), idoutlet: most[index]['id_outlet'].toString(), gambar: '', cekbutton: false, nama_outlet: most[index]['nama_outlet'], id_promo: most[index]['id_promo'].toString(), title: 'DetailOutlet')));
//                               },
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Container(
//                                     height: 240,
//                                     width: MediaQuery.of(context).size.width,
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(7),
//                                       border: Border.all(width: 1, color: Color(0xFFECEFF1)),
//                                       image: DecorationImage(image: NetworkImage(_dataUrl + "menu/" + most[index]['thumbnail']), fit: BoxFit.cover)
//                                     ),
//                                     child: Stack(
//                                       children: [
//                                         Positioned(
//                                           top: 10,
//                                           right: 10,
//                                           child: InkWell(
//                                             onTap: () {
//                                               setState(() async {
//                                                 SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//                                                 if ((sharedPreferences.containsKey('token_api')) && (sharedPreferences.getString('token_api') != '') && (sharedPreferences.getString('token_api') != null)) {
//                                                   most[index]['is_favorite'] = (most[index]['is_favorite']) ? false : true;
//                                                   favourite_list(most[index]['id_outlet'], most[index]['id_menu'], most[index]['is_favorite']);
//                                                   print(most[index]['is_favorite']);
//                                                   print(most[index]['id_menu']);
//                                                 } else {
//                                                   Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => Login()));
//                                                 }
//                                               });
//                                             },
//                                             child: Container(
//                                               height: 30,
//                                               width: 30,
//                                               alignment: Alignment.center,
//                                               decoration: BoxDecoration(
//                                                 shape: BoxShape.circle,
//                                                 border:Border.all(width: 1, color: Color(0xFFECEFF1)),
//                                                 color: most[index]['is_favorite'] == false || most[index]['is_favorite'] == "false" ? Color(0xCCB1B1B1) : Colors.white
//                                               ),
//                                               child: Icon(most[index]['is_favorite'] == false || most[index]['is_favorite'] == "false" ? Icons.favorite_outline : Icons.favorite, color: most[index]['is_favorite'] == false || most[index]['is_favorite'] == "false" ? Colors.white : Color(0xFFFF2C00), size: 19)
//                                             )
//                                           )
//                                         ),
//                                         if(most[index]['has_extra_discount'] == true) ...[
//                                           Container(
//                                             height: 40,
//                                             width: 80,
//                                             decoration: BoxDecoration(
//                                               borderRadius: BorderRadius.only(topRight: Radius.circular(7), topLeft: Radius.circular(7), bottomRight: Radius.circular(7)),
//                                               color: Color(0xE6FF550D)
//                                             ),
//                                             child: Row(
//                                               mainAxisAlignment: MainAxisAlignment.start,
//                                               crossAxisAlignment: CrossAxisAlignment.center,
//                                               children: [
//                                                 Image.asset('assets/image/GambarAsli/discountkepotong.png', height: 30),
//                                                 SizedBox(width: 2),
//                                                 Container(
//                                                   width: 58,
//                                                   child: Text('Get Extra Discount', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white))
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ],
//                                         Positioned(
//                                           bottom: 10,
//                                           right: 10,
//                                           child: Container(
//                                             padding: EdgeInsets.fromLTRB(5, 4, 5, 4),
//                                             decoration: BoxDecoration(
//                                               borderRadius: BorderRadius.circular(7),
//                                               color: Color(0xFFFFA800)
//                                             ),
//                                             child: Row(
//                                               children: [
//                                                 Text(_harga.format(most[index]['harga_online_max'] ?? 0).toString(), maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, decoration: TextDecoration.lineThrough, color: Colors.white)),
//                                                 SizedBox(width: 5),
//                                                 if(most[index]['has_extra_discount'] == true) ...[
//                                                   Text(_harga.format(most[index]['harga_diskon']).toString(), maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white))
//                                                 ] else ...[
//                                                   Text(_harga.format(most[index]['harga_normal']).toString(), maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white))
//                                                 ],
//                                               // Text('Get Extra Discount', maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.white)),
//                                               // SizedBox(width: 10),
//                                               // Text('Get Extra Discount', maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.white))
//                                               ],
//                                             ),
//                                           )
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                   SizedBox(height: 5),
//                                   Container(
//                                         width: MediaQuery.of(context).size.width,
//                                         child: 
//                                   Text(most[index]['nama_menu'], maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
//                                   ),
//                                   SizedBox(height: 1),
//                                   Row(
//                                     children: [
//                                       Icon(Icons.room_rounded, size: 20, color: Color(0xFFFF441D)),
//                                       Container(
//                                         width: MediaQuery.of(context).size.width - 252,
//                                         margin: EdgeInsets.only(left: 5),
//                                         child: Text(most[index]['nama_outlet'], maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: Color(0xFF909090)))
//                                       )
//                                     ],
//                                   )
//                                 ]
//                               )
//                             )
//                           );
//                         }),
//                     ],
//                   ),
//                   Container(
//                     height: 50,
//                     width: MediaQuery.of(context).size.width,
//                     padding: EdgeInsets.all(5),
//                     margin: EdgeInsets.only(top: 30, right: 15, left: 15),
//                     child: most.length == 0 ? Container() : Container(
//                         height: 45,
//                         width: MediaQuery.of(context).size.width,
//                         decoration: BoxDecoration(
//                           border: Border.all(width: 1, color: Color(0xFF005542)),
//                           borderRadius: BorderRadius.circular(7),
//                         ),
//                         child: MaterialButton(
//                             onPressed: () async {
//                               Navigator.push(context, MaterialPageRoute(builder: (_) => BigMost(title: 'Most Sale')));
//                             },
//                             child: Text('See All',
//                                 style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w600,
//                                     color: Color(0xFF005542)
//                     )))))
//               ],
//             ),
//           ),
//         ),
//         Positioned(
//           bottom: 15,
//           // right: 5,
//               child: most.length == 0 ? Container() : keranjang ? Container(
//                 height: 55,
//                 width: MediaQuery.of(context).size.width,
//                 padding: EdgeInsets.all(5),
//                 margin: EdgeInsets.only(right: 15, left: 15),
//                 child: Container(
//                     height: 50,
//                     width: MediaQuery.of(context).size.width,
//                     padding: EdgeInsets.only(top: 5, bottom: 5),
//                     margin: EdgeInsets.only(right: 30),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(7),
//                       gradient: LinearGradient(
//                         begin: Alignment.topLeft,
//                         end: Alignment(1.9, 1.0),
//                         colors: [
//                           Color(0xFF0ABC94),
//                           Color(0xFF77F5C8),
//                         ]
//                       )
//                     ),
//                     child: MaterialButton(
//                         onPressed: () async {
//                           print('Pajak Outlet' +  dari[0].pajak.toString());
//                           Navigator.push(context, MaterialPageRoute(builder: (_) => Cart(idOutlet: dari[0].id_outlet, kupon: '', id_order: '', tempat: 'Dine In', id_metode: '')));
//                         },
//                         child: Row(
//                           children: [
//                             Container(
//                               height: 30,
//                               width: 30,
//                               decoration: BoxDecoration(
//                                 image: DecorationImage(
//                                   image: AssetImage('assets/image/GambarAsli/iconkeranjang.png'),
//                                   fit: BoxFit.scaleDown)
//                               )
//                             ),
//                             SizedBox(width: 10),
//                             Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(dari.length.toString() + ' Item', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white)),
//                                 // SizedBox(height: 5),
//                                 Container(width: MediaQuery.of(context).size.width - 182, child: Text(dari[0].nama_outlet ?? '', maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w400, color: Colors.white)))
//                               ],
//                             ),
//                             Spacer(),
//                             Container(
//                               width: 70,
//                               // padding: EdgeInsets.only(right: 0, left: 2),
//                               child: Text(_harga.format(hargatotal), maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.right, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white)))
//                           ],
//                         )
//               ))) : Container()
//             ),
//           ],
//         )
//         ));
//         }
// }
// class Header extends SliverPersistentHeaderDelegate {
//   final double expandedHeight;
//   final String nama, tempat;
//   // final List<dynamic> resto;

//   Header({this.expandedHeight, this.nama, this.tempat});
//   @override
//   Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return Stack(
//       fit: StackFit.expand,
//       children: [
//         Positioned(
//           right: 0,
//           // child: Opacity(
//           //     opacity: (1 - shrinkOffset / expandedHeight),
//               child: 
//           Container(
//             height: 150,
//             width: 150,
//             decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/image/GambarAsli/HOMEORNAMEN.png'), fit: BoxFit.fill)),
//         )),
//         // ),
//         Positioned(
//           top: expandedHeight / 2 - shrinkOffset,
//           right: 0,
//           left: 0,
//           child: Opacity(
//               opacity: (1 - shrinkOffset / expandedHeight),
//               child: 
//           Container(
//                     margin: EdgeInsets.only(top: 20, right: 20, left: 20),
//                     decoration: BoxDecoration(
//                       border: Border.all(width: 1, color: Color(0xFFECEFF1)),
//                       borderRadius: BorderRadius.circular(7),
//                       color: Colors.white
//                     ),
//                     child:
//                   ListTile(
//                     onTap: (){
//                       Navigator.push(context, MaterialPageRoute(builder: (_) => SearchLocation()));
//                     },
//                     contentPadding: EdgeInsets.only(right: 15, left: 15),
//                     // dense: true,
//                     leading: Container(
//                     height: 40,
//                     width: 40,
//                     // padding: EdgeInsets.all(5),
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: Color(0xFFECF7FF)
//                     ),
//                     child: Icon(Icons.location_on_rounded, size: 30, color: Color(0xFF005542))),
//                     title: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text("Your Location", style: TextStyle(fontSize: 11, fontWeight: FontWeight.w400, color: Color(0xFF909090))),
//                         Text(tempat, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500))
//                       ],
//                     ),
//                     trailing: Icon(Icons.keyboard_arrow_right, size: 25, color: Color(0xFF005542))
//                   )))),
//         Center(
//           child: Opacity(
//               opacity: shrinkOffset / expandedHeight,
//               child: Container(
//                 height: 60,
//                     margin: EdgeInsets.only(top: 20, right: 20, left: 20),
//                     padding: EdgeInsets.only(bottom: 10),
//                     alignment: Alignment.center,
//                     decoration: BoxDecoration(
//                       border: Border.all(width: 1, color: Color(0xFFECEFF1)),
//                       borderRadius: BorderRadius.circular(7),
//                       color: Colors.white
//                     ),
//                     child:
//                   ListTile(
//                     onTap: (){
//                       Navigator.push(context, MaterialPageRoute(builder: (_) => SearchLocation()));
//                     },
//                     // contentPadding: EdgeInsets.only(right: 15, left: 15),
//                     // dense: true,
//                     leading: Container(
//                     height: 40,
//                     width: 40,
//                     // padding: EdgeInsets.all(5),
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: Color(0xFFECF7FF)
//                     ),
//                     child: Icon(Icons.location_on_rounded, size: 30, color: Color(0xFF005542))),
//                     title: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text("Your Location", style: TextStyle(fontSize: 11, fontWeight: FontWeight.w400, color: Color(0xFF909090))),
//                         Text(tempat ?? 0, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500))
//                       ],
//                     ),
//                     trailing: Icon(Icons.keyboard_arrow_right, size: 25, color: Color(0xFF005542))
//                   )))),
//         Positioned(
//           top: 0,
//           right: 0,
//           left: 0,
//           child: Opacity(
//               opacity: (1 - shrinkOffset / expandedHeight),
//               child: Container(
//                 width: MediaQuery.of(context).size.width,
//                     margin: EdgeInsets.only(top: 40),
//                     padding: EdgeInsets.only(right: 20, left: 20),
//                     child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       InkWell(
//                         // onTap: () {Navigator.push(context, MaterialPageRoute(builder: (_) => NewHome()));},
//                         child: Container(
//                           height: 25,
//                           width: 25,
//                           decoration: BoxDecoration(shape: BoxShape.circle, color: Color(0x54E3E3E3)),
//                           child: Icon(Icons.chevron_left, color: Colors.black))),
//                       SizedBox(width: 10),
//                       Container(child: Text('Hi 👋 ' + nama, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500))),
//                       Spacer(),
//                       Container(
//                         height: 35,
//                         width: 35,
//                         decoration: BoxDecoration(shape: BoxShape.circle, color: Color(0x70E8E8E8)),
//                         // alignment: Alignment.center,
//                         child: InkWell(onTap: (){
//                           // showSearch(context: context, delegate: Search(resto: resto));
//                           Navigator.push(context, MaterialPageRoute(builder: (_) => Search()));
//                         }, child: Icon(Icons.search, size: 20, color: Colors.white))
//                       ),
//                       SizedBox(width: 10),
//                       Container(
//                         height: 35,
//                         width: 35,
//                         decoration: BoxDecoration(shape: BoxShape.circle, color: Color(0x70E8E8E8)),
//                         // alignment: Alignment.center,
//                         child: InkWell(onTap: (){
//                           Navigator.push(context, MaterialPageRoute(builder: (_) => Favorit()));
//                         }, child: Icon(Icons.favorite, size: 20, color: Colors.white))
//                       )
//                     ],
//                   )),)),
//       ]
//     );
//   }

//   @override
//   // TODO: implement maxExtent
//   double get maxExtent => expandedHeight;

//   @override
//   // TODO: implement minExtent
//   double get minExtent => 90;

//   @override
//   bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => true;
// }

// MasonryGridView

// SliverToBoxAdapter(
//                 child: Container(
//                   decoration: BoxDecoration(color: widget.tutup ? Color(0x94FFFFFF) : Color(0x94FFFFFF)),
//                   child: menulist.isEmpty ? Container(
//                     margin: EdgeInsets.only(top: 150),
//                     child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Container(
//                         height: 100,
//                         width: 180,
//                         alignment: Alignment.center,
//                         decoration: BoxDecoration(
//                           image: DecorationImage(image: AssetImage('assets/image/GambarAsli/EMPTYSEARCH.png'))
//                         ),
//                       ),
//                       SizedBox(height: 5),
//                       Text('Sorry, no result found.', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF909090))),
//                     ],
//                   )) : isSearch == false ?
//                   ListView.builder(
//                     itemCount: menulist.length,
//                     shrinkWrap: true,
//                     padding: EdgeInsets.fromLTRB(20, 10, 0, 45),
//                     physics: NeverScrollableScrollPhysics(),
//                     itemBuilder: (context, indexsatu) {
//                       modulus = menulist[indexsatu].listmenu.length % 2;
//                       if (modulus == 1 && menulist[indexsatu].listmenu.length != 1) {
//                         sisi = true;
//                       } else {
//                         sisi = false;
//                       }
//                       return Stack(
//                         children: [
//                           Positioned(
//                             top: 5,
//                             left: 0,
//                             child: Text(menulist[indexsatu].nama_kategori, style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600
//                           ))),
//                           // sisi ? Positioned(bottom: 0, left: 100, child: Container(height: 315, color: Colors.blue,)) : Container(),
//                           MasonryGridView.builder(
//                             itemCount: sisi ? menulist[indexsatu].listmenu.length + 1 : menulist[indexsatu].listmenu.length,
//                             shrinkWrap: true,
//                             // mainAxisSpacing: 15,
//                             crossAxisSpacing: 20,
//                             padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
//                             physics: NeverScrollableScrollPhysics(),
//                             gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
//                             addAutomaticKeepAlives: false,
//                             primary: false,
//                             // reverse: sisi == true ? true : false,
//                             dragStartBehavior: DragStartBehavior.down,
//                             clipBehavior: Clip.antiAlias,
//                             itemBuilder: (context, index) {
//                               bool sama = false;
//                               int ind = menulist[indexsatu].listmenu.length-1;
//                               if (index != menulist[indexsatu].listmenu.length) {
//                               if (menulist[indexsatu].listmenu[index].harga_normal != menulist[indexsatu].listmenu[index].harga_online_max && menulist[indexsatu].listmenu[index].harga_diskon != menulist[indexsatu].listmenu[index].harga_online_max) {
//                                 sama = true;
//                               } else {
//                                 sama = false;
//                               }
//                               }
//                               // print(index);
//                               // print('Length : ' + (menulist[indexsatu].listmenu.length).toString());
//                               if (index == menulist[indexsatu].listmenu.length) {
//                                 return Container(
//                                 height: 315,
//                                 child: InkWell(
//                                   onTap: widget.tutup ? () async {
//                                     if (cek_warning == false) {
//                                       if (menulist[indexsatu].listmenu[ind].isExist) {
//                                         var obj = dari.where((element) => element.id == menulist[indexsatu].listmenu[ind].id_menu).toList();
//                                           await _detailOrder(obj, menulist[indexsatu].listmenu[ind].id_menu, menulist[indexsatu].listmenu[ind].thumbnail, menulist[indexsatu].listmenu[ind].id_promo);
//                                         } else {
//                                           Navigator.push(context, MaterialPageRoute(builder: (_) => DetailMenu(idoutlet: widget.id, idmenu: menulist[indexsatu].listmenu[ind].id_menu, gambar: menulist[indexsatu].listmenu[ind].thumbnail, cekbutton: false, nama_outlet: nama, id_promo: menulist[indexsatu].listmenu[ind].id_promo, alamat: alamat, pajak: ppn, lat: lat, lng: lng, title: 'DetailOutlet')));
//                                         }
//                                         setState(() {});
//                                     } else {
//                                       _warning(menulist[indexsatu].listmenu[ind].id_menu, menulist[indexsatu].listmenu[ind].thumbnail, menulist[indexsatu].listmenu[ind].id_promo);
//                                       setState(() {});
//                                     }
//                                   } : null,
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Container(
//                                         height: 240,
//                                         width: MediaQuery.of(context).size.width,
//                                         decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(7),
//                                           border:Border.all(width: 1, color: Color(0xFFECEFF1)),
//                                           image: DecorationImage(image: NetworkImage(_dataUrl + "menu/" + menulist[indexsatu].listmenu[ind].thumbnail), fit: BoxFit.cover, colorFilter: ColorFilter.mode(Colors.black, widget.tutup ? BlendMode.dst : BlendMode.hue))
//                                         ),
//                                         child: Stack(
//                                           children: [
//                                             if(menulist[indexsatu].listmenu[ind].harga_diskon != 0) ...[
//                                               Container(
//                                                 height: 40,
//                                                 width: 80,
//                                                 decoration: BoxDecoration(
//                                                   borderRadius: BorderRadius.only(topRight: Radius.circular(7), topLeft: Radius.circular(7), bottomRight: Radius.circular(7)),
//                                                   color: Color(0xE6FF550D)
//                                                 ),
//                                                 child: Row(
//                                                   mainAxisAlignment: MainAxisAlignment.start,
//                                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                                   children: [
//                                                     Image.asset('assets/image/GambarAsli/discountkepotong.png', height: 30),
//                                                     SizedBox(width: 2),
//                                                     Container(
//                                                       width: 58,
//                                                       child: Text('Get Extra Discount', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white))
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ],
//                                             Positioned(
//                                               bottom: 10,
//                                               right: 10,
//                                               child: Container(
//                                                 padding: EdgeInsets.fromLTRB(5, 4, 5, 4),
//                                                 decoration: BoxDecoration(
//                                                   borderRadius: BorderRadius.circular(7),
//                                                   color: Color(0xFFFFA800)
//                                                 ),
//                                                 child: Row(
//                                                   children: [
//                                                       Visibility(visible: sama, child: Text(_harga.format(menulist[indexsatu].listmenu[ind].harga_online_max ?? 0).toString(), maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, decoration: TextDecoration.lineThrough, color: Colors.white))),
//                                                       Visibility(visible: sama, child: SizedBox(width: 5)),
//                                                     if(menulist[indexsatu].listmenu[ind].harga_diskon != 0) ...[
//                                                       Text(_harga.format(menulist[indexsatu].listmenu[ind].harga_diskon).toString(), maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white))
//                                                     ] else ...[
//                                                       Text(_harga.format(menulist[indexsatu].listmenu[ind].harga_normal).toString(), maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white))
//                                                     ],
//                                                   ],
//                                                 ),
//                                               )
//                                             ),
//                                             Positioned(
//                                               top: 10,
//                                               right: 10,
//                                               child: InkWell(
//                                                 onTap: () {
//                                                   setState(() async {
//                                                     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//                                                     if ((sharedPreferences.containsKey('token_api')) && (sharedPreferences.getString('token_api') != '') && (sharedPreferences.getString('token_api') != null)) {
//                                                       menulist[indexsatu].listmenu[ind].is_favorite = (menulist[indexsatu].listmenu[ind].is_favorite) ? false : true;
//                                                       favourite_list(menulist[indexsatu].listmenu[ind].id_menu, menulist[indexsatu].listmenu[ind].is_favorite);
//                                                     } else {
//                                                       Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => Login()));
//                                                     }
//                                                   });
//                                                 },
//                                                 child: Container(
//                                                   height: 30,
//                                                   width: 30,
//                                                   decoration: BoxDecoration(
//                                                     shape: BoxShape.circle,
//                                                     border:Border.all(width: 1, color: Color(0xFFECEFF1)),
//                                                     color: menulist[indexsatu].listmenu[ind].is_favorite == false || menulist[indexsatu].listmenu[ind].is_favorite == "false" ? Color(0xCCB1B1B1) : Colors.white
//                                                   ),
//                                                   child: Icon(menulist[indexsatu].listmenu[ind].is_favorite == false || menulist[indexsatu].listmenu[ind].is_favorite == "false" ? Icons.favorite_outline : Icons.favorite, color: menulist[indexsatu].listmenu[ind].is_favorite == false || menulist[indexsatu].listmenu[ind].is_favorite == "false" ? Colors.white : Color(0xFFFF2C00), size: 19)
//                                                 )
//                                               )
//                                             )
//                                           ],
//                                         ),
//                                       ),
//                                       SizedBox(height: 5),
//                                       Row(
//                                         children: [
//                                           menulist[indexsatu].listmenu[ind].isExist ?
//                                           Container(
//                                             margin: EdgeInsets.only(right: 10),
//                                             padding: EdgeInsets.fromLTRB(8, 5, 8, 5),
//                                             alignment: Alignment.center,
//                                             decoration: BoxDecoration(
//                                               borderRadius: BorderRadius.circular(5),
//                                               color: Color(0xFF4FCFA8)
//                                             ),
//                                             child: Text('${menulist[indexsatu].listmenu[ind].item} x', maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white))
//                                           ) : Container(),
//                                           Container(
//                                             width: menulist[indexsatu].listmenu[ind].isExist ? MediaQuery.of(context).size.width - 271  :MediaQuery.of(context).size.width - 227,
//                                             child: Text(menulist[indexsatu].listmenu[ind].nama_menu, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600))
//                                           ),
//                                         ],
//                                       ),
//                                       SizedBox(height: 5),
//                                     ],
//                                   )
//                                 )
//                               );
//                               } else {
//                               return 
//                               Stack(
//                                 children: [
//                                   // sisi ? Positioned(bottom: 0, child: Container(height: 20, color: Colors.blue)) : Container(),
//                                   sisi == true ?
//                                   Container(
//                                 height: 315,
//                                 margin: EdgeInsets.only(top: sisi == true ? index == 0 ? 50 : 0 : index == 0 ? 50 : 0),
//                                 // decoration: BoxDecoration(color:Color(0x94FFFFFF)),
//                                 // color: index == menulist[indexsatu].listmenu.length-1 ? Colors.transparent : null,
//                                 child: index == menulist[indexsatu].listmenu.length-1 ? Container() :
//                                 InkWell(
//                                   onTap: widget.tutup ? () async {
//                                     if (cek_warning == false) {
//                                       if (menulist[indexsatu].listmenu[index].isExist) {
//                                         var obj = dari.where((element) => element.id == menulist[indexsatu].listmenu[index].id_menu).toList();
//                                         // print(menulist[indexsatu].listmenu[index].id_menu);
//                                         // print('Nama Varian : ' + jsonEncode(obj));
//                                           await _detailOrder(obj, menulist[indexsatu].listmenu[index].id_menu, menulist[indexsatu].listmenu[index].thumbnail, menulist[indexsatu].listmenu[index].id_promo);
//                                         } else {
//                                           Navigator.push(context, MaterialPageRoute(builder: (_) => DetailMenu(idoutlet: widget.id, idmenu: menulist[indexsatu].listmenu[index].id_menu, gambar: menulist[indexsatu].listmenu[index].thumbnail, cekbutton: false, nama_outlet: nama, id_promo: menulist[indexsatu].listmenu[index].id_promo, alamat: alamat, pajak: ppn, lat: lat, lng: lng, title: 'DetailOutlet')));
//                                         }
//                                         // print(jsonEncode(menulist[indexsatu].listmenu[index].item));
//                                         setState(() {});
//                                         // print(widget.tutup);
//                                     } else {
//                                       _warning(menulist[indexsatu].listmenu[index].id_menu, menulist[indexsatu].listmenu[index].thumbnail, menulist[indexsatu].listmenu[index].id_promo);
//                                       setState(() {});
//                                       // print(widget.tutup);
//                                     }
//                                   } : null,
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Container(
//                                         height: 240,
//                                         width: MediaQuery.of(context).size.width,
//                                         decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(7),
//                                           border:Border.all(width: 1, color: Color(0xFFECEFF1)),
//                                           image: DecorationImage(image: NetworkImage(_dataUrl + "menu/" + menulist[indexsatu].listmenu[index].thumbnail), fit: BoxFit.cover, colorFilter: ColorFilter.mode(Colors.black, widget.tutup ? BlendMode.dst : BlendMode.hue))
//                                         ),
//                                         child: Stack(
//                                           children: [
//                                             if(menulist[indexsatu].listmenu[index].harga_diskon != 0) ...[
//                                               Container(
//                                                 height: 40,
//                                                 width: 80,
//                                                 decoration: BoxDecoration(
//                                                   borderRadius: BorderRadius.only(topRight: Radius.circular(7), topLeft: Radius.circular(7), bottomRight: Radius.circular(7)),
//                                                   color: Color(0xE6FF550D)
//                                                 ),
//                                                 child: Row(
//                                                   mainAxisAlignment: MainAxisAlignment.start,
//                                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                                   children: [
//                                                     Image.asset('assets/image/GambarAsli/discountkepotong.png', height: 30),
//                                                     SizedBox(width: 2),
//                                                     Container(
//                                                       width: 58,
//                                                       child: Text('Get Extra Discount', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white))
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ],
//                                             Positioned(
//                                               bottom: 10,
//                                               right: 10,
//                                               child: Container(
//                                                 padding: EdgeInsets.fromLTRB(5, 4, 5, 4),
//                                                 decoration: BoxDecoration(
//                                                   borderRadius: BorderRadius.circular(7),
//                                                   color: Color(0xFFFFA800)
//                                                 ),
//                                                 child: Row(
//                                                   children: [
//                                                       Visibility(visible: sama, child: Text(_harga.format(menulist[indexsatu].listmenu[index].harga_online_max ?? 0).toString(), maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, decoration: TextDecoration.lineThrough, color: Colors.white))),
//                                                       Visibility(visible: sama, child: SizedBox(width: 5)),
//                                                     if(menulist[indexsatu].listmenu[index].harga_diskon != 0) ...[
//                                                       Text(_harga.format(menulist[indexsatu].listmenu[index].harga_diskon).toString(), maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white))
//                                                     ] else ...[
//                                                       Text(_harga.format(menulist[indexsatu].listmenu[index].harga_normal).toString(), maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white))
//                                                     ],
//                                                   ],
//                                                 ),
//                                               )
//                                             ),
//                                             // sisi ?
//                                             // Positioned(
//                                             //   bottom: 10,
//                                             //   left: 10,
//                                             //   child: Container(
//                                             //     padding: EdgeInsets.fromLTRB(5, 4, 5, 4),
//                                             //     decoration: BoxDecoration(
//                                             //       borderRadius: BorderRadius.circular(7),
//                                             //       color: Color(0xFFFFA800)
//                                             //     ),
//                                             //     child: Text('Ada')
//                                             //   )
//                                             // ) : Container(),
//                                             Positioned(
//                                               top: 10,
//                                               right: 10,
//                                               child: InkWell(
//                                                 onTap: () {
//                                                   setState(() async {
//                                                     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//                                                     if ((sharedPreferences.containsKey('token_api')) && (sharedPreferences.getString('token_api') != '') && (sharedPreferences.getString('token_api') != null)) {
//                                                       menulist[indexsatu].listmenu[index].is_favorite = (menulist[indexsatu].listmenu[index].is_favorite) ? false : true;
//                                                       favourite_list(menulist[indexsatu].listmenu[index].id_menu, menulist[indexsatu].listmenu[index].is_favorite);
//                                                       // print(menulist[indexsatu].listmenu[index].is_favorite);
//                                                       // print(menulist[indexsatu].listmenu[index].id_menu);
//                                                     } else {
//                                                       Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => Login()));
//                                                     }
//                                                   });
//                                                 },
//                                                 child: Container(
//                                                   height: 30,
//                                                   width: 30,
//                                                   decoration: BoxDecoration(
//                                                     shape: BoxShape.circle,
//                                                     border:Border.all(width: 1, color: Color(0xFFECEFF1)),
//                                                     color: menulist[indexsatu].listmenu[index].is_favorite == false || menulist[indexsatu].listmenu[index].is_favorite == "false" ? Color(0xCCB1B1B1) : Colors.white
//                                                   ),
//                                                   child: Icon(menulist[indexsatu].listmenu[index].is_favorite == false || menulist[indexsatu].listmenu[index].is_favorite == "false" ? Icons.favorite_outline : Icons.favorite, color: menulist[indexsatu].listmenu[index].is_favorite == false || menulist[indexsatu].listmenu[index].is_favorite == "false" ? Colors.white : Color(0xFFFF2C00), size: 19)
//                                                 )
//                                               )
//                                             )
//                                           ],
//                                         ),
//                                       ),
//                                       SizedBox(height: 5),
//                                       Row(
//                                         children: [
//                                           menulist[indexsatu].listmenu[index].isExist ?
//                                           Container(
//                                             margin: EdgeInsets.only(right: 10),
//                                             padding: EdgeInsets.fromLTRB(8, 5, 8, 5),
//                                             alignment: Alignment.center,
//                                             decoration: BoxDecoration(
//                                               borderRadius: BorderRadius.circular(5),
//                                               color: Color(0xFF4FCFA8)
//                                             ),
//                                             child: Text('${menulist[indexsatu].listmenu[index].item} x', maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white))
//                                           ) : Container(),
//                                           // SizedBox(width: 5),
//                                           Container(
//                                             width: menulist[indexsatu].listmenu[index].isExist ? MediaQuery.of(context).size.width - 271  :MediaQuery.of(context).size.width - 227,
//                                             child: Text(menulist[indexsatu].listmenu[index].nama_menu, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600))
//                                           ),
//                                         ],
//                                       ),
//                                       SizedBox(height: 5),
//                                       // Container(
//                                       //   width: MediaQuery.of(context).size.width,
//                                       //   child: Text(menulist[indexsatu].listmenu[index].keterangan, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: Color(0xFF909090)))
//                                       // )
//                                     ],
//                                   )
//                                 )
//                               ) : Container(
//                                 height: 315,
//                                 margin: EdgeInsets.only(top: sisi == true ? index == 0 ? 50 : 0 : index == 0 ? 50 : 0),
//                                 // decoration: BoxDecoration(color:Color(0x94FFFFFF)),
//                                 // color: index == menulist[indexsatu].listmenu.length-1 ? Colors.transparent : null,
//                                 child: InkWell(
//                                   onTap: widget.tutup ? () async {
//                                     if (cek_warning == false) {
//                                       if (menulist[indexsatu].listmenu[index].isExist) {
//                                         var obj = dari.where((element) => element.id == menulist[indexsatu].listmenu[index].id_menu).toList();
//                                         // print(menulist[indexsatu].listmenu[index].id_menu);
//                                         // print('Nama Varian : ' + jsonEncode(obj));
//                                           await _detailOrder(obj, menulist[indexsatu].listmenu[index].id_menu, menulist[indexsatu].listmenu[index].thumbnail, menulist[indexsatu].listmenu[index].id_promo);
//                                         } else {
//                                           Navigator.push(context, MaterialPageRoute(builder: (_) => DetailMenu(idoutlet: widget.id, idmenu: menulist[indexsatu].listmenu[index].id_menu, gambar: menulist[indexsatu].listmenu[index].thumbnail, cekbutton: false, nama_outlet: nama, id_promo: menulist[indexsatu].listmenu[index].id_promo, alamat: alamat, pajak: ppn, lat: lat, lng: lng, title: 'DetailOutlet')));
//                                         }
//                                         // print(jsonEncode(menulist[indexsatu].listmenu[index].item));
//                                         setState(() {});
//                                         // print(widget.tutup);
//                                     } else {
//                                       _warning(menulist[indexsatu].listmenu[index].id_menu, menulist[indexsatu].listmenu[index].thumbnail, menulist[indexsatu].listmenu[index].id_promo);
//                                       setState(() {});
//                                       // print(widget.tutup);
//                                     }
//                                   } : null,
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Container(
//                                         height: 240,
//                                         width: MediaQuery.of(context).size.width,
//                                         decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(7),
//                                           border:Border.all(width: 1, color: Color(0xFFECEFF1)),
//                                           image: DecorationImage(image: NetworkImage(_dataUrl + "menu/" + menulist[indexsatu].listmenu[index].thumbnail), fit: BoxFit.cover, colorFilter: ColorFilter.mode(Colors.black, widget.tutup ? BlendMode.dst : BlendMode.hue))
//                                         ),
//                                         child: Stack(
//                                           children: [
//                                             if(menulist[indexsatu].listmenu[index].harga_diskon != 0) ...[
//                                               Container(
//                                                 height: 40,
//                                                 width: 80,
//                                                 decoration: BoxDecoration(
//                                                   borderRadius: BorderRadius.only(topRight: Radius.circular(7), topLeft: Radius.circular(7), bottomRight: Radius.circular(7)),
//                                                   color: Color(0xE6FF550D)
//                                                 ),
//                                                 child: Row(
//                                                   mainAxisAlignment: MainAxisAlignment.start,
//                                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                                   children: [
//                                                     Image.asset('assets/image/GambarAsli/discountkepotong.png', height: 30),
//                                                     SizedBox(width: 2),
//                                                     Container(
//                                                       width: 58,
//                                                       child: Text('Get Extra Discount', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white))
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ],
//                                             Positioned(
//                                               bottom: 10,
//                                               right: 10,
//                                               child: Container(
//                                                 padding: EdgeInsets.fromLTRB(5, 4, 5, 4),
//                                                 decoration: BoxDecoration(
//                                                   borderRadius: BorderRadius.circular(7),
//                                                   color: Color(0xFFFFA800)
//                                                 ),
//                                                 child: Row(
//                                                   children: [
//                                                       Visibility(visible: sama, child: Text(_harga.format(menulist[indexsatu].listmenu[index].harga_online_max ?? 0).toString(), maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, decoration: TextDecoration.lineThrough, color: Colors.white))),
//                                                       Visibility(visible: sama, child: SizedBox(width: 5)),
//                                                     if(menulist[indexsatu].listmenu[index].harga_diskon != 0) ...[
//                                                       Text(_harga.format(menulist[indexsatu].listmenu[index].harga_diskon).toString(), maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white))
//                                                     ] else ...[
//                                                       Text(_harga.format(menulist[indexsatu].listmenu[index].harga_normal).toString(), maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white))
//                                                     ],
//                                                   ],
//                                                 ),
//                                               )
//                                             ),
//                                             // sisi ?
//                                             // Positioned(
//                                             //   bottom: 10,
//                                             //   left: 10,
//                                             //   child: Container(
//                                             //     padding: EdgeInsets.fromLTRB(5, 4, 5, 4),
//                                             //     decoration: BoxDecoration(
//                                             //       borderRadius: BorderRadius.circular(7),
//                                             //       color: Color(0xFFFFA800)
//                                             //     ),
//                                             //     child: Text('Ada')
//                                             //   )
//                                             // ) : Container(),
//                                             Positioned(
//                                               top: 10,
//                                               right: 10,
//                                               child: InkWell(
//                                                 onTap: () {
//                                                   setState(() async {
//                                                     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//                                                     if ((sharedPreferences.containsKey('token_api')) && (sharedPreferences.getString('token_api') != '') && (sharedPreferences.getString('token_api') != null)) {
//                                                       menulist[indexsatu].listmenu[index].is_favorite = (menulist[indexsatu].listmenu[index].is_favorite) ? false : true;
//                                                       favourite_list(menulist[indexsatu].listmenu[index].id_menu, menulist[indexsatu].listmenu[index].is_favorite);
//                                                       // print(menulist[indexsatu].listmenu[index].is_favorite);
//                                                       // print(menulist[indexsatu].listmenu[index].id_menu);
//                                                     } else {
//                                                       Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => Login()));
//                                                     }
//                                                   });
//                                                 },
//                                                 child: Container(
//                                                   height: 30,
//                                                   width: 30,
//                                                   decoration: BoxDecoration(
//                                                     shape: BoxShape.circle,
//                                                     border:Border.all(width: 1, color: Color(0xFFECEFF1)),
//                                                     color: menulist[indexsatu].listmenu[index].is_favorite == false || menulist[indexsatu].listmenu[index].is_favorite == "false" ? Color(0xCCB1B1B1) : Colors.white
//                                                   ),
//                                                   child: Icon(menulist[indexsatu].listmenu[index].is_favorite == false || menulist[indexsatu].listmenu[index].is_favorite == "false" ? Icons.favorite_outline : Icons.favorite, color: menulist[indexsatu].listmenu[index].is_favorite == false || menulist[indexsatu].listmenu[index].is_favorite == "false" ? Colors.white : Color(0xFFFF2C00), size: 19)
//                                                 )
//                                               )
//                                             )
//                                           ],
//                                         ),
//                                       ),
//                                       SizedBox(height: 5),
//                                       Row(
//                                         children: [
//                                           menulist[indexsatu].listmenu[index].isExist ?
//                                           Container(
//                                             margin: EdgeInsets.only(right: 10),
//                                             padding: EdgeInsets.fromLTRB(8, 5, 8, 5),
//                                             alignment: Alignment.center,
//                                             decoration: BoxDecoration(
//                                               borderRadius: BorderRadius.circular(5),
//                                               color: Color(0xFF4FCFA8)
//                                             ),
//                                             child: Text('${menulist[indexsatu].listmenu[index].item} x', maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white))
//                                           ) : Container(),
//                                           // SizedBox(width: 5),
//                                           Container(
//                                             width: menulist[indexsatu].listmenu[index].isExist ? MediaQuery.of(context).size.width - 271  :MediaQuery.of(context).size.width - 227,
//                                             child: Text(menulist[indexsatu].listmenu[index].nama_menu, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600))
//                                           ),
//                                         ],
//                                       ),
//                                       SizedBox(height: 5),
//                                       // Container(
//                                       //   width: MediaQuery.of(context).size.width,
//                                       //   child: Text(menulist[indexsatu].listmenu[index].keterangan, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: Color(0xFF909090)))
//                                       // )
//                                     ],
//                                   )
//                                 )
//                               )
//                               //  Positioned(child: Container(height: 100, color: Colors.blue)),
//                                 ]
//                               );}
//                             }
//                           ),
//                           // Align(alignment: Alignment.bottomLeft, child: Container(height: 315, alignment: Alignment.bottomLeft, color: Colors.blue))
//                         ],
//                       );
//                     }
//                   ) :
//                   MasonryGridView.builder(
//                     itemCount: listmenubaru.length,
//                     shrinkWrap: true,
//                     // mainAxisSpacing: 15,
//                     crossAxisSpacing: 20,
//                     padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
//                     physics: NeverScrollableScrollPhysics(),
//                     gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
//                     itemBuilder: (context, index) {
//                       bool sama = false;
//                       if (listmenubaru[index].harga_normal != listmenubaru[index].harga_online_max && listmenubaru[index].harga_diskon != listmenubaru[index].harga_online_max) {
//                         sama = true;
//                         // print(sama);
//                       } else {
//                         sama = false;
//                         // print(sama);
//                       }
//                       return Container(
//                         height: 315,
//                         // margin: EdgeInsets.only(top: index == 0 ? 50 : 0),
//                         // decoration: BoxDecoration(color:Color(0x94FFFFFF)),
//                         // color:Color(0x94FFFFFF),
//                         child: InkWell(
//                           onTap: widget.tutup ? () async {
//                             if (cek_warning == false) {
//                               if (listmenubaru[index].isExist) {
//                                 var obj = dari.where((element) => element.id == listmenubaru[index].id_menu).toList();
//                                 // print(listmenubaru[index].id_menu);
//                                 // print('Nama Varian : ' + jsonEncode(obj));
//                                   await _detailOrder(obj, listmenubaru[index].id_menu, listmenubaru[index].thumbnail, listmenubaru[index].id_promo);
//                                 } else {
//                                   Navigator.push(context, MaterialPageRoute(builder: (_) => DetailMenu(idoutlet: widget.id, idmenu: listmenubaru[index].id_menu, gambar: listmenubaru[index].thumbnail, cekbutton: false, nama_outlet: nama, id_promo: listmenubaru[index].id_promo, alamat: alamat, pajak: ppn, lat: lat, lng: lng, title: 'DetailOutlet')));
//                                 }
//                                 // print(jsonEncode(listmenubaru[index].item));
//                                 setState(() {});
//                                 // print(widget.tutup);
//                             } else {
//                               _warning(listmenubaru[index].id_menu, listmenubaru[index].thumbnail, listmenubaru[index].id_promo);
//                               setState(() {});
//                               // print(widget.tutup);
//                             }
//                           } : null,
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Container(
//                                 height: 240,
//                                 width: MediaQuery.of(context).size.width,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(7),
//                                   border:Border.all(width: 1, color: Color(0xFFECEFF1)),
//                                   image: DecorationImage(image: NetworkImage(_dataUrl + "menu/" + listmenubaru[index].thumbnail), fit: BoxFit.cover)
//                                 ),
//                                 child: Stack(
//                                   children: [
//                                     if(listmenubaru[index].harga_diskon != 0) ...[
//                                       Container(
//                                         height: 40,
//                                         width: 80,
//                                         decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.only(topRight: Radius.circular(7), topLeft: Radius.circular(7), bottomRight: Radius.circular(7)),
//                                           color: Color(0xE6FF550D)
//                                         ),
//                                         child: Row(
//                                           mainAxisAlignment: MainAxisAlignment.start,
//                                           crossAxisAlignment: CrossAxisAlignment.center,
//                                           children: [
//                                             Image.asset('assets/image/GambarAsli/discountkepotong.png', height: 30),
//                                             SizedBox(width: 2),
//                                             Container(
//                                               width: 58,
//                                               child: Text('Get Extra Discount', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white))
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                     Positioned(
//                                       bottom: 10,
//                                       right: 10,
//                                       child: Container(
//                                         padding: EdgeInsets.fromLTRB(5, 4, 5, 4),
//                                         decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(7),
//                                           color: Color(0xFFFFA800)
//                                         ),
//                                         child: Row(
//                                           children: [
//                                               Visibility(visible: sama, child: Text(_harga.format(listmenubaru[index].harga_online_max ?? 0).toString(), maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, decoration: TextDecoration.lineThrough, color: Colors.white))),
//                                               Visibility(visible: sama, child: SizedBox(width: 5)),
//                                             if(listmenubaru[index].harga_diskon != 0) ...[
//                                               Text(_harga.format(listmenubaru[index].harga_diskon).toString(), maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white))
//                                             ] else ...[
//                                               Text(_harga.format(listmenubaru[index].harga_normal).toString(), maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white))
//                                             ],
//                                           // Text('Get Extra Discount', maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.white)),
//                                           // SizedBox(width: 10),
//                                           // Text('Get Extra Discount', maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.white))
//                                           ],
//                                         ),
//                                       )
//                                     ),
//                                     Positioned(
//                                       top: 10,
//                                       right: 10,
//                                       child: InkWell(
//                                         onTap: () {
//                                           setState(() async {
//                                             SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//                                             if ((sharedPreferences.containsKey('token_api')) && (sharedPreferences.getString('token_api') != '') && (sharedPreferences.getString('token_api') != null)) {
//                                               listmenubaru[index].is_favorite = (listmenubaru[index].is_favorite) ? false : true;
//                                               favourite_list(listmenubaru[index].id_menu, listmenubaru[index].is_favorite);
//                                               // print(listmenubaru[index].is_favorite);
//                                               // print(listmenubaru[index].id_menu);
//                                             } else {
//                                               Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => Login()));
//                                             }
//                                           });
//                                         },
//                                         child: Container(
//                                           height: 30,
//                                           width: 30,
//                                           decoration: BoxDecoration(
//                                             shape: BoxShape.circle,
//                                             border:Border.all(width: 1, color: Color(0xFFECEFF1)),
//                                             color: listmenubaru[index].is_favorite == false || listmenubaru[index].is_favorite == "false" ? Color(0xCCB1B1B1) : Colors.white
//                                           ),
//                                           child: Icon(listmenubaru[index].is_favorite == false || listmenubaru[index].is_favorite == "false" ? Icons.favorite_outline : Icons.favorite, color: listmenubaru[index].is_favorite == false || listmenubaru[index].is_favorite == "false" ? Colors.white : Color(0xFFFF2C00), size: 19)
//                                         )
//                                       )
//                                     )
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(height: 5),
//                               Row(
//                                 children: [
//                                   listmenubaru[index].isExist ?
//                                   Container(
//                                     margin: EdgeInsets.only(right: 10),
//                                     padding: EdgeInsets.fromLTRB(8, 5, 8, 5),
//                                     alignment: Alignment.center,
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(5),
//                                       color: Color(0xFF4FCFA8)
//                                     ),
//                                     child: Text('${listmenubaru[index].item} x', maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white))
//                                   ) : Container(),
//                                   // SizedBox(width: 5),
//                                   Container(
//                                     width: listmenubaru[index].isExist ? MediaQuery.of(context).size.width - 271  :MediaQuery.of(context).size.width - 227,
//                                     child: Text(listmenubaru[index].nama_menu, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600))
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(height: 5),
//                               Container(
//                                 width: MediaQuery.of(context).size.width,
//                                 child: Text(listmenubaru[index].keterangan, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: Color(0xFF909090)))
//                               )
//                             ],
//                           )
//                         )
//                       );
//                     }
//                   )
//                 )
//               )


// Anchor Scroll


// import 'dart:math';

// import 'package:anchor_scroll_controller/anchor_scroll_controller.dart';
// import 'package:flutter/material.dart';

// class TestingAnchor extends StatefulWidget {
//   const TestingAnchor({super.key});

//   @override
//   State<TestingAnchor> createState() => _TestingAnchorState();
// }

// class _TestingAnchorState extends State<TestingAnchor> {

//   late final AnchorScrollController _scrollController;
//   late TabController _tabController;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _scrollController = AnchorScrollController(
//       onIndexChanged: (index, context) {
//         _tabController.animateTo(index);
//       }
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
          
//           Expanded(
//           child: ListView.builder(
//             controller: _scrollController,
//             itemCount: 50,
//             itemBuilder: (context, index) {
//               // _scrollController.scrollToIndex(index: index);
//               return AnchorItemWrapper(
//               index: index,
//               controller: _scrollController,
//               child: Container(
//                 height: 50.0 + Random().nextInt(50),
//                 color: Colors.primaries[index % Colors.primaries.length],
//                 alignment: Alignment.center,
//                 child: Text(index.toString(), style: const TextStyle(fontSize: 24, color: Colors.black)),
//               ),
//             );}
//           ),
//         ),
//         ],
//       ),
//     );
//   }
// }


 //           Form(key: _form, child: Container(
          //   height: 50.0,
          //   width: MediaQuery.of(context).size.width-120,
          //   // margin: EdgeInsets.only(left: 10),
          //   alignment: const Alignment(1.0, -1.7),
          //   child: AnimatedContainer(
          //     duration: const Duration(milliseconds: 375),
          //     height: 38.0,
          //     width: (toggle == 0) ? 38.0 : MediaQuery.of(context).size.width-120,
          //     curve: Curves.easeOut,
          //     decoration: BoxDecoration(
          //       color: Colors.white,
          //       borderRadius: BorderRadius.circular(50.0),
          //       // shape: BoxShape.circle,
          //       boxShadow: const [
          //         BoxShadow(
          //           color: Colors.black26,
          //           spreadRadius: -20.0,
          //           blurRadius: 10.0,
          //           offset: Offset(0.0, 10.0),
          //         ),
          //       ],
          //     ),
          //     child: Stack(
          //       children: [
          //         // AnimatedPositioned(
          //         //   duration: const Duration(milliseconds: 375),
          //         //   left: (toggle == 0) ? 20.0 : 5.0,
          //         //   curve: Curves.easeOut,
          //         //   top: 5.0,
          //         //   child: AnimatedOpacity(
          //         //     opacity: (toggle == 0) ? 0.0 : 1.0,
          //         //     duration: const Duration(milliseconds: 200),
          //         //     child: Container(
          //         //           height: 40,
          //         //           width: (toggle == 0) ? MediaQuery.of(context).size.width - 180 : MediaQuery.of(context).size.width - 150,
          //         //           child: TextFormField(
          //         //             focusNode: focusNode,
          //         //             controller: controler,
          //         //               decoration: InputDecoration(
          //         //                 // contentPadding: EdgeInsets.only(right: 5),
          //         //                   hintText: 'Search Menu',
          //         //                   hintStyle: TextStyle(color: Color(0xFF898989)),
          //         //                   border: OutlineInputBorder(
          //         //                       borderSide: BorderSide.none),
          //         //                   enabledBorder: OutlineInputBorder(
          //         //                       borderSide: BorderSide.none,
          //         //                       borderRadius: BorderRadius.circular(7)),
          //         //                   focusedBorder: OutlineInputBorder(
          //         //                       borderSide: BorderSide.none,
          //         //                       borderRadius: BorderRadius.circular(7)),
          //         //                   // suffixIcon: IconButton(
          //         //                   //   onPressed: () {
          //         //                   //     setState(() {});
          //         //                   //   }, icon: Icon(Icons.close), color: Colors.black)
          //         //                   // fillColor: Color(0xFFF6F6F6),
          //         //                   // filled: true
          //         //                   ),
          //         //                   onChanged: (value) {
          //         //                     // if (_form.currentState.validate()) {
          //         //                       // setState(() {
          //         //                         // tambah = 'Isi';
          //         //                         // page = 1;
          //         //                         // menulist.clear();
          //         //                         // list();
          //         //                         _cari(value);
          //         //                         // onChangeHandler();
          //         //                       // });
          //         //                     // }
          //         //                   },
          //         //                   // validator: (cari) {
          //         //                   //   key = cari;
          //         //                   //   print(key);
          //         //                   //   return null;
          //         //                   // },
          //         //                   ))
          //         //   ),
          //         // ),
          //         // AnimatedPositioned(
          //         //   duration: const Duration(milliseconds: 375),
          //         // child: toggle == 0 ? Container(
          //         //   decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
          //         //   child: IconButton(
          //         //     splashRadius: 15.0,
          //         //     icon: Icon(toggle == 0 && key == '' ? Icons.search : null, size: 20.0, color: Colors.black),
          //         //     onPressed: () {
          //         //       setState(() {
          //         //           if (toggle == 0) {
          //         //             toggle = 1;
          //         //             _con.forward();
          //         //             // page = 1;
          //         //             // tambah = 'Isi';
          //         //             // menulist.clear();
          //         //             // list();
          //         //             focusNode.requestFocus();
          //         //           }
          //         //           print(key);
          //         //           formfireld = true;
          //         //         }
          //         //       );
          //         //     }
          //         //   )
          //         // ) : Container()
          //         // ),
          //         // controler.text != '' ?
          //         // Positioned(
          //         //   top: -5,
          //         //   right: -5,
          //         //   child: IconButton(
          //         //     onPressed: () {
          //         //       setState(() {
          //         //         if (toggle == 0) {
          //         //           toggle = 1;
          //         //           // page = 1;
          //         //           // tambah = 'Isi';
          //         //           _con.forward();
          //         //           focusNode.requestFocus();
          //         //           print('Toggle');
          //         //         } else if (key != '') {
          //         //           setState(() {
          //         //             // key = '';
          //         //             // controler.text = '';
          //         //             // page = 1;
          //         //             menulist.clear();
          //         //             _cari('');
          //         //             // onChangeHandler();
          //         //             // list();
          //         //             // print('Key');
          //         //           });
          //         //           }
          //         //         print(key);
          //         //         formfireld = true;
          //         //       });
          //         //     }, icon: Icon(Icons.close, size: 20.0, color: Colors.black))
          //         // ) : Container()
          //       ]
          //     )
          //   )
          // )
          // ),
        // ),
      // ),
                    //     child: Container(
                    //         height: 30,
                    //         width: 30,
                    //         decoration: BoxDecoration(
                    //             shape: BoxShape.circle, color: Colors.white),
                    //         child: Icon(Icons.search,
                    //             size: 20, color: Colors.black))),
                    // SizedBox(width: 10),
                    // InkWell(
                    //     onTap: () {
                    //       // Navigator.pop(context);
                    //     },
                    //     child: Container(
                    //         height: 30,
                    //         width: 30,
                    //         decoration: BoxDecoration(
                    //             shape: BoxShape.circle, color: Colors.white),
                    //         child: Icon(Icons.share_outlined,
                    //             size: 20, color: Colors.black)))



import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TestingScroll extends StatefulWidget {
  const TestingScroll({super.key});

  @override
  State<TestingScroll> createState() => _TestingScrollState();
}

class _TestingScrollState extends State<TestingScroll> {
  final _itemScrollController = ItemScrollController();
  final _itemListener = ItemPositionsListener.create();

  @override
  void initState() {
    super.initState();
    _itemListener.itemPositions.addListener(() {
      final indices = _itemListener.itemPositions.value.where((element) {
        final istop = element.itemLeadingEdge >= 0;
        final isbottom = element.itemTrailingEdge <= 1;
        return istop && isbottom;
      }).map((e) => e.index).toList();
      print(indices);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScrollablePositionedList.builder(
        itemCount: 100,
        shrinkWrap: true,
        itemScrollController: _itemScrollController,
        itemPositionsListener: _itemListener,
        itemBuilder: (context, index) {
          return Container(
            height: 100,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(top: 15),
            color: Colors.blue,
            alignment: Alignment.center,
            child: Text(index.toString(), style: TextStyle(fontSize: 15)),
          );
        }),
    );
  }
}

class TestingYtPlayer extends StatefulWidget {
  @override
  _TestingYtPlayerState createState() => _TestingYtPlayerState();
}

class _TestingYtPlayerState extends State<TestingYtPlayer> {
  late YoutubePlayerController _controller;
  late TextEditingController _idController;
  late TextEditingController _seekToController;

  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;

  final List<String> _ids = [
    'nPt8bK2gbaU',
    'gQDByCdjUXw',
    'iLnmTe5Q2Qw',
    '_WoCV4c6XOE',
    'KmzdUe0RSJo',
    '6jZDSSZZxjQ',
    'p2lYr3vM_1w',
    '7QUtEmBT_-w',
    '34_PXCzGw1M',
  ];

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: _ids.first,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
    _idController = TextEditingController();
    _seekToController = TextEditingController();
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    _idController.dispose();
    _seekToController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      onExitFullScreen: () {
        // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
        SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      },
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.blueAccent,
        topActions: <Widget>[
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              _controller.metadata.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
              size: 25.0,
            ),
            onPressed: () {
              // log('Settings Tapped!');
            },
          ),
        ],
        onReady: () {
          _isPlayerReady = true;
        },
        onEnded: (data) {
          _controller
              .load(_ids[(_ids.indexOf(data.videoId) + 1) % _ids.length]);
          _showSnackBar('Next Video Started!');
        },
      ),
      builder: (context, player) => Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Image.asset(
              'assets/ypf.png',
              fit: BoxFit.fitWidth,
            ),
          ),
          title: const Text(
            'Youtube Player Flutter',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.video_library),
              onPressed: () {}
              // => 
              // Navigator.push(
              //   context,
              //   CupertinoPageRoute(
              //     builder: (context) => VideoList(),
              //   ),
              // ),
            ),
          ],
        ),
        body: ListView(
          children: [
            player,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _space,
                  _text('Title', _videoMetaData.title),
                  _space,
                  _text('Channel', _videoMetaData.author),
                  _space,
                  _text('Video Id', _videoMetaData.videoId),
                  _space,
                  Row(
                    children: [
                      _text(
                        'Playback Quality',
                        _controller.value.playbackQuality ?? '',
                      ),
                      const Spacer(),
                      _text(
                        'Playback Rate',
                        '${_controller.value.playbackRate}x  ',
                      ),
                    ],
                  ),
                  _space,
                  TextField(
                    enabled: _isPlayerReady,
                    controller: _idController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter youtube \<video id\> or \<link\>',
                      fillColor: Colors.blueAccent.withAlpha(20),
                      filled: true,
                      hintStyle: const TextStyle(
                        fontWeight: FontWeight.w300,
                        color: Colors.blueAccent,
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () => _idController.clear(),
                      ),
                    ),
                  ),
                  _space,
                  Row(
                    children: [
                      _loadCueButton('LOAD'),
                      const SizedBox(width: 10.0),
                      _loadCueButton('CUE'),
                    ],
                  ),
                  _space,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.skip_previous),
                        onPressed: _isPlayerReady
                            ? () => _controller.load(_ids[
                                (_ids.indexOf(_controller.metadata.videoId) -
                                        1) %
                                    _ids.length])
                            : null,
                      ),
                      IconButton(
                        icon: Icon(
                          _controller.value.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow,
                        ),
                        onPressed: _isPlayerReady
                            ? () {
                                _controller.value.isPlaying
                                    ? _controller.pause()
                                    : _controller.play();
                                setState(() {});
                              }
                            : null,
                      ),
                      IconButton(
                        icon: Icon(_muted ? Icons.volume_off : Icons.volume_up),
                        onPressed: _isPlayerReady
                            ? () {
                                _muted
                                    ? _controller.unMute()
                                    : _controller.mute();
                                setState(() {
                                  _muted = !_muted;
                                });
                              }
                            : null,
                      ),
                      FullScreenButton(
                        controller: _controller,
                        color: Colors.blueAccent,
                      ),
                      IconButton(
                        icon: const Icon(Icons.skip_next),
                        onPressed: _isPlayerReady
                            ? () => _controller.load(_ids[
                                (_ids.indexOf(_controller.metadata.videoId) +
                                        1) %
                                    _ids.length])
                            : null,
                      ),
                    ],
                  ),
                  _space,
                  Row(
                    children: <Widget>[
                      const Text(
                        "Volume",
                        style: TextStyle(fontWeight: FontWeight.w300),
                      ),
                      Expanded(
                        child: Slider(
                          inactiveColor: Colors.transparent,
                          value: _volume,
                          min: 0.0,
                          max: 100.0,
                          divisions: 10,
                          label: '${(_volume).round()}',
                          onChanged: _isPlayerReady
                              ? (value) {
                                  setState(() {
                                    _volume = value;
                                  });
                                  _controller.setVolume(_volume.round());
                                }
                              : null,
                        ),
                      ),
                    ],
                  ),
                  _space,
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 800),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: _getStateColor(_playerState),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      _playerState.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _text(String title, String value) {
    return RichText(
      text: TextSpan(
        text: '$title : ',
        style: const TextStyle(
          color: Colors.blueAccent,
          fontWeight: FontWeight.bold,
        ),
        children: [
          TextSpan(
            text: value,
            style: const TextStyle(
              color: Colors.blueAccent,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStateColor(PlayerState state) {
    switch (state) {
      case PlayerState.unknown:
        return Colors.grey[700]!;
      case PlayerState.unStarted:
        return Colors.pink;
      case PlayerState.ended:
        return Colors.red;
      case PlayerState.playing:
        return Colors.blueAccent;
      case PlayerState.paused:
        return Colors.orange;
      case PlayerState.buffering:
        return Colors.yellow;
      case PlayerState.cued:
        return Colors.blue[900]!;
      default:
        return Colors.blue;
    }
  }

  Widget get _space => const SizedBox(height: 10);

  Widget _loadCueButton(String action) {
    return Expanded(
      child: MaterialButton(
        color: Colors.blueAccent,
        onPressed: _isPlayerReady
            ? () {
                if (_idController.text.isNotEmpty) {
                  var id = YoutubePlayer.convertUrlToId(
                        _idController.text,
                      ) ??
                      '';
                  if (action == 'LOAD') _controller.load(id);
                  if (action == 'CUE') _controller.cue(id);
                  FocusScope.of(context).requestFocus(FocusNode());
                } else {
                  _showSnackBar('Source can\'t be empty!');
                }
              }
            : null,
        disabledColor: Colors.grey,
        disabledTextColor: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14.0),
          child: Text(
            action,
            style: const TextStyle(
              fontSize: 18.0,
              color: Colors.white,
              fontWeight: FontWeight.w300,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 16.0,
          ),
        ),
        backgroundColor: Colors.blueAccent,
        behavior: SnackBarBehavior.floating,
        elevation: 1.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
    );
  }
}

class TestingMap extends StatefulWidget {
  const TestingMap({super.key});

  @override
  State<TestingMap> createState() => _TestingMapState();
}

class _TestingMapState extends State<TestingMap> {
  
  Set<Marker> _markers = {};

  mark() {
    _markers.removeWhere((marker) => marker.markerId.value == 'marker_1');
    _markers.add(Marker(markerId: MarkerId('marker_1'),
    draggable: true,
    onDragEnd: (position) {
      print(position.latitude);
      print(position.longitude);
    },
    position: LatLng(-7.83312860708864, 110.38281006040087)));
  }

  @override
    void initState() {
      // TODO: implement initState
      super.initState();
      mark();
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
            target: LatLng(-7.83312860708864, 110.38281006040087),
            zoom: 12
            ),
            markers: _markers,
          )
        ],
      )
    );
  }
}