import 'dart:async';
import 'dart:developer';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:custom_widgets_toolkit/custom_widgets_toolkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:techstars_hackathon/common/colors.dart';
import 'package:techstars_hackathon/views/ai_chat/widgets/animated_markdown_text.dart';
import 'package:techstars_hackathon/views/ai_chat/widgets/example_question.dart';
import 'package:uuid/uuid.dart';

import '../../core/data/handle_ai_chat_store_data.dart';
import '../../core/services/gemini_services.dart';

class GeminiChatScreen extends StatefulWidget {
  const GeminiChatScreen({super.key});

  @override
  State<GeminiChatScreen> createState() => _GeminiChatScreenState();
}

class _GeminiChatScreenState extends State<GeminiChatScreen> with AutomaticKeepAliveClientMixin {
  final TextEditingController textEditingController = TextEditingController();
  bool isSendButtonClicked = false;
  List<types.TextMessage> _textMessage = [];
  final types.User _user = types.User(id: 'defaultUserId', role: types.Role.user, firstName: "User");
  final types.User _modelUser = types.User(id: 'model', role: types.Role.agent, firstName: "Nurturely assistant");
  final HandleAiChatStoreData handleAiChatStoreData = HandleAiChatStoreData("defaultUserId");
  bool isTyping = false;

  String getUUID() => Uuid().v4();

