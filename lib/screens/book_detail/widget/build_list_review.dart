import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';

import 'package:mocktest/constants/color_all_app.dart';
import 'package:mocktest/constants/svg_file.dart';
import 'package:mocktest/constants/text_style_app.dart';
import 'package:mocktest/constants/url.dart';

// ignore: must_be_immutable

class BuildListReview extends StatefulWidget {
  final bool isReply;

  String avatarBuyer;
  String imgAvatarSeller;
  String nameBuyer;
  String contentBuyer;
  String contentSeller;
  String createReviewAt;
  bool isDivider;
  String imgPathBuyer;
  String imgPathSeller;
  // String videoPathBuyer;

  BuildListReview(
      {super.key,
      required this.isReply,
      required this.avatarBuyer,
      required this.imgAvatarSeller,
      required this.nameBuyer,
      required this.contentBuyer,
      required this.imgPathBuyer,
      // required this.videoPathBuyer,
      required this.contentSeller,
      required this.createReviewAt,
      required this.isDivider,
      required this.imgPathSeller});

  @override
  State<BuildListReview> createState() => _BuildListReviewState();
}

class _BuildListReviewState extends State<BuildListReview> {
  late VideoPlayerController _controller;

  String convertToDateTime(String dateTimeString) {
    DateFormat inputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");
    DateFormat outputFormat = DateFormat("dd/MM/yyyy");
    DateTime dateTime = inputFormat.parse(dateTimeString);
    String formattedDateTime = outputFormat.format(dateTime);
    return formattedDateTime;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  ),
                ),
                child: ClipOval(
                  child: Image.network(
                    URL.urlIMG + widget.avatarBuyer,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.black,
                            width: 0,
                          ),
                        ),
                        child: ClipOval(
                            child: Image.asset(
                          'assets/images/avatar.jpg',
                          fit: BoxFit.cover,
                        )),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.nameBuyer,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(SVGFile.ic_starYellow),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(convertToDateTime(widget.createReviewAt))
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            width: 12,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 62.0, bottom: 8),
            child: Text(
              widget.contentBuyer,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          widget.imgPathBuyer != [].toString()
              ? (URL.urlIMG + widget.imgPathBuyer).contains('.jpg')
                  ? Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Image.network(
                            URL.urlIMG + widget.imgPathBuyer,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        )
                      ],
                    )
                  : VideoScreen(urlVideo: URL.urlIMG + widget.imgPathBuyer)
              : const SizedBox(),

          //    haveVideo ?

          widget.isReply
              ? Padding(
                  padding: const EdgeInsets.only(left: 48.0, top: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(SVGFile.ic_SellerReplyBuyer),
                      const SizedBox(
                        width: 12,
                      ),
                      ClipOval(
                        child: Image.network(
                          URL.urlIMG + widget.imgAvatarSeller,
                          fit: BoxFit.cover,
                          width: 40,
                          height: 40,
                          errorBuilder: (context, error, stackTrace) {
                            return SvgPicture.asset(SVGFile.ic_avatar);
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Phản hồi của người bán",
                            style: TextStyleAPP.textStyle14
                                .copyWith(color: ChooseColor.colorNameSeller),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            widget.contentSeller,
                            style: TextStyleAPP.textStyle14.copyWith(
                                color: ChooseColor.colorContentReview,
                                fontWeight: FontWeight.w400),
                          ),
                          widget.imgPathSeller != [].toString()
                              ? (URL.urlIMG + widget.imgPathSeller)
                                      .contains('.jpg')
                                  ? Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 12.0),
                                      child: Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            child: Image.network(
                                              URL.urlIMG + widget.imgPathSeller,
                                              width: 100,
                                              height: 100,
                                              fit: BoxFit.cover,
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: VideoScreen(
                                          urlVideo: URL.urlIMG +
                                              widget.imgPathSeller),
                                    )
                              : const SizedBox(),
                        ],
                      )
                    ],
                  ),
                )
              : const SizedBox(),
          const SizedBox(
            height: 4,
          ),
          widget.isDivider
              ? const Padding(
                  padding: EdgeInsets.only(left: 62.0),
                  child: Divider(
                    color: ChooseColor.colorButton,
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}

class ChewiePlayer extends StatefulWidget {
  final VideoPlayerController videoPlayerController;

  const ChewiePlayer({super.key, required this.videoPlayerController});

  @override
  _ChewiePlayerState createState() => _ChewiePlayerState();
}

class _ChewiePlayerState extends State<ChewiePlayer> {
  late ChewieController _chewieController;
  bool showControlsss = false;
  
  @override
  void initState() {
    super.initState();
    _chewieController = ChewieController(
      videoPlayerController: widget.videoPlayerController,
      aspectRatio: 16 / 9,
      autoPlay: false,
      looping: false,
      startAt: Duration.zero,
      deviceOrientationsAfterFullScreen: DeviceOrientation.values,
      deviceOrientationsOnEnterFullScreen: DeviceOrientation.values,
      showControlsOnInitialize: false,
      autoInitialize: true,
      fullScreenByDefault: true,
      // showOptions: true,
      showControls: false,
      customControls: InkWell(
        onTap: () {
          _chewieController.pause();
          _chewieController.exitFullScreen();
        },
        child: Container(
          width: 30,
          height: 30,
          color: Colors.white,
          child: showControlsss ? Icon(Icons.close_fullscreen): SizedBox(),
        ),
      ),
    );

    _chewieController.addListener(() {
      if (_chewieController.isFullScreen == false) {
        _chewieController.seekTo(Duration.zero);
        _chewieController.pause();
       

      }
    });
  }

  void _togglePlayPause() async {
    _chewieController.enterFullScreen();
    showControlsss =true;
    if (_chewieController.isPlaying == false) {
      await _chewieController.play();
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadiusDirectional.circular(4),
      child: Container(
        color: Colors.black,
        child: Stack(
          fit: StackFit.expand, 
          children: [
       
          GestureDetector(
            onTap: () {
              setState(() {
                // _togglePlayPause();
              });
            },
            child: Center(
              child: Chewie(
                controller: _chewieController,
              ),
            ),
          ),
          Visibility(
            visible: !widget.videoPlayerController.value.isPlaying,
            child: SizedBox(
              width: 100,
              height: 100,
              child: IconButton(
                icon: SvgPicture.asset(SVGFile.ic_Play_Video),
                onPressed: () {
                  // _togglePlayPause();
                },
                iconSize: 50,
                color: Colors.white,
              ),
            ),
          ),
            
        ]),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    widget.videoPlayerController.dispose();
    _chewieController.dispose();
  }
}

class VideoScreen extends StatelessWidget {
  String urlVideo;
  VideoScreen({super.key, required this.urlVideo});
  @override
  Widget build(BuildContext context) {
    final VideoPlayerController videoPlayerController =
        VideoPlayerController.network(
      urlVideo,

    );

    return SizedBox(
      width: 100,
      height: 100,
      child: Stack(children: [

       
        ChewiePlayer(videoPlayerController: videoPlayerController),
         
      ]),
    );
  }
}
