import 'package:http/http.dart';
import 'json.dart';

typedef ResponseMapper<T> = T Function(Response json);

class ResponseHandler<T> {
  const ResponseHandler(this.accept, this.map);

  final String accept;
  final ResponseMapper<T> map;
}

ResponseHandler<T> jsonMapper<T>(T Function(Json jsonObject) mapper) => 
    ResponseHandler('application/json', (Response response) => mapper(Json.fromString(response.body)));
ResponseHandler<T> jsonObjectMapper<T>(T Function(JsonObject jsonObject) mapper) => 
    ResponseHandler<T>('application/json', (Response response) => mapper(Json.fromString(response.body).asObject()));
