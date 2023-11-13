import 'dart:ffi';

class TokenPair {
  String? chainId;
  String? dexId;
  String? url;
  String? pairAddress;
  BaseToken? baseToken;
  QuoteToken? quoteToken;
  String? priceNative;
  String? priceUsd;
  Transactions? txns;
  TransactionsVolume? volume;
  PriceChange? priceChange;
  Liquidity? liquidity;
  int? fdv;
  int? pairCreatedAt;
}

class BaseToken {
  String? address;
  String? name;
  String? symbol;
}

class QuoteToken {
  String? symbol;
}

class Transactions {
  TransactionInfo? m5;
  TransactionInfo? h1;
  TransactionInfo? h6;
  TransactionInfo? h24;
}

class TransactionInfo {
  int? buys;
  int? sells;
}

class TransactionsVolume {
  Double? m5;
  Double? h1;
  Double? h6;
  Double? h24;
}

class PriceChange {
  Double? m5;
  Double? h1;
  Double? h6;
  Double? h24;
}

class Liquidity {
  int? usd;
  int? base;
  int? quote;
}
