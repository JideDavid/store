import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/view_Models/products_provider.dart';
import '../utility/constants/colors.dart';
import '../utility/constants/image_strings.dart';
import '../utility/constants/size_config.dart';
import '../utility/constants/sizes.dart';
import '../view_Models/user_settings_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.scaffoldKey});
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  String queryParam = "";
  int page = 1;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(scrollListener);
    Provider.of<ProductsProvider>(context, listen: false).getCategories();
    Provider.of<ProductsProvider>(context, listen: false).getProducts();
  }

  void scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      // load more items
      Provider.of<ProductsProvider>(context, listen: false).getProducts();
    }
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
                                  "Hello",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Welcome to store.",
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

          SliverAppBar(
            leading: Container(),
            centerTitle: true,
            floating: true,
            pinned: true,
            snap: false,
            expandedHeight: 120,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: Container(
                width: SizeConfig.screenWidth,
                height: SizeConfig.screenHeight,
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Spacer(),

                    /// category
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: TSizes.paddingSpaceXl),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Choose Category",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            "View All",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: TColors.grey),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: TSizes.paddingSpaceXl,
                    ),

                    /// loading categories
                    Provider.of<ProductsProvider>(context).productCategories ==
                            null
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: TSizes.paddingSpaceXl),
                            child: SizedBox(
                              height: TSizes.paddingSpaceXl * 2,
                              width: SizeConfig.screenWidth,
                              child: const Center(
                                child: Row(
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
                                    Text("getting categories..."),
                                  ],
                                ),
                              ),
                            ),
                          )

                        /// category list
                        : SizedBox(
                            width: SizeConfig.screenWidth,
                            height: 45,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    Provider.of<ProductsProvider>(context)
                                            .productCategories!
                                            .length +
                                        1,
                                itemBuilder: (context, index) {
                                  /// category item
                                  return Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        TSizes.paddingSpaceXl,
                                        0,
                                        index ==
                                                Provider.of<ProductsProvider>(
                                                        context)
                                                    .productCategories!
                                                    .length
                                            ? TSizes.paddingSpaceXl
                                            : 0,
                                        0),
                                    child: index == 0

                                        /// all products
                                        ? GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                Provider.of<ProductsProvider>(context, listen:  false).sortProducts(
                                                "All Products"
                                                );
                                              });
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: context.watch<ProductsProvider>().category ==
                                                          "All Products"
                                                      ? TColors.secondary
                                                      : context
                                                              .watch<
                                                                  UserSettingsProvider>()
                                                              .isLightMode
                                                          ? TColors.softWhite
                                                          : TColors.softBlack,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          TSizes
                                                              .paddingSpaceMd)),
                                              child: Padding(
                                                padding: const EdgeInsets
                                                    .symmetric(
                                                    horizontal:
                                                        TSizes.paddingSpaceXl *
                                                            2),
                                                child: Center(
                                                    child: Text(
                                                  "All Products",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium,
                                                )),
                                              ),
                                            ),
                                          )

                                        /// categories
                                        : GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                Provider.of<ProductsProvider>(context, listen:  false).sortProducts(
                                                  Provider.of<ProductsProvider>(context, listen: false).productCategories![index - 1]
                                                );
                                              });
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: context.watch<ProductsProvider>().category
                                                      == context.watch<ProductsProvider>().productCategories![index -1]
                                                      ? TColors.secondary
                                                      : context
                                                              .watch<
                                                                  UserSettingsProvider>()
                                                              .isLightMode
                                                          ? TColors.softWhite
                                                          : TColors.softBlack,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          TSizes
                                                              .paddingSpaceMd)),
                                              child: Padding(
                                                padding: const EdgeInsets
                                                    .symmetric(
                                                    horizontal:
                                                        TSizes.paddingSpaceXl *
                                                            2),
                                                child: Center(
                                                    child: Text(
                                                  Provider.of<ProductsProvider>(
                                                              context)
                                                          .productCategories![
                                                      index - 1],
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium,
                                                )),
                                              ),
                                            ),
                                          ),
                                  );
                                }),
                          ),

                    const SizedBox(
                      height: TSizes.paddingSpaceXl,
                    ),
                  ],
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
                child: context.watch<ProductsProvider>().products == null

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
                          Text("Loading products"),
                        ],
                      )
                    : context.watch<ProductsProvider>().category ==
                            "All Products"

                        /// All Products
                        ? GridView.builder(
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
                                .products!
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
                                                            .products![index]
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
                                                    Provider.of<ProductsProvider>(context, listen: false).products![index].id
                                                  );
                                                },
                                                child: Icon(
                                                  Provider.of<ProductsProvider>(context).wishList.contains(
                                                    Provider.of<ProductsProvider>(context).products![index].id
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
                                        .products![index]
                                        .title,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    context
                                        .watch<ProductsProvider>()
                                        .products![index]
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
                          )

                        /// sorted Products
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
                                .sortedProducts
                                .length, // Total number of items in the grid
                            itemBuilder: (context, index) {
                              /// product
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                      },
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
                                                              .sortedProducts[index]
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
                                                        Provider.of<ProductsProvider>(context, listen: false).sortedProducts[index].id
                                                    );
                                                  },
                                                  child: Icon(
                                                    Provider.of<ProductsProvider>(context).wishList.contains(
                                                        Provider.of<ProductsProvider>(context).sortedProducts[index].id
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
                                  ),
                                  Text(
                                    context
                                        .watch<ProductsProvider>()
                                        .sortedProducts[index]
                                        .title,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    context
                                        .watch<ProductsProvider>()
                                        .sortedProducts[index]
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
