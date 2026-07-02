import 'package:equatable/equatable.dart';

/// Domain representation of a single stream entry shown in the feed grid.
///
/// This entity is returned by [GetStreamFeed] and consumed directly by the
/// presentation layer — no framework or API types leak in here.
class StreamItemEntity extends Equatable {
  /// Unique identifier for the stream (used as a widget key and for dedup).
  final String id;

  /// Display name of the broadcaster.
  final String streamerName;

  /// URL of the stream preview thumbnail image.
  final String thumbnailUrl;

  /// Unicode flag emoji representing the streamer's country (e.g. `🇮🇳`).
  final String countryFlag;

  /// Current live viewer count displayed on the card badge.
  final int viewerCount;

  /// Whether the stream is currently broadcasting live.
  final bool isLive;

  /// Category / country label used for feed filtering (e.g. `'India'`).
  final String category;

  const StreamItemEntity({
    required this.id,
    required this.streamerName,
    required this.thumbnailUrl,
    required this.countryFlag,
    required this.viewerCount,
    required this.isLive,
    required this.category,
  });

  @override
  List<Object> get props =>
      [id, streamerName, thumbnailUrl, countryFlag, viewerCount, isLive, category];
}
