import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';
import '../../../theme/theme.dart';
import '../../../widgets/song/song_tile.dart';
import '../view_model/library_view_model.dart';

class LibraryContent extends StatelessWidget {
  const LibraryContent({super.key});

  @override
  Widget build(BuildContext context) {
    // 1- Read the globbal song repository
    LibraryViewModel mv = context.watch<LibraryViewModel>();

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 16),
          Text("Library", style: AppTextStyles.heading),
          SizedBox(height: 50),

          Expanded(
            child: Builder(
              builder: (context) {
                if (mv.songs.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (mv.songs.hasError) {
                  return Center(child: Text("Error: ${mv.songs.error}"));
                }

                final songs = mv.songs.value ?? [];
                return ListView.builder(
                  itemCount: songs.length,
                  itemBuilder: (context, index) => SongTile(
                    song: songs[index],
                    isPlaying: mv.isSongPlaying(songs[index]),
                    onTap: () {
                      mv.start(songs[index]);
                    },
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
