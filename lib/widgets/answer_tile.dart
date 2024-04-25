import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:miraijapanese/constraints/app_colors.dart';

class AnswerTile extends StatefulWidget {
  final String answer;
  final Color color;
  final Color textColor;
  final Color borderColor;
  final Icon customIcon;
  final String answerVoice;
  final String answerImage;
  const AnswerTile({
    super.key,
    required this.answer,
    required this.color,
    required this.textColor,
    required this.borderColor,
    required this.customIcon,
    required this.answerVoice,
    required this.answerImage,
  });

  @override
  State<AnswerTile> createState() => _AnswerTileState();
}

class _AnswerTileState extends State<AnswerTile> {
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    super.initState();
    audioPlayer.onPlayerStateChanged.listen((event) {
      if (mounted) {
        setState(() {
          isPlaying = event == PlayerState.playing;
        });
      }
    });

    audioPlayer.onDurationChanged.listen((newDuration) {
      if (mounted) {
        setState(() {
          duration = newDuration;
        });
      }
    });

    audioPlayer.onPositionChanged.listen((newDuration) {
      if (mounted) {
        setState(() {
          position = newDuration;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    audioPlayer.dispose();
  }

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minuts = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return [
      if (duration.inHours > 0) hours,
      minuts,
      seconds,
    ].join(':');
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth,
      //height: 50,
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: widget.color,
        border: Border.all(
          color: widget.borderColor,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                widget.answer,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: widget.textColor,
                ),
              ),
              Spacer(),
              widget.customIcon,
            ],
          ),
          widget.answerImage.isNotEmpty || widget.answerVoice.isNotEmpty
              ? SizedBox(
                  height: 10,
                )
              : SizedBox(),
          widget.answerImage.isNotEmpty
              ? Container(
                  width: screenWidth,
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.lowAccentColor,
                    border: Border.all(
                      color: AppColors.textGrayColor,
                      width: 0.5,
                    ),
                    image: DecorationImage(
                      image: NetworkImage(widget.answerImage),
                    ),
                  ),
                )
              : SizedBox(),
          widget.answerVoice.isNotEmpty
              ? Container(
                  width: screenWidth,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.lowAccentColor,
                    border: Border.all(
                      color: AppColors.textGrayColor,
                      width: 0.5,
                    ),
                  ),
                  child: Column(
                    children: [
                      Spacer(),
                      Slider(
                        min: 0,
                        max: duration.inSeconds.toDouble(),
                        value: position.inSeconds.toDouble(),
                        onChanged: (value) async {
                          final position = Duration(seconds: value.toInt());
                          await audioPlayer.seek(position);

                          await audioPlayer.resume();
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          children: [
                            Text(
                              formatTime(position),
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: AppColors.textBlackColor,
                              ),
                            ),
                            Spacer(),
                            Text(
                              formatTime(duration - position),
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: AppColors.textBlackColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: AppColors.accentColor,
                        child: IconButton(
                          onPressed: () async {
                            if (isPlaying) {
                              await audioPlayer.pause();
                            } else {
                              await audioPlayer.play(UrlSource(
                                widget.answerVoice,
                              ));
                            }
                          },
                          icon: Icon(
                            isPlaying ? Icons.pause : Icons.play_arrow,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                )
              : SizedBox()
        ],
      ),
    );
  }
}
