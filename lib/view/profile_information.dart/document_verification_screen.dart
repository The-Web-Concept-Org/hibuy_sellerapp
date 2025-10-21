import 'dart:io';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hibuy/Bloc/image_picker/image_picker_bloc.dart';
import 'package:hibuy/res/app_string/app_string.dart';
import 'package:hibuy/res/assets/image_assets.dart';
import 'package:hibuy/res/colors/app_color.dart';
import 'package:hibuy/res/media_querry/media_query.dart';
import 'package:hibuy/res/routes/routes_name.dart';
import 'package:hibuy/res/text_style.dart';
import 'package:hibuy/view/auth/bloc/auth_bloc.dart';
import 'package:hibuy/view/auth/bloc/auth_event.dart';
import 'package:hibuy/view/auth/bloc/auth_state.dart';
import 'package:hibuy/widgets/profile_widget.dart/app_bar.dart';
import 'package:hibuy/widgets/profile_widget.dart/button.dart';
import 'package:hibuy/widgets/profile_widget.dart/id_image.dart';
import 'package:hibuy/widgets/profile_widget.dart/reason_container.dart';

class DocumentVerificationScreen extends StatefulWidget {
  const DocumentVerificationScreen({super.key});

  @override
  State<DocumentVerificationScreen> createState() =>
      _DocumentVerificationScreenState();
}

