import 'package:flutter/material.dart';
import 'package:kshk/core/Services/service_locator.dart';
import 'package:kshk/core/utils/helper_functions/cart_items_list.dart';
import 'package:kshk/core/utils/styles.dart';
import 'package:kshk/core/widgets/custom_button.dart';
import 'package:kshk/features/home/domain/entities/item_card_entity.dart';
import 'package:kshk/features/home/presentation/view/widgets/color_picker_widget.dart';
import 'package:kshk/features/home/presentation/view/widgets/detailed_image_section.dart';
import 'package:kshk/features/home/presentation/view/widgets/detailed_screen_title.dart';
import 'package:kshk/features/home/presentation/view/widgets/size_picker_widget.dart';
import 'package:kshk/generated/l10n.dart';

class DetailedViewScreen extends StatefulWidget {
  const DetailedViewScreen({super.key, required this.item});
  final ItemCardEntity item;

  @override
  State<DetailedViewScreen> createState() => _DetailedViewScreenState();
}

class _DetailedViewScreenState extends State<DetailedViewScreen> {
  late ItemSize selectedSize;
  late Color selectedColor;

  @override
  void initState() {
    super.initState();
    selectedSize = widget.item.availableSizes.first;
    selectedColor = widget.item.colors.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DetailedImageSection(widget: widget),
              const SizedBox(height: 10),
              DetailedScreenTitle(item: widget.item),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  widget.item.description,
                  style: AppStyles.size16W600(context),
                ),
              ),
              const SizedBox(height: 20),

              // Size Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  S.of(context).size,
                  style: AppStyles.size24W800(context),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: widget.item.availableSizes.map((size) {
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: SizePickerWidget(
                          size: size,
                          isSelected: selectedSize == size,
                          onTap: () {
                            setState(() {
                              selectedSize = size;
                            });
                          },
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 20),

              // Color Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  S.of(context).color,
                  style: AppStyles.size24W800(context),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Wrap(
                  spacing: 12,
                  children: widget.item.colors.map((color) {
                    return ColorPickerWidget(
                      color: color,
                      isSelected: selectedColor == color,
                      onTap: () {
                        setState(() {
                          selectedColor = color;
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 30),

              // Add to Cart Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CustomButton(
                  text: S.of(context).add_to_cart,
                  onPressed: () {
                    getIt.get<CartItemsList>().addItem(
                      widget.item,
                      selectedSize.toString(),
                      selectedColor.toString(),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(S.of(context).added_to_cart),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
