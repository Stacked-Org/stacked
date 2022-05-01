// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef FLUTTER_FLUTTERDARTPROJECT_H_
#define FLUTTER_FLUTTERDARTPROJECT_H_

#import <Foundation/Foundation.h>

#import "FlutterMacros.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * A set of Flutter and Dart assets used by a `FlutterEngine` to initialize execution.
 */
FLUTTER_DARWIN_EXPORT
@interface FlutterDartProject : NSObject

/**
 * Initializes a Flutter Dart project from a bundle.
 */
- (instancetype)initWithPrecompiledDartBundle:(nullable NSBundle*)bundle NS_DESIGNATED_INITIALIZER;

/**
 * Unavailable - use `init` instead.
 */
- (instancetype)initFromDefaultSourceForConfiguration FLUTTER_UNAVAILABLE("Use -init instead.");

/**
 * Returns the file name for the given asset. If the bundle with the identifier
 * "io.flutter.flutter.app" exists, it will try use that bundle; otherwise, it
 * will use the main bundle.  To specify a different bundle, use
 * `-lookupKeyForAsset:asset:fromBundle`.
 *
 * @param asset The name of the asset. The name can be hierarchical.
 * @return the file name to be used for lookup in the main bundle.
 */
+ (NSString*)lookupKeyForAsset:(NSString*)asset;

/**
 * Returns the file name for the given asset.
 * The returned file name can be used to access the asset in the supplied bundle.
 *
 * @param asset The name of the asset. The name can be hierarchical.
 * @param bundle The `NSBundle` to use for looking up the asset.
 * @return the file name to be used for lookup in the main bundle.
 */
+ (NSString*)lookupKeyForAsset:(NSString*)asset fromBundle:(nullable NSBundle*)bundle;

/**
 * Returns the file name for the given asset which originates from the specified package.
 * The returned file name can be used to access the asset in the application's main bundle.
 *
 * @param asset The name of the asset. The name can be hierarchical.
 * @param package The name of the package from which the asset originates.
 * @return the file name to be used for lookup in the main bundle.
 */
+ (NSString*)lookupKeyForAsset:(NSString*)asset fromPackage:(NSString*)package;

/**
 * Returns the file name for the given asset which originates from the specified package.
 * The returned file name can be used to access the asset in the specified bundle.
 *
 * @param asset The name of the asset. The name can be hierarchical.
 * @param package The name of the package from which the asset originates.
 * @param bundle The bundle to use when doing the lookup.
 * @return the file name to be used for lookup in the main bundle.
 */
+ (NSString*)lookupKeyForAsset:(NSString*)asset
                   fromPackage:(NSString*)package
                    fromBundle:(nullable NSBundle*)bundle;

/**
 * Returns the default identifier for the bundle where we expect to find the Flutter Dart
 * application.
 */
+ (NSString*)defaultBundleIdentifier;

@end

NS_ASSUME_NONNULL_END

#endif  // FLUTTER_FLUTTERDARTPROJECT_H_
