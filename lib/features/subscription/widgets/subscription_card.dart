import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubscriptionCard extends StatelessWidget {
  const SubscriptionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      // height: 102,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(width: 1, color: const Color(0x7FBCBCBC)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x143B70B9),
            blurRadius: 50,
            offset: Offset(10, 20),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// Save badge
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "3 ",
                      style: TextStyle(
                        color: Color(0xFF212121),
                        fontSize: 28,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                      text: "months",
                      style: TextStyle(
                        color: Color(0xFF616161),
                        fontSize: 18,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0x26BCBCBC),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: const Text(
                  "Save 0 %",
                  style: TextStyle(
                    color: Color(0xFF747474),
                    fontSize: 10,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              // Spacer(),
            ],
          ),

          /// Price per month
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "\$",
                    style: TextStyle(
                      color: Color(0xFF616161).withOpacity(0.6),
                      fontSize: 18,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 4),
                  Text(
                    "299",
                    style: TextStyle(
                      color: Color(0xFF212121).withOpacity(0.8),
                      fontSize: 28,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              // Spacer(),
              Text(
                "96.6 / month",
                style: TextStyle(
                  color: Color(0xFF747474),
                  fontSize: 10,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),

          /// Price
        ],
      ),
    );
  }
}
