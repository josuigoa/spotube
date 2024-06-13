import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spotube/collections/formatters.dart';
import 'package:spotube/components/shared/page_window_title_bar.dart';
import 'package:spotube/components/stats/common/artist_item.dart';
import 'package:spotube/extensions/context.dart';
import 'package:spotube/provider/history/state.dart';
import 'package:spotube/provider/history/top.dart';

class StatsArtistsPage extends HookConsumerWidget {
  static const name = "stats_artists";
  const StatsArtistsPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final artists = ref.watch(
      playbackHistoryTopProvider(HistoryDuration.allTime)
          .select((s) => s.artists),
    );

    return Scaffold(
      appBar: PageWindowTitleBar(
        automaticallyImplyLeading: true,
        centerTitle: false,
        title: Text(context.l10n.artists),
      ),
      body: ListView.builder(
        itemCount: artists.length,
        itemBuilder: (context, index) {
          final artist = artists[index];
          return StatsArtistItem(
            artist: artist.artist,
            info: Text(context.l10n
                .count_plays(compactNumberFormatter.format(artist.count))),
          );
        },
      ),
    );
  }
}
