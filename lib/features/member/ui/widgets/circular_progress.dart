import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homekru_owner/shared/utils/size_utils.dart';
import 'package:homekru_owner/core/theme/theme_helper.dart';
import 'package:homekru_owner/shared/widgets/custom_text.dart';

class CircularProgress extends StatefulWidget {
  final double scoreValue; // Value between 0.0 and 1.0
  final Duration animationDuration;

  final Color backgroundColor;
  final double strokeWidth;
  final String? label;

  const CircularProgress({
    super.key,
    required this.scoreValue,
    this.animationDuration = const Duration(milliseconds: 1500),

    this.backgroundColor = const Color(0xFFF8FBFE),
    this.strokeWidth = 8.0,
    this.label = 'Score',
  });

  @override
  State<CircularProgress> createState() => _CircularProgressState();
}

class _CircularProgressState extends State<CircularProgress>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _progressAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: widget.scoreValue,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );

    // Start animation
    _animationController.forward();
  }

  @override
  void didUpdateWidget(CircularProgress oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.scoreValue != widget.scoreValue) {
      _progressAnimation = Tween<double>(
        begin: _progressAnimation.value,
        end: widget.scoreValue,
      ).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Curves.easeOutCubic,
        ),
      );

      _animationController.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            width: SizeUtils.width * 0.28.w,
            height: SizeUtils.width * 0.28.w,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
                colors: [Color(0xFFF8FBFE), Color(0xFFCAE5FF)],
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: appTheme.primaryColor.withValues(alpha: 0.15),
                  blurRadius: 50.r,
                  offset: Offset(20.w, 10.h),
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: SizeUtils.width * 0.22.w,
                  height: SizeUtils.width * 0.22.w,
                  decoration: BoxDecoration(
                    color: appTheme.lightBackground,
                    shape: BoxShape.circle,
                  ),
                ),
                // Background circle
                SizedBox(
                  width: SizeUtils.width * 0.22.w,
                  height: SizeUtils.width * 0.22.w,
                  child: CircularProgressIndicator(
                    value: 1.0,
                    strokeWidth: widget.strokeWidth,
                    color: appTheme.lightBackground,
                    strokeCap: StrokeCap.round,
                  ),
                ),
                // Animated progress circle
                SizedBox(
                  width: SizeUtils.width * 0.22.w,
                  height: SizeUtils.width * 0.22.w,
                  child: CircularProgressIndicator(
                    value: _progressAnimation.value,
                    strokeWidth: widget.strokeWidth,
                    backgroundColor: Colors.transparent,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      appTheme.primaryColor,
                    ),
                    strokeCap: StrokeCap.round,
                  ),
                ),

                // Animated score text
                TweenAnimationBuilder<double>(
                  duration: widget.animationDuration,
                  tween: Tween<double>(begin: 0, end: widget.scoreValue * 100),
                  curve: Curves.easeOutCubic,
                  builder: (context, value, child) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CText(
                          '${value.round()}%',
                          color: appTheme.primaryColor,
                          weight: FontWeight.w600,
                          size: 18.sp,
                        ),
                        if (widget.label != null)
                          CText(
                            widget.label!,
                            color: appTheme.grey,
                            weight: FontWeight.w600,
                            size: 12.sp,
                          ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
