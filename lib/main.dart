import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ClientHttp {
  Future<String> fetchData(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load data');
    }
  }
}

main() async {
  ClientHttp httpClient = ClientHttp();

  //replacement
  final replacementUrl = 'https://raw.githubusercontent.com/thewhitesoft/student-2023-assignment/4203ccd30371783a8cdbc801a5f344b8bb10c8df/replacement.json';
  final response = await httpClient.fetchData(replacementUrl);
  final jsonData = json.decode(response);
  final replacement = removeDuplicateAndSort(jsonData);

  //replaceText
  final dataUrl = 'https://raw.githubusercontent.com/thewhitesoft/student-2023-assignment/main/data.json';
  final content = await httpClient.fetchData(dataUrl);
  final completed = replaceText(content, replacement);

  writeToFile(completed);
}

List<Map<String, dynamic>> removeDuplicateAndSort(List<dynamic> jsonData) {
  List<Map<String, dynamic>> listMap = [];

  // создание структуры List<Map<String, dynamic>>
  jsonData.forEach((element) {
    if (element is Map<String, dynamic>) {
      listMap.add(
          {'replacement': element['replacement'], 'source': element['source']});
    }
  });

  //сортировка от большего к меньшему
  listMap.sort((a, b) => b['replacement'].compareTo(a['replacement']));

  //удаление повторяющихся элементов снизу
  List<int> removeIndex = [];
  for (var i = 0; i < listMap.length; ++i) {
    for (var j = i + 1; j < listMap.length; ++j) {
      if (listMap[i]['replacement'] == listMap[j]['replacement']) {
        removeIndex.add(i);
        ++i;
        continue;
      }
    }
  }

  for (var i = removeIndex.length - 1; i > -1; --i) {
    print( 'Duplicate => ${listMap[removeIndex[i]]['replacement']}');
    listMap.removeAt(removeIndex[i]);
  }
  print('\n');
  // listMap.forEach((element) {
  //   print('$element');
  // });
  return listMap;
}

String replaceText(String content, List<Map<String, dynamic>> replacementList) {
  String modifiedText = '';

  replacementList.forEach((element) {
    String searchText = element['replacement'];
    String replacementText = element['source'].toString();

    if (replacementText == 'null') {
      modifiedText = content.replaceAll(searchText, '');
    } else {
      modifiedText = content.replaceAll(searchText, replacementText);
    }
    content = modifiedText;
  });
  RegExp exp = RegExp(r'\s{2}"",\s');
  RegExp delQuotationMarks = RegExp(r',\s{0,6}""');
  content = content.replaceAll(exp, '');
  content = content.replaceAll(delQuotationMarks, '');
  print('content=>\n $content');
  return content;
}

void writeToFile(String text) {
  final File file = File('correction.txt');

  try {
    file.writeAsStringSync(text);
    print('file.path => ${file.path}');
  } catch (e) {
    print('Error: $e');
  }
}