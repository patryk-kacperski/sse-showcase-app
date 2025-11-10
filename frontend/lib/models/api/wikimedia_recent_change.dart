import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'wikimedia_recent_change.g.dart';

@JsonSerializable()
class WikimediaRecentChange extends Equatable {
  const WikimediaRecentChange({
    this.title,
    required this.schema,
    this.type,
    this.bot,
    this.comment,
    this.id,
    this.length,
    this.logAction,
    this.logActionComment,
    this.logId,
    this.logParams,
    this.logType,
    required this.meta,
    this.minor,
    this.namespace,
    this.parsedcomment,
    this.patrolled,
    this.revision,
    this.serverName,
    this.serverScriptPath,
    this.serverUrl,
    this.timestamp,
    this.user,
    this.wiki,
  });

  factory WikimediaRecentChange.fromJson(Map<String, dynamic> json) =>
      _$WikimediaRecentChangeFromJson(json);

  Map<String, dynamic> toJson() => _$WikimediaRecentChangeToJson(this);

  final String? title;

  @JsonKey(name: '\$schema')
  final String schema;

  final String? type;
  final bool? bot;
  final String? comment;
  final int? id;
  final WikimediaRecentChangeLength? length;

  @JsonKey(name: 'log_action')
  final String? logAction;

  @JsonKey(name: 'log_action_comment')
  final String? logActionComment;

  @JsonKey(name: 'log_id')
  final int? logId;

  @JsonKey(name: 'log_params')
  final dynamic logParams;

  @JsonKey(name: 'log_type')
  final String? logType;

  final WikimediaRecentChangeMeta meta;
  final bool? minor;
  final int? namespace;
  final String? parsedcomment;
  final bool? patrolled;
  final WikimediaRecentChangeRevision? revision;

  @JsonKey(name: 'server_name')
  final String? serverName;

  @JsonKey(name: 'server_script_path')
  final String? serverScriptPath;

  @JsonKey(name: 'server_url')
  final String? serverUrl;

  final int? timestamp;
  final String? user;
  final String? wiki;

  @override
  List<Object?> get props => [
    title,
    schema,
    type,
    bot,
    comment,
    id,
    length,
    logAction,
    logActionComment,
    logId,
    logParams,
    logType,
    meta,
    minor,
    namespace,
    parsedcomment,
    patrolled,
    revision,
    serverName,
    serverScriptPath,
    serverUrl,
    timestamp,
    user,
    wiki,
  ];
}

@JsonSerializable()
class WikimediaRecentChangeMeta extends Equatable {
  const WikimediaRecentChangeMeta({
    this.domain,
    required this.dt,
    this.id,
    this.requestId,
    required this.stream,
    this.uri,
  });

  factory WikimediaRecentChangeMeta.fromJson(Map<String, dynamic> json) =>
      _$WikimediaRecentChangeMetaFromJson(json);

  Map<String, dynamic> toJson() => _$WikimediaRecentChangeMetaToJson(this);

  final String? domain;
  final String dt;
  final String? id;

  @JsonKey(name: 'request_id')
  final String? requestId;

  final String stream;
  final String? uri;

  @override
  List<Object?> get props => [domain, dt, id, requestId, stream, uri];
}

@JsonSerializable()
class WikimediaRecentChangeLength extends Equatable {
  const WikimediaRecentChangeLength({this.newLength, this.oldLength});

  factory WikimediaRecentChangeLength.fromJson(Map<String, dynamic> json) =>
      _$WikimediaRecentChangeLengthFromJson(json);

  Map<String, dynamic> toJson() => _$WikimediaRecentChangeLengthToJson(this);

  @JsonKey(name: 'new')
  final int? newLength;

  @JsonKey(name: 'old')
  final int? oldLength;

  @override
  List<Object?> get props => [newLength, oldLength];
}

@JsonSerializable()
class WikimediaRecentChangeRevision extends Equatable {
  const WikimediaRecentChangeRevision({this.newRevision, this.oldRevision});

  factory WikimediaRecentChangeRevision.fromJson(Map<String, dynamic> json) =>
      _$WikimediaRecentChangeRevisionFromJson(json);

  Map<String, dynamic> toJson() => _$WikimediaRecentChangeRevisionToJson(this);

  @JsonKey(name: 'new')
  final int? newRevision;

  @JsonKey(name: 'old')
  final int? oldRevision;

  @override
  List<Object?> get props => [newRevision, oldRevision];
}
