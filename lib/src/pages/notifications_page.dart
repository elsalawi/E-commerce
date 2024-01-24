import 'package:flutter/material.dart';
import 'package:orders_app/src/modals/notification.dart';
import 'package:orders_app/src/pagination/bloc/pagination.dart';
import 'package:orders_app/src/pagination/model/response_model.dart';
import 'package:orders_app/src/pagination/view/pagination.dart';
import 'package:orders_app/src/repository/pagination_repository.dart';
import 'package:orders_app/src/widgets/empty.dart';
import 'package:orders_app/src/widgets/empty_records.dart';
import 'package:orders_app/src/widgets/notification_widget.dart';
import 'package:orders_app/src/widgets/spinner.dart';
import '../../generated/l10n.dart' show S;

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage>
    with TickerProviderStateMixin {
  late GlobalKey<PaginationViewState> key;
  PaginationBloc<NotificationModel>? _bloc;

  // StreamSubscription<BroadcastMessage?>? _messengerSubscription;

  @override
  void initState() {
    key = GlobalKey<PaginationViewState>();
    super.initState();
    // final _bloc = Provider.of<MessengerBloc>(context, listen: false);
    // _messengerSubscription = _bloc.messages.listen((message) {
    //   if (message != null && message.model == "notification") {
    //     _addItem(message.record);
    //   }
    // });
  }

  _addItem(NotificationModel model) {
    _bloc?.add(PaginationNewItemAddEvent<NotificationModel>(
      record: model,
    ));
  }

  @override
  void dispose() {
    // _messengerSubscription?.cancel();
    super.dispose();
  }

  _onItemClicked(NotificationModel model) {}

  Future<PaginationResponseModel<NotificationModel>> _getRoutes(
      String url, Map<String, dynamic> data) async {
    final repo = PaginationRepository();
    return repo.getPage<NotificationModel>(url, data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text(S.of(context).notifications) ,
      ),
      body: PaginationView<NotificationModel>(
        key: key,
        withAppBar: false,
        hasFilter: false,
        title: S.of(context).notifications,
        response: _getRoutes,
        padding: const EdgeInsets.all(8),
        itemBuilder: (BuildContext context, NotificationModel model, int index) =>
            NotificationWidget(
          model: model,
          onTap: _onItemClicked,
          key: Key(model.id.toString()),
        ),
        url: "/api/v3/notifications",
        modelParser: NotificationModel.parseList,
        pullToRefresh: true,
        onError: (dynamic error) => DataErrorWidget(
          title: S.of(context).ops,
          text: error.toString(),
          retry: () => _bloc!.add(PaginationRetryEvent<NotificationModel>()),
        ),
        onCreated: (bloc) {
          _bloc = bloc;
        },
        onEmpty: EmptyRecordsWidget(
          text: S.of(context).empty_notifications,
          message: S.of(context).empty_notifications_msg,
        ),
        bottomLoader: const Spinner(),
        initialLoader: const Spinner(),
      ),
    );
  }
}
