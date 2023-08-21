part of 'faq_bloc.dart';

@immutable
abstract class FaqEvent {}

class FaqFetchEvent extends FaqEvent {
  final bool isToRefresh;

  FaqFetchEvent({
    this.isToRefresh = false,
  });
}
