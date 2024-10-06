import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/screens/cart.dart';
import 'package:store/screens/home_page.dart';
import 'package:store/screens/wish_list.dart';
import 'package:store/view_Models/user_settings_provider.dart';
import '../utility/constants/colors.dart';
import '../utility/constants/image_strings.dart';
import '../utility/constants/size_config.dart';
import '../utility/constants/sizes.dart';

class HomeNav extends StatefulWidget {
  const HomeNav({super.key});

  @override
  State<HomeNav> createState() => _HomeNavState();
}

class _HomeNavState extends State<HomeNav> {

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  int navIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: Drawer(
        width: SizeConfig.screenWidth * 0.75,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,

        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// side drawer button
              Padding(
                padding: const EdgeInsets.all(TSizes.paddingSpaceXl),
                child: GestureDetector(
                  onTap: (){
                    setState(() {
                      scaffoldKey.currentState?.closeDrawer();
                    });

                  },
                  child: Container(
                      decoration: BoxDecoration(
                          color: context.watch<UserSettingsProvider>().isLightMode
                              ? TColors.softWhite : TColors.softBlack,
                          borderRadius: BorderRadius.circular(100)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(TSizes.borderRadiusMd),
                        child: Image.asset(TImages.menuVert,
                          color: context.watch<UserSettingsProvider>().isLightMode
                              ? TColors.black : TColors.white,),
                      )),
                ),
              ),
              ListTile(
                leading: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: TSizes.paddingSpaceMd
                  ),
                  child: Image.asset(TImages.sun,
                    color: context.watch<UserSettingsProvider>().isLightMode
                        ? TColors.black : TColors.white,),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Dark Mode", style: Theme.of(context).textTheme.titleMedium),
                  Switch(value: context.watch<UserSettingsProvider>().isLightMode,
                      onChanged: (val){
                    context.read<UserSettingsProvider>().changeLightMode();
                      })
                  ],
                ),
              )
            ],
          ),
        ),
      ),

      drawerEnableOpenDragGesture: false,
      drawerEdgeDragWidth: SizeConfig.screenWidth * 0.5,
      body: Stack(
        children: [
          ///navigation screens
          navIndex == 0 ? HomePage(scaffoldKey: scaffoldKey,)
          : navIndex == 1 ? WishList(scaffoldKey: scaffoldKey)
          : Cart(scaffoldKey: scaffoldKey),

          /// navigation bar
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: SizeConfig.screenWidth * 0.15, width: SizeConfig.screenWidth,
                color: Theme.of(context).scaffoldBackgroundColor,
                child: SizedBox(
                  height: SizeConfig.screenWidth * 0.15,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /// home
                      Expanded(
                        child: GestureDetector(
                          onTap: (){
                            setState(() {
                              navIndex = 0;
                            });
                          },
                          child: SizedBox(
                            child: Image.asset(
                                navIndex == 0 ? TImages.homeActV : TImages.homeInAct,
                              // color: context.watch<UserSettingsProvider>().isLightMode
                              //     ? TColors.primary : TColors.white,
                            ),
                          ),
                        ),
                      ),

                      /// wishlist
                      Expanded(
                        child: GestureDetector(
                          onTap: (){
                            setState(() {
                              navIndex = 1;
                            });
                          },
                          child: SizedBox(
                            child: Image.asset(
                                navIndex == 1 ? TImages.heartActV : TImages.heartInAct,
                              // color: context.watch<UserSettingsProvider>().isLightMode
                              //     ? TColors.primary : TColors.white,
                            ),
                          ),
                        ),
                      ),

                      /// cart
                      Expanded(
                        child: GestureDetector(
                          onTap: (){
                            setState(() {
                              navIndex = 2;
                            });
                          },
                          child: SizedBox(
                            child: Image.asset(
                                navIndex == 2 ? TImages.cartActV : TImages.cartInAct,
                              // color: context.watch<UserSettingsProvider>().isLightMode
                              //     ? TColors.primary : TColors.white,
                            ),
                          ),
                        ),
                      ),
                      //
                      // /// wallet
                      // Expanded(
                      //   child: GestureDetector(
                      //     onTap: (){
                      //       setState(() {
                      //         navIndex = 3;
                      //       });
                      //     },
                      //     child: SizedBox(
                      //       child: Image.asset(
                      //           navIndex == 3 ? TImages.walletActV : TImages.walletInAct,
                      //         // color: context.watch<UserSettingsProvider>().isLightMode
                      //         //     ? TColors.primary : TColors.white,
                      //       ),
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
