import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:orders_app/generated/l10n.dart';
import 'package:orders_app/src/bloc/auth_bloc.dart';
import 'package:orders_app/src/repository/auth_repository.dart';
import 'package:orders_app/src/utils/storage/storage_helper.dart';
import 'package:orders_app/src/utils/storage/storage_keys.dart';
import 'package:orders_app/src/utils/validators.dart';
import 'package:orders_app/src/values/colors.dart';
import 'package:orders_app/src/widgets/card_view.dart';
import 'package:orders_app/src/widgets/circular_image.dart';
import 'package:orders_app/src/widgets/spinner.dart';
import 'package:orders_app/src/widgets/text_styles.dart';
import 'package:provider/provider.dart';

import 'orders/create_orders.dart';

class ChangeProfilePage extends StatefulWidget {
  @override
  _ChangeAvatarPageState createState() => _ChangeAvatarPageState();
}

class _ChangeAvatarPageState extends State<ChangeProfilePage> {
  File? _image;
  final _formKey = GlobalKey<FormState>();
  bool isSelectedImage = false;
  bool isUpdating = false;
  String? name, mobile;
  String initName = "", initPhone = "";

  @override
  void initState() {
    super.initState();
    StorageHelper.get(StorageKeys.name).then((val) {
      if (val != null) {
        setState(() {
          initName = val;
        });
      }
    });
    StorageHelper.get(StorageKeys.phone).then((val) {
      if (val != null) {
        setState(() {
          initPhone = val;
        });
      }
    });
  }

  _showMessage(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    }
  }

  void _choseImageDialog() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return SizedBox(
          height: 180,
          child: ListView(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.add_a_photo),
                title: Text(S.of(context).camera),
                onTap: () => getImage(ImageSource.camera),
              ),
              ListTile(
                leading: const Icon(Icons.collections),
                title: Text(S.of(context).gallery),
                onTap: () => getImage(ImageSource.gallery),
              ),
              ListTile(
                leading: const Icon(Icons.delete),
                title: Text(S.of(context).remove),
                onTap: () {
                  Navigator.of(context).pop();
                  setState(() {
                    _image = null;
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future getImage(ImageSource imageSource) async {
    final image = await ImagePicker().pickImage(source: imageSource);
    if(image != null){
      setState(() {
        _image = File(image.path);
      });
    }
  }

  void save() async {
    if (_image == null) return;
    setState(() {
      isUpdating = true;
    });
    final _repo = AuthRepository();
    final res = await _repo.changeAvatar(_image!);
    if (res.success) {
      _showMessage(S.of(context).updated_successfully);
    }
    setState(() {
      isUpdating = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).change_profile),
          leading: const BackButton(),
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(8),
            children: <Widget>[
              CardView(
                hrPadding: 16,
                vrPadding: 16,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    changeImage(),
                    verticalDividerLarge,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        MaterialButton(
                          color: accentColor,
                          height: 42.0,
                          elevation: 1,
                          onPressed: () async {
                            if (_image != null) {
                              showProgress();
                              final resp = AuthRepository();
                              final res = await resp.changeAvatar(_image!);
                              Navigator.of(context).pop();
                              if (res.success) {
                                _showMessage(
                                    S.of(context).updated_successfully);
                              } else {
                                _showMessage(res.message);
                              }
                            } else {
                              _showMessage("Image not changed");
                            }
                          },
                          child: Text(
                            S.of(context).change,
                            style: const TextStyle(color: Colors.white),
                          ),
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              verticalDividerLarge,
              CardView(
                hrPadding: 16,
                vrPadding: 16,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      S.of(context).name,
                      style: accentTextStyleMediumDarkBold,
                    ),
                    verticalDividerSmall,
                    TextFieldInput(
                      hintText: S.of(context).ex_mohammed,
                      keyType: TextInputType.text,
                      value: initName,
                      validator: FormValidator.validateName,
                      save: (String value) => name = value,
                    ),
                    verticalDividerSmall,
                    Text(
                      S.of(context).phone,
                      style: accentTextStyleMediumDarkBold,
                    ),
                    TextFieldInput(
                      hintText: S.of(context).ex_9100100100,
                      keyType: TextInputType.text,
                      value: initPhone,
                      validator: FormValidator.validateMobile,
                      save: (String value) => mobile = value,
                    ),
                    verticalDividerLarge,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        MaterialButton(
                          color: accentColor,
                          height: 42.0,
                          elevation: 1,
                          onPressed: () async {
                            FocusScope.of(context).requestFocus(FocusNode());
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              showProgress();
                              final resp = AuthRepository();
                              final res = await resp.changeInfo(name!, mobile!);
                              Navigator.of(context).pop();
                              if (res.success) {
                                _showMessage(
                                    S.of(context).updated_successfully);
                              } else {
                                _showMessage(res.message);
                              }
                            }
                          },
                          child: Text(
                            S.of(context).update,
                            style: const TextStyle(color: Colors.white),
                          ),
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showProgress() {
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

  Widget changeImage() {
    return SizedBox(
      height: 120,
      width: 120,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          _image == null
              ? const ProfileImage(height: 120, width: 120)
              : CircleImage(
                  width: 120,
                  height: 120,
                  child: Image.file(
                    _image!,
                  )),
          Align(
            alignment: Alignment.center,
            child: Visibility(
              visible: true,
              child: SizedBox(
                width: 32,
                height: 32,
                child: FloatingActionButton(
                  elevation: 2,
                  child: const Icon(
                    Icons.edit,
                    size: 20,
                  ),
                  onPressed: () {
                    _choseImageDialog();
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ProfileImage extends StatelessWidget {
  final double width;
  final double height;
  const ProfileImage({this.width = 120, this.height = 120});
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "profile",
      child: SizedBox(
        height: width,
        width: height,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(94.0),
          child: FittedBox(
            fit: BoxFit.cover,
            child: FutureBuilder<String?>(
              future: StorageHelper.get(StorageKeys.avatar),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Container(
                    width: 120,
                    height: 120,
                    color: Colors.grey[400],
                  );
                } else {
                  return CircleCachedNetworkAvatar(
                    url: "${snapshot.data}/large",
                    size: 120,
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
