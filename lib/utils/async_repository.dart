import 'dart:async';

import 'post_data.dart';

class PostsRepository {
  final _streamController = StreamController<List<PostData>>.broadcast();
  final _likedPosts = <PostData>[];

  Future<List<PostData>> getPosts() async =>
      Future.delayed(const Duration(seconds: 3), () => MockItems.items);

  Future<List<PostData>> getLikedPosts() async =>
      Future.delayed(const Duration(seconds: 3), () => _likedPosts);

  Stream<int> get countOfLikedPostsStream =>
      _streamController.stream.map((posts) => posts.length);

  void likePost(PostData data) {
    if (_likedPosts.contains(data)) {
      return;
    }
    _likedPosts.add(data);
    _streamController.add(_likedPosts);
  }

  bool isLiked(PostData data) => _likedPosts.contains(data);
}
