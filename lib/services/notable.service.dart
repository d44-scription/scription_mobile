import 'package:scription_mobile/http-common.dart';

class NotableService {
  // GET notables index
  Future index(int notebookId, String type) async {
    final response =
        await Http().dio.get('/notebooks/$notebookId/${type.toLowerCase()}');

    return response.data;
  }

  // GET notables recents
  Future recents(int notebookId) async {
    final response =
        await Http().dio.get('/notebooks/$notebookId/notables/recents');

    return response.data;
  }
}
