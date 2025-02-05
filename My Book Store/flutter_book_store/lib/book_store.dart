// ignore: file_names
import 'package:flutter/material.dart';

void main() {
  runApp(BookStoreApp());
}

class Book {
  final String title;
  final String author;
  final String description;
  final double price;
  final String imageUrl;

  Book({
    required this.title,
    required this.author,
    required this.description,
    required this.price,
    required this.imageUrl,
  });
}

// ignore: use_key_in_widget_constructors
class BookStoreApp extends StatelessWidget {
  final List<Book> books = [
    Book(
      title: 'Ameneta',
      author: 'Eyob Mamo',
      description: 'the bool for love story',
      price: 69.99,
      imageUrl: 'lib/Resources/images/ameneta.jpg',
    ),
    Book(
      title: 'Balnjeraye',
      author: 'Dr Tekalgn',
      description: 'childhood story',
      price: 80.99,
      imageUrl: 'lib/Resources/images/Balnjeraye.jpg',
    ),
    Book(
      title: 'Temsalet',
      author: 'Nathaniel Temesegen',
      description: 'Description of this book',
      price: 12.99,
      imageUrl: 'lib/Resources/images/Temsalet.jpg',
    ),
    Book(
      title: 'Mamo Kilo',
      author: 'Yohannes',
      description: 'Story of silly child',
      price: 28.99,
      imageUrl: 'lib/Resources/images/SillyMammo.jpg',
    ),
    Book(
      title: "Tsion's life",
      author: 'Stacy Bailward',
      description: 'Female story',
      price: 65.99,
      imageUrl: 'lib/Resources/images/Tsion.jpg',
    ),
    // Add more books here...
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book Store',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BookListScreen(books: books),
    );
  }
}

class BookListScreen extends StatelessWidget {
  final List<Book> books;

  const BookListScreen({super.key, required this.books});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Store'),
      ),
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) {
          final book = books[index];
          return ListTile(
            leading: SizedBox(
              width: 60, // Adjust the width as needed
              child: Image.network(book.imageUrl),
            ),
            title: Text(book.title),
            subtitle: Text(book.author),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookDetailsScreen(book: book),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class BookDetailsScreen extends StatelessWidget {
  final Book book;

  const BookDetailsScreen({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Details'),
      ),
      body: Row(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(book.imageUrl),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              book.title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Author: ${book.author}',
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Price: \$${book.price.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Description: ${book.description}',
              style: const TextStyle(fontSize: 16),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Implement adding book to cart
            },
            child: const Text('Add to Cart'),
          ),
        ],
      ),
    );
  }
}
