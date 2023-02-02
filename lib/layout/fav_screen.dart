import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onboarding_project/cubit_shop/shop/cubit_cubit.dart';
import 'package:onboarding_project/model_shop_app/fav_model.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, CubitStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! ShopLoadingGetFavoritesState,
          builder: (context) => ListView.separated(
            itemBuilder: (context, index) => buidListProduct(
                ShopCubit.get(context).favoritesModel!.data!.data![index].product,
                context),
            separatorBuilder: (context, index) => const Divider(
              endIndent: 20,
              indent: 20,
              color: Colors.grey,
            ),
            itemCount:
                ShopCubit.get(context).favoritesModel!.data!.data!.length,
          ),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }


}


Widget buidListProduct( model, BuildContext context) => Padding(
  padding: const EdgeInsets.all(10.0),
  child: Container(
    height: 120.0,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Image(
              image: NetworkImage(
                model.image!,
              ),
              width: 120,
              height: 120,
            ),
            if (model.discount != 0 )
              Container(
                color: Colors.red,
                padding: const EdgeInsets.symmetric(
                    horizontal: 5.0, vertical: 2),
                child: const Text(
                  'DISCOUNT',
                  style: TextStyle(fontSize: 12.0, color: Colors.white),
                ),
              ),
          ],
        ),
        const SizedBox(width: 20.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.name!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  height: 1.3,
                  fontSize: 14.0,
                ),
              ),
              Spacer(),
              Row(
                children: [
                  Text(
                    '${model.price.toString()}\$',
                    style: const TextStyle(
                      color: Colors.blue,
                      height: 1.3,
                      fontSize: 12.3,
                    ),
                  ),
                  const SizedBox(width: 15.0),
                  if (model.discount != 0)
                    Text(
                      '${model.oldPrice.toString()}\$',
                      style: const TextStyle(
                          color: Colors.grey,
                          height: 1.3,
                          fontSize: 10.3,
                          decoration: TextDecoration.lineThrough),
                    ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      ShopCubit.get(context)
                          .changeFavorites(model.id!);
                      print(model.product!.id);
                    },
                    icon: CircleAvatar(
                      radius: 15.0,
                      backgroundColor: ShopCubit.get(context)
                          .favorites[model.id]!
                          ? Colors.blue
                          : Colors.grey,
                      child: const Icon(
                        Icons.favorite_border,
                        size: 14.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);