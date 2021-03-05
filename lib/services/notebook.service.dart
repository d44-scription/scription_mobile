import 'package:scription_mobile/http-common.dart';

class NotebookService {
  // GET notebooks index
  Future index() async {
    final response = await Http().dio.get('/notebooks');

    return response.data;
  }
}
