class PostData {
  final String message;
  final String author;

  PostData(this.message, this.author);
}

abstract class MockItems {
  static final items = [
    PostData(
      'Movies are dreams we can watch on the big screen.',
      'Ava Ramirez',
    ),
    PostData(
      'A great film stays with you long after the credits roll.',
      'Lucas Jensen',
    ),
    PostData(
      'In movies, we escape reality and embrace magic.',
      'Maya Brooks',
    ),
    PostData(
      'Every film is a journey through someone else’s eyes.',
      'Ethan Clarke',
    ),
    PostData(
      'Good cinema makes us feel every possible emotion.',
      'Sofia Lee',
    ),
    PostData(
      'A great story, well told—that’s the art of film.',
      'Oscar Patel',
    ),
    PostData(
      'Movies show us different worlds without leaving our seat.',
      'Liam Foster',
    ),
    PostData(
      'Cinema is the language that speaks to every heart.',
      'Ella Simmons',
    ),
    PostData(
      'Each film scene is like a frame in a moving masterpiece.',
      'James O’Neil',
    ),
    PostData(
      'From script to screen, every film is a creative journey.',
      'Aria Mitchell',
    ),
  ];
}
