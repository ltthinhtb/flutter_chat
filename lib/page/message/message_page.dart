import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:vn_dental/generated/l10n.dart';
import 'package:vn_dental/models/network/response/user.dart';
import 'package:vn_dental/page/authentication/authentication.dart';
import 'package:vn_dental/page/main/main.dart';
import 'package:vn_dental/page/message_detail/message_detail_page.dart';
import 'package:vn_dental/page/widgets/appbar.dart';
import 'package:vn_dental/themes/colors.dart';
import 'package:vn_dental/themes/sizes.dart';
import 'package:vn_dental/utils/const.dart';
import 'package:vn_dental/utils/utils.dart';

import 'message.dart';

class MessagePage extends StatefulWidget {
  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  MessageBloc _bloc;
  TextEditingController _searchDoctorController = TextEditingController();

  // ignore: close_sinks
  AuthenticationBloc _authenticationBloc;

  // ignore: close_sinks
  RefreshController _refreshController = RefreshController();

  // ignore: close_sinks
  MainBloc _mainBloc;

  @override
  void initState() {
    _bloc = BlocProvider.of<MessageBloc>(context);
    _mainBloc = BlocProvider.of<MainBloc>(context);
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    // TODO: implement initState
    _bloc.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MessageBloc, MessageState>(
      listener: (context, state) {
        if (state is MessageLoginSuccess) {
          _mainBloc.add(ChangeAuthorizationEvent());
        }
        if (!(state is MessageLoading)) _refreshController.refreshCompleted();
      },
      child: BlocBuilder<MessageBloc, MessageState>(
        builder: (context, state) {
          return Scaffold(
            appBar: appBar(title: S.of(context).message, isCenter: false),
            body: isLoggedIn()
                ? Container(
                    height: double.infinity,
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: SmartRefresher(
                      controller: _refreshController,
                      onRefresh: () => _bloc.add(
                          GetListDoctor(isRefresh: true, userID: _bloc.userID)),
                      child: StreamBuilder(
                        stream: _bloc.users
                            .where(Const.ID, isNotEqualTo: _bloc.userID)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.none) {
                            print("no data");
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            print('waitting');
                          }
                          _bloc.list.clear();
                          List<QueryDocumentSnapshot> listUser = List.from([]);
                          listUser.addAll(snapshot.data.documents);
                          _bloc.list.addAll(
                              listUser.map((e) => User.fromDoc(e)).toList());
                          return ListView(
                            shrinkWrap: true,
                            padding: EdgeInsets.all(10),
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              buildSearchDoctor(context),
                              SizedBox(
                                height: 10,
                              ),
                              ListView.separated(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                physics: NeverScrollableScrollPhysics(),
                                separatorBuilder: (context, int index) {
                                  return Divider(
                                    endIndent: 10,
                                    indent: 10,
                                  );
                                },
                                shrinkWrap: true,
                                itemCount: _bloc
                                        ?.searchDoctor(_searchDoctorController
                                            .text
                                            .toLowerCase())
                                        ?.length ??
                                    0,
                                itemBuilder: (context, int index) {
                                  List<User> listDoctor = _bloc?.searchDoctor(
                                      _searchDoctorController.text
                                          .toLowerCase());
                                  return rowDoctor(listDoctor[index]);
                                },
                              )
                            ],
                          );
                        },
                      ),
                    ),
                  )
                : Container(
                    child: Text(S.of(context).login_toUse),
                    alignment: Alignment.center,
                  ),
          );
        },
      ),
    );
  }

  bool isLoggedIn() {
    return _authenticationBloc.isLoggedIn;
  }

  Widget rowDoctor(User doctorData) {
    return InkWell(
      onTap: () => onPressChat(doctorData),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.only(right: 20),
              child: CircleAvatar(
                radius: height(100),
                backgroundImage:
                    CachedNetworkImageProvider(doctorData?.avatarUrl ?? ""),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    doctorData?.name ?? "",
                    style: TextStyle(
                        fontSize: size(50), fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "Đang hoạt động" ?? "",
                    style: TextStyle(fontSize: size(40)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onPressChat(User doctorData) {
    Utils.navigatePage(
        _mainBloc.context,
        MessageDetailPage(
          user: doctorData,
        ));
  }

  Widget buildSearchDoctor(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: TypeAheadField<User>(
            hideSuggestionsOnKeyboardHide: false,
            getImmediateSuggestions: false,
            keepSuggestionsOnLoading: true,
            textFieldConfiguration: TextFieldConfiguration(
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.search,
              style: TextStyle(color: black, fontSize: size(45)),
              controller: _searchDoctorController,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(
                      MdiIcons.close,
                      size: height(100),
                      semanticLabel: 'clear',
                    ),
                    onPressed: () {
                      _searchDoctorController.clear();
                      _bloc.add(SelectDoctor(null));
                      FocusScope.of(context).requestFocus(new FocusNode());
                    },
                  ),
                  border: OutlineInputBorder(),
                  labelText: S.of(context).search_clinic,
                  labelStyle: TextStyle(
                      fontSize: size(45),
                      color: black,
                      fontStyle: FontStyle.italic),
                  hintStyle: TextStyle(
                    fontSize: size(45),
                    color: grey,
                  ),
                  errorStyle: TextStyle(
                    fontSize: size(30),
                    color: red,
                  )),
            ),
            onSuggestionSelected: (User data) {
              _searchDoctorController.text = data.name;
              _bloc.add(SelectDoctor(data));
            },
            suggestionsCallback: (String text) {
              return _bloc.searchDoctor(text);
            },
            itemBuilder: (BuildContext context, User doctor) {
              return Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  doctor.name ?? "",
                  style: TextStyle(
                      fontWeight: FontWeight.w500, fontSize: size(40)),
                ),
              );
            },
            //keepSuggestionsOnSuggestionSelected: false,
            noItemsFoundBuilder: (context) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(S.of(context).no_data),
              );
            },
          ),
        )
      ],
    );
  }
}
