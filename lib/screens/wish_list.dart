import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/view_Models/products_provider.dart';
import '../utility/constants/colors.dart';
import '../utility/constants/image_strings.dart';
import '../utility/constants/size_config.dart';
import '../utility/constants/sizes.dart';
import '../view_Models/user_settings_provider.dart';

class WishList extends StatefulWidget {
  const WishList({super.key, required this.scaffoldKey});
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  TextEditingController searchController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  String queryParam = "";
  int page = 1;

  @override
  void initState() {
    super.initState();
    // Provider.of<ProductsProvider>(context, listen: false).getWishList();
  }

  @override
  Widget build(BuildContext context) {
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

                            /// cart button
                            GestureDetector(
                              onTap: () {
                                Provider.of<ProductsProvider>(context, listen: false).updateWishList(context, 2);
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
                                      TImages.cart,
                                      color: context
                                              .watch<UserSettingsProvider>()
                                              .isLightMode
                                          ? TColors.black
                                          : TColors.white,
                                    ),
                                  )),
                            )
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
                                  "Wishlist",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "All your favourite products.",
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
                child: context.watch<ProductsProvider>().wishList.isEmpty

                    ///
                    ? const Row(
                        children: [
                          SizedBox(
                              height: 10,
                              width: 10,
                              child: CircularProgressIndicator(
                                color: TColors.secondary,
                                strokeWidth: 2,
                              )),
                          SizedBox(
                            width: TSizes.paddingSpaceMd,
                          ),
                          Text("Favourite a product to see in wishlist"),
                        ],
                      )

                    : GridView.builder(
                            physics:
                                const NeverScrollableScrollPhysics(), // Disable GridView's scroll
                            shrinkWrap:
                                true, // Let GridView take only as much height as needed
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, // Number of items per row
                              crossAxisSpacing:
                                  10.0, // Spacing between items on the cross axis
                              mainAxisSpacing:
                                  10.0, // Spacing between items on the main axis
                              childAspectRatio:
                                  0.6, // Aspect ratio of the items (width/height)
                            ),
                            itemCount: context
                                .watch<ProductsProvider>()
                                .wishProducts
                                .length, // Total number of items in the grid
                            itemBuilder: (context, index) {

                              /// product
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Stack(
                                      children: [
                                        Card(
                                          color: TColors.white,
                                          elevation: 5,
                                          shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                  width: 2,
                                                  color: TColors.grey
                                                      .withOpacity(0.5)),
                                              borderRadius: BorderRadius.circular(
                                                  TSizes.paddingSpaceXl)),
                                          clipBehavior: Clip.hardEdge,
                                          child: Stack(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: CachedNetworkImageProvider(
                                                        context
                                                            .watch<
                                                                ProductsProvider>()
                                                            .wishProducts[index]
                                                            .image,
                                                        scale: 5),
                                                    onError:
                                                        (exception, stackTrace) {
                                                      // Handle error here, though DecorationImage doesn't support errorBuilder directly.
                                                      // You can choose to replace the URL with a fallback image if needed.
                                                      debugPrint(
                                                          'Image loading failed: $exception');
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: TSizes.paddingSpaceXl,
                                            vertical: TSizes.paddingSpaceXl
                                          ),
                                          child: Row(
                                            children: [
                                              const Spacer(),
                                              GestureDetector(
                                                onTap: (){
                                                  /// update wishlist with product Id
                                                  Provider.of<ProductsProvider>(context, listen: false).updateWishList(
                                                    context,
                                                    Provider.of<ProductsProvider>(context, listen: false).wishProducts[index].id
                                                  );
                                                },
                                                child: Icon(
                                                  Provider.of<ProductsProvider>(context).wishList.contains(
                                                    Provider.of<ProductsProvider>(context).wishProducts[index].id
                                                  ) ? Icons.favorite : Icons.favorite_outline,
                                                  color: TColors.secondary,
                                                  size: 30,
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),

                                  Text(
                                    context
                                        .watch<ProductsProvider>()
                                        .wishProducts[index]
                                        .title,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),

                                  Text(
                                    context
                                        .watch<ProductsProvider>()
                                        .wishProducts[index]
                                        .price
                                        .toString(),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(fontWeight: FontWeight.w700),
                                  ),
                                ],
                              );
                            },
                          )),
          )
        ],
      ),
    );
  }
}
