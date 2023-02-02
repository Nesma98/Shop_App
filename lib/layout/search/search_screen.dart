import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onboarding_project/components/TestFiled.dart';
import 'package:onboarding_project/layout/fav_screen.dart';
import 'package:onboarding_project/layout/search/cubit/search_cubit.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  var formKey = GlobalKey<FormState>();
  var SearchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                child: Column(
                  children: [

                    defaultTextFormFiled(
                      controller: SearchController,
                      type: TextInputType.text,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'Search';
                        }
                        return null;
                      },
                      label: 'search',
                      prefixIcon: Icons.search,
                      onSubmit: (String text) {
                        SearchCubit.get(context).search(text);
                      },
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    if (state is SearchLoadingStates)
                      const LinearProgressIndicator(),
                    const SizedBox(
                      height: 15.0,
                    ),
                    if (state is SearchSuccessStates)
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) => buidListProduct(
                            SearchCubit.get(context).model!.data!.data[index],
                            context,
                          ),
                          separatorBuilder: (context, index) => const Divider(
                            endIndent: 20,
                            indent: 20,
                            color: Colors.grey,
                          ),
                          itemCount: SearchCubit.get(context).model!.data!.data.length,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
