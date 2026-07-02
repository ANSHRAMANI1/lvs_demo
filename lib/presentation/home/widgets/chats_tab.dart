import 'package:flutter/material.dart';
import '../../../app/theme/app_colors.dart';

class ChatsTab extends StatelessWidget {
  const ChatsTab({super.key});

  static const _dummyChats = [
    {'name': 'John Doe', 'msg': 'Hey, great stream today!', 'time': '2m', 'unread': '1'},
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
            child: Row(
              children: [
                const Text(
                  'Chats',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                const Spacer(),
                Container(
                  width: 38,
                  height: 38,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFF0F0F0),
                  ),
                  child: const Icon(Icons.edit_outlined,
                      color: Color(0xFF888888), size: 18),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFF4F4F4),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                children: [
                  SizedBox(width: 12),
                  Icon(Icons.search_rounded, color: Color(0xFFAAAAAA), size: 18),
                  SizedBox(width: 8),
                  Text('Search messages…',
                      style: TextStyle(color: Color(0xFFAAAAAA), fontSize: 13)),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.only(bottom: 100),
              itemCount: _dummyChats.length,
              separatorBuilder: (_, __) => const Divider(
                  height: 1, indent: 72, endIndent: 16, color: Color(0xFFF0F0F0)),
              itemBuilder: (context, i) {
                final chat = _dummyChats[i];
                final hasUnread = chat['unread']!.isNotEmpty;
                return ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  leading: CircleAvatar(
                    radius: 24,
                    backgroundColor: AppColors.primary.withValues(alpha: 0.15),
                    child: Text(
                      chat['name']![0],
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  title: Text(
                    chat['name']!,
                    style: TextStyle(
                      fontWeight:
                          hasUnread ? FontWeight.w700 : FontWeight.w500,
                      fontSize: 14,
                      color: const Color(0xFF1A1A1A),
                    ),
                  ),
                  subtitle: Text(
                    chat['msg']!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      color: hasUnread
                          ? const Color(0xFF333333)
                          : const Color(0xFF999999),
                    ),
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(chat['time']!,
                          style: TextStyle(
                            fontSize: 11,
                            color: hasUnread
                                ? AppColors.primary
                                : const Color(0xFFAAAAAA),
                          )),
                      if (hasUnread) ...[
                        const SizedBox(height: 4),
                        Container(
                          width: 18,
                          height: 18,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primary,
                          ),
                          child: Center(
                            child: Text(
                              chat['unread']!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
