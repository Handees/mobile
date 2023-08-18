import 'package:logger/logger.dart';

class MyLogger {
  late Logger logger;

  MyLogger._() {
    logger = Logger(
      printer: PrettyPrinter(
        methodCount: 2,
        errorMethodCount: 8, // Number of method calls if stacktrace is provided
        lineLength: 120, // Width of the output
        colors: true, // Colorful log messages
        printEmojis: true, // Print an emoji for each log message
        printTime: false,
      ),
    );
  }

  static final instance = MyLogger._();
}
