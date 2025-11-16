// --- Model Data (Mereplikasi State atau Data dari Backend) ---
class PriceConfig {
  final int session1Price;
  final int session2Price;
  final int discountPercent;
  final String bankName;
  final String accountNumber;
  final String accountHolder;

  PriceConfig({
    required this.session1Price,
    required this.session2Price,
    required this.discountPercent,
    required this.bankName,
    required this.accountNumber,
    required this.accountHolder,
  });

  PriceConfig copyWith({
    int? session1Price,
    int? session2Price,
    int? discountPercent,
    String? bankName,
    String? accountNumber,
    String? accountHolder,
  }) {
    return PriceConfig(
      session1Price: session1Price ?? this.session1Price,
      session2Price: session2Price ?? this.session2Price,
      discountPercent: discountPercent ?? this.discountPercent,
      bankName: bankName ?? this.bankName,
      accountNumber: accountNumber ?? this.accountNumber,
      accountHolder: accountHolder ?? this.accountHolder,
    );
  }
}
