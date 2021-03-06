import 'package:campus_app/citm.dart';
import 'package:campus_app/screens/mail_detail_screen.dart';
import 'package:flutter/material.dart';

class ReceivedMailsList extends StatefulWidget {
  const ReceivedMailsList({Key? key}) : super(key: key);

  @override
  State<ReceivedMailsList> createState() => _ReceivedMailsListState();
}

class _ReceivedMailsListState extends State<ReceivedMailsList> {
  List<Mail> receivedMails = [];
  int numPages = 1;
  int currPage = 0;
  bool _loaded = false;

  getFirstMailListPage() async {
    numPages = await CITM.mailsPageCount(folder: 'Received');
    currPage = 0;
    List<Mail> loadedMessages = await CITM.getMailListPage("0", currPage);
    currPage++;
    setState(() {
      receivedMails = loadedMessages;
      _loaded = true;
    });
  }

  getNextMailListPage() async {
    List<Mail> loadedMessages = await CITM.getMailListPage("0", currPage);
    currPage++;
    setState(() {
      receivedMails.addAll(loadedMessages);
    });
  }

  @override
  void initState() {
    super.initState();
    getFirstMailListPage();
  }

  bool _onScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification) {
      getNextMailListPage();
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return _loaded
        ? NotificationListener<ScrollNotification>(
            onNotification: _onScrollNotification,
            child: ListView.separated(
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            MailDetailScreen(mail: receivedMails[index])));
                  },
                  child: Container(
                    color: receivedMails[index].unread
                        ? Colors.blue.shade50
                        : Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: receivedMails[index].unread
                                ? const Icon(Icons.mark_email_unread_rounded,
                                    color: Colors.blue)
                                : const Icon(
                                    Icons.email_rounded,
                                    color: Colors.grey,
                                  ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    receivedMails[index].time.minute >= 10
                                        ? Text(
                                            '${receivedMails[index].time.day}/${receivedMails[index].time.month}/${receivedMails[index].time.year} - ${receivedMails[index].time.hour}:${receivedMails[index].time.minute}',
                                            style: TextStyle(
                                                color: Colors.grey.shade600,
                                                fontSize: 12),
                                          )
                                        : Text(
                                            '${receivedMails[index].time.day}/${receivedMails[index].time.month}/${receivedMails[index].time.year} - ${receivedMails[index].time.hour}:0${receivedMails[index].time.minute}',
                                            style: TextStyle(
                                                color: Colors.grey.shade600,
                                                fontSize: 12),
                                          ),
                                    Text(
                                      receivedMails[index].author,
                                      style: TextStyle(
                                          color: Colors.grey.shade600,
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 3),
                                Text(receivedMails[index].subject,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.left),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
              itemCount: receivedMails.length,
              separatorBuilder: (context, index) {
                return Divider(
                  color: Colors.blue.shade100,
                  thickness: 1,
                  height: 1,
                );
              },
            ),
          )
        : const Center(child: CircularProgressIndicator());
  }
}
