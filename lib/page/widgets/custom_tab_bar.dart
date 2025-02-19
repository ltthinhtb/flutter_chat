// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Standard iOS 10 tab bar height.
const double _kTabBarHeight = 50.0;

const Color _kDefaultTabBarBorderColor = Color(0x4C000000);

/// An iOS-styled bottom navigation tab bar.
///
/// Displays multiple tabs using [CustomNavigationBarItem] with one tab being
/// active, the first tab by default.
///
/// This [StatelessWidget] doesn't store the active tab itself. You must
/// listen to the [onTap] callbacks and call `setState` with a new [currentIndex]
/// for the new selection to reflect. This can also be done automatically
/// by wrapping this with a [CustomTabScaffold].
///
/// Tab changes typically trigger a switch between [Navigator]s, each with its
/// own navigation stack, per standard iOS design. This can be done by using
/// [CustomTabView]s inside each tab builder in [CustomTabScaffold].
///
/// If the given [backgroundColor]'s opacity is not 1.0 (which is the case by
/// default), it will produce a blurring effect to the content behind it.
///
/// See also:
///
///  * [CustomTabScaffold], which hosts the [CustomTabBar] at the bottom.
///  * [CustomNavigationBarItem], an item in a [CustomTabBar].
class CustomTabBar extends StatelessWidget implements PreferredSizeWidget {
  /// Creates a tab bar in the iOS style.
  CustomTabBar({
    Key key,
    @required this.items,
    this.onTap,
    this.currentIndex = 0,
    this.backgroundColor,
    this.activeColor,
    this.inactiveColor = Colors.grey,
    this.iconSize = 30.0,
    this.border = const Border(
      top: BorderSide(
        color: _kDefaultTabBarBorderColor,
        width: 0.0, // One physical pixel.
        style: BorderStyle.solid,
      ),
    ),
  })  : assert(items != null),
        assert(
          items.length >= 2,
          "Tabs need at least 2 items to conform to Apple's HIG",
        ),
        assert(currentIndex != null),
        assert(0 <= currentIndex && currentIndex < items.length),
        assert(iconSize != null),
        assert(inactiveColor != null),
        super(key: key);

  /// The interactive items laid out within the bottom navigation bar.
  ///
  /// Must not be null.
  final List<BottomNavigationBarItem> items;

  /// The callback that is called when a item is tapped.
  ///
  /// The widget creating the bottom navigation bar needs to keep track of the
  /// current index and call `setState` to rebuild it with the newly provided
  /// index.
  final ValueChanged<int> onTap;

  /// The index into [items] of the current active item.
  ///
  /// Must not be null and must inclusively be between 0 and the number of tabs
  /// minus 1.
  final int currentIndex;

  /// The background color of the tab bar. If it contains transparency, the
  /// tab bar will automatically produce a blurring effect to the content
  /// behind it.
  ///
  /// Defaults to [CustomTheme]'s `barBackgroundColor` when null.
  final Color backgroundColor;

  /// The foreground color of the icon and title for the [CustomNavigationBarItem]
  /// of the selected tab.
  ///
  /// Defaults to [CustomTheme]'s `primaryColor` if null.
  final Color activeColor;

  /// The foreground color of the icon and title for the [CustomNavigationBarItem]s
  /// in the unselected state.
  ///
  /// Defaults to [CustomColors.inactiveGray] and cannot be null.
  final Color inactiveColor;

  /// The size of all of the [CustomNavigationBarItem] icons.
  ///
  /// This value is used to configure the [IconTheme] for the navigation bar.
  /// When a [CustomNavigationBarItem.icon] widget is not an [Icon] the widget
  /// should configure itself to match the icon theme's size and color.
  ///
  /// Must not be null.
  final double iconSize;

  /// The border of the [CustomTabBar].
  ///
  /// The default value is a one physical pixel top border with grey color.
  final Border border;

