import 'package:flutter/material.dart';
import 'quote.dart';

void main() => runApp(const MaterialApp(
      home: QuoteList(),
    ));

class QuoteList extends StatefulWidget {
  const QuoteList({super.key});

  @override
  State<QuoteList> createState() => _QuoteListState();
}

List<Quote> quotes = [
  Quote(author: 'Natty up', title: 'am just jocking'),
  Quote(author: 'Haddis', title: 'Fikir Eske Mekabir'),
  Quote(author: 'Hashmal', title: "I don't Know")
];

Widget quoteTemplate(quote) {
  return Padding(
    padding: const EdgeInsets.all(14.0),
    child: Card(
        margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
        child: Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(quote.title,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.grey[700],
                )
                ),
                const SizedBox(height: 6.0),
                Text(quote.author,
                style:const TextStyle(
                  fontSize: 14.0,
                  color:  Color.fromARGB(167, 97, 97, 97),
                )
                ),
          ],
        )),
  );
}

class _QuoteListState extends State<QuoteList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Awesome Quotes"),
        centerTitle: true,
        backgroundColor:const Color.fromARGB(217, 233, 79, 79),
      ),
      body: Column(
        children: quotes.map((quote) => quoteTemplate(quote)).toList(),
      ),
    );
  }
}
