import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orders_app/src/modals/base.dart';
import 'package:orders_app/src/pagination/bloc/pagination.dart';
import 'package:orders_app/src/pagination/model/response_model.dart';
import 'package:orders_app/src/values/colors.dart';
import 'widgets/bottom_loader.dart';
import 'widgets/empty_separator.dart';
import 'widgets/initial_loader.dart';
import 'widgets/load_more_error.dart';
import '../../../generated/l10n.dart' show S;

class PaginationView<T extends BaseModel> extends StatefulWidget {
  PaginationView({
    Key? key,
    required this.url,
    required this.itemBuilder,
    required this.modelParser,
    required this.onEmpty,
    required this.onError,
    required this.onCreated,
    required this.response,
    this.pullToRefresh = false,
    this.withAppBar = false,
    this.hasFilter = false,
    this.gridDelegate =
        const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
    List<T>? preloadedItems,
    this.initialLoader = const InitialLoader(),
    this.bottomLoader = const BottomLoader(),
    this.shrinkWrap = false,
    this.reverse = false,
    this.scrollDirection = Axis.vertical,
    this.padding = const EdgeInsets.all(0),
    this.physics,
    this.title,
    this.separatorBuilder,
    this.scrollController,
  })  : preloadedItems = preloadedItems ?? <T>[],
        super(key: key);

  final String url;
  final Widget bottomLoader;
  final SliverGridDelegate gridDelegate;
  final Widget initialLoader;
  final Widget onEmpty;
  final EdgeInsets padding;
  final ModelBuilder<T> modelParser;
  final PaginationResponse<T> response;
  final ScrollPhysics? physics;
  final List<T> preloadedItems;
  final bool pullToRefresh;
  final bool reverse;
  final ScrollController? scrollController;
  final Axis scrollDirection;
  final bool shrinkWrap;
  final bool withAppBar;
  final bool hasFilter;
  final String? title;

  @override
  PaginationViewState<T> createState() => PaginationViewState<T>();

  final Widget Function(BuildContext, T, int) itemBuilder;

  final Widget Function(BuildContext, int)? separatorBuilder;

  final Widget Function(dynamic) onError;
  final void Function(PaginationBloc<T> bloc) onCreated;
}