  @override
  Size get preferredSize => const Size.fromHeight(_kTabBarHeight);

  /// Indicates whether the tab bar is fully opaque or can have contents behind
  /// it show through it.
  bool opaque(BuildContext context) {
    final Color backgroundColor =
        this.backgroundColor ?? Theme.of(context).bottomAppBarColor;
    return backgroundColor.alpha == 0xFF;
  }

  @override
  Widget build(BuildContext context) {
    final double bottomPadding = MediaQuery.of(context).padding.bottom;

    Widget result = DecoratedBox(
      decoration: BoxDecoration(
        border: border,
        color: backgroundColor ?? Theme.of(context).bottomAppBarColor,
      ),
      child: SizedBox(
        height: _kTabBarHeight + bottomPadding,
        child: IconTheme.merge(
          // Default with the inactive state.
          data: IconThemeData(
            color: inactiveColor,
            size: iconSize,
          ),
          child: DefaultTextStyle(
            // Default with the inactive state.
            style: Theme.of(context)
                .textTheme
                // ignore: deprecated_member_use
                .title
                .copyWith(color: inactiveColor),
            child: Padding(
              padding: EdgeInsets.only(bottom: bottomPadding),
              child: Row(
                // Align bottom since we want the labels to be aligned.
                crossAxisAlignment: CrossAxisAlignment.end,
                children: _buildTabItems(context),
              ),
            ),
          ),
        ),
      ),
    );

    if (!opaque(context)) {
      // For non-opaque backgrounds, apply a blur effect.
      result = ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: result,
        ),
      );
    }

    return result;
  }

  List<Widget> _buildTabItems(BuildContext context) {
    final List<Widget> result = <Widget>[];

    for (int index = 0; index < items.length; index += 1) {
      final bool active = index == currentIndex;
      result.add(
        _wrapActiveItem(
          context,
          Expanded(
            child: Semantics(
              selected: active,
              // TODO(xster): This needs localization support. https://github.com/flutter/flutter/issues/13452
              hint: 'tab, ${index + 1} of ${items.length}',
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: onTap == null
                    ? null
                    : () {
                        onTap(index);
                      },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: _buildSingleTabItem(items[index], active),
                  ),
                ),
              ),
            ),
          ),
          active: active,
        ),
      );
    }

    return result;
  }

  List<Widget> _buildSingleTabItem(BottomNavigationBarItem item, bool active) {
    final List<Widget> components = <Widget>[
      Expanded(
        child: Center(child: active ? item.activeIcon : item.icon),
      )
    ];

    // ignore: deprecated_member_use
    if (item.title != null) {
      // ignore: deprecated_member_use
      components.add(item.title);
    }

    return components;
  }

  /// Change the active tab item's icon and title colors to active.
  Widget _wrapActiveItem(BuildContext context, Widget item,
      {@required bool active}) {
    if (!active) return item;

    final Color activeColor =
        this.activeColor ?? Theme.of(context).primaryColor;
    return IconTheme.merge(
      data: IconThemeData(color: activeColor),
      child: DefaultTextStyle.merge(
        style: TextStyle(color: activeColor),
        child: item,
      ),
    );
  }

  /// Create a clone of the current [CustomTabBar] but with provided
  /// parameters overridden.
  CustomTabBar copyWith({
    Key key,
    List<BottomNavigationBarItem> items,
    Color backgroundColor,
    Color activeColor,
    Color inactiveColor,
    Size iconSize,
    Border border,
    int currentIndex,
    ValueChanged<int> onTap,
  }) {
    return CustomTabBar(
      key: key ?? this.key,
      items: items ?? this.items,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      activeColor: activeColor ?? this.activeColor,
      inactiveColor: inactiveColor ?? this.inactiveColor,
      iconSize: iconSize ?? this.iconSize,
      border: border ?? this.border,
      currentIndex: currentIndex ?? this.currentIndex,
      onTap: onTap ?? this.onTap,
    );
  }
}
