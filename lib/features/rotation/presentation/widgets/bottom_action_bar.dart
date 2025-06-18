import 'package:flutter/material.dart';

class BottomActionBar extends StatelessWidget {
  final VoidCallback onCancel;
  final VoidCallback onSubmit;
  final String submitText;
  final bool isSubmitting;

  const BottomActionBar({
    super.key,
    required this.onCancel,
    required this.onSubmit,
    this.submitText = 'ローテーションを追加',
    this.isSubmitting = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: isSubmitting ? null : onCancel,
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                side: BorderSide(color: Colors.grey[300]!),
              ),
              child: Text(
                'キャンセル',
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: isSubmitting ? null : onSubmit,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black87,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child:
                  isSubmitting
                      ? SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      )
                      : Text(
                        submitText,
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
            ),
          ),
        ],
      ),
    );
  }
}
