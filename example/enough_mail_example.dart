import 'dart:io';

import 'package:enough_mail/enough_mail.dart';

void main() async {
  var client = ImapClient(isLogEnabled: false);
  await client.connectToServer('imap.domain.com', 993, isSecure: true);
  var loginResponse = await client.login('user.name', 'password');
  if (loginResponse.isOkStatus) {
    var listResponse = await client.listMailboxes();
    if (listResponse.isOkStatus) {
      print('mailboxes: ${listResponse.result}');
    }
    var inboxResponse = await client.selectInbox();
    if (inboxResponse.isOkStatus) {
      // fetch 10 most recent messages:
      var fetchResponse = await client.fetchRecentMessages(
          messageCount: 10, criteria: 'BODY.PEEK[]');
      if (fetchResponse.isOkStatus) {
        for (var message in fetchResponse.result) {
          print(
              'from: ${message.from} with subject "${message.decodeSubject()}"');
          if (!message.isPlainTextMessage()) {
            print(' content-type: ${message.mediaType}');
          } else {
            var plainText = message.decodePlainTextPart();
            if (plainText != null) {
              var lines = plainText.split('\r\n');
              for (var line in lines) {
                if (line.startsWith('>')) {
                  // break when quoted text starts
                  break;
                }
                print(line);
              }
            }
          }
        }
      }
    }
    await client.logout();
  }
  exit(0);
}
