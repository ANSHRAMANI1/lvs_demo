import 'package:equatable/equatable.dart';

class StreamItemEntity extends Equatable {
  final String id;
  final String streamerName;
  final String thumbnailUrl;
  final String countryFlag;
  final int viewerCount;
  final bool isLive;
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
