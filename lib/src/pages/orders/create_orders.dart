import 'dart:async';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:orders_app/generated/l10n.dart';
import 'package:orders_app/src/bloc/address_block.dart';
import 'package:orders_app/src/bloc/orders_bloc.dart';
import 'package:orders_app/src/modals/address_model.dart';
import 'package:orders_app/src/modals/city_model.dart';
import 'package:orders_app/src/modals/order_model.dart';
import 'package:orders_app/src/utils/validators.dart';
import 'package:orders_app/src/values/colors.dart';
import 'package:orders_app/src/widgets/spinner.dart';
import 'package:orders_app/src/widgets/text_styles.dart';
import 'package:provider/provider.dart';

import '../../utils/extensions.dart';

typedef Validator = String? Function(String? value);

class CreateOrderPage extends StatefulWidget {
  final OrderModel order;
  final bool isCreate;

  const CreateOrderPage({
    Key? key,
    required this.order,
    this.isCreate = true,
  }) : super(key: key);
  @override
  _CreateOrderPageState createState() => _CreateOrderPageState();
}

class _CreateOrderPageState extends State<CreateOrderPage> {
  final _formKey = GlobalKey<FormState>();
  StreamSubscription<String>? _subscription;
  OrderModel? order;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final _bloc = Provider.of<OrdersBloc>(context);
    _subscription = _bloc.errorMessage.listen((message) async {
      if (message == null || message.isEmpty || message == "CLEAR") return;
      await Future.delayed(const Duration(milliseconds: 200));
      _showMessage(message);
    });
  }

  _showMessage(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    }
  }

  @override
  void initState() {
    super.initState();
    order?.copy(widget.order);
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  void sh() {
    showDialog<dynamic>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: Dialog(
                backgroundColor: Colors.white,
                insetAnimationDuration: const Duration(milliseconds: 100),
                elevation: 2,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(2))),
                child: SizedBox(
                  height: 120,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const Spinner(),
                        verticalDividerSmall,
                        Text(S.of(context).please_wait)
                      ],
                    ),
                  ),
                )),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // print("home lan .... ${widget.order.state}");
    // order.orderName="muller";
    print("build create .......");
    return Scaffold(
        appBar: AppBar(
          title: widget.isCreate
              ? Text(
                  S.of(context).create_order,
                )
              : Text(
                  order?.orderName ?? "",
                ),
          actions: <Widget>[
            widget.isCreate
                ? Container()
                : Row(
                    children: <Widget>[
                      Container(
                        height: 20,
                        decoration: BoxDecoration(
                            color: widget.order.isDraft
                                ? Colors.green
                                : Colors.blue,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4))),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        child: Text(widget.order.state,
                            style: const TextStyle(
                                fontSize: 12, color: Colors.white)),
                      ),
                      const SizedBox(width: 10)
                    ],
                  )
          ],
        ),
        // persistentFooterButtons: !!widget.order.isDraft
        persistentFooterButtons: <Widget>[formSubmitBtns()],
        body: Form(
          key: _formKey,
          child: Scrollbar(
            child: ListView(
              padding: const EdgeInsets.all(5),
              children: <Widget>[
                pickupWidgetForm(),
                verticalDividerSmall,
                dropOffWidgetForm(),
                verticalDividerSmall,
                invoiceWidgetForm(),
                verticalDividerSmall,
                descriptionWidgetForm(),
//                dateWidgetForm(),
                const SizedBox(height: 24),
//                muller,
              ],
            ),
          ),
        ));
  }

  DateTime selectedDate = DateTime.now();

  _selectDate(BuildContext context) async {
//     final DateTime picked = await showDatePicker(
//       context: context,
//       initialDate: selectedDate, // Refer step 1
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2025),
//     );
//     if (picked != null && picked != selectedDate)
//       setState(() {
//         selectedDate = picked;
// //        widget.order.selectedDate = picked;
//       });
  }

  Widget dateWidgetForm() {
    return Container(
      child: Card(
          elevation: 5,
//          color: Colors.blue,
          child: Container(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "${selectedDate.toLocal()}".split(' ')[0],
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                ElevatedButton(
                  onPressed: () => _selectDate(context), // Refer step 3
                  child: const Text(
                    'Select date',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),

//          color: Colors.greenAccent,
                ),
              ],
            ),
          )),
    );
  }

  Widget pickupWidgetForm() {
    return Container(
      child: Card(
          elevation: 5,
//          color: Colors.blue,
          child: Container(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    const Icon(
                      Icons.person,
                      color: primaryColor,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      S.of(context).sender,
                      style: accentTextStyleMediumDarkBold,
                    )
                  ],
                ),
                verticalDividerSmall,
                verticalDividerSmall,
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  S.of(context).name,
                                  style: accentTextStyleMediumDarkBold,
                                ),
                                verticalDividerSmall,
                                TextFieldInput(
                                  hintText: S.of(context).ex_mohammed,
                                  keyType: TextInputType.text,
                                  value: widget.order.pickupName,
                                  // validator: FormValidator.validName,
                                  save: (String name) {
                                    print(name +
                                        "  ...........................are you here");
                                    setState(() {
                                      // order.pickupName = name;
                                      widget.order.pickupName = name;
                                    });
                                  },
                                  isReadOnly: !widget.order.isDraft,
                                  validator: (String? value) {},
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 2),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  S.of(context).phone,
                                  style: accentTextStyleMediumDarkBold,
                                ),
                                verticalDividerSmall,
                                TextFieldInput(
                                    hintText: S.of(context).ex_9100100100,
                                    value: widget.order.pickUptMobile,
                                    keyType: TextInputType.phone,
                                    isReadOnly: !widget.order.isDraft,
                                    validator:
                                        FormValidator.validateMobileNonRequired,
                                    save: (String mobile) {
                                      setState(() {
                                        widget.order.pickUptMobile = mobile;
                                      });
                                    }),
                              ],
                            ),
                          ),
                        ],
                      ),

                      ///top

                      const SizedBox(height: 12),
                      Text(
                        S.of(context).address,
                        style: accentTextStyleMediumDarkBold,
                      ),
                      verticalDividerSmall,
                      //mam
                      pickUpAddressWidget(),
                      verticalDividerSmall,
                    ],
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          )),
    );
  }

  pickUpAddressWidget() {
    // List<String>\\
    return DropdownSearch<AddressModel>(
      mode: Mode.MENU,
      dropdownSearchDecoration: InputDecoration(
        fillColor: Theme.of(context).inputDecorationTheme.fillColor,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Colors.black, width: 4)),
      ),
      showSelectedItems: true,
      popupItemDisabled: (AddressModel item) =>
          item.id == widget.order.pickupAddress!.id,
      validator: (AddressModel? x) {
        if (x != null && x.id == 0) return S.of(context).please_select_address;
        return null;
      },
      onFind: (String? filter) => AddressBlock().pickUpAddress(),
      enabled: !!widget.order.isDraft,
      itemAsString: (AddressModel? item) => item != null ? item.name! : "",
      onChanged: (AddressModel? item) {
        if (item != null) {
          widget.order.pickupAddress = item;
          widget.order.printOrder();
          setState(() {});
        }
      },
      compareFn: (AddressModel? i, AddressModel? s) =>
          i != null && s != null && i.id == s.id,
      selectedItem: widget.order.pickupAddress,
    );
  }

  Widget dropOffWidgetForm() {
    return Container(
      child: Card(
          elevation: 5,
//          color: Colors.blue,
          child: Container(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    const Icon(
                      Icons.person,
                      color: primaryColor,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      S.of(context).receiver,
                      style: accentTextStyleMediumDarkBold,
                    )
                  ],
                ),
                verticalDividerSmall,
                verticalDividerSmall,
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  S.of(context).name,
                                  style: accentTextStyleMediumDarkBold,
                                ),
                                verticalDividerSmall,
                                TextFieldInput(
                                  hintText: S.of(context).ex_mohammed,
                                  keyType: TextInputType.text,
                                  value: widget.order.dropOffName,
                                  validator: FormValidator.validName,
                                  save: (String name) {
                                    setState(() {
                                      widget.order.dropOffName = name;
                                    });
                                  },
                                  isReadOnly: !widget.order.isDraft,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 2),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  S.of(context).phone,
                                  style: accentTextStyleMediumDarkBold,
                                ),
                                verticalDividerSmall,
                                TextFieldInput(
                                    hintText: S.of(context).ex_9100100100,
                                    value: widget.order.dropOffMobile,
                                    keyType: TextInputType.phone,
                                    isReadOnly: !widget.order.isDraft,
                                    validator: FormValidator.validateMobile,
                                    save: (String mobile) {
                                      setState(() {
                                        widget.order.dropOffMobile = mobile;
                                      });
                                    }),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Text(
                        S.of(context).city,
                        style: accentTextStyleMediumDarkBold,
                      ),
                      verticalDividerSmall,
                      verticalDividerSmall,
                      DropdownSearch<CityModel>(
                        mode: Mode.MENU,
                        showSelectedItems: true,
                        isFilteredOnline: true,
                        validator: (CityModel? cityModel) {
                          if (cityModel != null && cityModel.id == 0) {
                            return S.of(context).please_select_city;
                          }
                          return null;
                        },
                        dropdownSearchDecoration: InputDecoration(
                          fillColor:
                              Theme.of(context).inputDecorationTheme.fillColor,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 2),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 4)),
                        ),
                        onFind: (String? filter) =>
                            AddressBlock().dropOffCities(),
                        enabled: !!widget.order.isDraft,
                        popupItemDisabled: (CityModel item) =>
                            item.id == widget.order.dropOffCity!.id,
                        itemAsString: (CityModel? item) =>
                            item != null ? item.name! : "",
                        onChanged: (CityModel? item) {
                          if (item != null) {
                            widget.order.dropOffCity = item;
                            widget.order.printOrder();
                            setState(() {});
                          }
                        },
                        compareFn: (CityModel? i, CityModel? s) =>
                            i != null && s != null && i.id == s.id,
                        selectedItem: widget.order.dropOffCity,
                      ),
                      const SizedBox(height: 15),
                      Text(
                        S.of(context).address,
                        style: accentTextStyleMediumDarkBold,
                      ),
                      verticalDividerSmall,
                      TextFieldInput(
                        hintText: S.of(context).ex_khartoum_bahri,
                        value: widget.order.dropOffAddress,
                        validator: FormValidator.validateAddress,
                        isReadOnly: !widget.order.isDraft,
                        // isMultiLine: true,
                        save: (String address) {
                          setState(() {
                            widget.order.dropOffAddress = address;
                          });
                        },
                      ),
                      verticalDividerSmall,
                    ],
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          )),
    );
  }

  Widget invoiceWidgetForm() {
    return Card(
      elevation: 5,
//          color: Colors.blue,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                const Icon(
                  Icons.attach_money,
                  color: primaryColor,
                ),
                const SizedBox(width: 5),
                Text(
                  S.of(context).invoice_amount,
                  style: accentTextStyleMediumDarkBold,
                )
              ],
            ),
            verticalDividerSmall,
            verticalDividerSmall,
            //package price and delivery charge forms
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            S.of(context).package_price,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          verticalDividerSmall,
                          TextFieldInput(
                              hintText: S.of(context).ex_1000,
                              isReadOnly: !widget.order.isDraft,
                              value: widget.isCreate
                                  ? ""
                                  : widget.order.packagePrice.toString(),
//                                  value: widget.order.packagePrice.toString(),
                              validator: FormValidator.validateCash,
                              keyType: TextInputType.number,
                              save: (String invoiceAmount) {
                                setState(
                                  () {
                                    widget.order.packagePrice =
                                        invoiceAmount.isFloat()
                                            ? double.parse(invoiceAmount)
                                            : 0.0;
                                  },
                                );
                              }),
                        ],
                      ),
                    ),
                    const SizedBox(width: 2),
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            S.of(context).deliver_charge,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          verticalDividerSmall,
                          TextFieldInput(
                              hintText: S.of(context).ex_1000,
                              isReadOnly: !widget.order.isDraft,
                              value: widget.isCreate
                                  ? ""
                                  : widget.order.deliveryCharge.toString(),
                              validator: FormValidator.validateCash,
                              keyType: TextInputType.number,
                              save: (String price) {
                                setState(() {
                                  widget.order.deliveryCharge = price.isFloat()
                                      ? double.parse(price)
                                      : 0.0;
                                });
                              }),
                        ],
                      ),
                    ),
                    const SizedBox(width: 2),
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            S.of(context).paid_amount,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          verticalDividerSmall,
                          TextFieldInput(
                              hintText: S.of(context).ex_1000,
                              isReadOnly: !widget.order.isDraft,
                              value: widget.isCreate
                                  ? ""
                                  : widget.order.paidAmount.toString(),
                              validator: FormValidator.validateCash,
                              keyType: TextInputType.number,
                              save: (String price) {
                                setState(() {
                                  widget.order.paidAmount = price.isFloat()
                                      ? double.parse(price)
                                      : 0.0;
                                });
                              }),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            verticalDividerSmall,
            verticalDividerSmall,
            SizedBox(
              height: 70,
              // color: Colors.blue,
              child: Row(
                // crossAxisAlignment: WrapCrossAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          S.of(context).collection_amount,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.all(Radius.circular(
                                    10.0) //                 <--- border radius here
                                ),
                          ),
                          child: Text(
                            widget.isCreate
                                ? "0.0"
                                : widget.order.collectionAmount.toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          S.of(context).collected_amount,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.all(Radius.circular(
                                    10.0) //                 <--- border radius here
                                ),
                          ),
                          child: Text(
                            widget.isCreate
                                ? "0.0"
                                : widget.order.collectedAmount.toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          S.of(context).drop_off_balance,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.all(Radius.circular(
                                    10.0) //                 <--- border radius here
                                ),
                          ),
                          child: Text(
                            widget.isCreate
                                ? "0.0"
                                : widget.order.dropOffBalance.toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget descriptionWidgetForm() {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              S.of(context).description,
              style: accentTextStyleMediumDarkBold,
            ),
            verticalDividerSmall,
            TextFieldInput(
              isMultiLine: true,
              isReadOnly: !widget.order.isDraft,
              hintText: S.of(context).describe_the_item,
              value: widget.order.description,
              validator: FormValidator.validateAddress,
              keyType: TextInputType.multiline,
              save: (String desc) {
                setState(() {
                  widget.order.description = desc;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget formSubmitBtns() {
    final bloc = Provider.of<OrdersBloc>(context);
    return SizedBox(
      // color: Colors.green,
      width: MediaQuery.of(context).size.width,
      child: (widget.order.state == "draft" || widget.isCreate)
          ? Row(
              children: [
                Expanded(
                  child: MaterialButton(
                    color: accentColor,
                    height: 42.0,
                    minWidth: 40,
                    // minWidth: MediaQuery.of(context).size.width / 1.8,
                    elevation: 1,
                    onPressed: () async {
                      FocusScope.of(context).requestFocus(FocusNode());
                      //
                      // _formKey.currentState.reset();
                      // widget.order.copy(new OrderModel());
                      // setState(() {});
                      // return;
                      // final res = await bloc.createOrder(widget.order);
                      // return;
                      if (_formKey.currentState!.validate()) {
                        // _formKey.currentState.save();
                        // _formKey.res

                        //muller create order
                        _formKey.currentState!.save();
                        sh();
                        if (widget.isCreate) {
                          final res = await bloc.createOrder(widget.order);
                          Navigator.of(context).pop();

                          if (res != null) {
                            _formKey.currentState!.reset();
                            // widget.order=res;
                            // widget.order.copy(res);
                            _showMessage(
                                S.of(context).order_created_successfully);
                            Navigator.pop(context);
                            // widget.order.copy(new OrderModel());
                            // setState(() {});
                          }
                        } else {
                          // order.id = widget.order.id;
                          print("home");
                          widget.order.updateOnlyState = false;
                          final res = await bloc.updateOrder(widget.order);
                          Navigator.of(context).pop();
                          if (res != null) {
                            print(
                                "update response ........ on update ... **************************************** ............................");
                            print(res);
                            setState(() {
                              widget.order.copy(res);
                            });
                            _showMessage(
                                S.of(context).order_updated_successfully);
                          }
                        }
                      }
                    },
                    child: Text(
                      widget.isCreate
                          ? S.of(context).save
                          : S.of(context).update,
                      style: const TextStyle(color: Colors.white),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                const SizedBox(width: 5),

                //confirm btn
                (widget.order.state == "draft" || widget.isCreate)
                    ? Expanded(
                        child: MaterialButton(
                          color: accentColor,
                          height: 42.0,
                          minWidth: 55,
                          // minWidth: MediaQuery.of(context).size.width / 2,
                          elevation: 1,
                          onPressed: () async {
                            FocusScope.of(context).requestFocus(FocusNode());
                            // final res = await bloc.createOrder(widget.order);
                            // return;
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              sh();
                              String temState = widget.order.state;
                              widget.order.state = "confirm";
                              if (widget.isCreate) {
                                // widget.order.updateOnlyState = false;
                                final res =
                                    await bloc.createOrder(widget.order);
                                Navigator.of(context).pop();
                                if (res != null) {
                                  setState(() {
                                    widget.order.copy(res);
                                  });
                                  _formKey.currentState!.reset();
                                  _showMessage(
                                      S.of(context).order_created_successfully);
                                  Navigator.pop(context);
                                } else {
                                  widget.order.state = temState;
                                  setState(() {});
                                }
                              } else {
                                widget.order.updateOnlyState = true;
                                order!.id = widget.order.id;
                                final res =
                                    await bloc.updateOrder(widget.order);
                                Navigator.of(context).pop();
                                if (res != null) {
                                  setState(() {
                                    widget.order.copy(res);
                                  });
                                  _showMessage(
                                      S.of(context).order_updated_successfully);
                                } else {
                                  widget.order.state = temState;
                                }
                              }
                              setState(() {});
                            }
                          },
                          child: Text(
                            widget.isCreate
                                ? S.of(context).save_and_confirm
                                : S.of(context).confirm,
                            style: const TextStyle(color: Colors.white),
                          ),
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                          ),
                        ),
                      )
                    : Container(
                        // width: 2,
                        child: const Text(""),
                      ),
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: MaterialButton(
                    color: accentColor,
                    height: 42.0,
                    minWidth: 55,
                    // minWidth: MediaQuery.of(context).size.width / 2,
                    elevation: 1,
                    onPressed: () async {
                      FocusScope.of(context).requestFocus(FocusNode());
                      // final res = await bloc.createOrder(widget.order);
                      // return;
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        sh();
                        String temState = widget.order.state;
                        widget.order.updateOnlyState = true;
                        widget.order.state =
                            widget.order.isConfirmed ? "cancel" : "draft";
                        final res = await bloc.updateOrder(widget.order);
                        Navigator.of(context).pop();
                        if (res != null) {
                          setState(() {
                            widget.order.copy(res);
                          });
                          _formKey.currentState!.reset();
                          _showMessage(
                              S.of(context).order_created_successfully);
                          // Navigator.pop(context);
                        } else {
                          widget.order.state = temState;
                        }
                        setState(() {});
                      }
                    },
                    child: Text(
                      widget.order.isConfirmed
                          ? S.of(context).cancel
                          : S.of(context).set_to_draft,
                      style: const TextStyle(color: Colors.white),
                    ),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                if (widget.order.isConfirmed)
                  Expanded(
                    child: MaterialButton(
                      color: accentColor,
                      height: 42.0,
                      minWidth: 40,
                      elevation: 1,
                      onPressed: () async {
                        FocusScope.of(context).requestFocus(FocusNode());
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          sh();
                          String temState = widget.order.state;
                          widget.order.updateOnlyState = true;
                          widget.order.state = "delivered";
                          final res = await bloc.updateOrder(widget.order);
                          Navigator.of(context).pop();
                          if (res != null) {
                            setState(() {
                              widget.order.copy(res);
                            });
                            _formKey.currentState!.reset();
                            _showMessage(
                                S.of(context).order_created_successfully);
                            // Navigator.pop(context);
                          } else {
                            widget.order.state = temState;
                          }
                          setState(() {});
                        }
                      },
                      child: Text(
                        S.of(context).delivered,
                        style: const TextStyle(color: Colors.white),
                      ),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                    ),
                  ),
              ],
            ),
    );
  }
}

class TextFieldInput extends StatelessWidget {
  final String? hintText;
  final String? value;
  final bool isMultiLine;
  final bool isReadOnly;
  final Validator validator;
  final Function(String) save;
  final TextInputType keyType;
  const TextFieldInput({
    Key? key,
    this.value,
    this.hintText,
    required this.save,
    required this.validator,
    this.keyType = TextInputType.text,
    this.isReadOnly = false,
    this.isMultiLine = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: value,
      readOnly: isReadOnly,
      keyboardType: keyType,
      autofocus: false,
      maxLines: isMultiLine ? 12 : null,
      // minLines: isMultiLine ? 10 : null,
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      validator: validator,
      onChanged: save,
    );
  }
}
