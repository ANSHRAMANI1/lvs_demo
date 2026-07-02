import '../../domain/entities/stream_item_entity.dart';

/// Data-layer representation of a stream feed item.
///
/// Extends [StreamItemEntity] and adds JSON serialisation so the model can
/// be decoded from REST API responses without touching the domain layer.
class StreamItemModel extends StreamItemEntity {
  const StreamItemModel({
    required super.id,
    required super.streamerName,
    required super.thumbnailUrl,
    required super.countryFlag,
    required super.viewerCount,
    required super.isLive,
    required super.category,
  });

  /// Deserialises a [StreamItemModel] from a JSON map returned by the API.
  factory StreamItemModel.fromJson(Map<String, dynamic> json) {
    return StreamItemModel(
      id: json['id'] as String,
      streamerName: json['streamer_name'] as String,
      thumbnailUrl: json['thumbnail_url'] as String,
      countryFlag: json['country_flag'] as String,
      viewerCount: json['viewer_count'] as int,
      isLive: json['is_live'] as bool,
      category: json['category'] as String,
    );
  }

  /// Serialises this model to a JSON map (e.g. for caching or upload).
  Map<String, dynamic> toJson() => {
        'id': id,
        'streamer_name': streamerName,
        'thumbnail_url': thumbnailUrl,
        'country_flag': countryFlag,
        'viewer_count': viewerCount,
        'is_live': isLive,
        'category': category,
      };
}
