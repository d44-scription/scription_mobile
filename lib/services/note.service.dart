import 'package:scription_mobile/http-common.dart';

class NoteService {
  // GET notable notes
  Future index(notebookId, notableId) async {
    final response = notableId == null
        ? await Http().dio.get('/notebooks/$notebookId/notes/unlinked')
        : await Http()
            .dio
            .get('/notebooks/$notebookId/notables/$notableId/notes');

    return response.data;
  }
}
