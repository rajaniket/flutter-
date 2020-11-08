import 'package:flutter/material.dart';
import 'quote.dart';
void main() => runApp(MaterialApp(
  home: QuoteList(),
));

class QuoteList extends StatefulWidget {
  @override
  _QuoteListState createState() => _QuoteListState();
}

class _QuoteListState extends State<QuoteList> {
  List<Quote> quotes=[
    Quote(author: 'Oscar Wilde',text: 'Be yourself; everyone is already taken'),
    Quote(author: 'Oscar Wilde',text: 'I have nothing to declare except my genius'),
    Quote(text: 'The truth is rarely pure and never simple',author: 'Oscar Wilde')
  ];
  Widget quoteTemplete(quote){ // return type is a widget
    return Card(
      margin: EdgeInsets.fromLTRB(16,16,16,0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(quote.text,    // quote is an argument
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 6.0),
            Text(quote.author,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey[800],
              ),
            )
          ],
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Awesome Quotes'),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
        elevation: 0.0,
      ),
      body: Column(
        children: quotes.map((i) => quoteTemplete(i)).toList(),  // map is iterable and returning each element through iteration but as we know children accepts only list so we have to return a list  that's why using toList() and i is representing each quote in iteration
      ),

    );
  }
}
