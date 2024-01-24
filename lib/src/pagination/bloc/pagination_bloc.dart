import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:orders_app/src/modals/base.dart';
import 'package:orders_app/src/pagination/model/pagination.dart';
import 'package:orders_app/src/pagination/model/response_model.dart';
import 'package:orders_app/src/utils/exceptions/custom_exceptions.dart';

import '../../../generated/l10n.dart' show S;

part 'pagination_event.dart';
part 'pagination_state.dart';

const paginationLimit = 10;

class PaginationBloc<T extends BaseModel> extends Bloc<PaginationEvent<T>, PaginationState<T>> {
  final List<T> preloadedItems;
  final String url;
  final ModelBuilder<T> builder;
  final PaginationResponse<T> paginationResponse;

  PaginationBloc({
    required this.preloadedItems,
    required this.builder,
    required this.url,
    required this.paginationResponse,
  }) : super(PaginationInitial<T>());


  @override
  Stream<PaginationState<T>> mapEventToState(
    PaginationEvent<T> event,
  ) async* {
    if (event is PaginationLoadMoreEvent<T>) {
      final loadedState = state as PaginationLoadedState;
      if (loadedState.hasReachedEnd) return;
      _fetchAndEmitPaginatedList(previousList: loadedState.items as List<T>, filter: event.filter);
    }

    if (event is PaginationLoadEvent<T>) {
      _fetchAndEmitPaginatedList(filter: event.filter);
    }
    if (event is PaginationLoadedEvent<T>) {
      yield* _handlePaginationLoadState(event);
    }
    if (event is PaginationRefreshEvent<T>) {
      _refreshPaginatedList(filter:event.filter);
    }
    if (event is PaginationRetryEvent<T>) {
      yield* _handlePaginationRetryState(event);
    }
    if (event is PaginationLoadMoreRetryEvent<T>) {
      yield* _handlePaginationLoadMoreRetryState(event);
    }

    if (event is PaginationLoadErrorEvent<T>) {
      yield* _handlePaginationLoadErrorEvent(event);
    }
    if (event is PaginationNewItemAddEvent<T>) {
      if (state is PaginationLoadedState<T>) {
        final oldState = state as PaginationLoadedState<T>;
        final newState = oldState.copyWith(
          hasReachedEnd: oldState.hasReachedEnd,
          filters: oldState.filters,
          items: List.of([event.record])..addAll(oldState.items),
        );
        yield newState;
      }
    }
    if (event is PaginationItemUpdatedEvent<T>) {
      if (state is PaginationLoadedState<T>) {
        final oldState = state as PaginationLoadedState<T>;
        final index = oldState.items.indexWhere((e) => e.id == event.record.id);
        if (index > -1) {
          final List<T> newList = List.from(oldState.items);
          newList[index] = event.record ;
          final newState = oldState.copyWith(
            hasReachedEnd: oldState.hasReachedEnd,
            filters: oldState.filters,
            items: newList,
          );
          yield newState;
        } else {
          final newState = oldState.copyWith(
            hasReachedEnd: oldState.hasReachedEnd,
            filters: oldState.filters,
            items: List.of(oldState.items)..addAll([event.record]),
          );
          yield newState;
        }
      }
    }
  }

  Stream<PaginationState<T>> _handlePaginationLoadState(
      PaginationLoadedEvent<T> event) async* {
    yield PaginationLoadedState<T>(
        items: event.items, hasReachedEnd: event.hasReachedEnd, filters: event.filters);
  }

  Stream<PaginationState<T>> _handlePaginationRetryState(
      PaginationRetryEvent<T> event) async* {
    yield PaginationInitial<T>();
    _refreshPaginatedList(filter:event.filter);
  }

  Stream<PaginationState<T>> _handlePaginationLoadErrorEvent(
      PaginationLoadErrorEvent<T> event) async* {
    yield PaginationError<T>(error: event.error);
  }

  Stream<PaginationState<T>> _handlePaginationLoadMoreRetryState(
      PaginationLoadMoreRetryEvent<T> event) async* {}

  Future<void> _fetchAndEmitPaginatedList({
    List<T> previousList = const [],
    String? filter
  }) async {
    try {
      final responseModel = await paginationResponse(url, {
        "limit": paginationLimit,
        "offset": previousList.length,
        if(filter != null)
          ...{'state':filter}
      });
      if (!responseModel.success) throw Exception(responseModel.message);
      if(responseModel.data['records'] == null || responseModel.data['total'] == null) {
        throw Exception(S.current.unable_to_handle_data );
      }
      final pagination =
          PaginationModel<T>.fromJson(responseModel.data, builder);
      if(responseModel.data['filters'] != null){
        List<String> filters = [];
        for(final item in responseModel.data['filters']){
          filters.add(item);
        }
        add(PaginationLoadedEvent(
          items: List<T>.from(pagination.records + previousList),
          hasReachedEnd: !pagination.hasNext,
          filters: filters.isNotEmpty ? filters : null
        ));
      }else{
        add(PaginationLoadedEvent(
          items: List<T>.from(pagination.records + previousList),
          hasReachedEnd: !pagination.hasNext,
        ));
      }
    } on Exception catch (error) {
      if (preloadedItems.isNotEmpty) {
        add(PaginationLoadedEvent<T>(
          items: preloadedItems,
          hasReachedEnd: false,
          hasError: true,
        ));
      } else {
        add(PaginationLoadErrorEvent<T>(
          error: CustomException.formatException(error),
          isLoad: previousList.isEmpty,
        ));
      }
    }
  }


  Future<void> _refreshPaginatedList({String? filter}) async {
    await _fetchAndEmitPaginatedList(previousList: preloadedItems,filter: filter);
  }

}
