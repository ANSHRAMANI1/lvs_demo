import '../../domain/entities/stream_item_entity.dart';

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
