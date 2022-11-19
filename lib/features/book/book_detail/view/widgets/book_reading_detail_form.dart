import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/book/data/book_reading_status.dart';
import 'package:konfiso/shared/app_colors.dart';

class BookReadingDetailForm extends ConsumerStatefulWidget {
  const BookReadingDetailForm({super.key});

  @override
  ConsumerState<BookReadingDetailForm> createState() =>
      _BookReadingDetailFormState();
}

class _BookReadingDetailFormState extends ConsumerState<BookReadingDetailForm> {
  BookReadingStatus? _readingStatus = BookReadingStatus.wantToRead;
  double _rating = 0;

  void _changeRating(double newRating) {
    setState(() {
      _rating = newRating;
    });
  }

  void _changeReadingStatus(BookReadingStatus? newReadingStatus) {
    setState(() {
      _readingStatus = newReadingStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 30,
        ),
        Text(
          AppLocalizations.of(context)!.reading,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 10,
        ),
        DropdownButtonFormField<BookReadingStatus>(
          items: BookReadingStatus.values
              .map((readingStatus) => DropdownMenuItem(
                    value: readingStatus,
                    child: Text(
                        getReadingStatusDisplayText(readingStatus, context)),
                  ))
              .toList(),
          value: _readingStatus,
          onChanged: _changeReadingStatus,
          iconEnabledColor: AppColors.primaryColor,
        ),
        Visibility(
          visible: _readingStatus == BookReadingStatus.currentlyReading,
          child: Column(children: [
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.currentPage),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(
              height: 10,
            )
          ]),
        ),
        const SizedBox(
          height: 10,
        ),
        RatingBar.builder(
          initialRating: _rating,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemBuilder: (_, __) =>
              const Icon(Icons.star, color: AppColors.primaryColor),
          onRatingUpdate: _changeRating,
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          maxLines: 3,
          textInputAction: TextInputAction.done,
          decoration:
              InputDecoration(hintText: AppLocalizations.of(context)!.comment),
        ),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
            onPressed: () {}, child: Text(AppLocalizations.of(context)!.save)),
      ],
    ));
  }
}
