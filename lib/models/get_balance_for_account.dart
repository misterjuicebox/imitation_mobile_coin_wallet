import 'package:json_annotation/json_annotation.dart';

part 'get_balance_for_account.g.dart';

@JsonSerializable()
class GetBalanceForAccount {
  final String object;
  final String network_block_height;
  final String local_block_height;
  final String account_block_height;
  final bool is_synced;
  final String unspent_pmob;
  final String spent_pmob;
  final String secreted_pmob;
  final String orphaned_pmob;

  GetBalanceForAccount(this.object, this.network_block_height, this.local_block_height, this.account_block_height,
      this.is_synced, this.unspent_pmob, this.spent_pmob, this.secreted_pmob, this.orphaned_pmob);

  factory GetBalanceForAccount.fromJson(Map<String, dynamic> json) => _$GetBalanceForAccountFromJson(json);

  Map<String, dynamic> toJson() => _$GetBalanceForAccountToJson(this);
}
