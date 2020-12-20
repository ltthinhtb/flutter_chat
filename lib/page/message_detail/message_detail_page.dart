import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:vn_dental/generated/l10n.dart';
import 'package:vn_dental/models/network/response/message.dart';
import 'package:vn_dental/models/network/response/user.dart';
import 'package:vn_dental/page/authentication/authentication.dart';
import 'package:vn_dental/page/widgets/full_screen_image.dart';
import 'package:vn_dental/themes/colors.dart';
import 'package:vn_dental/themes/my_flutter_app_icons.dart';
import 'package:vn_dental/themes/sizes.dart';
import 'package:vn_dental/utils/const.dart';
import 'package:vn_dental/utils/utils.dart';

import 'message_detail.dart';

class MessageDetailPage extends StatefulWidget {
  final User user;

  const MessageDetailPage({Key key, this.user}) : super(key: key);

  @override
  _MessageDetailPageState createState() => _MessageDetailPageState();
}

class _MessageDetailPageState extends State<MessageDetailPage>
    with AutomaticKeepAliveClientMixin {
  // ignore: close_sinks

  MessageDetailBloc _bloc;

  String chatID;
  List<String> deviceToken = List();

  // ignore: close_sinks
  AuthenticationBloc _authenticationBloc;
  TextEditingController _messageController = TextEditingController();
  RefreshController _refreshController = RefreshController();

  @override
  void initState() {
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    _bloc = MessageDetailBloc();
    loadIdChat();
    _bloc.add(LoadMessage(chatId: chatID));
    deviceToken.add(widget.user.token);
    // TODO: implement initState
    super.initState();
  }

  void loadIdChat() {
    String user1 = _authenticationBloc.userID;
    String user2 = widget.user.id;
    if (user1.hashCode < user2.hashCode) {
      chatID = "$user1-$user2";
    } else
      chatID = "$user2-$user1";
  }

  @override
  // ignore:
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocListener<MessageDetailBloc, MessageDetailState>(
        listener: (context, state) {
          if (!(state is MessageDetailLoading))
            _refreshController.loadComplete();
          _refreshController.refreshCompleted();
          if (state is DeleteMessageSuccess) Navigator.pop(context);
        },
        child: BlocBuilder<MessageDetailBloc, MessageDetailState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: white,
                iconTheme: IconThemeData(color: pink, size: height(125)),
                title: Row(
                  children: [
                    Stack(
                      children: [
                        Container(
                          child: CircleAvatar(
                            radius: height(70),
                            backgroundImage: CachedNetworkImageProvider(
                                widget.user.avatarUrl ?? ""),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            decoration: BoxDecoration(
                                color: _bloc.activeStatus ? green : grey,
                                shape: BoxShape.circle),
                            height: height(50),
                            width: height(50),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.user.name,
                          style: TextStyle(
                              fontSize: size(50),
                              fontWeight: FontWeight.bold,
                              color: black),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          _bloc.activeStatus ? "Active now" : "Offline",
                          style: TextStyle(
                              color: black.withOpacity(0.4),
                              fontSize: size(45)),
                        )
                      ],
                    )
                  ],
                ),
                actions: [
                  IconButton(
                      icon: _bloc.isCompress
                          ? Icon(
                              Icons.check_box_outlined,
                              color: blue,
                            )
                          : Icon(
                              Icons.check_box_outline_blank,
                              color: blue,
                            ),
                      onPressed: ()=> _bloc.add(IsCompress()))
                ],
              ),
              body: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(new FocusNode());
                },
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: height(20)),
                        height: double.infinity,
                        width: double.infinity,
                        child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection(Const.MESSAGES)
                              .doc(chatID)
                              .collection(chatID)
                              .orderBy(Const.DateTIME, descending: true)
                              .limit(_bloc.limit)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.none) {}
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {}
                            List<Message> messages = List();
                            List<QueryDocumentSnapshot> listMessageDoc =
                                List.from([]);
                            listMessageDoc.addAll(snapshot.data.documents);
                            listMessageDoc.forEach((element) {
                              messages.add(Message.fromQuery(element));
                            });
                            return SmartRefresher(
                              reverse: true,
                              controller: _refreshController,
                              enablePullDown: false,
                              onRefresh: () =>
                                  _bloc.add(LoadMessage(isLoadMore: true)),
                              enablePullUp: true,
                              onLoading: () =>
                                  _bloc.add(LoadMessage(isLoadMore: true)),
                              child: ListView.builder(
                                cacheExtent: 999,
                                shrinkWrap: true,
                                reverse: true,
                                itemCount: messages.length,
                                itemBuilder: (context, int index) {
                                  Message _message = messages[index];
                                  _message.id =
                                      snapshot.data.documents[index].id;
                                  Message _lastMessage;
                                  bool isLastMessageOwner = false;
                                  if (index == 0)
                                    isLastMessageOwner = true;
                                  else if (index > 0) {
                                    _lastMessage = messages[index - 1];
                                    if (_lastMessage.imageOwner !=
                                        _message.imageOwner)
                                      isLastMessageOwner = true;
                                  }
                                  return buildMessage(
                                      _message, isLastMessageOwner);
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    _sendMessageArea()
                  ],
                ),
              ),
              // bottomNavigationBar: ,
            );
          },
        ),
      ),
    );
  }

  Widget buildMessage(Message message, bool isLastMessageOwner) {
    Widget widgetLeft;
    Widget widgetRight;
    isMessageOwner(message)
        ? widgetLeft = buildContentMessage(message)
        : widgetLeft = buildAvatarSend(message, isLastMessageOwner);
    isMessageOwner(message)
        ? widgetRight = buildAvatarSend(message, isLastMessageOwner)
        : widgetRight = buildContentMessage(message);
    return GestureDetector(
      onLongPress: () =>
          isMessageOwner(message) ? _modalBottomSheetMenu(message) : null,
      child: Container(
          margin: EdgeInsets.fromLTRB(10, 0, 10, 5),
          child: Container(
              child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: isMessageOwner(message)
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              widgetLeft,
              SizedBox(
                width: height(20),
              ),
              widgetRight
            ],
          ))),
    );
  }

  Widget buildContentMessage(Message message) {
    return message.type == Const.EMOJI_TYPE
        ? _icon(MyFlutterApp.thumbs_up)
        : message.type == Const.LIST_IMAGE_TYPE
            ? Container(
                width: sizeImage(message.listImage.length),
                // height: MediaQuery.of(context).size.width,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: countLength(message.listImage.length)),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: message.listImage.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return FullScreenImage(
                            title: widget.user.name,
                            imageUrl: message.listImage[index],
                            tag: message.listImage[index],
                          );
                        }));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: Hero(
                          tag: message.listImage[index],
                          child: ClipRRect(
                            borderRadius: new BorderRadius.circular(7),
                            child: CachedNetworkImage(
                              imageUrl: message.listImage[index],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            : (message.type == Const.IMAGE_TYPE)
                ? GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return FullScreenImage(
                          title: widget.user.name,
                          imageUrl: message.content,
                          tag: message.content,
                        );
                      }));
                    },
                    child: Hero(
                      tag: message.content,
                      child: ClipRRect(
                        borderRadius: new BorderRadius.circular(7),
                        child: CachedNetworkImage(
                          imageUrl: message.content ?? "",
                          height: MediaQuery.of(context).size.width / 2.5,
                          // fit: BoxFit.cover,
                          placeholder: (context, url) => Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ),
                    ),
                  )
                : Flexible(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: isMessageOwner(message) ? grey_300 : blue),
                      child: Text(
                        message.content,
                        maxLines: 20,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: size(50),
                            color: isMessageOwner(message) ? black : white),
                      ),
                    ),
                  );
  }

  Icon _icon(IconData icons) {
    return Icon(
      icons,
      size: height(200),
      color: blue,
    );
  }

  Widget buildAvatarSend(Message message, bool isLastMessageOwner) {
    String imageUrl = message.imageOwner;
    return isLastMessageOwner
        ? CircleAvatar(
            radius: height(50),
            backgroundImage: CachedNetworkImageProvider(imageUrl ?? ""),
          )
        : SizedBox(
            width: height(100),
          );
  }

  bool isMessageOwner(Message message) {
    return message.userOwner == _authenticationBloc.userID;
  }

  Widget _sendMessageArea() {
    return Container(
      color: white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Visibility(
              visible: _bloc.isOnTyping,
              child: SizedBox(
                width: 10,
              )),
          Visibility(
            visible: !_bloc.isOnTyping,
            child: IconButton(
              icon: Icon(MyFlutterApp.camera),
              iconSize: height(75),
              color: blue,
              onPressed: () {
                _bloc.add(ImagePick(
                    true,
                    Message(
                        type: Const.IMAGE_TYPE,
                        userName: _bloc.userName,
                        tokenDevice: deviceToken,
                        dateTime: Utils.parseDateToString(
                            DateTime.now(), Const.SEND_TIME),
                        userOwner: _authenticationBloc.userID),
                    chatID));
              },
            ),
          ),
          Visibility(
            visible: !_bloc.isOnTyping,
            child: IconButton(
              icon: Icon(MyFlutterApp.picture),
              iconSize: height(75),
              color: blue,
              onPressed: () {
                _bloc.add(ImagePick(
                    false,
                    Message(
                        userName: _bloc.userName,
                        type: Const.LIST_IMAGE_TYPE,
                        dateTime: Utils.parseDateToString(
                            DateTime.now(), Const.SEND_TIME),
                        userOwner: _authenticationBloc.userID,
                        tokenDevice: deviceToken),
                    chatID));
              },
            ),
          ),
          Visibility(
            visible: !_bloc.isOnTyping,
            child: GestureDetector(
              child: IconButton(
                icon: Icon(MyFlutterApp.mic),
                iconSize: height(75),
                color: blue,
                onPressed: () {},
              ),
            ),
          ),
          Flexible(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              padding: EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                  color: grey_400, borderRadius: BorderRadius.circular(20)),
              alignment: Alignment.center,
              child: TextField(
                controller: _messageController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                onChanged: (String text) {
                  _bloc.add(OnTypingEvent(text));
                },
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(
                      MyFlutterApp.smile,
                      color: blue,
                    ),
                    iconSize: height(75),
                    color: Theme.of(context).primaryColor,
                    onPressed: () {},
                  ),
                  hintText: "Aa",
                  border: InputBorder.none,
                ),
                textCapitalization: TextCapitalization.sentences,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              final Message message = Message(
                  tokenDevice: deviceToken,
                  userName: _bloc.userName,
                  userOwner: _authenticationBloc.userID,
                  imageOwner: _bloc.avatarUser,
                  type:
                      _bloc.isOnTyping ? Const.MESSAGE_TYPE : Const.EMOJI_TYPE,
                  dateTime:
                      Utils.parseDateToString(DateTime.now(), Const.SEND_TIME),
                  content: _bloc.isOnTyping
                      ? _messageController.text
                      : Const.EMOJI_TYPE);
              _bloc.add(SentMessage(chatID, message));
              _messageController.clear();
            },
            icon: Icon(
              !_bloc.isOnTyping ? MyFlutterApp.thumbs_up : Icons.send,
              size: height(90),
              color: blue,
            ),
          )
        ],
      ),
    );
  }

  void _modalBottomSheetMenu(Message message) {
    showModalBottomSheet<void>(
        context: context,
        builder: (builder) {
          return Container(
              height: height(300),
              color: Colors.transparent,
              //could change this to Color(0xFF737373),
              child: Container(
                  decoration: new BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      buildIconButton(Icons.redo, () {}, S.of(context).rep),
                      buildIconButton(
                          Icons.copy_sharp, () {}, S.of(context).copy),
                      buildIconButton(Icons.delete_outline, () {
                        _bloc.add(DeleteMessage(chatID, message.id));
                      }, S.of(context).delete),
                    ],
                  )));
        });
  }

  Widget buildIconButton(IconData icon, VoidCallback onPress, String text) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(
              icon,
              size: height(125),
              color: grey,
            ),
            onPressed: onPress,
          ),
          Text(
            text,
            style: TextStyle(fontSize: size(50), fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  }

  int countLength(int length) {
    if (length == 1)
      return length;
    else if (length % 2 == 0)
      return 2;
    else
      return 3;
  }

  double sizeImage(int length) {
    if (countLength(length) == 1)
      return MediaQuery.of(context).size.width / 3;
    else if (countLength(length) == 2)
      return MediaQuery.of(context).size.width / 1.5;
    else if (countLength(length) == 3)
      return MediaQuery.of(context).size.width / 1.5;
    else
      return MediaQuery.of(context).size.width / 2;
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