class PaginationViewState<T extends BaseModel>
    extends State<PaginationView<T>> {
  PaginationBloc<T>? _bloc;
  ScrollController? _scrollController;
  String? filter;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.scrollController ?? ScrollController();
    _bloc = PaginationBloc<T>(
        preloadedItems: widget.preloadedItems,
        builder: widget.modelParser,
        paginationResponse: widget.response,
        url: widget.url);
    widget.onCreated(_bloc!);
    _bloc!.add(PaginationLoadEvent<T>(filter: filter));
  }

  Future<void> refresh() async {
    _bloc!.add(PaginationRefreshEvent(filter: filter));
    _scrollController!.animateTo(
      0,
      curve: Curves.easeIn,
      duration: const Duration(milliseconds: 200),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaginationBloc<T>, PaginationState<T>>(
      bloc: _bloc,
      builder: (context, state) {
        if (state is PaginationInitial<T>) {
          return widget.initialLoader;
        } else if (state is PaginationError<T>) {
          return widget.onError(state.error);
        } else {
          final loadedState = state as PaginationLoadedState<T>;
          if (loadedState.items.isEmpty && !widget.withAppBar) {
            return widget.onEmpty;
          }
          if (widget.pullToRefresh) {
            return RefreshIndicator(
              onRefresh: refresh,
              child: _buildCustomScrollView(loadedState),
            );
          }
          return _buildCustomScrollView(loadedState);
        }
      },
    );
  }

  _buildCustomScrollView(PaginationLoadedState<T> loadedState) {
    return CustomScrollView(
      reverse: widget.reverse,
      controller: _scrollController,
      shrinkWrap: widget.shrinkWrap,
      scrollDirection: widget.scrollDirection,
      physics: widget.physics,
      slivers: [
        if (widget.withAppBar)
          SliverAppBar(
            title: Text(widget.title!),
            floating: true,
            pinned: true,
            elevation: 8,
            actions: [
              if (widget.hasFilter && loadedState.filters != null)
                IconButton(
                  onPressed: () {
                    _showFilter(loadedState.filters!);
                  },
                  icon: const Icon(Icons.filter_list_outlined),
                )
            ],
          ),
        if (loadedState.items.isEmpty)
          SliverToBoxAdapter(
            child: widget.onEmpty,
          ),
        if (loadedState.items.isNotEmpty)
          SliverPadding(
            padding: widget.padding,
            sliver: _buildSliverList(loadedState),
          ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 64,
          ),
        )
      ],
    );
  }


  _buildSliverList(PaginationLoadedState<T> loadedState) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final itemIndex = index ~/ 2;
          if (index.isEven) {
            if (itemIndex >= loadedState.items.length) {
              _bloc!.add(PaginationLoadMoreEvent(filter: filter));
              return loadedState.hasError
                  ? LoadMoreError(
                      onPressed: () {
                        //_bloc.add(event);
                      },
                    )
                  : widget.bottomLoader;
            }
            return widget.itemBuilder(
                context, loadedState.items[itemIndex], itemIndex);
          }
          return widget.separatorBuilder != null
              ? widget.separatorBuilder!(context, itemIndex)
              : const EmptySeparator();
        },
        semanticIndexCallback: (widget, localIndex) {
          if (localIndex.isEven) {
            return localIndex ~/ 2;
          }
          // ignore: avoid_returning_null
          return null;
        },
        childCount: max(
            0,
            (loadedState.hasReachedEnd || loadedState.hasError
                        ? loadedState.items.length
                        : loadedState.items.length + 1) *
                    2 -
                1),
      ),
    );
  }

  _showFilter(List<String> filters) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return PaginationFilterWidget(
              filters: filters,
              selected: filter,
              onReset: () {
                filter = null;
                refresh();
                if (Navigator.canPop(context)) {
                  Navigator.of(context).pop();
                }
              },
              onFilter: (String value) {
                filter = value;
                refresh();
                if (Navigator.canPop(context)) {
                  Navigator.of(context).pop();
                }
              });
        });
  }
}

class PaginationFilterWidget extends StatefulWidget {
  final List<String> filters;
  final String? selected;
  final Function(String) onFilter;
  final Function() onReset;
  PaginationFilterWidget({
    Key? key,
    required this.filters,
    required this.onFilter,
    required this.onReset,
    this.selected,
  }) : super(key: key);

  @override
  _PaginationFilterWidgetState createState() => _PaginationFilterWidgetState();
}

class _PaginationFilterWidgetState extends State<PaginationFilterWidget> {
  String? selectedFilter;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              Expanded(
                  child: Text(
                S.of(context).filters,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              )),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  if (Navigator.canPop(context)) {
                    Navigator.of(context).pop();
                  }
                },
              )
            ],
          ),
          const SizedBox(height: 4),
          const Divider(height: 1, color: defaultButtonColor),
          const SizedBox(height: 16),
          Wrap(
            alignment: WrapAlignment.start,
            direction: Axis.horizontal,
            crossAxisAlignment: WrapCrossAlignment.start,
            children: widget.filters.map(
              (item) {
                final selected =
                    (widget.selected != null && item == widget.selected) ||
                        (selectedFilter != null && item == selectedFilter);
                return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ChoiceChip(
                        selected: selected,
                        label: Text(item),
                        backgroundColor:
                            selected ? accentColor : Colors.grey[300],
                        onSelected: (value) {
                          setState(() {
                            selectedFilter = item;
                          });
                        }));
              },
            ).toList(),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              if (widget.selected != null) ...[
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(),
                    child: Text(S.of(context).reset),
                    onPressed: () {
                      widget.onReset();
                    },
                  ),
                ),
                const SizedBox(height: 16),
              ],
              if (selectedFilter != null)
                Expanded(
                  child: ElevatedButton(
                    child: Text(S.of(context).apply),
                    onPressed: () {
                      widget.onFilter(selectedFilter!);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: primaryColor,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
