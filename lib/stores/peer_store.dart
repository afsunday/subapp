import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:subapp/models/peers_model.dart';
import 'package:subapp/services/user_service.dart';

class PeerStore extends ChangeNotifier {
  final String token;
  bool loading = false;
  late PeerData peerData = PeerData(
    currentPage: 0,
    data: [],
    firstPageUrl: '',
    from: 0,
    nextPageUrl: '',
    path: '',
    perPage: 0,
    prevPageUrl: '',
    to: 0,
  );

  PeerStore(this.token);

  getPeerData(context) async {
    UserService api = UserService(token);

    if ( peerData.data.isNotEmpty) {
      return;
    }

    loading = true;

    peerData = await api.getUserPeers(context);

    loading = false;
    notifyListeners();
  }

  void reHydrate() {}
}
