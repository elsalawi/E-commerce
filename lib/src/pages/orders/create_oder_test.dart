// import 'dart:async';
//
// import 'package:dropdown_search/dropdown_search.dart';
// import 'package:flutter/material.dart';
// import 'package:orders_app/generated/l10n.dart';
// import 'package:orders_app/src/bloc/address_block.dart';
// import 'package:orders_app/src/bloc/orders_bloc.dart';
// import 'package:orders_app/src/modals/address_model.dart';
// import 'package:orders_app/src/modals/city_model.dart';
// import 'package:orders_app/src/modals/order_model.dart';
// import 'package:orders_app/src/utils/validators.dart';
// import 'package:orders_app/src/values/colors.dart';
// import 'package:orders_app/src/widgets/spinner.dart';
// import 'package:orders_app/src/widgets/text_styles.dart';
// import 'package:orders_app/src/widgets/toast.dart';
// import 'package:provider/provider.dart';
//
// import '../../utils/extensions.dart';
//
// class CreateOrderPage extends StatefulWidget {
//   final OrderModel order;
//   final bool isCreate;
//   final bool isReadOnly;
//   CreateOrderPage({this.order, this.isCreate = true, this.isReadOnly = false});
//   @override
//   _CreateOrderPageState createState() => _CreateOrderPageState();
// }
//
// class _CreateOrderPageState extends State<CreateOrderPage> {
//   final _formKey = GlobalKey<FormState>();
//   StreamSubscription<String> _subscription;
//   OrderModel order = new OrderModel();
//   List<AddressModel> pickUPAddress = [];
//   List<String> customPickUPAddress = [];
//   int selectAddressIndex = 0;
//   bool _pickupAddressLoading = false;
//   //drop off cities
//   List<CityModel> dropOffCities = [];
//   List<String> customDropOffCities = [];
//   int selectedDropOffCity = 0;
//   bool _dropOffCitiesLoading = false;
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     final _bloc = Provider.of<OrdersBloc>(context);
//     _subscription = _bloc.errorMessage.listen((message) async {
//       if (message == null || message.isEmpty || message == "CLEAR") return;
//       await Future.delayed(Duration(milliseconds: 200));
//       CustomToast.show(message);
//     });
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     order.copy(widget.order);
//     _getPickUpAddress();
//     _getDropOffCities();
//   }
//
//   @override
//   void dispose() {
//     _subscription.cancel();
//     super.dispose();
//   }
//
//   void _getPickUpAddress() async {
//     //muller2
//     setState(() {
//       _pickupAddressLoading = true;
//     });
//     pickUPAddress = await AddressBlock().pickUpAddress();
//     customPickUPAddress = pickUPAddress.map((e) => e.name).toList();
//     print(pickUPAddress.length);
//     if (pickUPAddress.length != 0) {
//       if (!widget.isCreate) {
//         selectAddressIndex = pickUPAddress
//             .indexWhere((element) => element.id == order.pickupAddress.id);
//         if (selectAddressIndex < 0) selectAddressIndex = 0;
//         widget.order.pickupAddress = pickUPAddress[selectAddressIndex];
//         print("selected index is $selectAddressIndex");
//       }
//       widget.order.pickupAddress = pickUPAddress[selectAddressIndex];
//     }
//     //muller2
//     setState(() {
//       _pickupAddressLoading = false;
//     });
//   }
//
//   void _getDropOffCities() async {
//     //muller2
//     setState(() {
//       _dropOffCitiesLoading = true;
//     });
//     dropOffCities = await AddressBlock().dropOffCities();
//     customDropOffCities = dropOffCities.map((e) => e.name).toList();
//     print(dropOffCities.length);
//     if (dropOffCities.length != 0) {
//       if (!widget.isCreate) {
//         selectedDropOffCity = dropOffCities
//             .indexWhere((element) => element.id == order.dropOffCity.id);
//         if (selectedDropOffCity < 0) selectedDropOffCity = 0;
//         widget.order.dropOffCity = dropOffCities[selectedDropOffCity];
//         print("selected index is $selectedDropOffCity");
//       }
//       widget.order.dropOffCity = dropOffCities[selectedDropOffCity];
//     }
//     setState(() {
//       _dropOffCitiesLoading = false;
//     });
//   }
//
//   void sh() {
//     showDialog<dynamic>(
//         context: context,
//         barrierDismissible: true,
//         builder: (BuildContext context) {
//           return WillPopScope(
//             onWillPop: () async => false,
//             child: Dialog(
//                 backgroundColor: Colors.white,
//                 insetAnimationDuration: Duration(milliseconds: 100),
//                 elevation: 2,
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(2))),
//                 child: Container(
//                   height: 120,
//                   child: Center(
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: <Widget>[
//                         Spinner(),
//                         verticalDividerSmall,
//                         Text(S.of(context).please_wait)
//                       ],
//                     ),
//                   ),
//                 )),
//           );
//         });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     print("home lan .... ${widget.order.state}");
//     final bloc = Provider.of<OrdersBloc>(context);
//     print("build create .......");
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           iconTheme: IconThemeData(color: Colors.black),
//           textTheme: TextTheme(
//               title: TextStyle(
//                   fontSize: 18,
//                   color: Colors.black,
//                   fontWeight: FontWeight.bold)),
//           title: widget.isCreate
//               ? Text(S.of(context).create_order)
//               : Text(order.orderName),
//           elevation: 0,
//           actions: <Widget>[
//             widget.isCreate
//                 ? Container()
//                 : Row(
//               children: <Widget>[
//                 Container(
//                   height: 20,
//                   decoration: BoxDecoration(
//                       color: widget.order.isDraft
//                           ? Colors.green
//                           : Colors.blue,
//                       borderRadius: BorderRadius.all(Radius.circular(4))),
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 8, vertical: 4),
//                   child: Text("${widget.order.state}",
//                       style:
//                       TextStyle(fontSize: 12, color: Colors.white)),
//                 ),
//                 SizedBox(width: 10)
//               ],
//             )
//           ],
//         ),
//         // persistentFooterButtons: !widget.isReadOnly
//         persistentFooterButtons: <Widget>[formSubmitBtns()],
//         body: Form(
//           key: _formKey,
//           child: Scrollbar(
//             child: ListView(
//               padding: const EdgeInsets.all(5),
//               children: <Widget>[
//                 pickupWidgetForm(),
//                 verticalDividerSmall,
//                 dropOffWidgetForm(),
//                 verticalDividerSmall,
//                 invoiceWidgetForm(),
//                 verticalDividerSmall,
//                 descriptionWidgetForm(),
//                 SizedBox(height: 24),
// //                muller,
//               ],
//             ),
//           ),
//         ));
//   }
//
//   Widget pickupWidgetForm() {
//     return Container(
//       child: Card(
//           elevation: 5,
// //          color: Colors.blue,
//           child: Container(
//             padding: EdgeInsets.all(12),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Row(
//                   children: <Widget>[
//                     Icon(
//                       Icons.person,
//                       color: primaryColor,
//                     ),
//                     SizedBox(width: 5),
//                     Text(
//                       S.of(context).sender,
//                       style: accentTextStyleMediumDarkBold,
//                     )
//                   ],
//                 ),
//                 verticalDividerSmall,
//                 verticalDividerSmall,
//                 Container(
//                   padding: EdgeInsets.only(left: 10),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Row(
//                         children: [
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   S.of(context).name,
//                                   style: accentTextStyleMediumDarkBold,
//                                 ),
//                                 verticalDividerSmall,
//                                 TextFieldInput(
//                                   hintText: S.of(context).ex_mohammed,
//                                   keyType: TextInputType.text,
//                                   value: widget.order?.pickupName,
//                                   // validator: FormValidator.validName,
//                                   save: (String name) {
//                                     print(name +
//                                         "  ...........................are you here");
//                                     setState(() {
//                                       widget.order.pickupName = name;
//                                     });
//                                   },
//                                   isReadOnly: widget.isReadOnly,
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(width: 2),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   S.of(context).phone,
//                                   style: accentTextStyleMediumDarkBold,
//                                 ),
//                                 verticalDividerSmall,
//                                 TextFieldInput(
//                                     hintText: S.of(context).ex_9100100100,
//                                     value: widget.order?.pickUptMobile,
//                                     keyType: TextInputType.phone,
//                                     isReadOnly: widget.isReadOnly,
//                                     validator:
//                                     FormValidator.validateMobileNonRequired,
//                                     save: (String mobile) {
//                                       setState(() {
//                                         widget.order.pickUptMobile = mobile;
//                                       });
//                                     }),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//
//                       ///top
//
//                       SizedBox(height: 12),
//                       Text(
//                         S.of(context).address,
//                         style: accentTextStyleMediumDarkBold,
//                       ),
//                       verticalDividerSmall,
//                       //mam
//                       pickUpAddressWidget(),
//                       verticalDividerSmall,
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 10),
//               ],
//             ),
//           )),
//     );
//   }
//
//   pickUpAddressWidget() {
//     // List<String>
//     return DropdownSearch<String>(
//       mode: Mode.MENU,
//       showSelectedItem: true,
//       items: customPickUPAddress,
//       hint: S.of(context).address,
//       onChanged: (String data) {
//         selectAddressIndex = customPickUPAddress
//             .indexWhere((element) => element.trim() == data.trim());
//         print(selectAddressIndex);
//         widget.order.pickupAddress = (pickUPAddress[selectAddressIndex]);
//         widget.order.printOrder();
//         setState(() {});
//       },
//       selectedItem: customPickUPAddress.length > 0
//           ? customPickUPAddress[selectAddressIndex]
//           : _pickupAddressLoading
//           ? S.of(context).please_wait
//           : S.of(context).no_address,
//     );
//   }
//
//   Widget dropOffWidgetForm() {
//     return Container(
//       child: Card(
//           elevation: 5,
// //          color: Colors.blue,
//           child: Container(
//             padding: EdgeInsets.all(12),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Row(
//                   children: <Widget>[
//                     Icon(
//                       Icons.person,
//                       color: primaryColor,
//                     ),
//                     SizedBox(width: 5),
//                     Text(
//                       S.of(context).receiver,
//                       style: accentTextStyleMediumDarkBold,
//                     )
//                   ],
//                 ),
//                 verticalDividerSmall,
//                 verticalDividerSmall,
//                 Container(
//                   padding: EdgeInsets.only(left: 10),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Row(
//                         children: [
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   S.of(context).name,
//                                   style: accentTextStyleMediumDarkBold,
//                                 ),
//                                 verticalDividerSmall,
//                                 TextFieldInput(
//                                   hintText: S.of(context).ex_mohammed,
//                                   keyType: TextInputType.text,
//                                   value: widget.order?.dropOffName,
//                                   validator: FormValidator.validName,
//                                   save: (String name) {
//                                     setState(() {
//                                       widget.order.dropOffName = name;
//                                     });
//                                   },
//                                   isReadOnly: widget.isReadOnly,
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(width: 2),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   S.of(context).phone,
//                                   style: accentTextStyleMediumDarkBold,
//                                 ),
//                                 verticalDividerSmall,
//                                 TextFieldInput(
//                                     hintText: S.of(context).ex_9100100100,
//                                     value: widget.order?.dropOffMobile,
//                                     keyType: TextInputType.phone,
//                                     isReadOnly: widget.isReadOnly,
//                                     validator: FormValidator.validateMobile,
//                                     save: (String mobile) {
//                                       setState(() {
//                                         widget.order.dropOffMobile = mobile;
//                                       });
//                                     }),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 15),
//                       Row(
//                         children: [
//                           Expanded(
//                             flex: 1,
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   S.of(context).city,
//                                   style: accentTextStyleMediumDarkBold,
//                                 ),
//                                 verticalDividerSmall,
//                                 DropdownSearch<CityModel>(
//                                   mode: Mode.MENU,
//                                   items: dropOffCities,
//                                   showSelectedItem: true,
//                                   // onFind: (String filter) => AddressBlock().dropOffCities(),
//                                   itemAsString:(CityModel item)=>  item.name,
//                                   hint: S.of(context).city,
//                                   onChanged: (CityModel item) {
//                                     print(selectedDropOffCity);
//                                     widget.order.dropOffCity =
//                                         item;
//                                     widget.order.printOrder();
//                                     setState(() {});
//                                   },
//                                   compareFn: (CityModel i, CityModel s) => i.id==s.id,
//                                   selectedItem: widget.order.dropOffCity,
//                                 ),
//                                 //   DropdownSearch<String>(
//                                 //       mode: Mode.MENU,
//                                 //       showSelectedItem: true,
//                                 //       items: customDropOffCities,
//                                 //       hint: S.of(context).city,
//                                 //       onChanged: (String data) {
//                                 //         selectedDropOffCity = customDropOffCities
//                                 //             .indexWhere((element) =>
//                                 //         element.trim() == data.trim());
//                                 //         print(selectedDropOffCity);
//                                 //         widget.order.dropOffCity =
//                                 //         (dropOffCities[selectedDropOffCity]);
//                                 //         widget.order.printOrder();
//                                 //         setState(() {});
//                                 //       },
//                                 //       selectedItem: customDropOffCities.length > 0
//                                 //           ? customDropOffCities[selectedDropOffCity]
//                                 //           : _dropOffCitiesLoading
//                                 //           ? S.of(context).please_wait
//                                 //
//                                 //
//                                 //     // selectedItem: customDropOffCities.length > 0
//                                 //   //     ? customDropOffCities[selectedDropOffCity]
//                                 //   //     : _dropOffCitiesLoading
//                                 //   //         ? S.of(context).please_wait
//                                 //   //         : S.of(context).no_cities,
//                                 // ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(width: 2),
//                           Expanded(
//                             flex: 2,
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   S.of(context).address,
//                                   style: accentTextStyleMediumDarkBold,
//                                 ),
//                                 verticalDividerSmall,
//                                 TextFieldInput(
//                                   hintText: S.of(context).ex_khartoum_bahri,
//                                   value: widget.order?.dropOffAddress,
//                                   validator: FormValidator.validateAddress,
//                                   isReadOnly: widget.isReadOnly,
//                                   save: (String address) {
//                                     setState(() {
//                                       widget.order.dropOffAddress = address;
//                                     });
//                                   },
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                       verticalDividerSmall,
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 10),
//               ],
//             ),
//           )),
//     );
//   }
//
//   Widget invoiceWidgetForm() {
//     return Container(
//       child: Card(
//         elevation: 5,
// //          color: Colors.blue,
//         child: Container(
//           padding: EdgeInsets.all(12),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Row(
//                 children: <Widget>[
//                   Icon(
//                     Icons.attach_money,
//                     color: primaryColor,
//                   ),
//                   SizedBox(width: 5),
//                   Text(
//                     S.of(context).invoice_amount,
//                     style: accentTextStyleMediumDarkBold,
//                   )
//                 ],
//               ),
//               verticalDividerSmall,
//               verticalDividerSmall,
//               //package price and delivery charge forms
//               Container(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: <Widget>[
//                         Expanded(
//                           flex: 1,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: <Widget>[
//                               Text(
//                                 S.of(context).package_price,
//                                 style: TextStyle(fontWeight: FontWeight.bold),
//                               ),
//                               verticalDividerSmall,
//                               TextFieldInput(
//                                   hintText: S.of(context).ex_1000,
//                                   isReadOnly: widget.isReadOnly,
//                                   value: widget.isCreate
//                                       ? ""
//                                       : widget.order.packagePrice.toString(),
// //                                  value: widget.order.packagePrice.toString(),
//                                   validator: FormValidator.validateCash,
//                                   keyType: TextInputType.number,
//                                   save: (String invoiceAmount) {
//                                     setState(
//                                           () {
//                                         widget.order.packagePrice =
//                                         invoiceAmount.isFloat()
//                                             ? double.parse(invoiceAmount)
//                                             : 0.0;
//                                       },
//                                     );
//                                   }),
//                             ],
//                           ),
//                         ),
//                         SizedBox(width: 2),
//                         Expanded(
//                           flex: 1,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: <Widget>[
//                               Text(
//                                 S.of(context).deliver_charge,
//                                 style: TextStyle(fontWeight: FontWeight.bold),
//                               ),
//                               verticalDividerSmall,
//                               TextFieldInput(
//                                   hintText: S.of(context).ex_1000,
//                                   isReadOnly: widget.isReadOnly,
//                                   value: widget.isCreate
//                                       ? ""
//                                       : widget.order.deliveryCharge.toString(),
//                                   validator: FormValidator.validateCash,
//                                   keyType: TextInputType.number,
//                                   save: (String price) {
//                                     setState(() {
//                                       widget.order.deliveryCharge =
//                                       price.isFloat()
//                                           ? double.parse(price)
//                                           : 0.0;
//                                     });
//                                   }),
//                             ],
//                           ),
//                         ),
//                         SizedBox(width: 2),
//                         Expanded(
//                           flex: 1,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: <Widget>[
//                               Text(
//                                 S.of(context).paid_amount,
//                                 style: TextStyle(fontWeight: FontWeight.bold),
//                               ),
//                               verticalDividerSmall,
//                               TextFieldInput(
//                                   hintText: S.of(context).ex_1000,
//                                   isReadOnly: widget.isReadOnly,
//                                   value: widget.isCreate
//                                       ? ""
//                                       : widget.order.paidAmount.toString(),
//                                   validator: FormValidator.validateCash,
//                                   keyType: TextInputType.number,
//                                   save: (String price) {
//                                     setState(() {
//                                       widget.order.paidAmount = price.isFloat()
//                                           ? double.parse(price)
//                                           : 0.0;
//                                     });
//                                   }),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               verticalDividerSmall,
//               verticalDividerSmall,
//               Container(
//                 height: 70,
//                 // color: Colors.blue,
//                 child: Row(
//                   // crossAxisAlignment: WrapCrossAlignment.center,
//                   // mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Expanded(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             S.of(context).collection_amount,
//                             maxLines: 2,
//                             textAlign: TextAlign.center,
//                             style: TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                           SizedBox(height: 8),
//                           Container(
//                             padding: EdgeInsets.all(5),
//                             decoration: BoxDecoration(
//                               color: primaryColor,
//                               borderRadius: BorderRadius.all(Radius.circular(
//                                   10.0) //                 <--- border radius here
//                               ),
//                             ),
//                             child: Text(
//                               widget.isCreate
//                                   ? "0.0"
//                                   : widget.order.collectionAmount.toString(),
//                               style: TextStyle(color: Colors.white),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Expanded(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         // crossAxisAlignment: CrossAxisAlignment.center,
//                         // mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             S.of(context).collected_amount,
//                             maxLines: 2,
//                             textAlign: TextAlign.center,
//                             style: TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                           SizedBox(height: 8),
//                           Container(
//                             padding: EdgeInsets.all(5),
//                             decoration: BoxDecoration(
//                               color: primaryColor,
//                               borderRadius: BorderRadius.all(Radius.circular(
//                                   10.0) //                 <--- border radius here
//                               ),
//                             ),
//                             child: Text(
//                               widget.isCreate
//                                   ? "0.0"
//                                   : widget.order.collectedAmount.toString(),
//                               style: TextStyle(color: Colors.white),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Expanded(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             S.of(context).drop_off_balance,
//                             textAlign: TextAlign.center,
//                             maxLines: 2,
//                             style: TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                           SizedBox(height: 8),
//                           Container(
//                             padding: EdgeInsets.all(5),
//                             decoration: BoxDecoration(
//                               color: primaryColor,
//                               borderRadius: BorderRadius.all(Radius.circular(
//                                   10.0) //                 <--- border radius here
//                               ),
//                             ),
//                             child: Text(
//                               widget.isCreate
//                                   ? "0.0"
//                                   : widget.order.dropOffBalance.toString(),
//                               style: TextStyle(color: Colors.white),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
//               SizedBox(height: 10),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget descriptionWidgetForm() {
//     return Container(
//       child: Card(
//         elevation: 5,
//         child: Container(
//           padding: EdgeInsets.all(12),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Text(
//                 S.of(context).description,
//                 style: accentTextStyleMediumDarkBold,
//               ),
//               verticalDividerSmall,
//               TextFieldInput(
//                 isMultiLine: true,
//                 isReadOnly: widget.isReadOnly,
//                 hintText: S.of(context).describe_the_item,
//                 value: widget.order.description,
//                 validator: FormValidator.validateAddress,
//                 keyType: TextInputType.multiline,
//                 save: (String desc) {
//                   setState(() {
//                     widget.order.description = desc;
//                   });
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget formSubmitBtns() {
//     final bloc = Provider.of<OrdersBloc>(context);
//     return Container(
//       // color: Colors.green,
//       width: MediaQuery.of(context).size.width,
//       child: (widget.order.state == "draft" || widget.isCreate)
//           ? Row(
//         children: [
//           Expanded(
//             child: MaterialButton(
//               color: accentColor,
//               height: 42.0,
//               minWidth: 100,
//               // minWidth: MediaQuery.of(context).size.width / 1.8,
//               elevation: 1,
//               onPressed: () async {
//                 FocusScope.of(context).requestFocus(FocusNode());
//                 //
//                 // _formKey.currentState.reset();
//                 // widget.order.copy(new OrderModel());
//                 // setState(() {});
//                 // return;
//                 // final res = await bloc.createOrder(widget.order);
//                 // return;
//                 if (_formKey.currentState.validate()) {
//                   // _formKey.currentState.save();
//                   // _formKey.res
//
//                   //muller create order
//                   _formKey.currentState.save();
//                   sh();
//                   if (widget.isCreate) {
//                     final res = await bloc.createOrder(widget.order);
//                     Navigator.of(context).pop();
//
//                     if (res) {
//                       _formKey.currentState.reset();
//                       CustomToast.show(
//                           S.of(context).order_created_successfully);
//                       Navigator.pop(context);
//                       // widget.order.copy(new OrderModel());
//                       // setState(() {});
//                     }
//                   } else {
//                     // order.id = widget.order.id;
//                     widget.order.updateOnlyState=false;
//                     final res = await bloc.updateOrder(widget.order);
//                     Navigator.of(context).pop();
//                     if (res) {
//                       widget.order.copy(widget.order);
//                       CustomToast.show(
//                           S.of(context).order_updated_successfully);
//                     }
//                   }
//                 }
//               },
//               child: Text(
//                 widget.isCreate
//                     ? S.of(context).save
//                     : S.of(context).update,
//                 style: TextStyle(color: Colors.white),
//               ),
//               shape: RoundedRectangleBorder(
//                 borderRadius: new BorderRadius.circular(8.0),
//               ),
//             ),
//           ),
//           SizedBox(width: 5),
//
//           //confirm btn
//           (widget.order.state == "draft" || widget.isCreate)
//               ? Expanded(
//             child: MaterialButton(
//               color: accentColor,
//               height: 42.0,
//               minWidth: 100,
//               // minWidth: MediaQuery.of(context).size.width / 2,
//               elevation: 1,
//               onPressed: () async {
//                 FocusScope.of(context).requestFocus(FocusNode());
//                 // final res = await bloc.createOrder(widget.order);
//                 // return;
//                 if (_formKey.currentState.validate()) {
//                   _formKey.currentState.save();
//                   sh();
//                   String temState = widget.order.state;
//                   widget.order.state = "confirm";
//                   if (widget.isCreate) {
//                     // widget.order.updateOnlyState = false;
//                     final res =
//                     await bloc.createOrder(widget.order);
//                     Navigator.of(context).pop();
//                     if (res) {
//                       _formKey.currentState.reset();
//                       CustomToast.show(
//                           S.of(context).order_created_successfully);
//                       Navigator.pop(context);
//                     } else {
//                       widget.order.state = temState;
//                       setState(() {});
//                     }
//                   } else {
//                     widget.order.updateOnlyState = true;
//                     order.id = widget.order.id;
//                     final res =
//                     await bloc.updateOrder(widget.order);
//                     Navigator.of(context).pop();
//                     if (res) {
//                       widget.order.copy(widget.order);
//                       CustomToast.show(
//                           S.of(context).order_updated_successfully);
//                     } else {
//                       widget.order.state = temState;
//                     }
//                   }
//                   setState(() {});
//                 }
//               },
//               child: Text(
//                 widget.isCreate
//                     ? S.of(context).save_and_confirm
//                     : S.of(context).confirm,
//                 style: TextStyle(color: Colors.white),
//               ),
//               shape: RoundedRectangleBorder(
//                 borderRadius: new BorderRadius.circular(8.0),
//               ),
//             ),
//           )
//               : Container(
//             // width: 2,
//             child: Text(""),
//           ),
//         ],
//       )
//           : Row(
//         children: [
//           Expanded(
//             child: MaterialButton(
//               color: accentColor,
//               height: 42.0,
//               minWidth: 100,
//               // minWidth: MediaQuery.of(context).size.width / 2,
//               elevation: 1,
//               onPressed: () async {
//                 FocusScope.of(context).requestFocus(FocusNode());
//                 // final res = await bloc.createOrder(widget.order);
//                 // return;
//                 if (_formKey.currentState.validate()) {
//                   _formKey.currentState.save();
//                   sh();
//                   String temState=widget.order.state;
//                   widget.order.updateOnlyState=true;
//                   widget.order.state=widget.order.isConfirmed?"cancel":"draft";
//                   final res = await bloc.updateOrder(widget.order);
//                   Navigator.of(context).pop();
//                   if (res) {
//                     _formKey.currentState.reset();
//                     CustomToast.show(
//                         S.of(context).order_created_successfully);
//                     // Navigator.pop(context);
//                   } else {
//                     widget.order.state = temState;
//                   }
//                   setState(() {});
//                 }
//               },
//               child: Text(
//                 widget.order.isConfirmed
//                     ? S.of(context).cancel
//                     : S.of(context).set_to_draft,
//                 style: TextStyle(color: Colors.white),
//               ),
//               shape: RoundedRectangleBorder(
//                 borderRadius: new BorderRadius.circular(8.0),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
//
// class TextFieldInput extends StatelessWidget {
//   final String hintText;
//   final String value;
//   final bool isMultiLine;
//   final bool isReadOnly;
//   final Function(String) validator;
//   final Function(String) save;
//   final TextInputType keyType;
//   TextFieldInput(
//       {this.value,
//         this.hintText,
//         this.save,
//         this.validator,
//         this.keyType = TextInputType.text,
//         this.isReadOnly = false,
//         this.isMultiLine = false});
//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       initialValue: value,
//       readOnly: isReadOnly,
//       keyboardType: keyType,
//       autofocus: false,
//       maxLines: isMultiLine ? 12 : null,
//       minLines: isMultiLine ? 10 : null,
//       decoration: InputDecoration(
//         hintText: hintText,
//         contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
//       ),
//       validator: validator,
//       onChanged: save,
//     );
//   }
// }
