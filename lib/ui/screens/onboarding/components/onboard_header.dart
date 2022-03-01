import 'package:flutter/material.dart';
import 'package:themotorwash/theme_constants.dart';
import 'package:themotorwash/ui/widgets/fade_slide_transition.dart';

class OnboardHeaderModel {
  final String title;
  final String subtitle;
  OnboardHeaderModel({
    required this.title,
    required this.subtitle,
  });
}

class OnboardHeader extends StatefulWidget {
  final int currentIndex;
  final List<OnboardHeaderModel> headers;
  OnboardHeader({Key? key, required this.currentIndex, required this.headers})
      : super(key: key);

  @override
  State<OnboardHeader> createState() => _OnboardHeaderState();
}

class _OnboardHeaderState extends State<OnboardHeader> {
  @override
  Widget build(BuildContext context) {
    return OnboardHeaderWidget(
      onboardHeaderModel: widget.headers[widget.currentIndex],
      key: ValueKey(widget.currentIndex),
    );
  }
}

class OnboardHeaderWidget extends StatefulWidget {
  final OnboardHeaderModel onboardHeaderModel;
  const OnboardHeaderWidget({Key? key, required this.onboardHeaderModel})
      : super(key: key);

  @override
  State<OnboardHeaderWidget> createState() => _OnboardHeaderWidgetState();
}

class _OnboardHeaderWidgetState extends State<OnboardHeaderWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  Duration kLoginAnimationDuration = Duration(milliseconds: 500);

  late final Animation<double> _formElementAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: kLoginAnimationDuration,
    );
    final fadeSlideTween = Tween<double>(begin: 0.0, end: 1.0);
    _formElementAnimation = fadeSlideTween.animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(
        0.7,
        1.0,
        curve: Curves.easeInOut,
      ),
    ));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeSlideTransition(
        animation: _formElementAnimation,
        additionalOffset: 0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.onboardHeaderModel.title,
              style: SizeConfig.kStyle24Bold,
            ),
            SizeConfig.kverticalMargin16,
            Text(
              widget.onboardHeaderModel.subtitle,
              style: SizeConfig.kStyle16
                  .copyWith(color: SizeConfig.kGreyTextColor),
            ),
          ],
        ));
  }
}
