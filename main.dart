import 'dart:convert';
import 'dart:io';

main() async {
  final replacementUrl =
      'https://raw.githubusercontent.com/thewhitesoft/student-2023-assignment/4203ccd30371783a8cdbc801a5f344b8bb10c8df/replacement.json';
  final response = await HttpClient().getUrl(Uri.parse(replacementUrl));
  final httpResponse = await response.close();

  if (httpResponse.statusCode == HttpStatus.ok) {
    final content = await utf8.decodeStream(httpResponse);
    final jsonData = await json.decode(content);
    final replacement = removeDuplicateAndSort(jsonData);

    final dataUrl =
        'https://raw.githubusercontent.com/thewhitesoft/student-2023-assignment/main/data.json';
    final responseData = await HttpClient().getUrl(Uri.parse(dataUrl));
    final httpResponseData = await responseData.close();
    if (httpResponseData.statusCode == HttpStatus.ok) {
      final content = await utf8.decodeStream(httpResponseData);
      final jsonData = await json.decode(content);

      final rereplaceText = replaceText(content, replacement);

      writeToFile(rereplaceText);
    } else {
      print(
          'Не удалось получить файл. Код состояния: ${httpResponse.statusCode}');
    }
  } else {
    print(
        'Не удалось получить файл. Код состояния: ${httpResponse.statusCode}');
  }
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
      }
    }
  }
  for (var i = removeIndex.length - 1; i > 0; --i) {
    print( 'Duplicate => ${listMap[removeIndex[i]]['replacement']}');
    listMap.removeAt(removeIndex[i]);
  }
  print('\n');
  listMap.forEach((element) {
    print('$element');
  });
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
  RegExp exp = RegExp(r'\s{2}\"\".?\s');
  content = content.replaceAll(exp, '');
  print('content=> $content');
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