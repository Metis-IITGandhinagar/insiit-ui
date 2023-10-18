import 'package:gsheets/gsheets.dart';

class UserSheetsApi {
  // your spreadsheet id
  static const _spreadsheetId = r'1EyL7b6bY0MNQ2DtGt67PLX8si1hv6jwX8f-WvFVYuG8';
  static const _credentials = r'''
      {
  "type": "service_account",
  "project_id": "insiit-iitgn-2cd16",
  "private_key_id": "e78fa297fbb05d348314a64f409081d2513cea09",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDg3QS+4DpkLNg+\nTCavzJAJO7KBcPHokMgepm7SX+VZfubYNv3PmJcZZpVAbBB/4IqzU50B/MuagCD8\n+ye3/X3v+faGoNq7E2RcAqI/pddQUDLHNu3wWWmkdl7xi+oTF+9RrXoM8yZ+bJwr\nL+eVGMQyo1fCCIzJb1BQDTCZZJiqR4Xlz9hDVHNtL65FSrXSHw6oXWWI6TT0OeRY\n664J3lA9HETPCXQXGSWFv6rPCBHrI3Eh5orDimorTNBP1t2QUUsSLvKx3Dgr+KIG\nSZtGgq56R/TzOIS17O133XIttsPuRwfLQfrD4UwcYT3s4HVIHnaK47BAbCR5aGc6\nbLrgS99NAgMBAAECggEABoRxbETcfGXOWLPlVSgVLqdTy6ul30s++aBySterspXa\ng/7ICXnPO1W9UrIvIj20V3E/djzI++/lxN9UreEDgu6YRhuoa06rFH2hDT41yOai\nKiL9737v8Gvb4Z1gCfCiJ5hjFrf/cB+ewSOwzyH6IcuZMg8EYZw/1Cols/R19k1x\nekmLMyhDhNoCRosxzB6zxQ99Iff1/pvQhsmPAtBnJYLZk02dydvEUaojWFbIaV2Z\n6jk7tKpz9FuE/evOXvlbizLQodIma9qQpnRTqKobyMPS53MOEr1Jv4NSEVHuq+tk\n8zDbDpmVim2KsRQn2pzQJie/73giNWTvNllarW/6wwKBgQD3rTMjGpU3JBbc7WGA\nODkFC857G/34HrMQvan6mgObIGoWWGzfamo13xlhqnTANt4K6KQZbvrNKpgVcl4j\ng6qvmY37TO6z2rwjSTolR3dLC82xfyLO1Z8Q587B7+HcL6H7czlIVlcRF2tHvLOE\nJ5HlkCzedfHSGC3k6x3oIzWKkwKBgQDoa42daYKQb2+YDt5QciQMNEbr2KggQMOF\n9sFsxBk/Q+pNcLkj356sEmfihFBe9ZEJQR+uVBFh/38cYYIfF0RbHCBqmzP4WxOX\nVPOuvJDR5P7KDd2TIfT7HY8dlx5KN0HOVk7hRGpWguT22IbYFzovaJE0ry1XxFWV\negWSJLS6nwKBgCNCgw8yT5/kAWU+Xi0U0/lF7wVTvNo/9JojhjlpB65j9PZtbEJ6\nMdithD2FOM3MgdvntsTwKcBfmfsjpwdDTV9mavIlx63PLA2R9Tctb2w9p/Dm+pub\nieOsPKEbd3oTReo4QyVrNUX3oYw67wuXXovh9KFPBTg1vQLj/gP4Tz0FAoGBANrO\nNloVNKfJYSOkC8NsUWdz57itFUqX7fq2XU6KJsKaq4AQORv+sCCKi2aC7i8XvF0c\nBDlYR60cnYwYeCnQ+7dSeWojhv+urnjvryG3wBb6IKwT9Z9IfpvSLiPLWua/sqIQ\nOt50TC/5tph1LC1PYKW1Kc6RhHx2B6RbZdc52zM9AoGBAPd0L01vcDOj3QyiJShK\nt0FmPGxoFLWlv+OZReNI0HNrfNljdONYnK1bbW/RUCf4HdtSqLttqVWxcrp4RMd4\nk2fZYvzZHBEif8iCHjgPpu79nFY7DhPvDUupjYHdUSpC0wponfN0lrsrVCHraInW\njoDWNER0NxxRxFz4vD9ExxSB\n-----END PRIVATE KEY-----\n",
  "client_email": "iitgn-mess@insiit-iitgn-2cd16.iam.gserviceaccount.com",
  "client_id": "102487331349415039547",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/iitgn-mess%40insiit-iitgn-2cd16.iam.gserviceaccount.com"
}
    ''';

  static final _gsheets = GSheets(_credentials);
  static Worksheet? _userSheet;

  static Future init() async {
    final spreadSheets = await _gsheets.spreadsheet(_spreadsheetId);
    // get worksheet
    _userSheet = await _getWorksheet(spreadSheets, title: "Sheet1");
  }

  static Future<Worksheet?> _getWorksheet(Spreadsheet spreadsheet,
      {required String title}) async {
    // print(spreadsheet.worksheetByTitle(title));
    return spreadsheet.worksheetByTitle(title);
  }

  static Future getMessMenu(int weekDay, String mealName) async {
    // print(weekDay);
    //   print(weekDay);
    //   print(mealName);
    if (mealName == "Breakfast") {
      // print(_userSheet?.values.column(weekDay, fromRow: 3, length: 9));
      // print(_userSheet?.values.column(6));
      return _userSheet?.values.column(weekDay, fromRow: 3, length: 9);
    } else if (mealName == "Lunch") {
      return _userSheet?.values
          .column(weekDay, fromRow: 14, length: (22 - 14 + 1));
    } else if (mealName == "Snacks") {
      return _userSheet?.values
          .column(weekDay, fromRow: 25, length: (28 - 25 + 1));
    } else if (mealName == "Dinner") {
      return _userSheet?.values
          .column(weekDay, fromRow: 31, length: (40 - 31 + 1));
    }
  }
}
