import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

class GenericBottomSheet extends StatelessWidget {
  final SheetRequest request;
  final Function(SheetResponse<GenericBottomSheetResponse>) completer;

  const GenericBottomSheet({
    super.key,
    required this.request,
    required this.completer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(25),
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            request.title ?? 'Generic Bottom Sheet',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[900],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            request.description ?? '',
            style: const TextStyle(color: Colors.grey),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MaterialButton(
                onPressed: () => completer(SheetResponse(
                  confirmed: true,
                  data: const GenericBottomSheetResponse(
                      message: 'SecondaryButton'),
                )),
                child: Text(
                  request.secondaryButtonTitle ?? '',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
              TextButton(
                onPressed: () => completer(SheetResponse(
                  confirmed: true,
                  data: const GenericBottomSheetResponse(message: 'MainButton'),
                )),
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(
                    Theme.of(context).primaryColor,
                  ),
                ),
                child: Text(
                  request.mainButtonTitle ?? '',
                  style: const TextStyle(color: Colors.white),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class GenericBottomSheetResponse {
  const GenericBottomSheetResponse({
    this.message = 'GenericBottomSheetResponse',
  });

  final String message;
}
