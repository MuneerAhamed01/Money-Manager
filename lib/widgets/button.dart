import 'package:flutter/material.dart';
import 'package:money_manager/widgets/loading_indicator.dart';

enum AppButtonStyle { primary, outlined, textButton }

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    this.onTap,
    this.isLoading = false,
    this.isDisabled = false,
    this.style = AppButtonStyle.primary,
    this.borderColor,
  });

  final VoidCallback? onTap;

  final String label;

  final AppButtonStyle style;

  final bool isDisabled;

  final bool isLoading;

  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(8),
      color: _backgroundColor(context),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: style != AppButtonStyle.textButton
            ? _buildTextWithBackground(context)
            : _buttonLabel(context),
      ),
    );
  }

  Container _buildTextWithBackground(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor != null
              ? borderColor!
              : style == AppButtonStyle.outlined
                  ? Theme.of(context).colorScheme.onTertiaryContainer
                  : Colors.transparent,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: isLoading ? _buildLoading() : _buttonLabel(context),
    );
  }

  Widget _buttonLabel(BuildContext context) {
    return Center(
      child: Text(
        label,
        style: Theme.of(context)
            .textTheme
            .labelLarge
            ?.copyWith(color: _color, overflow: TextOverflow.ellipsis),
      ),
    );
  }

  Widget _buildLoading() {
    return const Center(
      child: AppLoadingIndicator(),
    );
  }

  Color get _color {
    if (style == AppButtonStyle.primary) return Colors.white;

    return Colors.black;
  }

  Color _backgroundColor(context) {
    if (isDisabled) {
      return Theme.of(context).colorScheme.onTertiaryContainer.withOpacity(0.5);
    }

    if (style == AppButtonStyle.primary) {
      return Theme.of(context).colorScheme.onTertiaryContainer;
    }

    return Colors.white;
  }
}
