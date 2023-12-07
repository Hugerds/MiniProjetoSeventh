import 'package:prova_seventh/1-base/dto/video_dto.dart';

abstract class IVideoService {
  Future<VideoDTO> getUrl();
}
