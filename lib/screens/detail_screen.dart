import 'package:flutter/material.dart';
import 'package:news_aggregator/models/article.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

class DetailScreen extends StatelessWidget {
  final Article article;

  const DetailScreen({super.key, required this.article});

  void _launchURL(BuildContext context) async {
    final urlString = article.url;
    final url = Uri.tryParse(
      urlString.startsWith('http') ? urlString : 'https://$urlString',
    );

    if (url != null && await canLaunchUrl(url)) {
      final launched = await launchUrl(url, mode: LaunchMode.platformDefault);
      if (!launched) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open the article URL')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid or unsupported URL')),
      );
    }
  }

  void _shareArticle() {
    Share.share(article.url, subject: article.title);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text(
          article.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: _shareArticle,
            tooltip: 'Share Article',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (article.image.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  article.image,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: 16),
            Text(
              article.title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              article.description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => _launchURL(context),
              icon: const Icon(Icons.open_in_browser),
              label: const Text('Read Full Article'),
              style: ElevatedButton.styleFrom(
                padding:
                const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}