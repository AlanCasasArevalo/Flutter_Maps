part of 'widgets.dart';

class SearchBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState> (
      builder: (context, state) {
        if (state.manualSelection) {
          return Container();
        } else {
          return FadeInDown(child: _buildSearchBar(context));
        }
      },
    );
  }

  Widget _buildSearchBar(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        width: size.width,
        height: 50,
        child: GestureDetector(
          onTap: () async {
            final SearchResult result = await showSearch(context: context, delegate: SearchDestination());
            this._searchResults(context, result);
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

  void _searchResults(BuildContext context, SearchResult result) {
    final _searchBloc = BlocProvider.of<SearchBloc>(context);
    if(result.canceled) return;
    if (result.manual) {
      _searchBloc.add(OnPinMarkedActivated());
      return;
    }
  }
}
