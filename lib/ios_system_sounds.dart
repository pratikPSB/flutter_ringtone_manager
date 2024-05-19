/// Default iOS system sound IDs
enum SystemSoundID {
  newMail,
  mailSent,
  voicemailReceived,
  receivedMessage,
  sentMessage,
  alarm,
  lowPower,
  smsReceived,
  smsSent,
  tweetSent,
  anticipate,
  bloom,
  calypso,
  chooChoo,
  descent,
  fanfare,
  ladder,
  minuet,
  newsFlash,
  noir,
  sherwoodForest,
  spell,
  suspense,
  telegraph,
  tiptoes,
  typewriters,
  update,
  ussdAlert,
  simToolkitCallDropped,
}

extension SystemSoundIDExtension on SystemSoundID {
  int get value {
    switch (this) {
      case SystemSoundID.newMail:
        return 1000;
      case SystemSoundID.mailSent:
        return 1001;
      case SystemSoundID.voicemailReceived:
        return 1002;
      case SystemSoundID.receivedMessage:
        return 1003;
      case SystemSoundID.sentMessage:
        return 1004;
      case SystemSoundID.alarm:
        return 1005;
      case SystemSoundID.lowPower:
        return 1006;
      case SystemSoundID.smsReceived:
        return 1007;
      case SystemSoundID.smsSent:
        return 1008;
      case SystemSoundID.tweetSent:
        return 1009;
      case SystemSoundID.anticipate:
        return 1010;
      case SystemSoundID.bloom:
        return 1011;
      case SystemSoundID.calypso:
        return 1012;
      case SystemSoundID.chooChoo:
        return 1013;
      case SystemSoundID.descent:
        return 1014;
      case SystemSoundID.fanfare:
        return 1015;
      case SystemSoundID.ladder:
        return 1016;
      case SystemSoundID.minuet:
        return 1017;
      case SystemSoundID.newsFlash:
        return 1018;
      case SystemSoundID.noir:
        return 1019;
      case SystemSoundID.sherwoodForest:
        return 1020;
      case SystemSoundID.spell:
        return 1021;
      case SystemSoundID.suspense:
        return 1022;
      case SystemSoundID.telegraph:
        return 1023;
      case SystemSoundID.tiptoes:
        return 1024;
      case SystemSoundID.typewriters:
        return 1025;
      case SystemSoundID.update:
        return 1026;
      case SystemSoundID.ussdAlert:
        return 1027;
      case SystemSoundID.simToolkitCallDropped:
        return 1028;
      default:
        throw Exception('Unknown SystemSoundID');
    }
  }
}
