import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/view_Models/products_provider.dart';
import '../utility/constants/colors.dart';
import '../utility/constants/image_strings.dart';
import '../utility/constants/size_config.dart';
import '../utility/constants/sizes.dart';
import '../view_Models/user_settings_provider.dart';

class Cart extends StatefulWidget {
  const Cart({super.key, required this.scaffoldKey});
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Provider.of<ProductsProvider>(context, listen: false).getCartList();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductsProvider>(context);
    return Scaffold(
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverAppBar(
            leading: Container(),
            centerTitle: true,
            floating: false,
            pinned: true,
            snap: false,
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: Container(
                width: SizeConfig.screenWidth,
                height: SizeConfig.screenHeight,
                color: Theme.of(context).scaffoldBackgroundColor,
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [

                      /// top icons
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: TSizes.paddingSpaceXl),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            /// side drawer button
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  widget.scaffoldKey.currentState?.openDrawer();
                                });
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: context
                                              .watch<UserSettingsProvider>()
                                              .isLightMode
                                          ? TColors.softWhite
                                          : TColors.softBlack,
                                      borderRadius: BorderRadius.circular(100)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(
                                        TSizes.borderRadiusMd),
                                    child: Image.asset(
                                      TImages.menuHoz,
                                      color: context
                                              .watch<UserSettingsProvider>()
                                              .isLightMode
                                          ? TColors.black
                                          : TColors.white,
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),

                      const Spacer(),

                      /// greetings text
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: TSizes.paddingSpaceXl),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Cart",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Your products in your cart",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          color: TColors.grey, fontSize: 20),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // const SizedBox(
                      //   height: TSizes.paddingSpaceXl,
                      // ),
                      //
                      // /// search box
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(
                      //       horizontal: TSizes.paddingSpaceXl),
                      //   child: TextField(
                      //     controller: searchController,
                      //     decoration: InputDecoration(
                      //         fillColor: context
                      //                 .watch<UserSettingsProvider>()
                      //                 .isLightMode
                      //             ? TColors.softWhite
                      //             : TColors.softBlack,
                      //         prefixIcon: Image.asset(TImages.search),
                      //         hintText: "Search..."),
                      //   ),
                      // ),

                      const SizedBox(
                        height: TSizes.paddingSpaceXl,
                      ),

                    ],
                  ),
                ),
              ),
              centerTitle: true,
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
                padding: const EdgeInsets.only(
                    left: TSizes.paddingSpaceXl,
                    right: TSizes.paddingSpaceXl,
                    bottom: TSizes.paddingSpaceXl * 5),
                child: context.watch<ProductsProvider>().cartList.isEmpty

                    /// empty wishlist state
                    ? SizedBox(
                  height: SizeConfig.screenHeight * 0.6,
                      width: SizeConfig.screenWidth,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(TImages.emptySearch, scale: 1.5,),
                            const SizedBox(
                              height: TSizes.paddingSpaceMd,
                            ),
                            const Text("Add item to cart to see in here"),
                          ],
                        ),
                    )

                    : GridView.builder(
                            physics:
                                const NeverScrollableScrollPhysics(), // Disable GridView's scroll
                            shrinkWrap:
                                true, // Let GridView take only as much height as needed
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1, // Number of items per row
                              crossAxisSpacing:
                                  10.0, // Spacing between items on the cross axis
                              mainAxisSpacing:
                                  10.0, // Spacing between items on the main axis
                              childAspectRatio:
                                  2.5, // Aspect ratio of the items (width/height)
                            ),
                            itemCount: context
                                .watch<ProductsProvider>()
                                .cartList
                                .length, // Total number of items in the grid
                            itemBuilder: (context, index) {

                              /// product
                              return Container(
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  color: TColors.lightGrey,
                                  borderRadius: BorderRadius.circular(TSizes.borderRadiusMd)
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(TSizes.paddingSpaceMd),
                                      child: Container(
                                        width: SizeConfig.screenWidth * 0.3,
                                        decoration: BoxDecoration(
                                          color: TColors.white,
                                          borderRadius: BorderRadius.circular(TSizes.borderRadiusMd),
                                          image: DecorationImage(
                                            image: CachedNetworkImageProvider(
                                                productProvider.cartList[index]
                                                    .image,
                                                scale: 5),
                                          ),
                                        ),
                                      ),
                                    ),

                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(TSizes.paddingSpaceMd,),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [

                                            // ---------- title ------------- //
                                            Expanded(
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(productProvider.cartList[index].title,
                                                      maxLines: 2,
                                                      overflow: TextOverflow.ellipsis,
                                                      
                                                        style: const TextStyle(
                                                          color: TColors.black,
                                                          fontSize: 13,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ),
                                                    ),
                                                    IconButton(
                                                        onPressed: (){
                                                          productProvider.removeItemFromCart(context,
                                                              productProvider.cartList[index].id);
                                                        },
                                                        icon: const Icon(Icons.delete_outline_rounded,
                                                        color: TColors.error,))
                                                  ],
                                                )),

                                            // ---------- price ------------- //
                                            Expanded(
                                                child: Center(
                                                  child: Row(
                                                    children: [
                                                      Text("N ${productProvider.cartList[index].price}",
                                                        style: const TextStyle(
                                                            color: TColors.black,
                                                            fontSize: 15,
                                                            fontWeight: FontWeight.w400),),
                                                    ],
                                                  ),
                                                )),

                                            // ---------- button ------------- //

                                            Expanded(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      // ---------- down count ------------- //
                                                      GestureDetector(
                                                        onTap: (){
                                                          productProvider.modifyCartItemUnit(false, index);
                                                        },
                                                        child: Container(
                                                          width: 30, height: 30,
                                                          decoration: BoxDecoration(
                                                            // border: Border.all(color: TColors.primary),
                                                            borderRadius: BorderRadius.circular(300)
                                                          ),
                                                          child: const Icon(Icons.arrow_circle_down,
                                                          color: TColors.grey,),
                                                        ),
                                                      ),

                                                      // ---------- item count ------------- //
                                                      Padding(
                                                        padding: const EdgeInsets.symmetric(horizontal: TSizes.paddingSpaceMd),
                                                        child: Text(productProvider.cartItems[index].units.toString(),
                                                        style: const TextStyle(color: TColors.black,
                                                            fontWeight: FontWeight.bold),),
                                                      ),

                                                      // ---------- up count ------------- //
                                                      GestureDetector(
                                                        onTap: (){
                                                          productProvider.modifyCartItemUnit(true, index);
                                                        },
                                                        child: Container(
                                                          width: 30, height: 30,
                                                          decoration: BoxDecoration(
                                                            // border: Border.all(color: TColors.primary),
                                                              borderRadius: BorderRadius.circular(300)
                                                          ),
                                                          child: const Icon(Icons.arrow_circle_up,
                                                            color: TColors.grey,),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  // ---------- price ------------- //
                                                  Row(
                                                    children: [
                                                      Text("Total': N ${(productProvider.cartList[index].price
                                                      * productProvider.cartItems[index].units).toStringAsFixed(2)}",
                                                        style: const TextStyle(
                                                            color: TColors.success,
                                                            fontSize: 15,
                                                            fontWeight: FontWeight.w400),),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )

                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          )),
          )
        ],
      ),
    );
  }
}
