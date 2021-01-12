part of 'widgets.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final _mapBloc = BlocProvider.of<MapBloc>(context);
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        width: size.width,
        height: 50,
        child: GestureDetector(
          onTap: () async {
            final SearchResult result = await showSearch(context: context, delegate: SearchDestination());
            this._searchResults(result);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12, blurRadius: 5, offset: Offset(0, 5)
                )
              ]
            ),
            child: Text(Constants.searchBarPlaceholder),
          ),
        ),
      ),
    );
  }

  void _searchResults(SearchResult result) {
    if(result.canceled) return;
  }
}
