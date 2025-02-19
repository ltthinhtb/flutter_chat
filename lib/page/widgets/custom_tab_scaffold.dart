// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'custom_tab_bar.dart';

/// Implements a tabbed iOS application's root layout and behavior structure.
///
/// The scaffold lays out the tab bar at the bottom and the content between or
/// behind the tab bar.
///
/// A [tabBar] and a [tabBuilder] are required. The [CustomTabScaffold]
/// will automatically listen to the provided [CustomTabBar]'s tap callbacks
/// to change the active tab.
///
/// Tabs' contents are built with the provided [tabBuilder] at the active
/// tab index. The [tabBuilder] must be able to build the same number of
/// views.pages as there are [tabBar.items]. Inactive tabs will be moved [Offstage]
/// and their animations disabled.
///
/// Use [CustomTabView] as the content of each tab to support tabs with parallel
/// navigation state and history.
///
/// {@tool sample}
///
/// A sample code implementing a typical iOS information architecture with tabs.
///
/// ```dart
/// CustomTabScaffold(
///   tabBar: CustomTabBar(
///     items: <BottomNavigationBarItem> [
///       // ...
///     ],
///   ),
///   tabBuilder: (BuildContext context, int index) {
///     return CustomTabView(
///       builder: (BuildContext context) {
///         return CustomPageScaffold(
///           navigationBar: CustomNavigationBar(
///             middle: Text('Page 1 of tab $index'),
///           ),
///           child: Center(
///             child: CustomButton(
///               child: const Text('Next page'),
///               onPressed: () {
///                 Navigator.of(context).push(
///                   CustomPageRoute<void>(
///                     builder: (BuildContext context) {
///                       return CustomPageScaffold(
///                         navigationBar: CustomNavigationBar(
///                           middle: Text('Page 2 of tab $index'),
///                         ),
///                         child: Center(
///                           child: CustomButton(
///                             child: const Text('Back'),
///                             onPressed: () { Navigator.of(context).pop(); },
///                           ),
///                         ),
///                       );
///                     },
///                   ),
///                 );
///               },
///             ),
///           ),
///         );
///       },
///     );
///   },
/// )
/// ```
/// {@end-tool}
///
/// To push a route above all tabs instead of inside the currently selected one
/// (such as when showing a dialog on top of this scaffold), use
/// `Navigator.of(rootNavigator: true)` from inside the [BuildContext] of a
/// [CustomTabView].
///
/// See also:
///
///  * [CustomTabBar], the bottom tab bar inserted in the scaffold.
///  * [CustomTabView], the typical root content of each tab that holds its own
///    [Navigator] stack.
///  * [CustomPageRoute], a route hosting modal views.pages with iOS style transitions.
///  * [CustomPageScaffold], typical contents of an iOS modal page implementing
///    layout with a navigation bar on top.
class CustomTabScaffold extends StatefulWidget {
  /// Creates a layout for applications with a tab bar at the bottom.
  ///
  /// The [tabBar] and [tabBuilder] arguments must not be null.
  const CustomTabScaffold({
    Key key,
    @required this.tabBar,
    @required this.tabBuilder,
    this.backgroundColor,
    this.resizeToAvoidBottomInset = true,
  })  : assert(tabBar != null),
        assert(tabBuilder != null),
        super(key: key);

  /// The [tabBar] is a [CustomTabBar] drawn at the bottom of the screen
  /// that lets the user switch between different tabs in the main content area
  /// when present.
  ///
  /// Setting and changing [CustomTabBar.currentIndex] programmatically will
  /// change the currently selected tab item in the [tabBar] as well as change
  /// the currently focused tab from the [tabBuilder].

  /// If [CustomTabBar.onTap] is provided, it will still be called.
  /// [CustomTabScaffold] automatically also listen to the
  /// [CustomTabBar]'s `onTap` to change the [CustomTabBar]'s `currentIndex`
  /// and change the actively displayed tab in [CustomTabScaffold]'s own
  /// main content area.
  ///
  /// If translucent, the main content may slide behind it.
  /// Otherwise, the main content's bottom margin will be offset by its height.
  ///
  /// Must not be null.
  final CustomTabBar tabBar;

  /// An [IndexedWidgetBuilder] that's called when tabs become active.
  ///
  /// The views.widgets built by [IndexedWidgetBuilder] is typically a [CustomTabView]
  /// in order to achieve the parallel hierarchies information architecture seen
  /// on iOS apps with tab bars.
  ///
  /// When the tab becomes inactive, its content is still cached in the widget
  /// tree [Offstage] and its animations disabled.
  ///
  /// Content can slide under the [tabBar] when they're translucent.
  /// In that case, the child's [BuildContext]'s [MediaQuery] will have a
  /// bottom padding indicating the area of obstructing overlap from the
  /// [tabBar].
  ///
  /// Must not be null.
  final IndexedWidgetBuilder tabBuilder;

  /// The color of the widget that underlies the entire scaffold.
  ///
  /// By default uses [CustomTheme]'s `scaffoldBackgroundColor` when null.
  final Color backgroundColor;

  /// Whether the [child] should size itself to avoid the window's bottom inset.
  ///
  /// For example, if there is an onscreen keyboard displayed above the
  /// scaffold, the body can be resized to avoid overlapping the keyboard, which
  /// prevents views.widgets inside the body from being obscured by the keyboard.
  ///
  /// Defaults to true and cannot be null.
  final bool resizeToAvoidBottomInset;

