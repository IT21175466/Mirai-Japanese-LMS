import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:miraijapanese/constraints/app_colors.dart';
import 'package:miraijapanese/providers/quiz/question_provider.dart';
import 'package:miraijapanese/widgets/answer_tile.dart';
import 'package:provider/provider.dart';

class SingleQuizToPreview extends StatefulWidget {
  const SingleQuizToPreview({
    super.key,
  });

  @override
  State<SingleQuizToPreview> createState() => _SingleQuizToPreviewState();
}

class _SingleQuizToPreviewState extends State<SingleQuizToPreview> {
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
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Text(
          "Preview",
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColors.accentColor,
      ),
      body: Container(
        height: screenHeight,
        width: screenWidth,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Consumer(
          builder: (BuildContext context, QuestionProvider questionProvider,
                  Widget? child) =>
              ListView.builder(
            itemCount: questionProvider.questions.length,
            itemBuilder: (context, index) {
              String selected = questionProvider.selectedAnswers[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: screenWidth,
                    height: 180,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: AppColors.textGrayColor,
                        width: 0.5,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${questionProvider.questions[index].questionNumber}. ${questionProvider.questions[index].question}',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: AppColors.textBlackColor,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        questionProvider
                                .questions[index].questionImage.isNotEmpty
                            ? Expanded(
                                child: Image.network(questionProvider
                                    .questions[index].questionImage),
                              )
                            : SizedBox(),
                        questionProvider
                                .questions[index].questionVoice.isNotEmpty
                            ? Expanded(
                                child: Container(
                                  width: screenWidth,
                                  height: 150,
                                  child: Column(
                                    children: [
                                      Slider(
                                        min: 0,
                                        max: duration.inSeconds.toDouble(),
                                        value: position.inSeconds.toDouble(),
                                        onChanged: (value) async {
                                          final position =
                                              Duration(seconds: value.toInt());
                                          await audioPlayer.seek(position);

                                          await audioPlayer.resume();
                                        },
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15),
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
                                                questionProvider
                                                    .questions[index]
                                                    .questionVoice,
                                              ));
                                            }
                                          },
                                          icon: Icon(
                                            isPlaying
                                                ? Icons.pause
                                                : Icons.play_arrow,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : SizedBox(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  AnswerTile(
                    answer: questionProvider.questions[index].answer1,
                    color: selected == questionProvider.questions[index].answer1
                        ? questionProvider.questions[index].correctAnswer ==
                                questionProvider.questions[index].answer1
                            ? Colors.green
                            : Colors.red
                        : Colors.white,
                    textColor:
                        selected == questionProvider.questions[index].answer1
                            ? Colors.white
                            : AppColors.textBlackColor,
                    borderColor: AppColors.borderColor,
                    customIcon:
                        selected == questionProvider.questions[index].answer1
                            ? questionProvider.questions[index].correctAnswer ==
                                    questionProvider.questions[index].answer1
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
                    answerVoice: questionProvider.questions[index].answer1Voice,
                    answerImage: questionProvider.questions[index].answer1Image,
                    questionNumber: 'A',
                  ),
                  AnswerTile(
                    answer: questionProvider.questions[index].answer2,
                    color: selected == questionProvider.questions[index].answer2
                        ? questionProvider.questions[index].correctAnswer ==
                                questionProvider.questions[index].answer2
                            ? Colors.green
                            : Colors.red
                        : Colors.white,
                    textColor:
                        selected == questionProvider.questions[index].answer2
                            ? Colors.white
                            : AppColors.textBlackColor,
                    borderColor: AppColors.borderColor,
                    customIcon:
                        selected == questionProvider.questions[index].answer2
                            ? questionProvider.questions[index].correctAnswer ==
                                    questionProvider.questions[index].answer2
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
                    answerVoice: questionProvider.questions[index].answer2Voice,
                    answerImage: questionProvider.questions[index].answer2Image,
                    questionNumber: 'B',
                  ),
                  AnswerTile(
                    answer: questionProvider.questions[index].answer3,
                    color: selected == questionProvider.questions[index].answer3
                        ? questionProvider.questions[index].correctAnswer ==
                                questionProvider.questions[index].answer3
                            ? Colors.green
                            : Colors.red
                        : Colors.white,
                    textColor:
                        selected == questionProvider.questions[index].answer3
                            ? Colors.white
                            : AppColors.textBlackColor,
                    borderColor: AppColors.borderColor,
                    customIcon:
                        selected == questionProvider.questions[index].answer3
                            ? questionProvider.questions[index].correctAnswer ==
                                    questionProvider.questions[index].answer3
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
                    answerVoice: questionProvider.questions[index].answer3Voice,
                    answerImage: questionProvider.questions[index].answer3Image,
                    questionNumber: 'C',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Correct Answer : ${questionProvider.questions[index].correctAnswer}',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: AppColors.textBlackColor,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Divider(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
