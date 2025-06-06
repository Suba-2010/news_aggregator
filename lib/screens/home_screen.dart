  import 'package:flutter/material.dart';
  import 'package:news_aggregator/services/news_api_service.dart';
  import 'package:news_aggregator/models/article.dart';
  import 'package:news_aggregator/widgets/news_card.dart';

  class HomeScreen extends StatefulWidget {
    const HomeScreen({super.key});

    @override
    State<HomeScreen> createState() => _HomeScreenState();

  }

  class _HomeScreenState extends State<HomeScreen> {
    late Future<List<Article>>_newsFuture;
    final TextEditingController _searchController = TextEditingController();
    String _searchQuery = '';
    final NewsApiService _newsApiService=NewsApiService();
    final Map<String, String> categories = {
      'general': 'latest',
      'sports': 'sports',
      'technology': 'technology',
      'health': 'health',
      'business': 'business',
    };
    String selectedCategory = 'general';
    @override
    void initState(){
      super.initState();
      _newsFuture = _newsApiService.searchNews(
        query: categories[selectedCategory]!,
        country: 'in',
        lang: 'en',
        maxResults: 20,
      );
    }
    void _changeCategory(String category){
      setState(() {
        selectedCategory = category;
        _newsFuture = _newsApiService.searchNews(
          query: categories[category]!,
          country: 'in',
          lang: 'en',
          maxResults: 20,
        );
      });
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.lightBlueAccent,
        appBar: AppBar(
          title: const Text('News Aggregator'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Padding(
              padding:EdgeInsets.all(8),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search News.....',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onSubmitted: (value){
                  if(value.trim().isEmpty)return;
                  setState(() {
                    _searchQuery=value.trim();
                    _newsFuture=_newsApiService.searchNews(
                      query: _searchQuery,
                      country: 'in',
                      lang: 'en',
                      maxResults: 20,
                    );
                  });
                },
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: ['general','sports','technology','health','business'].map((category)=>Padding(
                    padding:EdgeInsets.symmetric(horizontal: 8,vertical: 10),
                    child: ChoiceChip(
                        label: Text(category),
                        selected: selectedCategory==category,
                        onSelected:(_)=>_changeCategory(category),
                    ),
                )).toList(),
              ),
            ),
            Expanded(
                child:FutureBuilder<List<Article>>(
                    future: _newsFuture,
                    builder: (context,snapshot){
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return Center(child:CircularProgressIndicator());
                      }
                      else if(snapshot.hasError){
                        return Center(
                          child: Text('Error:${snapshot.error}')
                        );
                      }
                      else if(!snapshot.hasData||snapshot.data!.isEmpty){
                        return Center(
                            child:Text('No Articles Available'));
                      }
                      final articles=snapshot.data!;
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: articles.length,
                        itemBuilder: (context, index) => NewsCard(article: articles[index]),
                      );
                    }
                )
            )
          ],
        ),
      );
    }
  }

