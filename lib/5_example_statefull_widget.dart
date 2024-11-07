import 'package:flutter/material.dart';

import 'utils/post_data.dart';
import 'utils/sync_repository.dart';

class MyApp extends StatelessWidget {
  final PostsRepository repository = PostsRepository();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: HomePage(
          repository: repository,
        ),
      );
}

// Обьявляем сам виджет
class HomePage extends StatefulWidget {
  final PostsRepository repository;

  const HomePage({
    required this.repository,
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

// Обьявляем стейт виджета
class _HomePageState extends State<HomePage> {
  late int page;

  @override
  void initState() {
    super.initState();
    // здесь инициируем наш стейт
    page = 0;
  }

  void _onChanged(int newPage) {
    // говорим фремворку, что нужно перерисовать виджет
    // и тогда фреймворк заново вызывает метод build()
    setState(() {
      page = newPage;
    });
  }

  Widget _body() {
    switch (page) {
      case 0:
        return ListsOfPostsBody(
          repository: widget.repository,
        );
      case 1:
        return UserBody(
          repository: widget.repository,
        );
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
      ),
      body: _body(),
      // Из виджета навигации достаем номер экрана
      bottomNavigationBar: BottomMenu(
        page: page,
        onChanged: _onChanged,
      ),
    );
  }
}

class BottomMenu extends StatelessWidget {
  final int page;
  final void Function(int) onChanged;

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
  final PostsRepository repository;

  const UserBody({required this.repository, super.key});

  @override
  State<UserBody> createState() => _UserBodyState();
}

class _UserBodyState extends State<UserBody> {
  late final List<PostData> likedPosts;

  @override
  void initState() {
    super.initState();
    // Хорошей практикой является делать какие-то походы, например
    // в репозитории, вне метода build(). Метод build может
    // вызываться достаточно часто и не так, как мы ожидаем.
    likedPosts = widget.repository.getLikedPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
        itemCount: likedPosts.length + 1,
        itemBuilder: (context, index) => index == 0
            ? const Bio()
            : PostItem(
                data: likedPosts[index - 1],
                repository: widget.repository,
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
  final PostsRepository repository;

  const ListsOfPostsBody({
    required this.repository,
    super.key,
  });

  @override
  State<ListsOfPostsBody> createState() => _ListsOfPostsBodyState();
}

class _ListsOfPostsBodyState extends State<ListsOfPostsBody> {
  late List<PostData> items;

  @override
  void initState() {
    super.initState();
    items = widget.repository.getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) => PostItem(
          // про это можно пока не думать
          key: ValueKey(items[index]),
          data: items[index],
          repository: widget.repository,
        ),
      ),
    );
  }
}

class PostItem extends StatefulWidget {
  final PostData data;
  final PostsRepository repository;

  const PostItem({
    required this.data,
    required this.repository,
    super.key,
  });

  @override
  State<PostItem> createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  late bool liked;

  @override
  void initState() {
    super.initState();
    liked = widget.repository.isLiked(widget.data);
  }

  void _onTapLikeButton() {
    setState(() {
      liked = true;
      widget.repository.likePost(widget.data);
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
