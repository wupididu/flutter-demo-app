import 'dart:async';

import 'package:flutter/material.dart';
import 'utils/post_data.dart';
import 'utils/async_repository.dart';

class MyApp extends StatelessWidget {
  final PostsRepository repository = PostsRepository();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) => PostsRepositoryProvider(
        repository,
        child: const MaterialApp(
          home: HomePage(),
        ),
      );
}

class PostsRepositoryProvider extends InheritedWidget {
  final PostsRepository repository;

  const PostsRepositoryProvider(
    this.repository, {
    required super.child,
    super.key,
  });

  @override
  bool updateShouldNotify(covariant PostsRepositoryProvider oldWidget) =>
      oldWidget.repository != repository;

  static PostsRepository of(BuildContext context) => context
      .getInheritedWidgetOfExactType<PostsRepositoryProvider>()!
      .repository;
}

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int page;
  late final PostsRepository repository;

  @override
  void initState() {
    super.initState();
    page = 0;
    repository = PostsRepositoryProvider.of(context);
  }

  void _onChanged(int newPage) {
    setState(() {
      page = newPage;
    });
  }

  Widget _body() {
    switch (page) {
      case 0:
        return const ListsOfPostsBody();
      case 1:
        return const UserBody();
      case 2:
        return const SettingsBody();
      default:
    }

    throw UnimplementedError('unknown page $page');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My App'),
        actions: const [LikedPostsCounter()],
      ),
      body: _body(),
      bottomNavigationBar: BottomMenu(
        page: page,
        onChanged: _onChanged,
      ),
    );
  }
}

class LikedPostsCounter extends StatefulWidget {
  const LikedPostsCounter({super.key});

  @override
  State<LikedPostsCounter> createState() => _LikedPostsCounterState();
}

class _LikedPostsCounterState extends State<LikedPostsCounter> {
  late final PostsRepository _postsRepository;
  late final Stream<int> _countOfLikedPostsStream;

  @override
  void initState() {
    super.initState();
    _postsRepository = PostsRepositoryProvider.of(context);
    _countOfLikedPostsStream = _postsRepository.countOfLikedPostsStream;
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<int>(
        stream: _countOfLikedPostsStream,
        builder: (context, snapshot) {
          final data = snapshot.data ?? 0;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('liked: $data'),
          );
        },
      );
}

class BottomMenu extends StatelessWidget {
  final int page;
  final ValueChanged<int> onChanged;

  const BottomMenu({
    required this.page,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: page,
      onTap: onChanged,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'User',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
    );
  }
}

class UserBody extends StatefulWidget {
  const UserBody({super.key});

  @override
  State<UserBody> createState() => _UserBodyState();
}

class _UserBodyState extends State<UserBody> {
  late final PostsRepository repository;
  List<PostData>? likedPosts;

  @override
  void initState() {
    super.initState();
    repository = PostsRepositoryProvider.of(context);
    _fetchData();
  }

  Future<void> _fetchData() async {
    final likedPosts = await repository.getLikedPosts();

    // мы вызываели await, значит, не факт, что, когда завершится операция,
    // виджет еще будет жить
    // обязательно это нужно проверить, а то будет ругаться на setState
    if (!mounted) {
      return;
    }
    setState(() {
      this.likedPosts = likedPosts;
    });
  }

  @override
  Widget build(BuildContext context) {
    final posts = likedPosts;
    if (posts == null) {
      return const SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Bio(),
              CircularProgressIndicator(),
            ],
          ),
        ),
      );
    }
    return Center(
      child: ListView.builder(
        itemCount: posts.length + 1,
        itemBuilder: (context, index) => index == 0
            ? const Bio()
            : PostItem(
                // про это можно пока не думать
                key: ValueKey(posts[index - 1]),
                data: posts[index - 1],
              ),
      ),
    );
  }
}

class Bio extends StatelessWidget {
  const Bio({super.key});

  @override
  Widget build(BuildContext context) => Column(
        children: [
          SizedBox(
            height: 200,
            width: 200,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.asset('assets/cat.jpg', fit: BoxFit.fitHeight),
            ),
          ),
          const Text(
            'Oliver Grant',
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
          ),
          const Text(
            'About me:',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Hello, human! I am a creature of mystery, elegance, and just the '
              'right amount of chaos. I enjoy warm sunbeams, soft blankets, and '
              'long naps (preferably in the most inconvenient spots). My daily '
              'mission? To knock things off tables, chase invisible prey, and '
              'remind everyone who’s really in charge here. Approach with treats, '
              'and I might grace you with a purr. Or I might not. After all, I’m a cat.',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      );
}

class SettingsBody extends StatelessWidget {
  const SettingsBody({super.key});

  @override
  Widget build(BuildContext context) => const Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Version app:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('Demo')
              ],
            ),
          ),
        ],
      );
}

class ListsOfPostsBody extends StatefulWidget {
  const ListsOfPostsBody({
    super.key,
  });

  @override
  State<ListsOfPostsBody> createState() => _ListsOfPostsBodyState();
}

class _ListsOfPostsBodyState extends State<ListsOfPostsBody> {
  late final PostsRepository repository;
  late final Future<List<PostData>> postDataFuture;

  @override
  void initState() {
    super.initState();
    repository = PostsRepositoryProvider.of(context);
    postDataFuture = repository.getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: postDataFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final items = snapshot.data ?? [];
          return LayoutBuilder(builder: (context, constraint) {
            final size = constraint.biggest;

            if (size.height < size.width) {
              return GridView.builder(
                itemCount: items.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2.5,
                ),
                itemBuilder: (context, index) => PostItem(
                  // про это можно пока не думать
                  key: ValueKey(items[index]),
                  data: items[index],
                ),
              );
            } else {
              return Center(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) => PostItem(
                    // про это можно пока не думать
                    key: ValueKey(items[index]),
                    data: items[index],
                  ),
                ),
              );
            }
          });
        });
  }
}

class PostItem extends StatefulWidget {
  final PostData data;

  const PostItem({
    required this.data,
    super.key,
  });

  @override
  State<PostItem> createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  late bool liked;
  late final PostsRepository repository;

  @override
  void initState() {
    super.initState();
    repository = PostsRepositoryProvider.of(context);
    liked = repository.isLiked(widget.data);
  }

  void _onTapLikeButton() {
    setState(() {
      liked = true;
      repository.likePost(widget.data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 32,
      ),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.amber,
        border: Border.all(width: 5),
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      widget.data.message,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: Text(widget.data.author),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  icon: Icon(
                    Icons.thumb_up,
                    color: liked ? Colors.redAccent : Colors.deepPurpleAccent,
                  ),
                  onPressed: _onTapLikeButton,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
