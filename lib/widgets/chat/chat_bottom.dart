import 'dart:ui' as ui;
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:mojipanda/common/common.dart';
import 'package:mojipanda/common/storage_manager.dart';
import 'package:mojipanda/widgets/chat/emoji_widget.dart';
import 'package:mojipanda/widgets/chat/extra_widget.dart';
import 'package:mojipanda/widgets/chat/image_button.dart';
import 'package:mojipanda/widgets/chat/record_button.dart';

String _initType = "text";

typedef void OnSendCallBack(String text);
typedef void OnImageSelectCallBack(File file);
typedef void OnAudioCallBack(File file, int duration);

class ChatBottomInputWidget extends StatefulWidget {
  final OnSendCallBack onSendCallBack;
  final OnImageSelectCallBack onImageSelectCallBack;
  final OnAudioCallBack onAudioCallBack;
  final Stream shouldTriggerChange;

  const ChatBottomInputWidget({
    Key key,
    @required this.shouldTriggerChange,
    this.onSendCallBack,
    this.onImageSelectCallBack,
    this.onAudioCallBack,
  }) : super(key: key);

  @override
  _ChatBottomInputWidgetState createState() => _ChatBottomInputWidgetState();
}

class _ChatBottomInputWidgetState extends State<ChatBottomInputWidget>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  String mCurrentType = _initType;
  FocusNode focusNode = FocusNode();
  AnimationController _bottomHeightController;
  TextEditingController mEditController = TextEditingController();
  StreamController<String> inputContentStreamController =
      StreamController.broadcast();
  Stream<String> get inputContentStream => inputContentStreamController.stream;

  double _softKeyHeight = StorageManager.localStorage.getItem("kHeight") ?? 300;

  final GlobalKey globalKey = GlobalKey();

  bool mBottomLayoutShow = false;

  bool mAddLayoutShow = false;

  bool mEmojiLayoutShow = false;

  KeyboardVisibilityNotification _keyboardVisibility =
      KeyboardVisibilityNotification();

  StreamSubscription streamSubscription;

  void _getWH() {
    if (globalKey == null ||
        globalKey.currentContext == null ||
        globalKey.currentContext.size == null) {
      return;
    }
  }

  @override
  void didChangeMetrics() {
    final mediaQueryData = MediaQueryData.fromWindow(ui.window);
    final keyHeight = mediaQueryData?.viewInsets?.bottom;
    if (keyHeight != 0) {
      _softKeyHeight = keyHeight;
      print("键盘高度是:" + _softKeyHeight.toString());
    }
    // super.didChangeMetrics();
  }

  @override
  void didUpdateWidget(ChatBottomInputWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.shouldTriggerChange != oldWidget.shouldTriggerChange) {
      streamSubscription.cancel();
      streamSubscription =
          widget.shouldTriggerChange.listen((_) => hideBottomLayout());
    }
  }

  @override
  void dispose() {
    super.dispose();
    streamSubscription.cancel();
  }

  void hideBottomLayout() {
    setState(() {
      this.mCurrentType = "text2";
      mBottomLayoutShow = false;
      mAddLayoutShow = false;
      mEmojiLayoutShow = false;
    });
  }

  @override
  void initState() {
    super.initState();
    streamSubscription =
        widget.shouldTriggerChange.listen((_) => hideBottomLayout());
    WidgetsBinding.instance.addObserver(this);
    mEditController.addListener(() {
      inputContentStreamController.add(mEditController.text);
    });
    _bottomHeightController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    _keyboardVisibility.addNewListener(onChange: (bool visible) {
      if (visible) {
        mBottomLayoutShow = true;
        if (mEmojiLayoutShow) {
          this.mCurrentType = "emoji";
          setState(() {});
        } else {
          setState(() {});
        }
      } else {
        if (mBottomLayoutShow) {
          if (!mAddLayoutShow) {
            if (!mEmojiLayoutShow) {
              mBottomLayoutShow = false;
              setState(() {});
            }
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              buildLeftButton(),
              Expanded(child: buildInputButton()),
              buildEmojiButton(),
              buildRightButton(),
            ],
          ),
          _buildBottomContainer(child: _buildBottomItems()),
        ],
      ),
    );
  }

  Widget buildLeftButton() {
    return mCurrentType == "voice" ? mKeyBoardButton() : mRecordButton();
  }

  Widget mRecordButton() {
    return new ImageButton(
      onPressed: () {
        this.mCurrentType = "voice";
        hideSoftKey();
        mBottomLayoutShow = false;
        mEmojiLayoutShow = false;
        setState(() {});
      },
      image: new AssetImage(Constant.ASSETS_IMG + "ic_audio.png"),
    );
  }

  Widget mKeyBoardButton() {
    return new ImageButton(
      onPressed: () {
        this.mCurrentType = "text";
        showSoftKey();
        setState(() {});
      },
      image: new AssetImage(Constant.ASSETS_IMG + "ic_keyboard.png"),
    );
  }

  Widget mVoiceButton(BuildContext context) {
    return Container(
      width: double.infinity,
      child: RecordButton(onAudioCallBack: (value, duration) {
        widget.onAudioCallBack?.call(value, duration);
      }),
    );
  }

  Widget buildInputButton() {
    final voiceButton = mVoiceButton(context);
    final inputButton = Container(
      // height: 40,
      constraints: BoxConstraints(
        maxHeight: 80.0,
        minHeight: 40.0,
      ),

      child: TextField(
        maxLines: null,
        keyboardType: TextInputType.multiline,
        //minLines: 1,
        style: TextStyle(fontSize: 16),
        focusNode: focusNode,
        controller: mEditController,
        decoration: InputDecoration(
          isDense: true,
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
          enabledBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 0.0),
            borderRadius: const BorderRadius.all(const Radius.circular(5.0)),
          ),
          disabledBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 0.0),
            borderRadius: const BorderRadius.all(const Radius.circular(5.0)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 0.0),
            borderRadius: const BorderRadius.all(const Radius.circular(5.0)),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 0.0),
            borderRadius: const BorderRadius.all(const Radius.circular(5.0)),
          ),
        ),
      ),
    );

    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: Stack(
        textDirection: TextDirection.rtl,
        children: <Widget>[
          Offstage(
            child: voiceButton,
            offstage: mCurrentType != "voice",
          ),
          Offstage(
            child: inputButton,
            offstage: mCurrentType == "voice",
          ),
        ],
      ),
    );
  }

  Widget buildEmojiButton() {
    return mCurrentType != "emoji" ? mEmojiButton() : mEmojiKeyBoardButton();
  }

  Widget mEmojiButton() {
    return new ImageButton(
      onPressed: () {
        this.mCurrentType = "emoji";
        _getWH();
        setState(() {
          mBottomLayoutShow = true;
          mEmojiLayoutShow = true;
        });
        hideSoftKey();

        _getWH();
      },
      image: new AssetImage(Constant.ASSETS_IMG + "ic_emoji.png"),
    );
  }

  Widget mEmojiKeyBoardButton() {
    return new ImageButton(
      onPressed: () {
        _getWH();
        this.mCurrentType = "text2";
        mBottomLayoutShow = true;
        mEmojiLayoutShow = false;
        setState(() {});
        showSoftKey();
      },
      image: new AssetImage(Constant.ASSETS_IMG + "ic_keyboard.png"),
    );
  }

  Widget buildRightButton() {
    return StreamBuilder<String>(
      stream: this.inputContentStream,
      builder: (context, snapshot) {
        final sendButton = buildSend();
        final extraButton = ImageButton(
            image: new AssetImage(Constant.ASSETS_IMG + "ic_add.png"),
            onPressed: () {
              this.mCurrentType = "extra";
              if (mBottomLayoutShow) {
                if (mAddLayoutShow) {
                  showSoftKey();
                  mBottomLayoutShow = true;
                  mAddLayoutShow = false;
                  setState(() {});
                } else {
                  mBottomLayoutShow = true;
                  mAddLayoutShow = true;
                  hideSoftKey();
                  setState(() {});
                }
              } else {
                if (focusNode.hasFocus) {
                  hideSoftKey();
                  Future.delayed(const Duration(milliseconds: 50), () {
                    setState(() {
                      mBottomLayoutShow = true;
                      mAddLayoutShow = true;
                    });
                  });
                } else {
                  mBottomLayoutShow = true;
                  mAddLayoutShow = true;
                  setState(() {});
                }
              }
            });
        CrossFadeState crossFadeState =
            checkShowSendButton(mEditController.text)
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond;
        return AnimatedCrossFade(
          duration: const Duration(milliseconds: 0),
          crossFadeState: crossFadeState,
          firstChild: sendButton,
          secondChild: extraButton,
        );
      },
    );
  }

  Widget buildSend() {
    return Container(
      width: 60,
      height: 30,
      child: new RaisedButton(
        padding: EdgeInsets.all(0),
        color: Color(0xffFF8200),
        textColor: Colors.white,
        disabledTextColor: Colors.white,
        disabledColor: Color(0xffFFD8AF),
        elevation: 0,
        disabledElevation: 0,
        highlightElevation: 0,
        onPressed: () {
          widget.onSendCallBack?.call(mEditController.text.trim());
          mEditController.clear();
        },
        child: new Text(
          "发送",
          style: new TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }

  bool checkShowSendButton(String text) {
    if (mCurrentType == "voice") {
      return false;
    }
    if (text.trim().isNotEmpty) {
      return true;
    }
    return false;
  }

  void showSoftKey() {
    FocusScope.of(context).requestFocus(focusNode);
  }

  void hideSoftKey() {
    focusNode.unfocus();
  }

  void changeBottomHeight(final double height) {
    if (height > 0) {
      _bottomHeightController.animateTo(1);
    } else {
      _bottomHeightController.animateBack(0);
    }
  }

  Widget _buildBottomContainer({Widget child}) {
    return Visibility(
      visible: mBottomLayoutShow,
      child: Container(
        key: globalKey,
        child: child,
        height: _softKeyHeight,
      ),
    );
  }

  Widget _buildBottomItems() {
    if (this.mCurrentType == "extra") {
      return Visibility(
          visible: mAddLayoutShow,
          child: new DefaultExtraWidget(onImageSelectBack: (value) {
            widget.onImageSelectCallBack?.call(value);
          }));
    } else if (mCurrentType == "emoji") {
      return Visibility(
        visible: mEmojiLayoutShow,
        child: EmojiWidget(onEmojiClockBack: (value) {
          if (0 == value) {
            mEditController.clear();
          } else {
            mEditController.text =
                mEditController.text + String.fromCharCode(value);
          }
        }),
      );
    } else {
      return Container();
    }
  }
}

class ChangeChatTypeNotification extends Notification {
  final String type;

  ChangeChatTypeNotification(this.type);
}
