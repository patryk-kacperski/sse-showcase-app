// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wikimedia_recent_change.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WikimediaRecentChange _$WikimediaRecentChangeFromJson(
  Map<String, dynamic> json,
) => WikimediaRecentChange(
  title: json['title'] as String?,
  schema: json[r'$schema'] as String,
  type: json['type'] as String?,
  bot: json['bot'] as bool?,
  comment: json['comment'] as String?,
  id: (json['id'] as num?)?.toInt(),
  length: json['length'] == null
      ? null
      : WikimediaRecentChangeLength.fromJson(
          json['length'] as Map<String, dynamic>,
        ),
  logAction: json['log_action'] as String?,
  logActionComment: json['log_action_comment'] as String?,
  logId: (json['log_id'] as num?)?.toInt(),
  logParams: json['log_params'],
  logType: json['log_type'] as String?,
  meta: WikimediaRecentChangeMeta.fromJson(
    json['meta'] as Map<String, dynamic>,
  ),
  minor: json['minor'] as bool?,
  namespace: (json['namespace'] as num?)?.toInt(),
  parsedcomment: json['parsedcomment'] as String?,
  patrolled: json['patrolled'] as bool?,
  revision: json['revision'] == null
      ? null
      : WikimediaRecentChangeRevision.fromJson(
          json['revision'] as Map<String, dynamic>,
        ),
  serverName: json['server_name'] as String?,
  serverScriptPath: json['server_script_path'] as String?,
  serverUrl: json['server_url'] as String?,
  timestamp: (json['timestamp'] as num?)?.toInt(),
  user: json['user'] as String?,
  wiki: json['wiki'] as String?,
);

Map<String, dynamic> _$WikimediaRecentChangeToJson(
  WikimediaRecentChange instance,
) => <String, dynamic>{
  'title': instance.title,
  r'$schema': instance.schema,
  'type': instance.type,
  'bot': instance.bot,
  'comment': instance.comment,
  'id': instance.id,
  'length': instance.length,
  'log_action': instance.logAction,
  'log_action_comment': instance.logActionComment,
  'log_id': instance.logId,
  'log_params': instance.logParams,
  'log_type': instance.logType,
  'meta': instance.meta,
  'minor': instance.minor,
  'namespace': instance.namespace,
  'parsedcomment': instance.parsedcomment,
  'patrolled': instance.patrolled,
  'revision': instance.revision,
  'server_name': instance.serverName,
  'server_script_path': instance.serverScriptPath,
  'server_url': instance.serverUrl,
  'timestamp': instance.timestamp,
  'user': instance.user,
  'wiki': instance.wiki,
};

WikimediaRecentChangeMeta _$WikimediaRecentChangeMetaFromJson(
  Map<String, dynamic> json,
) => WikimediaRecentChangeMeta(
  domain: json['domain'] as String?,
  dt: json['dt'] as String,
  id: json['id'] as String?,
  requestId: json['request_id'] as String?,
  stream: json['stream'] as String,
  uri: json['uri'] as String?,
);

Map<String, dynamic> _$WikimediaRecentChangeMetaToJson(
  WikimediaRecentChangeMeta instance,
) => <String, dynamic>{
  'domain': instance.domain,
  'dt': instance.dt,
  'id': instance.id,
  'request_id': instance.requestId,
  'stream': instance.stream,
  'uri': instance.uri,
};

WikimediaRecentChangeLength _$WikimediaRecentChangeLengthFromJson(
  Map<String, dynamic> json,
) => WikimediaRecentChangeLength(
  newLength: (json['new'] as num?)?.toInt(),
  oldLength: (json['old'] as num?)?.toInt(),
);

Map<String, dynamic> _$WikimediaRecentChangeLengthToJson(
  WikimediaRecentChangeLength instance,
) => <String, dynamic>{'new': instance.newLength, 'old': instance.oldLength};

WikimediaRecentChangeRevision _$WikimediaRecentChangeRevisionFromJson(
  Map<String, dynamic> json,
) => WikimediaRecentChangeRevision(
  newRevision: (json['new'] as num?)?.toInt(),
  oldRevision: (json['old'] as num?)?.toInt(),
);

Map<String, dynamic> _$WikimediaRecentChangeRevisionToJson(
  WikimediaRecentChangeRevision instance,
) => <String, dynamic>{
  'new': instance.newRevision,
  'old': instance.oldRevision,
};
