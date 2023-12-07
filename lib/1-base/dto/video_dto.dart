import 'package:json_annotation/json_annotation.dart';

part 'video_dto.g.dart';

@JsonSerializable()
class VideoDTO {
  final String url;

  VideoDTO({required this.url});

  factory VideoDTO.fromJson(Map<String, dynamic> json) => _$VideoDTOFromJson(json);

  Map<String, dynamic> toJson() => _$VideoDTOToJson(this);
}
