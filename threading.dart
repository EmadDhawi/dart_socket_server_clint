import 'dart:convert';
import 'dart:io';

void main() async {
  f1();
  f2();
  f3();
}

Stream<String> readLine() => stdin.transform(utf8.decoder).transform(const LineSplitter());

Future<void> f1() async {
  await readLine().listen((d) {
    print(d);
  });
}

void f2() {
  print("f2");
}

void f3() async {
  while (true) {
    await Future.delayed(Duration(seconds: 10));
    print("f3");
  }
}
