class StatusBase {}

class InitStatus extends StatusBase {}

class ErrorStatus extends StatusBase {
  final String message;
  final String? error;

  ErrorStatus({
    required this.message,
    this.error,
  }) {
    if (error != null) {
      print(error);
    }
  }
}

class LoadingStatus extends StatusBase {}

class SuccessStatus extends StatusBase {}
