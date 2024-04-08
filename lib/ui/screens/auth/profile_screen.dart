import 'package:cached_network_image/cached_network_image.dart';
import 'package:cubex/core/core.dart';
import 'package:cubex/ui/components/components.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AuthVM>().getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthVM>(
      builder: (context, vm, _) {
        return Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            backgroundColor: AppColors.white,
            elevation: 0,
            automaticallyImplyLeading: false,
            title: Text(
              "Profile Screen",
              style: AppTypography.text16b,
            ),
          ),
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: Sizer.width(24))
                .copyWith(top: Sizer.height(20)),
            child: Center(
              child: Column(
                children: [
                  const YBox(30),
                  Skeletonizer(
                    enabled: vm.isBusy,
                    child: Container(
                      width: Sizer.width(100),
                      height: Sizer.width(100),
                      decoration: BoxDecoration(
                        color: AppColors.baseGray,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: FittedBox(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: CachedNetworkImage(
                            imageUrl:
                                "https://img.fpik.com/free-psd/3d-illustration-human-avatar-profile_23-2150671142.jpg?w=1060&t=st=1712611710~exp=1712612310~hmac=54df4dd2df8b201272342edd6e4265a8b68328bc8778d322909e127896f5e552",
                            imageBuilder: (context, imageProvider) => Container(
                              width: Sizer.width(100),
                              height: Sizer.width(100),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            placeholder: (context, url) => SizedBox(
                              width: Sizer.width(50),
                              height: Sizer.height(50),
                              child: const CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) => const Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Icon(
                                Icons.person,
                                color: AppColors.gray500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const YBox(40),
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: Sizer.height(10),
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: AppColors.gray200,
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Builder(builder: (context) {
                      if (vm.isBusy) {
                        return Skeletonizer(
                          child: ListView.separated(
                            itemBuilder: (ctx, i) {
                              return CustomListTile(
                                  title: "Username",
                                  subtitle: BoneMock.words(5));
                            },
                            separatorBuilder: (ctx, _) => const Divider(),
                            itemCount: 4,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                          ),
                        );
                      }
                      return Column(
                        children: [
                          CustomListTile(
                            title: "Username",
                            subtitle: vm.authUser?.username ?? "",
                          ),
                          const Divider(),
                          CustomListTile(
                            title: "Email",
                            subtitle: vm.authUser?.email ?? "",
                          ),
                          const Divider(),
                          CustomListTile(
                            title: "Phone Number",
                            subtitle: vm.authUser?.phone ?? "",
                          ),
                          const Divider(),
                          CustomListTile(
                            title: "Address",
                            subtitle: vm.authUser?.address ?? "",
                          ),
                        ],
                      );
                    }),
                  ),
                  const YBox(80),
                  InkWell(
                    onTap: () {
                      BsWrapper.showCustomDialog(
                        context,
                        child: LogoutDialog(
                          onConfirm: () {
                            Navigator.pop(context);
                            vm.logOut().then((_) {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                RoutePath.loginScreen,
                                (route) => false,
                              );
                            });
                          },
                        ),
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Log out',
                            style: AppTypography.text16.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.red,
                            ),
                          ),
                          const XBox(8),
                          Icon(
                            Iconsax.logout_1,
                            size: Sizer.radius(24),
                            color: AppColors.red,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: AppTypography.text14,
      ),
      subtitle: Text(
        subtitle,
        style: AppTypography.text16b,
      ),
    );
  }
}
