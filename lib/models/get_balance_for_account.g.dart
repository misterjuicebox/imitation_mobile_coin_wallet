// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_balance_for_account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetBalanceForAccount _$GetBalanceForAccountFromJson(
        Map<String, dynamic> json) =>
    GetBalanceForAccount(
      json['object'] as String,
      json['network_block_height'] as String,
      json['local_block_height'] as String,
      json['account_block_height'] as String,
      json['is_synced'] as bool,
      json['unspent_pmob'] as String,
      json['spent_pmob'] as String,
      json['secreted_pmob'] as String,
      json['orphaned_pmob'] as String,
    );

Map<String, dynamic> _$GetBalanceForAccountToJson(
        GetBalanceForAccount instance) =>
    <String, dynamic>{
      'object': instance.object,
      'network_block_height': instance.network_block_height,
      'local_block_height': instance.local_block_height,
      'account_block_height': instance.account_block_height,
      'is_synced': instance.is_synced,
      'unspent_pmob': instance.unspent_pmob,
      'spent_pmob': instance.spent_pmob,
      'secreted_pmob': instance.secreted_pmob,
      'orphaned_pmob': instance.orphaned_pmob,
    };
