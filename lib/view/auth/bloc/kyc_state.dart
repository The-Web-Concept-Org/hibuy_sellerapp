enum KycStatus { initial, loading, success, error }

class KycState {
  final KycStatus status;
  final dynamic kycResponse;
  final String? errorMessage;

  KycState({
    required this.status,
    this.kycResponse,
    this.errorMessage,
  });

  factory KycState.initial() => KycState(status: KycStatus.initial);

  KycState copyWith({
    KycStatus? status,
    dynamic kycResponse,
    String? errorMessage,
  }) {
    return KycState(
      status: status ?? this.status,
      kycResponse: kycResponse ?? this.kycResponse,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
