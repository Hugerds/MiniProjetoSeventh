import 'dart:convert';

import 'package:prova_seventh/1-base/dto/video_dto.dart';
import 'package:prova_seventh/1-base/services/base_service.dart';
import 'package:prova_seventh/1-base/services/interfaces/iplayer_service.dart';
import 'package:prova_seventh/2-app/utils/exceptions.dart';
import 'package:prova_seventh/2-app/utils/integrations.dart';

class VideoService extends BaseService implements IVideoService {
  @override
  Future<VideoDTO> getUrl() async {
    const url = "${urlAPI}video/bunny.mp4";
    final token = await getToken();
    final response = await get(url, headers: {"x-access-token": token});
    if (response.statusCode == 200) {
      return VideoDTO.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else if (response.statusCode == 404) {
      throw VideoNaoEncontradoException();
    } else {
      throw Exception();
    }
  }
}
