import 'package:flutter/material.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:intl/intl.dart'; // For date formatting
import '../../Profile.dart';

class SmsReaderScreen extends StatefulWidget {
  @override
  _SmsReaderScreenState createState() => _SmsReaderScreenState();
}

class _SmsReaderScreenState extends State<SmsReaderScreen> {
  final SmsQuery _smsQuery = SmsQuery();
  List<SmsMessage> _filteredMessages = [];

  @override
  void initState() {
    super.initState();
    _requestPermissionAndFetchSms();
  }

  /// Requests SMS permission and fetches SMS messages if granted.
  Future<void> _requestPermissionAndFetchSms() async {
    var status = await Permission.sms.request();
    if (status.isGranted) {
      _fetchFilteredSms();
    } else {
      setState(() {
        _filteredMessages = [];
      });
    }
  }

  /// Fetches all inbox messages and filters those containing "exp".
  Future<void> _fetchFilteredSms() async {
    List<SmsMessage> messages = await _smsQuery.querySms(
      kinds: [SmsQueryKind.inbox], // Fetch only inbox messages
    );

    // Filter messages that contain the word "exp"
    List<SmsMessage> filteredMessages = messages.where((sms) {
      bool containsExp = sms.body?.toLowerCase().contains("50%
      ") ?? false;
      return containsExp;
    }).toList();

    setState(() {
      _filteredMessages = filteredMessages;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _filteredMessages.isEmpty
          ? const Center(
              child: Text(
                "No messages found with 'expiry'.",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(8.0),
              itemCount: _filteredMessages.length,
              itemBuilder: (context, index) {
                SmsMessage sms = _filteredMessages[index];
                return Card(
                  elevation: 3,
                  margin: EdgeInsets.symmetric(vertical: 5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blueAccent,
                      child: Icon(Icons.message, color: Colors.white),
                    ),
                    title: Text(
                      sms.address ?? "Unknown Sender",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(sms.body ?? "No content"),
                    trailing: Text(
                      DateFormat('hh:mm a').format(sms.date ?? DateTime.now()),
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
