import 'package:di_sample/common/widgets/abs_pagination_view.dart';
import 'package:di_sample/features/product/presentation/bloc/faq_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injectable.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({Key? key}) : super(key: key);

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  @override
  void initState() {
    super.initState();
    getIt<FaqBloc>().add(FaqFetchEvent(isToRefresh: true));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FAQ"),
      ),
      body: BlocBuilder<FaqBloc, FaqImp>(
        builder: (context, state) {
          return AbsPaginationView(
            absNormalStatus: state.faqState.absNormalStatus,
            data: [...state.faqState.data ?? []],
            child: const Text("Success"),
            onTapToRefresh: () {
              getIt<FaqBloc>().add(FaqFetchEvent(isToRefresh: true));
            },
            onLoading: () {
              getIt<FaqBloc>().add(FaqFetchEvent());
            },
          );
        },
      ),
    );
  }
}
