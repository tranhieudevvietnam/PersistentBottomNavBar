part of persistent_bottom_nav_bar;

class BottomNavStyle7 extends StatelessWidget {
  final NavBarEssentials? navBarEssentials;

  BottomNavStyle7({
    Key? key,
    this.navBarEssentials = const NavBarEssentials(items: null),
  });

  Widget _buildItem(
      PersistentBottomNavBarItem item, bool isSelected, double? height,
      {context}) {
    return this.navBarEssentials!.navBarHeight == 0
        ? SizedBox.shrink()
        : GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: isSelected == true
                ? () {
                    item.onIconRight?.call();
                  }
                : null,
            child: AnimatedContainer(
              // width: isSelected ? 120 : 50,
              // height: 32,
              duration:
                  this.navBarEssentials!.itemAnimationProperties?.duration ??
                      Duration(milliseconds: 400),
              curve: this.navBarEssentials!.itemAnimationProperties?.curve ??
                  Curves.ease,
              // padding: EdgeInsets.all(item.contentPadding),
              padding: isSelected
                  ? EdgeInsets.only(
                      top: 7,
                      bottom: 7,
                      left: item.valuePaddingLeftRight ?? 20,
                      right: item.valuePaddingLeftRight ?? 20)
                  : EdgeInsets.only(top: 2, bottom: 2),
              decoration: BoxDecoration(
                color: isSelected
                    ? item.activeColorPrimary
                    : this.navBarEssentials!.backgroundColor!.withOpacity(0.0),
                borderRadius: BorderRadius.all(Radius.circular(100)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 2),
                    child: IconTheme(
                      data: IconThemeData(
                          // size: item.iconSize,
                          color: isSelected
                              ? (item.activeColorSecondary == null
                                  ? item.activeColorPrimary
                                  : item.activeColorSecondary)
                              : item.inactiveColorPrimary == null
                                  ? item.activeColorPrimary
                                  : item.inactiveColorPrimary),
                      child: isSelected
                          ? item.icon
                          : item.inactiveIcon ?? item.icon,
                    ),
                  ),
                  item.title == null
                      ? SizedBox.shrink()
                      : isSelected
                          ? GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                item.onIconRight?.call();
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    item.title!,
                                    textAlign: TextAlign.center,
                                    style: item.textStyle != null
                                        ? (item.textStyle!.apply(
                                            color: isSelected
                                                ? (item.activeColorSecondary ==
                                                        null
                                                    ? item.activeColorPrimary
                                                    : item.activeColorSecondary)
                                                : item.inactiveColorPrimary))
                                        : TextStyle(
                                            color: (item.activeColorSecondary ==
                                                    null
                                                ? item.activeColorPrimary
                                                : item.activeColorSecondary),
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12),
                                  ),
                                  Visibility(
                                    visible: item.iconRight != null,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 5),
                                      child: item.iconRight,
                                    ),
                                  )
                                ],
                              ),
                            )
                          : SizedBox.shrink(),

                  // item.title == null
                  //     ? SizedBox.shrink()
                  //     : isSelected
                  //     ? Flexible(
                  //   child: Material(
                  //     type: MaterialType.transparency,
                  //     child: FittedBox(
                  //         child: GestureDetector(
                  //           onTap: () {
                  //             item.onIconRight?.call();
                  //           },
                  //           child: Row(
                  //             crossAxisAlignment: CrossAxisAlignment.center,
                  //             children: [
                  //               Text(
                  //                 item.title!,
                  //                 textAlign: TextAlign.center,
                  //                 style: item.textStyle != null
                  //                     ? (item.textStyle!.apply(
                  //                     color: isSelected
                  //                         ? (item.activeColorSecondary ==
                  //                         null
                  //                         ? item
                  //                         .activeColorPrimary
                  //                         : item
                  //                         .activeColorSecondary)
                  //                         : item
                  //                         .inactiveColorPrimary))
                  //                     : TextStyle(
                  //                     color: (item.activeColorSecondary ==
                  //                         null
                  //                         ? item.activeColorPrimary
                  //                         : item
                  //                         .activeColorSecondary),
                  //                     fontWeight: FontWeight.w400,
                  //                     fontSize: 10),
                  //               ),
                  //               item.iconRight ?? SizedBox.shrink()
                  //             ],
                  //           ),
                  //         )),
                  //   ),
                  // )
                  //     : SizedBox.shrink()
                ],
              ),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: this.navBarEssentials!.navBarHeight,
      padding: EdgeInsets.only(
          // top: this.navBarEssentials!.padding?.top ??
          //     this.navBarEssentials!.navBarHeight! * 0.15,
          top: 10,
          // left: this.navBarEssentials!.padding?.left ??
          //     MediaQuery.of(context).size.width * 0.07,
          left: 10,
          right: 10,
          // right: this.navBarEssentials!.padding?.right ??
          //     MediaQuery.of(context).size.width * 0.07,
          // bottom: this.navBarEssentials!.padding?.bottom ??
          //     this.navBarEssentials!.navBarHeight! * 0.15
          bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: this.navBarEssentials!.items!.map((item) {
          int index = this.navBarEssentials!.items!.indexOf(item);
          return GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              if (this.navBarEssentials!.items![index].onPressed != null) {
                this.navBarEssentials!.items![index].onPressed!(
                    this.navBarEssentials!.selectedScreenBuildContext);
              } else {
                this.navBarEssentials!.onItemSelected!(index);
              }
            },
            child: _buildItem(
              item,
              this.navBarEssentials!.selectedIndex == index,
              this.navBarEssentials!.navBarHeight,
              context: context,
            ),
          );
          // return IntrinsicHeight(
          //     child: GestureDetector(
          //       onTap: () {
          //         if (this.navBarEssentials!.items![index].onPressed != null) {
          //           this.navBarEssentials!.items![index].onPressed!(
          //               this.navBarEssentials!.selectedScreenBuildContext);
          //         } else {
          //           this.navBarEssentials!.onItemSelected!(index);
          //         }
          //       },
          //       child: _buildItem(
          //         item,
          //         this.navBarEssentials!.selectedIndex == index,
          //         this.navBarEssentials!.navBarHeight,
          //         context: context,
          //       ),
          //     )
          //   // Flexible(
          //   //   flex: this.navBarEssentials!.selectedIndex == index ? 3 : 1,
          //   //   child:  GestureDetector(
          //   //     onTap: () {
          //   //       if (this.navBarEssentials!.items![index].onPressed != null) {
          //   //         this.navBarEssentials!.items![index].onPressed!(
          //   //             this.navBarEssentials!.selectedScreenBuildContext);
          //   //       } else {
          //   //         this.navBarEssentials!.onItemSelected!(index);
          //   //       }
          //   //     },
          //   //     child: _buildItem(
          //   //       item,
          //   //       this.navBarEssentials!.selectedIndex == index,
          //   //       this.navBarEssentials!.navBarHeight,
          //   //       context: context,
          //   //     ),
          //   //   ) ,
          //   // )
          // );
        }).toList(),
      ),
    );
  }
}
