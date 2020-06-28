import 'package:flutter/material.dart';
import 'package:mojipanda/blocs/bloc_provider.dart';

import 'package:mojipanda/blocs/bloc_index.dart';

class Event {
  static void sendAppEvent(BuildContext context, int id) {
    BlocProvider.of<ApplicationBloc>(context).sendAppEvent(id);
  }
}
