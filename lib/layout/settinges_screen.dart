import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onboarding_project/components/TestFiled.dart';
import 'package:onboarding_project/components/defaultButton.dart';
import 'package:onboarding_project/components/nav.dart';
import 'package:onboarding_project/cubit_shop/shop/cubit_cubit.dart';
import 'package:onboarding_project/login/login_Screen.dart';
import 'package:onboarding_project/network/cacheHelper.dart';

class SettingesScreen extends StatelessWidget {
  SettingesScreen({super.key});
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, CubitStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopCubit.get(context).userModel;

        nameController.text = model!.data!.name!;
        emailController.text = model.data!.email!;
        phoneController.text = model.data!.phone!;

        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: ConditionalBuilder(
            condition: ShopCubit.get(context).userModel != null,
            builder: (context) => Column(
              children: [
                defaultTextFormFiled(
                  controller: nameController,
                  type: TextInputType.name,
                  validate: (value) {
                    if (value.isEmpty) {
                      return 'name must not be empty';
                    }
                    return null;
                  },
                  label: 'Name',
                  prefixIcon: Icons.email,
                ),
                const SizedBox(height: 20),
                defaultTextFormFiled(
                  controller: emailController,
                  type: TextInputType.emailAddress,
                  validate: (value) {
                    if (value.isEmpty) {
                      return 'Email must not be empty';
                    }
                    return null;
                  },
                  label: 'Email',
                  prefixIcon: Icons.person,
                ),
                const SizedBox(height: 20),
                defaultTextFormFiled(
                  controller: phoneController,
                  type: TextInputType.phone,
                  validate: (value) {
                    if (value.isEmpty) {
                      return 'Phone must not be empty';
                    }
                    return null;
                  },
                  label: 'Phone',
                  prefixIcon: Icons.person,
                ),
                const SizedBox(height: 20),
                defaultButton(
                    text: 'LOGOUT',
                    function: () {
                      SingOut(context);
                    }),
              ],
            ),
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
}

void SingOut(context) {
  CacheHelper.removeData(
    key: 'token',
  ).then((value) {
    NavPushReplacement(context, LoginScreen());
  });
}
