part of 'faq_bloc.dart';

@immutable
abstract class FaqState extends Equatable {
  final AbsPaginationStateImpl<List<Faqs>> faqState;

  const FaqState({required this.faqState});

  @override
  List<Object?> get props => [
    faqState,
  ];
}

class FaqImp extends FaqState {
  const FaqImp({
    required AbsPaginationStateImpl<List<Faqs>> faqState,
  }) : super(faqState: faqState);

  FaqImp copyWith({
    AbsPaginationStateImpl<List<Faqs>>? faqState,
  }) {
    return FaqImp(
      faqState: faqState ?? this.faqState,
    );
  }


}

class FaqInitial extends FaqImp {
  FaqInitial() : super(faqState: AbsPaginationInitialState());
}

