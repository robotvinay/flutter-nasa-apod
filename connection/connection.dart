import "package:http/http.dart" as http;

const urlBase = "https://apodapi.herokuapp.com/";
//const baseUrl ="http://www.json-generator.com/api/json/get/cfwZmvEBbC?indent=2";

class API {
  static Future getAPOD() async {
    var url = urlBase + "/users";
    return await http.get(url);
  }
}