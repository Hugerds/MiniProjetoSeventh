import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prova_seventh/2-app/modules/player/controllers/video_controller.dart';
import 'package:prova_seventh/2-app/utils/assets.dart';
import 'package:prova_seventh/2-app/utils/instancias.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late final VideoController controller;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    controller = GerenciadorInstancias().getInstance<VideoController>(VideoController());
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async => await controller.getUrl(context));
  }

  @override
  void dispose() {
    GerenciadorInstancias().removeInstance<VideoController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async => false,
        child: SafeArea(
          child: ListenableBuilder(
            listenable: controller,
            builder: (_, __) {
              if (controller.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (controller.isError) {
                return Center(child: Text(controller.error.value!));
              }
              return Stack(
                children: [
                  Center(
                    child: AspectRatio(
                      aspectRatio: controller.chewieController.videoPlayerController.value.aspectRatio,
                      child: Chewie(
                        controller: controller.chewieController,
                      ),
                    ),
                  ),
                  if (!controller.isFullscreen)
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Image.asset(
                        logoSeventh,
                        height: MediaQuery.of(context).size.height * 0.1,
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
