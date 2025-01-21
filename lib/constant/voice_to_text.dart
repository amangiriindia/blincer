import 'package:speech_to_text/speech_to_text.dart' as stt;

class VoiceToText {
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool isListening = false;

  // Function to start listening and return the recognized text
  Future<void> startListening({
    required Function(String recognizedText) onResult,
    required Function(String error) onError,
    required Function() onStop,
  }) async {
    bool available = await _speech.initialize(
      onStatus: (status) {
        if (status == 'done') {
          stopListening(onStop: onStop); // Stop automatically if done
        }
      },
      onError: (error) {
        onError(error.toString());
      },
    );

    if (available) {
      isListening = true;
      _speech.listen(onResult: (result) {
        onResult(result.recognizedWords);
      });
    } else {
      onError("Speech recognition not available.");
    }
  }

  // Function to stop listening
  void stopListening({required Function() onStop}) {
    _speech.stop();
    isListening = false;
    onStop();
  }
}
