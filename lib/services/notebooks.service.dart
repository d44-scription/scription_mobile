import 'package:scription_mobile/http-common.dart';

class NotebooksService {
  // GET notebooks index
  Future index() async {
    final response = await Http().dio.get('/notebooks');

    print(response.data.toString());
  }
}
