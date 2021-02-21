import 'package:analyzer/dart/element/element.dart';
import 'package:stacked_generator/src/generators/router/stacked_router_generator.dart';
import 'package:build/build.dart';

const pkg = '_test_';

class StackedRouteGeneratorMock extends StackedRouterGenerator {
  @override
  Resolver getResolver(_) => ResolverMock();
}

class ResolverMock implements Resolver {
  @override
  Future<AssetId> assetIdForElement(Element element) async {
    if (element.source != null) {
      return AssetId(pkg, element.source.uri.pathSegments.last);
    } else {
      return null;
    }
  }

  @override
  Future<LibraryElement> findLibraryByName(String libraryName) {
    return null;
  }

  Future<bool> isLibrary(AssetId assetId) async {
    return false;
  }

  @override
  Stream<LibraryElement> get libraries => null;

  @override
  Future<LibraryElement> libraryFor(AssetId assetId) {
    return null;
  }
}