  @override
  _CustomTabScaffoldState createState() => _CustomTabScaffoldState();
}

class _CustomTabScaffoldState extends State<CustomTabScaffold> {
  int _currentPage;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.tabBar.currentIndex;
  }

  @override
  void didUpdateWidget(CustomTabScaffold oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_currentPage >= widget.tabBar.items.length) {
      // Clip down to an acceptable range.
      _currentPage = widget.tabBar.items.length - 1;
      // Sanity check, since CustomTabBar.items's minimum length is 2.
      assert(
        _currentPage >= 0,
        'CustomTabBar is expected to keep at least 2 tabs after updating',
      );
    }
    // The user can still specify an exact desired index.
    if (widget.tabBar.currentIndex != oldWidget.tabBar.currentIndex) {
      _currentPage = widget.tabBar.currentIndex;
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> stacked = <Widget>[];

    final MediaQueryData existingMediaQuery = MediaQuery.of(context);
    MediaQueryData newMediaQuery = MediaQuery.of(context);

    Widget content = _TabSwitchingView(
      currentTabIndex: _currentPage,
      tabNumber: widget.tabBar.items.length,
      tabBuilder: widget.tabBuilder,
    );

    if (widget.resizeToAvoidBottomInset) {
      // Remove the view inset and add it back as a padding in the inner content.
      newMediaQuery = newMediaQuery.removeViewInsets(removeBottom: true);
      content = Padding(
        padding: EdgeInsets.only(bottom: existingMediaQuery.viewInsets.bottom),
        child: content,
      );
    }

    if (widget.tabBar != null &&
        // Only pad the content with the height of the tab bar if the tab
        // isn't already entirely obstructed by a keyboard or other view insets.
        // Don't double pad.
        (!widget.resizeToAvoidBottomInset ||
            widget.tabBar.preferredSize.height >
                existingMediaQuery.viewInsets.bottom)) {
      // TODO(xster): Use real size after partial layout instead of preferred size.
      // https://github.com/flutter/flutter/issues/12912
      final double bottomPadding = widget.tabBar.preferredSize.height +
          existingMediaQuery.padding.bottom;

      // If tab bar opaque, directly stop the main content higher. If
      // translucent, let main content draw behind the tab bar but hint the
      // obstructed area.
      if (widget.tabBar.opaque(context)) {
        content = Padding(
          padding: EdgeInsets.only(bottom: bottomPadding),
          child: content,
        );
      } else {
        newMediaQuery = newMediaQuery.copyWith(
          padding: newMediaQuery.padding.copyWith(
            bottom: bottomPadding,
          ),
        );
      }
    }

    content = MediaQuery(
      data: newMediaQuery,
      child: content,
    );

    // The main content being at the bottom is added to the stack first.
    stacked.add(content);

    if (widget.tabBar != null) {
      stacked.add(Align(
        alignment: Alignment.bottomCenter,
        // Override the tab bar's currentIndex to the current tab and hook in
        // our own listener to update the _currentPage on top of a possibly user
        // provided callback.
        child: widget.tabBar.copyWith(
            currentIndex: _currentPage,
            onTap: (int newIndex) {
              setState(() {
                _currentPage = newIndex;
              });
              // Chain the user's original callback.
              if (widget.tabBar.onTap != null) widget.tabBar.onTap(newIndex);
            }),
      ));
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        color:
            widget.backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Stack(
        children: stacked,
      ),
    );
  }
}

/// A widget laying out multiple tabs with only one active tab being built
/// at a time and on stage. Off stage tabs' animations are stopped.
class _TabSwitchingView extends StatefulWidget {
  const _TabSwitchingView({
    @required this.currentTabIndex,
    @required this.tabNumber,
    @required this.tabBuilder,
  })  : assert(currentTabIndex != null),
        assert(tabNumber != null && tabNumber > 0),
        assert(tabBuilder != null);

  final int currentTabIndex;
  final int tabNumber;
  final IndexedWidgetBuilder tabBuilder;

  @override
  _TabSwitchingViewState createState() => _TabSwitchingViewState();
}

class _TabSwitchingViewState extends State<_TabSwitchingView> {
  List<Widget> tabs;
  List<FocusScopeNode> tabFocusNodes;

  @override
  void initState() {
    super.initState();
    tabs = List<Widget>(widget.tabNumber);
    tabFocusNodes = List<FocusScopeNode>.generate(
      widget.tabNumber,
      (int index) => FocusScopeNode(),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _focusActiveTab();
  }

  @override
  void didUpdateWidget(_TabSwitchingView oldWidget) {
    super.didUpdateWidget(oldWidget);
    _focusActiveTab();
  }

  void _focusActiveTab() {
    FocusScope.of(context).setFirstFocus(tabFocusNodes[widget.currentTabIndex]);
  }

  @override
  void dispose() {
    for (FocusScopeNode focusScopeNode in tabFocusNodes) {
      focusScopeNode.unfocus();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: List<Widget>.generate(widget.tabNumber, (int index) {
        final bool active = index == widget.currentTabIndex;

        if (active || tabs[index] != null) {
          tabs[index] = widget.tabBuilder(context, index);
        }

        return Offstage(
          offstage: !active,
          child: TickerMode(
            enabled: active,
            child: FocusScope(
              node: tabFocusNodes[index],
              child: tabs[index] ?? Container(),
            ),
          ),
        );
      }),
    );
  }
}
