import 'dart:convert';
import 'dart:io';

import 'package:mockito/annotations.dart';
import 'package:restoring_file_WS/main.dart';
import 'package:test/test.dart';
import 'package:http/http.dart' as http;

import 'variable/main_var.dart';

@GenerateMocks([ClientHttp, http.Client])

void main() {
  String? resultJson;

  setUp(() async {
    resultJson = await File('test/lib/variable/result.json').readAsString();
  });

  group(
    'removeDuplicateAndSort(List<dynamic> jsonData)',
    () => {
      test('test an empty list', () {
        //setup
        List<dynamic> jsonData = [];

        //run
        var value = removeDuplicateAndSort(jsonData);

        //verify
        expect(value, equals([]));
      }),
      test('test an invalid list', () {
        List<dynamic> jsonData = ['\t [{}], \n {:} invalid json format'];

        var value = removeDuplicateAndSort(jsonData);

        expect(value, equals([]));
      }),
      test('test sorting and removing double repeats', () {
        var value = removeDuplicateAndSort(doubleRepeatsList);

        expect(value, equals(outputList));
      }),
      test('test multiple repetition, zero values... (all possible options depending on the task + sorting)', () {
        var value = removeDuplicateAndSort(replacementList);

        expect(value, equals(actualOutput));
      })
    },
  );

  group(
    'replaceText(String content, List<Map<String, dynamic>> replacementList)',
    () => {
      test('Test replace text with valid replacementList', () {
        //setup
        String content = 'Hi, if you\'re reading this, you\'re a good person. ';
        List<Map<String, dynamic>> replacementList = [
          {"replacement": "Hi", "source": "Hello"},
          {"replacement": "good", "source": "wonderful"},
        ];

        //run
        var value = replaceText( content, replacementList);

        //verify
        expect(value, equals('Hello, if you\'re reading this, you\'re a wonderful person. '));
      }),
      test('Test replace text with null ', () {
        //setup
        String content = 'Hi, if you\'re reading this, you\'re a good person. ';
        List<Map<String, dynamic>> replacementList = [
          {"replacement": "Hi", "source": null},
          {"replacement": "good", "source": null},
        ];

        //run
        var value = replaceText( content, replacementList);

        //verify
        expect(value, equals(', if you\'re reading this, you\'re a  person. '));
      }),
      test('Multiple word replacement test', () {
        //setup
        String content = 'Hi,Hi HiHello if you\'re reading this, you\'re a good_person.';
        List<Map<String, dynamic>> replacementList = [
          {"replacement": "Hi", "source": null},
          {"replacement": "good", "source": null},
        ];

        //run
        var value = replaceText( content, replacementList);

        //verify
        expect(value, equals(', Hello if you\'re reading this, you\'re a _person.'));
      }),
    },
  );


  test('final testing, conversion of data received from the API and comparison with the original', () async {
    //setup
    // final mockClient = MockClientHttp();
    ClientHttp httpClient = ClientHttp();
    final replacementUrl = 'https://raw.githubusercontent.com/thewhitesoft/student-2023-assignment/4203ccd30371783a8cdbc801a5f344b8bb10c8df/replacement.json';

    // when(mockClient.fetchData(url)).thenAnswer(
    //       (_) async => http.Response(response, 200).body,
    // );

    //run
    final response = await httpClient.fetchData(replacementUrl);
    final jsonData = json.decode(response);
    final replacement = removeDuplicateAndSort(jsonData);

    final dataUrl = 'https://raw.githubusercontent.com/thewhitesoft/student-2023-assignment/main/data.json';
    final content = await httpClient.fetchData(dataUrl);
    final completed = replaceText(content, replacement);

    //verify
    expect(jsonDecode(completed), jsonDecode(resultJson ?? '') );
  });
  tearDown(() async {
    resultJson = null;
  });
}
