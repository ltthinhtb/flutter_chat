import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vn_dental/generated/l10n.dart';
import 'package:vn_dental/page/widgets/appbar.dart';
import 'package:vn_dental/page/widgets/button_widget.dart';
import 'package:vn_dental/page/widgets/dropdown_column_widget.dart';
import 'package:vn_dental/page/widgets/pending_action.dart';
import 'package:vn_dental/page/widgets/text_field_widget.dart';
import 'package:vn_dental/themes/colors.dart';
import 'package:vn_dental/themes/sizes.dart';

import 'package:vn_dental/utils/utils.dart';

import 'sign_up.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _nameController;
  TextEditingController _emailController;
  TextEditingController _passwordController;
  TextEditingController _confirmPassController;
  TextEditingController _phoneNumberController;
  SignUpBloc _signUpBloc;

  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passFocusNode = FocusNode();
  final FocusNode _rePassFocusNode = FocusNode();
  final FocusNode _phoneFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPassController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _signUpBloc = SignUpBloc(context);
    _signUpBloc.add(GetDistrict());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        appBar: appBar(title: S.of(context).sign_up),
        body: BlocProvider(
          create: (context) => _signUpBloc,
          child: BlocListener<SignUpBloc, SignUpState>(
            listener: (context, state) {
              if (state is SignUpFailure) {
                Utils.showSnackBar(context, state.error);
              }
            },
            child: BlocBuilder<SignUpBloc, SignUpState>(builder: (
              BuildContext context,
              SignUpState state,
            ) {
              return SafeArea(
                child: GestureDetector(
                  onTap: () =>
                      FocusScope.of(context).requestFocus(new FocusNode()),
                  child: Stack(
                    children: <Widget>[
                      SingleChildScrollView(
                          child: Container(
                              color: white,
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              alignment: Alignment.center,
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextFieldWidget(
                                      controller: _nameController,
                                      textInputAction: TextInputAction.next,
                                      errorText: _signUpBloc.errorName,
                                      labelText: S.of(context).name,
                                      onChanged: (text) =>
                                          _signUpBloc.add(ValidateName(text)),
                                      focusNode: _nameFocusNode,
                                      onSubmitted: (text) =>
                                          Utils.navigateNextFocusChange(context,
                                              _nameFocusNode, _emailFocusNode)),
                                  SizedBox(height: 10),
                                  TextFieldWidget(
                                      controller: _phoneNumberController,
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.phone,
                                      errorText: _signUpBloc.errorPhone,
                                      labelText: S.of(context).phone_number_1,
                                      onChanged: (text) =>
                                          _signUpBloc.add(ValidatePhone(text)),
                                      focusNode: _phoneFocusNode,
                                      onSubmitted: (text) =>
                                          Utils.navigateNextFocusChange(
                                              context,
                                              _phoneFocusNode,
                                              _emailFocusNode)),
                                  SizedBox(height: 10),
                                  TextFieldWidget(
                                      controller: _emailController,
                                      textInputAction: TextInputAction.next,
                                      errorText: _signUpBloc.errorEmail,
                                      labelText: S.of(context).email,
                                      onChanged: (text) =>
                                          _signUpBloc.add(ValidateEmail(text)),
                                      focusNode: _emailFocusNode,
                                      onSubmitted: (text) =>
                                          Utils.navigateNextFocusChange(context,
                                              _emailFocusNode, _passFocusNode)),
                                  SizedBox(height: 10),
                                  DropdownColumnWidget(
                                    listData: _signUpBloc.gender,
                                    hintText: S.of(context).gender,
                                    currentValue: _signUpBloc.selectedGender,
                                    //label: S.of(context).gender,
                                    selectedValue: (value) {
                                      _signUpBloc.add(SelectGender(value));
                                    },
                                  ),
                                  SizedBox(height: 10),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: DropdownColumnWidget(
                                        listData: _signUpBloc.listCity,
                                        hintText: S.of(context).city,
                                        selectedValue: (value) {},
                                        currentValue: _signUpBloc?.selectCity,
                                      )),
                                      Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10)),
                                      Expanded(
                                          child: DropdownColumnWidget(
                                        listData: _signUpBloc.district
                                            .map((e) => e.title)
                                            .toList(),
                                        hintText: S.of(context).district,
                                        currentValue:
                                            _signUpBloc.selectDistrict,
                                        selectedValue: (value) {
                                          if (value ==
                                              _signUpBloc?.selectDistrict)
                                            return;
                                        },
                                      ))
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  TextFieldWidget(
                                    isPassword: true,
                                    controller: _passwordController,
                                    textInputAction: TextInputAction.next,
                                    labelText: S.of(context).password,
                                    errorText: _signUpBloc.errorPassword,
                                    onChanged: (text) =>
                                        _signUpBloc.add(ValidatePass(text)),
                                    focusNode: _passFocusNode,
                                    onSubmitted: (text) =>
                                        Utils.navigateNextFocusChange(context,
                                            _passFocusNode, _rePassFocusNode),
                                  ),
                                  SizedBox(height: 10),
                                  TextFieldWidget(
                                    isPassword: true,
                                    controller: _confirmPassController,
                                    textInputAction: TextInputAction.go,
                                    labelText: S.of(context).confirm_password,
                                    errorText: _signUpBloc.errorConfirmPassword,
                                    onChanged: (text) => _signUpBloc.add(
                                        ValidateRePass(
                                            _passwordController.text, text)),
                                    focusNode: _rePassFocusNode,
                                    onSubmitted: (text) => _signUpBloc.add(
                                        SignUpByEmail(
                                            _nameController.text,
                                            _emailController.text,
                                            _passwordController.text,
                                            _confirmPassController.text)),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 30.0),
                                    child: ButtonWidget(
                                      title:
                                          S.of(context).sign_up.toUpperCase(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: white,
                                          fontSize: size(50)),
                                      onPressed: () => state is SignUpLoading
                                          ? null
                                          : _signUpBloc.add(SignUpByEmail(
                                              _nameController.text,
                                              _emailController.text,
                                              _passwordController.text,
                                              _confirmPassController.text)),
                                    ),
                                  ),
                                  SizedBox(height: 50),
                                ],
                              ))),
                      Visibility(
                        visible: state is SignUpLoading,
                        child: PendingAction(),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ));
  }

}
