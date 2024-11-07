import 'post_data.dart';

class PostsRepository {
  final _likedPosts = <PostData>[];

  List<PostData> getPosts() => MockItems.items;
  List<PostData> getLikedPosts() => _likedPosts;

  void likePost(PostData data) {
    if (_likedPosts.contains(data)) {
      return;
    }
    _likedPosts.add(data);
  }

  bool isLiked(PostData data) => _likedPosts.contains(data);
}