  @override
  void initState() {
    super.initState();
    _textMessage = [];
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadTextMessages();
    });
  }

  Future<void> loadTextMessages() async {
    final List<Content> chatContents = await handleAiChatStoreData.getUserChatStore();

    if (chatContents.length == _textMessage.length) {
      bool listsAreSame = true;
      for (int i = 0; i < chatContents.length; i++) {
        final Content content = chatContents[i];
        final String newText = (content.parts.first as TextPart?)?.text ?? "";
        final types.TextMessage existingMessage = _textMessage[i];

        if (existingMessage.text != newText) {
          listsAreSame = false;
          break;
        }
      }
      if (listsAreSame) return; // No changes found; exit
    }

    List<types.TextMessage> tempList = <types.TextMessage>[];
    // Rebuild the message list if there's any difference.
    for (int i = 0; i < chatContents.length; i++) {
      final String text = (chatContents[i].parts.first as TextPart?)?.text ?? "";
      tempList.add(types.TextMessage(author: chatContents[i].role == "user" ? _user : _modelUser, id: "message_${getUUID()}", text: text));
    }
    setState(() {
      _textMessage = tempList;
    });
  }

  Stream sendPromptToModel(Content content) async* {
    final List<Content> getUserChatContents = await handleAiChatStoreData.getUserChatStore();
    // log("getUserChatContents result: $getUserChatContents");
    final Stream rawResult = GeminiServices.sendPrompt(content: [...getUserChatContents, content]);
    yield* rawResult;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final ThemeData themeData = Theme.of(context);
    final bool isDarkMode = themeData.brightness == Brightness.dark;
    final double width = mediaQuery.size.width;
    final double height = mediaQuery.size.height;

    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: themeData.scaffoldBackgroundColor,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SizedBox(
          height: height,
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).padding.top),
              SizedBox(
                height: kToolbarHeight + 12,
                child: Row(
                  children: [
                    BackButton(),
                    Expanded(
                      child: Center(
                        child: AnimatedTextKit(
                          // key: UniqueKey(),
                          animatedTexts: [
                            TypewriterAnimatedText(
                              "Nurturely Assistant",
                              textStyle: TextStyle(color: TechStarsColors.primaryDark, fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: CustomText("Clear Chat?", fontSize: 18, fontWeight: FontWeight.bold),
                              content: CustomText("Are you sure you want to clear your chat?"),
                              actions: [
                                CustomTextButton(label: "Cancel", onClick: () => Navigator.of(context).pop()),
                                CustomTextButton(
                                  backgroundColor: TechStarsColors.lightTeal,
                                  label: "Delete",
                                  onClick: () async {
                                    Navigator.of(context).pop();
                                    LoadingDialog.showLoadingDialog(context, msg: "Deleting chat");
                                    handleAiChatStoreData.deleteUserAllChatStore();
                                    _textMessage.clear();
                                    setState(() {
                                      _textMessage;
                                    });
                                    LoadingDialog.hideLoadingDialog(context);
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      icon: Icon(Iconsax.trash),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: Chat(
                  customBottomWidget: Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const SizedBox(width: 12),
                        Expanded(
                          child: CustomTextfield(
                            controller: textEditingController,
                            constraints: BoxConstraints(maxHeight: 128),
                            hint: "Ask me anything",
                            selectionColor: TechStarsColors.primary.withAlpha(50),
                            selectionHandleColor: TechStarsColors.primary,
                            cursorColor: Colors.black,
                            hintStyle: CustomText("", color: Color(0xFF9E9093)).effectiveStyle(context),
                            maxLines: 4,
                            inputTextStyle: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
                            inputContentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                            pixelWidth: width,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(36),
                              borderSide: BorderSide(color: Color(0xFF2D0F15)),
                            ),
                            onchanged: (text) {
                              if (textEditingController.text != text) setState(() => textEditingController.text = text);
                            },
                            backgroundColor: TechStarsColors.lightGray,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(36),
                              borderSide: BorderSide(color: TechStarsColors.primary),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () {
                            final types.PartialText content = types.PartialText(text: textEditingController.text);
                            askModel(content);
                          },
                          child: SizedBox.square(
                            dimension: 60,
                              child: SvgPicture.asset("assets/svgs/send_msg_button.svg")),
                        ),
                        const SizedBox(width: 8),
                      ],
                    ),
                  ),

                  // textMessageBuilder: ,
                  emptyState:
                      _textMessage.isEmpty
                          ? SingleChildScrollView(
                            child: FutureBuilder(
                              future: _buildEmptyPageWidget(
                                handleAiChatStoreData,
                                (question) => askModel(types.PartialText(text: question)),
                              ),
                              builder: (context, snapshot) {
                                log("snapshot: ${snapshot.data}");
                                if (snapshot.hasData && snapshot.data != null) return snapshot.data!;
                                if (snapshot.data == null) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const SizedBox(height: kToolbarHeight + 24),
                                      const SizedBox(height: 64),
                                      SvgPicture.asset("assets/svgs/nurturely_logo.svg", width: 200, height: 200),
                                      const SizedBox(height: 48),
                                      CustomText(
                                        "Start chatting with Nurturely AI",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: TechStarsColors.primary,
                                      ),
                                    ],
                                  );
                                }
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(height: kToolbarHeight + 80),
                                    SizedBox.square(
                                      dimension: 48,
                                      child: CircularProgressIndicator(color: TechStarsColors.primary, strokeCap: StrokeCap.round),
                                    ),
                                    const SizedBox(height: 24),
                                    CustomText(
                                      "Loading Nurturely Assistant",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: TechStarsColors.primary,
                                    ),
                                  ],
                                );
                              },
                            ),
                          )
                          : null,
                  typingIndicatorOptions: TypingIndicatorOptions(
                    typingUsers: isTyping ? [_modelUser.copyWith(id: "model_${getUUID()}")] : [],
                  ),
                  scrollPhysics: BouncingScrollPhysics(),
                  messages: _textMessage.reversed.toList(),

                  user: _user,
                  onSendPressed: (_) {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  askModel(types.PartialText partialText) async {
    if (isTyping) return;
    setState(() => isTyping = true);
    // User's message
    final Content userContent = Content("user", [TextPart(partialText.text)]);

    // Update the user's message in the ui
    _textMessage.add(types.TextMessage(id: "message_${getUUID()}", author: _user, text: partialText.text));
    setState(() {
      _textMessage;
    });
    handleAiChatStoreData.addContentToChatStore(userContent); // store the user message immediately

    // Prepare a buffer to store the AI's response.
    final StringBuffer modelResponseString = StringBuffer();
    final modelCurrentId = "message_${getUUID()}";

    // Consulting Model text
    _textMessage.add(types.TextMessage(id: modelCurrentId, author: _modelUser, text: "Consulting model..."));
    setState(() {
      _textMessage;
    });

    final int aiMessageIndex = _textMessage.lastIndexWhere((element) => (element.id == modelCurrentId));

    // Listen to the streaming AI response.
    final StreamSubscription modelResponseSub = sendPromptToModel(userContent).listen((response) {
      log("listening: ${modelResponseString.toString()}");
      final String? newText = response.text;
      if (newText != null) {
        // Append new text to the buffer.
        modelResponseString.write(newText);

        // Create a new ChatMessage with the updated text.
        final types.TextMessage updatedMessage = types.TextMessage(
          id: modelCurrentId,
          author: _modelUser,
          text: modelResponseString.toString(),
        );

        _textMessage[aiMessageIndex] = updatedMessage;
        setState(() {
          _textMessage;
        });
      }
    });

    Timer timeoutTimer = Timer(Duration(seconds: 20), () async {
      await modelResponseSub.cancel();
      setState(() => isTyping = false);
      loadTextMessages();
    });

    // Cancel the timer on error.
    modelResponseSub.onError((error, stackTrace) async {
      if (timeoutTimer.isActive) timeoutTimer.cancel();
      await modelResponseSub.cancel();
      setState(() => isTyping = false);
      loadTextMessages();
    });

    // Cancel the timer on done.
    modelResponseSub.onDone(() async {
      if (timeoutTimer.isActive) timeoutTimer.cancel();
      handleAiChatStoreData.addContentToChatStore(Content(_modelUser.id, [TextPart(modelResponseString.toString())]));
      await modelResponseSub.cancel();
      setState(() => isTyping = false);
      loadTextMessages();
    });
  }

  @override
  bool get wantKeepAlive => true;
}

Future<Widget> _buildEmptyPageWidget(HandleAiChatStoreData handleAiChatStoreData, void Function(String) onTap) async {
  buildExampleQuestion(String question) {
    return ExampleQuestion(question: question, onTap: (question) => onTap(question));
  }

  return Column(
    children: [
      buildExampleQuestion("What are the best foods to eat during pregnancy?"),
      buildExampleQuestion("What are the best practices for baby hygiene and care?"),
    ],
  );
  // final List<Content> content = (await handleAiChatStoreData.getUserChatStore()).reversed.toList();

  //
  //
  // // Fetch multiple suggestions in parallel
  // List<Future<String?>> futures = List.generate(2, (_) => GeminiServices.generateSuggestion(content: content));
  // List<String?> outputs = await Future.wait(futures);
  // List<ExampleQuestion> exampleQuestions = outputs
  //     .where((output) => output != null && output.trim().isNotEmpty) // Remove null/empty responses
  //     .map((output) => buildExampleQuestion(output!.trim()))
  //     .toList();
  //
  //
  // if (exampleQuestions.isEmpty) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 16),
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         const SizedBox(height: kToolbarHeight),
  //         CustomText("Nurturely AI", fontSize: 32, fontWeight: FontWeight.w600),
  //         const SizedBox(height: 75),
  //         SvgPicture.asset("assets/svgs/nurturely_logo.svg", width: 200, height: 200,),
  //         const SizedBox(height: 48),
  //         CustomText(
  //           "Assistant Limit exceeded or try connecting to a network",
  //           fontWeight: FontWeight.bold,
  //           fontSize: 18,
  //           textAlign: TextAlign.center,
  //           color: TechStarsColors.primary,
  //         ),
  //       ],
  //     ),
  //   );
  // }
  //
  // return Column(
  //   children: [
  //     const SizedBox(height: kToolbarHeight),
  //     CustomText("Nurturely AI", fontSize: 32, fontWeight: FontWeight.w600),
  //     const SizedBox(height: 64),
  //     ...exampleQuestions,
  //   ],
  // );
}
