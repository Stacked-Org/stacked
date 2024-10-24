import 'package:stacked/stacked.dart';

/// A [SearchViewModel] that provides functionality to search for items of [T]
/// type.
abstract class SearchViewModel<T> extends ReactiveViewModel
    with FormStateHelper {
  /// Busy object for [searchItems]
  abstract final String busySearchingItems;

  String? _searchTerm;
  String? get searchTerm => _searchTerm;

  bool get hasSearchTerm => searchTerm != null;

  bool get canRequestSearch => hasSearchTerm && searchTerm!.length > 3;

  bool get showClearIcon => hasSearchTerm && searchTerm!.isNotEmpty;

  bool _isSearchActive = false;
  bool get isSearchActive => _isSearchActive;

  bool _searchResultPlaced = false;
  bool get searchResultPlaced => _searchResultPlaced;

  List<T> _items = <T>[];
  List<T> get items => _items;

  bool get hasSearchResults => items.isNotEmpty;

  bool get isSearchInProgress =>
      busy(busySearchingItems) ||
      isSearchActive ||
      hasSearchResults ||
      searchResultPlaced ||
      hasSearchTerm;

  Future<List<T>> searchItems(String term);

  void setSearchActive(bool value) {
    _isSearchActive = value;
    rebuildUi();
  }

  void clearSearch() {
    _searchTerm = null;
    _searchResultPlaced = false;
    _items.clear();

    rebuildUi();
  }

  Future<void> searchForText() => _searchForText(searchTerm);

  Future<void> _searchForText(String? term) async {
    if (term == null || term.isEmpty || term.length < 4) return;

    _searchTerm = term.trim();

    _items = await runBusyFuture(
      searchItems(term),
      busyObject: busySearchingItems,
      throwException: true,
    );

    _searchResultPlaced = true;

    rebuildUi();
  }

  void setSearchTerm(String term) {
    _searchTerm = term;
  }
}
