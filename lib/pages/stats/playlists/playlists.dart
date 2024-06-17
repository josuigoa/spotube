import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spotube/collections/formatters.dart';
import 'package:spotube/components/titlebar/titlebar.dart';
import 'package:spotube/modules/stats/common/playlist_item.dart';
import 'package:spotube/extensions/context.dart';
import 'package:spotube/provider/history/state.dart';
import 'package:spotube/provider/history/top.dart';

class StatsPlaylistsPage extends HookConsumerWidget {
  static const name = "stats_playlists";
  const StatsPlaylistsPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final playlists = ref.watch(
      playbackHistoryTopProvider(HistoryDuration.allTime)
          .select((s) => s.playlists),
    );

    return Scaffold(
      appBar: PageWindowTitleBar(
        automaticallyImplyLeading: true,
        centerTitle: false,
        title: Text(context.l10n.playlists),
      ),
      body: ListView.builder(
        itemCount: playlists.length,
        itemBuilder: (context, index) {
          final playlist = playlists[index];
          return StatsPlaylistItem(
            playlist: playlist.playlist.playlist,
            info: Text(
              context.l10n
                  .count_plays(compactNumberFormatter.format(playlist.count)),
            ),
          );
        },
      ),
    );
  }
}
