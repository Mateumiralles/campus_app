import 'package:campus_app/screens/send_mail_screen.dart';
import 'package:campus_app/widgets/received_mails_list.dart';
import 'package:campus_app/widgets/sent_mails_list.dart';
import 'package:flutter/material.dart';

class MailsScreen extends StatefulWidget {
  const MailsScreen({Key? key}) : super(key: key);

  @override
  State<MailsScreen> createState() => _MailsScreenState();
}

class _MailsScreenState extends State<MailsScreen> {
  final List<String> _folders = ['Rebuts', 'Enviats'];
  bool _inbox = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Missatges ${_inbox ? 'Rebuts' : 'Enviats'}'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Center(
              child: DropdownButton(
                items: _folders
                    .map((String e) => DropdownMenuItem(
                          value: e,
                          alignment: Alignment.centerRight,
                          child: Text(e,
                              style: const TextStyle(fontSize: 15), textAlign: TextAlign.right),
                        ))
                    .toList(),
                onChanged: (value) => {
                  setState(() {
                    value == _folders[0] ? _inbox = true : _inbox = false;
                  })
                },
                hint: const Icon(Icons.folder),
                alignment: Alignment.centerRight,
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
      body: _inbox ? const ReceivedMailsList() : const SentMailsList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return const SendMailScreen();
          }));
        },
        backgroundColor: Colors.blue,
        child: const Icon(
          Icons.draw_rounded,
          color: Colors.white,
        ),
      ),
    );
  }
}
