import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:miraijapanese/constraints/app_colors.dart';
import 'package:miraijapanese/providers/quiz/question_provider.dart';
import 'package:miraijapanese/widgets/answer_tile.dart';
import 'package:provider/provider.dart';

class SingleQuestionScreen extends StatefulWidget {
  final String questionNumber;
  final String question;
  final String answer1;
  final String answer2;
  final String answer3;
  final String correctAnswer;
  //Images
  final String questionImage;
  final String answer1Image;
  final String answer2Image;
  final String answer3Image;
  //Voice
  final String questionVoice;
  final String answer1Voice;
  final String answer2Voice;
  final String answer3Voice;
  const SingleQuestionScreen(
      {super.key,
      required this.questionNumber,
      required this.question,
      required this.answer1,
      required this.answer2,
      required this.answer3,
      required this.correctAnswer,
      required this.questionImage,
      required this.answer1Image,
      required this.answer2Image,
      required this.answer3Image,
      required this.questionVoice,
      required this.answer1Voice,
      required this.answer2Voice,
      required this.answer3Voice});

  @override
  State<SingleQuestionScreen> createState() => _SingleQuestionScreenState();
}

class _SingleQuestionScreenState extends State<SingleQuestionScreen> {
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  bool isSelected1 = false;
  bool isSelected2 = false;
  bool isSelected3 = false;

  @override
  void initState() {
    super.initState();
    audioPlayer.onPlayerStateChanged.listen((event) {
      setState(() {
        isPlaying = event == PlayerState.playing;
      });
    });

    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    audioPlayer.onPositionChanged.listen((newDuration) {
      setState(() {
        position = newDuration;
      });
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
    return Consumer(
      builder: (BuildContext context, QuestionProvider questionProvider,
              Widget? child) =>
          Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.question,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              fontSize: 18,
              color: AppColors.textBlackColor,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          widget.questionImage.isEmpty
              ? SizedBox()
              : Container(
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
                      image: NetworkImage(widget.questionImage),
                    ),
                  ),
                ),
          widget.questionVoice.isEmpty
              ? SizedBox()
              : Container(
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
                                widget.questionVoice,
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
                ),
          SizedBox(
            height: 25,
          ),
          Text(
            'Answers',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: AppColors.textGrayColor,
            ),
          ),
          Divider(),
          GestureDetector(
            onTap: () {
              if (questionProvider.isAnswerSelected == true) {
                print("You Already Selected A Answer!");
              } else {
                questionProvider.checkAnswerCorrectOrNot(
                    widget.correctAnswer, widget.answer1);
                setState(() {
                  questionProvider.selectedAnswer = widget.answer1;
                  questionProvider.isAnswerSelected = true;
                });
              }
            },
            child: AnswerTile(
              answer: widget.answer1,
              color: questionProvider.selectedAnswer == widget.answer1
                  ? widget.correctAnswer == widget.answer1
                      ? Colors.green
                      : Colors.red
                  : Colors.white,
              textColor: questionProvider.selectedAnswer == widget.answer1
                  ? Colors.white
                  : AppColors.textBlackColor,
              borderColor: AppColors.borderColor,
              customIcon: questionProvider.selectedAnswer == widget.answer1
                  ? widget.correctAnswer == widget.answer1
                      ? Icon(
                          Icons.done,
                          color: Colors.white,
                        )
                      : Icon(
                          Icons.close,
                          color: Colors.white,
                        )
                  : Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
              answerVoice: widget.answer1Voice,
              answerImage: widget.answer1Image,
            ),
          ),
          GestureDetector(
            onTap: () {
              if (questionProvider.isAnswerSelected == true) {
                print("You Already Selected A Answer!");
              } else {
                questionProvider.checkAnswerCorrectOrNot(
                    widget.correctAnswer, widget.answer2);
                setState(() {
                  questionProvider.selectedAnswer = widget.answer2;
                  questionProvider.isAnswerSelected = true;
                });
              }
            },
            child: AnswerTile(
              answer: widget.answer2,
              color: questionProvider.selectedAnswer == widget.answer2
                  ? widget.correctAnswer == widget.answer2
                      ? Colors.green
                      : Colors.red
                  : Colors.white,
              textColor: questionProvider.selectedAnswer == widget.answer2
                  ? Colors.white
                  : AppColors.textBlackColor,
              borderColor: AppColors.borderColor,
              customIcon: questionProvider.selectedAnswer == widget.answer2
                  ? widget.correctAnswer == widget.answer2
                      ? Icon(
                          Icons.done,
                          color: Colors.white,
                        )
                      : Icon(
                          Icons.close,
                          color: Colors.white,
                        )
                  : Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
              answerVoice: widget.answer2Voice,
              answerImage: widget.answer2Image,
            ),
          ),
          GestureDetector(
            onTap: () {
              if (questionProvider.isAnswerSelected == true) {
                print("You Already Selected A Answer!");
              } else {
                questionProvider.checkAnswerCorrectOrNot(
                    widget.correctAnswer, widget.answer3);
                setState(() {
                  questionProvider.selectedAnswer = widget.answer3;
                  questionProvider.isAnswerSelected = true;
                });
              }
            },
            child: AnswerTile(
              answer: widget.answer3,
              color: questionProvider.selectedAnswer == widget.answer3
                  ? widget.correctAnswer == widget.answer3
                      ? Colors.green
                      : Colors.red
                  : Colors.white,
              textColor: questionProvider.selectedAnswer == widget.answer3
                  ? Colors.white
                  : AppColors.textBlackColor,
              borderColor: AppColors.borderColor,
              customIcon: questionProvider.selectedAnswer == widget.answer3
                  ? widget.correctAnswer == widget.answer3
                      ? Icon(
                          Icons.done,
                          color: Colors.white,
                        )
                      : Icon(
                          Icons.close,
                          color: Colors.white,
                        )
                  : Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
              answerVoice: widget.answer3Voice,
              answerImage: widget.answer3Image,
            ),
          ),
        ],
      ),
    );
  }
}
