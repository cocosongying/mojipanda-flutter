import 'package:flutter/material.dart';
import 'package:mojipanda/common/resource_mananger.dart';
import 'package:mojipanda/generated/l10n.dart';
import 'package:mojipanda/provider/view_state.dart';

class ViewStateBusyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

class ViewStateWidget extends StatelessWidget {
  final String title;
  final String message;
  final Widget image;
  final Widget buttonText;
  final String buttonTextData;
  final VoidCallback onPressed;

  ViewStateWidget({
    Key key,
    this.image,
    this.title,
    this.message,
    this.buttonText,
    this.buttonTextData,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var titleStyle =
        Theme.of(context).textTheme.headline3.copyWith(color: Colors.grey);
    var messageStyle = titleStyle.copyWith(
        color: titleStyle.color.withOpacity(0.7), fontSize: 14);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        image ?? Icon(IconFonts.pageError, size: 80, color: Colors.grey[500]),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(title ?? S.of(context).viewStateMessageError,
                  style: titleStyle),
              SizedBox(
                height: 20,
              ),
              ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 200, minHeight: 150),
                child: SingleChildScrollView(
                  child: Text(
                    message ?? '',
                    style: messageStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
        Center(
          child: ViewStateButton(
            child: buttonText,
            textData: buttonTextData,
            onPressed: onPressed,
          ),
        ),
      ],
    );
  }
}

class ViewStateUnAuthWidget extends StatelessWidget {
  final String message;
  final Widget image;
  final Widget buttonText;
  final VoidCallback onPressed;

  const ViewStateUnAuthWidget(
      {Key key,
      this.image,
      this.message,
      this.buttonText,
      @required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewStateWidget(
      onPressed: this.onPressed,
      image: image ?? ViewStateUnAuthImage(),
      title: message ?? S.of(context).viewStateMessageUnAuth,
      buttonText: buttonText,
      buttonTextData: S.of(context).viewStateButtonLogin,
    );
  }
}

class ViewStateErrorWidget extends StatelessWidget {
  final ViewStateError error;
  final String title;
  final String message;
  final Widget image;
  final Widget buttonText;
  final String buttonTextData;
  final VoidCallback onPressed;

  const ViewStateErrorWidget({
    Key key,
    @required this.error,
    this.image,
    this.title,
    this.message,
    this.buttonText,
    this.buttonTextData,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var defaultImage;
    var defaultTitle;
    var errorMessage = error.message;
    String defaultTextData = S.of(context).viewStateButtonRetry;
    switch (error.errorType) {
      case ViewStateErrorType.networkTimeOutError:
        defaultImage = Transform.translate(
          offset: Offset(-50, 0),
          child: const Icon(IconFonts.pageNetworkError,
              size: 100, color: Colors.grey),
        );
        defaultTitle = S.of(context).viewStateMessageNetworkError;
        // errorMessage = ''; // 网络异常移除message提示
        break;
      case ViewStateErrorType.defaultError:
        defaultImage =
            const Icon(IconFonts.pageError, size: 100, color: Colors.grey);
        defaultTitle = S.of(context).viewStateMessageError;
        break;

      case ViewStateErrorType.unauthorizedError:
        return ViewStateUnAuthWidget(
          image: image,
          message: message,
          buttonText: buttonText,
          onPressed: onPressed,
        );
    }

    return ViewStateWidget(
      onPressed: this.onPressed,
      image: image ?? defaultImage,
      title: title ?? defaultTitle,
      message: message ?? errorMessage,
      buttonTextData: buttonTextData ?? defaultTextData,
      buttonText: buttonText,
    );
  }
}

class ViewStateEmptyWidget extends StatelessWidget {
  final String message;
  final Widget image;
  final Widget buttonText;
  final VoidCallback onPressed;

  const ViewStateEmptyWidget(
      {Key key,
      this.image,
      this.message,
      this.buttonText,
      @required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewStateWidget(
      onPressed: this.onPressed,
      image: image ??
          const Icon(IconFonts.pageEmpty, size: 100, color: Colors.grey),
      title: message ?? S.of(context).viewStateMessageEmpty,
      buttonText: buttonText,
      buttonTextData: S.of(context).viewStateButtonRefresh,
    );
  }
}

class ViewStateUnAuthImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'loginLogo',
      child: Image.asset(
        ImageHelper.wrapAssets('login_logo.png'),
        width: 130,
        height: 100,
        fit: BoxFit.fitWidth,
        color: Theme.of(context).accentColor,
        colorBlendMode: BlendMode.srcIn,
      ),
    );
  }
}

class ViewStateButton extends StatelessWidget {
  final String textData;
  final Widget child;
  final VoidCallback onPressed;

  const ViewStateButton({@required this.onPressed, this.child, this.textData})
      : assert(child == null || textData == null);

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      child: child ??
          Text(
            textData ?? S.of(context).viewStateButtonRetry,
            style: TextStyle(wordSpacing: 5),
          ),
      textColor: Colors.grey,
      splashColor: Theme.of(context).splashColor,
      onPressed: onPressed,
      highlightedBorderColor: Theme.of(context).splashColor,
    );
  }
}
