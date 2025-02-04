import 'dart:async';
import 'dart:convert';

import 'dart:io';

class Dog {
  final String name;
  final String location;
  final String description;
  String imageUrl;
  int rating = 10;

  Dog(this.name, this.location, this.description);

  Future getImageUrl() async {
    if (imageUrl != null) {
      return;
    }
    // Get an Image
    HttpClient http = new HttpClient();
    try {
      var uri = new Uri.http('dog.ceo', '/api/breeds/image/random');
      var request = await http.getUrl(uri);
      var response = await request.close();
      var responseBody = await response.transform(Utf8Decoder()).join();
      var json = jsonDecode(responseBody).decode(responseBody);
      var url = json['message'];
      imageUrl = url;
    } catch (exception) {
      print(exception);
    }
  }
}
