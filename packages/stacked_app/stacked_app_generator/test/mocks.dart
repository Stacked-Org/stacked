import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:stacked_app_generator/stacked_app_generator.dart';
import 'package:build/build.dart';

const pkg = '_test_';

class StackedRouterGeneratorMock extends StackedRouterGenerator {
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
  Future<LibraryElement> libraryFor(AssetId assetId,
      {bool allowSyntaxErrors = false}) {
    throw UnimplementedError();
  }

  @override
  Future<CompilationUnit> compilationUnitFor(AssetId assetId,
      {bool allowSyntaxErrors = false}) {
    // TODO: implement compilationUnitFor
    throw UnimplementedError();
  }
}
