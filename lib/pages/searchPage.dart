import 'package:algolia_helper_flutter/algolia_helper_flutter.dart';
import 'package:financially/components/searchCard.dart';
import 'package:financially/models/AssetInfo.dart';
import 'package:financially/models/HitPage.dart';
import 'package:financially/models/SearchMetadata.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _stocksSearcher = HitsSearcher(
      applicationID: '5X7LUN8XGB',
      apiKey: 'ba2fc08c1f22582d8886b3ea6f573fa0',
      indexName: 'stocks');

  final _searchTextController = TextEditingController();
  final PagingController<int, AssetInfo> _pagingController =
      PagingController(firstPageKey: 0);

  Stream<SearchMetadata> get _searchMetadata =>
      _stocksSearcher.responses.map(SearchMetadata.fromResponse);
  Stream<HitsPage> get _searchPage =>
      _stocksSearcher.responses.map(HitsPage.fromResponse);

  @override
  void initState() {
    super.initState();
    _searchTextController.addListener(() {
      _stocksSearcher.query(_searchTextController.text);
      _pagingController.refresh();
    });
    _searchPage.listen((page) {
      if (page.pageKey == 0) {
        _pagingController.refresh();
      }
      _pagingController.appendPage(page.items, page.nextPageKey);
    }).onError((error) => _pagingController.error = error);
    _pagingController.addPageRequestListener((pageKey) =>
        _stocksSearcher.applyState((state) => state.copyWith(page: pageKey)));
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    _stocksSearcher.dispose();
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Container(
            width: MediaQuery.of(context).size.width * .7,
            height: kToolbarHeight * 0.8,
            decoration: BoxDecoration(
              color: Colors.white70,
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextField(
              autofocus: true,
              controller: _searchTextController,
              autocorrect: false,
              enableSuggestions: false,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter ticker or keyword',
                prefixIcon: Icon(Icons.search_rounded),
              ),
              style: const TextStyle(
                color: Colors.pink,
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(color: Colors.pink.shade100),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                StreamBuilder<SearchMetadata>(
                  stream: _searchMetadata,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const SizedBox.shrink();
                    }
                    return Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text('${snapshot.data!.nbHits} results'),
                    );
                  },
                ),
                Expanded(child: _hits(context)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _hits(BuildContext context) => PagedListView<int, AssetInfo>(
      pagingController: _pagingController,
      builderDelegate: PagedChildBuilderDelegate<AssetInfo>(
          noItemsFoundIndicatorBuilder: (_) => const Center(
                child: Text('No results found'),
              ),
          itemBuilder: (_, item, __) => Container(
                height: 130,
                padding: const EdgeInsets.all(4),
                child: SearchCard(
                  cardinfo: item,
                ),
              )));
}