class _DocumentVerificationScreenState
    extends State<DocumentVerificationScreen> {
  final SingleSelectController<String> countryController =
      SingleSelectController<String>(null);
  final SingleSelectController<String> provinceController =
      SingleSelectController<String>(null);
  final SingleSelectController<String> cityController =
      SingleSelectController<String>(null);

  final _formKey = GlobalKey<FormState>();
  // focus node
  final FocusNode countryFocus = FocusNode();
  final FocusNode provinceFocus = FocusNode();
  final FocusNode cityFocus = FocusNode();

  bool _hasNavigated = false; // Flag to prevent duplicate navigation

  @override
  void initState() {
    super.initState();
    // Restore data from AuthBloc
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authState = context.read<AuthBloc>().state;
      if (authState.documentsCountry != null) {
        countryController.value = authState.documentsCountry!;
      }
      if (authState.documentsProvince != null) {
        provinceController.value = authState.documentsProvince;
      }
      if (authState.documentsCity != null) {
        cityController.value = authState.documentsCity;
      }
    });
  }

  @override
  void dispose() {
    countryController.dispose();
    provinceController.dispose();
    cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ✅ Get AuthState to access network URLs
    final authState = context.watch<AuthBloc>().state;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CustomAppBar(
        title: AppStrings.documentVerification,
        previousPageTitle: "Back",
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: context.widthPct(0.043), // ~16px
        ),
        child: Form(
          key: _formKey, // ✅ Wrap with Form
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: context.heightPct(0.018)),
              if (authState.documentInfoRejectReason != null &&
                  authState.documentInfoRejectReason != '')
                Padding(
                  padding: EdgeInsetsGeometry.only(
                    bottom: context.heightPct(0.02),
                  ),
                  child: reasonContainer(
                    context: context,
                    reason: authState.documentInfoRejectReason!,
                  ),
                ),
              Text(
                AppStrings.shophome,
                style: AppTextStyles.bodyRegular(context),
              ),
              SizedBox(height: context.heightPct(0.012)),
              ReusableImageContainer(
                widthFactor: 0.9,
                heightFactor: 0.25,
                placeholderSvg: ImageAssets.profileimage,
                imageKey: 'profileimage',
                networkImageUrl:
                    authState.documentsHomeBillUrl, // ✅ Network URL
              ),

              SizedBox(height: context.heightPct(0.02)),
              Text(
                AppStrings.shopvideo,
                style: AppTextStyles.bodyRegular(context),
              ),
              SizedBox(height: context.heightPct(0.012)),
              ReusableImageContainer(
                widthFactor: 0.9,
                heightFactor: 0.25,
                placeholderSvg: ImageAssets.profileimage,
                imageKey: 'shopVideo',
                isVideo: true,
                networkImageUrl:
                    authState.documentsShopVideoUrl, // ✅ Network URL
              ),

              SizedBox(height: context.heightPct(0.02)),

              // ✅ Fields with validation
              // ReusableTextField(
              //   controller: countryController,
              //   hintText: AppStrings.select,
              //   labelText: AppStrings.country,

              //   focusNode: countryFocus,
              //   nextFocusNode: provinceFocus,
              //   validator: (value) {
              //     if (value == null || value.trim().isEmpty) {
              //       return "Please select a country";
              //     }
              //     return null;
              //   },
              // ),
              Text(
                AppStrings.country,
                style: AppTextStyles.bodyRegular(context),
              ),
              SizedBox(height: context.heightPct(0.007)),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.stroke, width: 1),
                  borderRadius: BorderRadius.circular(context.widthPct(0.013)),
                ),
                height: context.heightPct(0.06),
                padding: EdgeInsets.symmetric(
                  horizontal: context.widthPct(0.043),
                ),
                child: CustomDropdown<String>(
                  hintText: 'Select ',
                  closedHeaderPadding: EdgeInsets.zero,
                  decoration: CustomDropdownDecoration(
                    hintStyle: AppTextStyles.normal(context),
                    headerStyle: TextStyle(),
                  ),
                  items: const ['Pakistan'],
                  controller: countryController,
                  onChanged: (value) async {
                    print('Selected: $value');
                  },
                ),
              ),
              SizedBox(height: context.heightPct(0.015)),

              Text(
                AppStrings.provinceregion,
                style: AppTextStyles.bodyRegular(context),
              ),
              SizedBox(height: context.heightPct(0.007)),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.stroke, width: 1),
                  borderRadius: BorderRadius.circular(context.widthPct(0.013)),
                ),
                height: context.heightPct(0.06),
                padding: EdgeInsets.symmetric(
                  horizontal: context.widthPct(0.043),
                ),
                child: CustomDropdown<String>.search(
                  hintText: 'Select ',
                  closedHeaderPadding: EdgeInsets.zero,
                  decoration: CustomDropdownDecoration(
                    headerStyle: TextStyle(),

                    hintStyle: AppTextStyles.normal(context),
                  ),
                  items: const [
                    'Punjab',
                    'Sindh',
                    'Khyber Pakhtunkhwa',
                    'Balochistan',
                    'Islamabad',
                    'Gilgit-Baltistan',
                    'Azad Jammu and Kashmir',
                  ],
                  controller: provinceController,
                  onChanged: (value) async {
                    print('Selected: $value');
                  },
                ),
              ),

              SizedBox(height: context.heightPct(0.015)),

              Text(AppStrings.city, style: AppTextStyles.bodyRegular(context)),
              SizedBox(height: context.heightPct(0.007)),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.stroke, width: 1),
                  borderRadius: BorderRadius.circular(context.widthPct(0.013)),
                ),
                height: context.heightPct(0.06),
                padding: EdgeInsets.symmetric(
                  horizontal: context.widthPct(0.043),
                ),
                child: CustomDropdown<String>.search(
                  hintText: 'Select ',
                  closedHeaderPadding: EdgeInsets.zero,
                  decoration: CustomDropdownDecoration(
                    headerStyle: TextStyle(),

                    hintStyle: AppTextStyles.normal(context),
                  ),
                  items: const [
                    'Abbottabad',
                    'Ahmedpur East',
                    'Ahmadpur Sial',
                    'Alipur',
                    'Arifwala',
                    'Attock',
                    'Badin',
                    'Bagh',
                    'Bahawalnagar',
                    'Bahawalpur',
                    'Bannu',
                    'Barkhan',
                    'Batkhela',
                    'Bhakkar',
                    'Bhalwal',
                    'Bhakkar',
                    'Bhera',
                    'Bhimber',
                    'Burewala',
                    'Chakwal',
                    'Charsadda',
                    'Chichawatni',
                    'Chiniot',
                    'Chishtian',
                    'Chitral',
                    'Dadu',
                    'Daska',
                    'Dera Bugti',
                    'Dera Ghazi Khan',
                    'Dera Ismail Khan',
                    'Dhaular',
                    'Digri',
                    'Dina',
                    'Dir',
                    'Dipalpur',
                    'Faisalabad',
                    'Fateh Jang',
                    'Ghotki',
                    'Gilgit',
                    'Gojra',
                    'Gujar Khan',
                    'Gujranwala',
                    'Gujrat',
                    'Gwadar',
                    'Hafizabad',
                    'Hangu',
                    'Haripur',
                    'Harnai',
                    'Hyderabad',
                    'Islamabad',
                    'Jacobabad',
                    'Jaffarabad',
                    'Jalalpur Jattan',
                    'Jamshoro',
                    'Jampur',
                    'Jaranwala',
                    'Jatoi',
                    'Jauharabad',
                    'Jhang',
                    'Jhelum',
                    'Kabirwala',
                    'Kahror Pakka',
                    'Kalat',
                    'Kamalia',
                    'Kamoke',
                    'Kandhkot',
                    'Karachi',
                    'Karak',
                    'Kasur',
                    'Khairpur',
                    'Khanewal',
                    'Khanpur',
                    'Khushab',
                    'Khuzdar',
                    'Kohat',
                    'Kot Addu',
                    'Kotli',
                    'Lahore',
                    'Lakki Marwat',
                    'Lalamusa',
                    'Larkana',
                    'Lasbela',
                    'Leiah',
                    'Lodhran',
                    'Loralai',
                    'Malakand',
                    'Mandi Bahauddin',
                    'Mansehra',
                    'Mardan',
                    'Mastung',
                    'Matiari',
                    'Mian Channu',
                    'Mianwali',
                    'Mingora',
                    'Mirpur',
                    'Mirpur Khas',
                    'Multan',
                    'Muridke',
                    'Murree',
                    'Muzaffargarh',
                    'Muzaffarabad',
                    'Nankana Sahib',
                    'Narowal',
                    'Naushahro Feroze',
                    'Nawabshah',
                    'Nowshera',
                    'Okara',
                    'Pakpattan',
                    'Panjgur',
                    'Pattoki',
                    'Peshawar',
                    'Quetta',
                    'Rahim Yar Khan',
                    'Rajanpur',
                    'Rawalpindi',
                    'Sadiqabad',
                    'Sahiwal',
                    'Sanghar',
                    'Sangla Hill',
                    'Sargodha',
                    'Shahdadkot',
                    'Shahkot',
                    'Shahpur',
                    'Shakargarh',
                    'Sheikhupura',
                    'Shikarpur',
                    'Sialkot',
                    'Sibi',
                    'Sukkur',
                    'Swabi',
                    'Swat',
                    'Tando Adam',
                    'Tando Allahyar',
                    'Tando Muhammad Khan',
                    'Tank',
                    'Taxila',
                    'Thatta',
                    'Toba Tek Singh',
                    'Turbat',
                    'Umerkot',
                    'Upper Dir',
                    'Vehari',
                    'Wah Cantt',
                    'Wazirabad',
                    'Zhob',
                    'Ziarat',
                  ],
                  controller: cityController,
                  onChanged: (value) async {
                    print('Selected: $value');
                  },
                ),
              ),

              SizedBox(height: context.heightPct(0.03)),

              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state.documentsStatus == DocumentsStatus.success &&
                      !_hasNavigated) {
                    _hasNavigated = true;
                    Navigator.pushNamed(
                      context,
                      RoutesName.businessVerification,
                    );
                  } else if (state.documentsStatus == DocumentsStatus.error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          state.errorMessage ?? "Something went wrong",
                        ),
                      ),
                    );
                  }
                  print("documentsHomeBill: ${state.documentsHomeBill}");
                  print("documentsShopVideo: ${state.documentsShopVideo}");
                },
                builder: (context, state) {
                  return ReusableButton(
                    text: state.documentsStatus == DocumentsStatus.loading
                        ? "Saving..."
                        : "Done",
                    onPressed: () {
                      // ✅ Validate before submitting
                      if (_formKey.currentState!.validate()) {
                        _hasNavigated =
                            false; // Reset flag for new save attempt
                        final imageState = context
                            .read<ImagePickerBloc>()
                            .state;

                        final homeBillPath = imageState.images['profileimage'];
                        final shopVideoPath = imageState.images['shopVideo'];

                        final File? homeBill = homeBillPath != null
                            ? File(homeBillPath)
                            : null;

                        final File? shopVideo = shopVideoPath != null
                            ? File(shopVideoPath)
                            : null;

                        context.read<AuthBloc>().add(
                          SaveDocumentsInfoEvent(
                            country: countryController.value ?? '',
                            province: provinceController.value ?? '',
                            city: cityController.value ?? '',
                            homeBill: homeBill,
                            shopVideo: shopVideo,
                          ),
                        );
                      }
                    },
                  );
                },
              ),

              SizedBox(height: context.heightPct(0.05)),
            ],
          ),
        ),
      ),
    );
  }
}
