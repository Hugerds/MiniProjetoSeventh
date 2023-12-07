import 'package:chewie/chewie.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:prova_seventh/1-base/services/interfaces/iplayer_service.dart';
import 'package:prova_seventh/2-app/utils/instancias.dart';
import 'package:video_player/video_player.dart';

class VideoController extends ChangeNotifier {
  late final VideoPlayerController _videoPlayerController;
  late final ChewieController _chewieController;
  late final IVideoService _videoService;
  late ValueNotifier<bool> _loading;
  late ValueNotifier<String?> _error;
  late ValueNotifier<bool> _fullscreen;

  VideoController() {
    _videoService = GerenciadorInstancias().getInstance<IVideoService>();
    _loading = ValueNotifier<bool>(true);
    _fullscreen = ValueNotifier<bool>(false);
    _error = ValueNotifier<String?>(null);
  }

  //Getters
  ChewieController get chewieController => _chewieController;
  ValueNotifier<bool> get loading => _loading;
  bool get isLoading => _loading.value;
  ValueNotifier<String?> get error => _error;
  bool get isError => _error.value != null;
  ValueNotifier<bool> get fullscreen => _fullscreen;
  bool get isFullscreen => _fullscreen.value;

  Future<void> getUrl(BuildContext context) async {
    try {
      final response = await _videoService.getUrl();
      if (!context.mounted) throw Exception();
      _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(response.url));
      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        autoPlay: true,
        allowPlaybackSpeedChanging: false,
        allowMuting: false,
        showOptions: false,
        deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
        deviceOrientationsOnEnterFullScreen: [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight],
        errorBuilder: (_, __) => const Text("Não foi possível carregar o vídeo"),
        allowedScreenSleep: false,
        fullScreenByDefault: true,
      );

      /// Listener para verificar se o vídeo está em fullscreen
      _chewieController.addListener(() {
        if (_chewieController.isFullScreen) {
          _fullscreen.value = true;
        } else {
          _fullscreen.value = false;
        }
        notifyListeners();
      });
    } on FormatException catch (e) {
      _error.value = e.message;
    } catch (_) {
      _error.value = "Não foi possível carregar o vídeo";
    } finally {
      _loading.value = false;
      notifyListeners();
    }
  }
}
