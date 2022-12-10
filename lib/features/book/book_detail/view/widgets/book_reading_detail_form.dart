import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/book/book_detail/controller/book_detail_page_state_notifier.dart';
import 'package:konfiso/features/book/data/book_reading_detail.dart';
import 'package:konfiso/features/book/data/book_reading_status.dart';
import 'package:konfiso/shared/app_colors.dart';
import 'package:konfiso/shared/app_validators.dart';

class BookReadingDetailForm extends ConsumerStatefulWidget {
  const BookReadingDetailForm({
    required this.bookReadingDetail,
    super.key,
  });

  final BookReadingDetail bookReadingDetail;

  @override
  ConsumerState<BookReadingDetailForm> createState() => _BookReadingDetailFormState();
}

class _BookReadingDetailFormState extends ConsumerState<BookReadingDetailForm> {
  final _formKey = GlobalKey<FormState>();
  late BookReadingStatus _readingStatus;
  late double _rating;
  int? _currentPage;
  String? _comment;

  @override
  void initState() {
    super.initState();
    _readingStatus = widget.bookReadingDetail.status;
    _rating = widget.bookReadingDetail.rating ?? 0;
    _currentPage = widget.bookReadingDetail.currentPage;
    _comment = widget.bookReadingDetail.comment;
  }

  void _changeRating(double newRating) {
    setState(() {
      _rating = newRating;
    });
  }

  void _changeReadingStatus(BookReadingStatus? newReadingStatus) {
    setState(() {
      if (newReadingStatus == null) {
        return;
      }
      _readingStatus = newReadingStatus;
      if (_readingStatus != BookReadingStatus.currentlyReading) {
        _currentPage = null;
      }
    });
  }

  String? _validateCurrentPage(String? value) {
    String? errorMessage;
    if (value != null && value.isNotEmpty && AppValidators.integer(value)) {
      errorMessage = 'Please provide a number';
    }
    return errorMessage;
  }

  void _saveCurrentPage(String? newCurrentPage) {
    if (newCurrentPage != null && newCurrentPage.isNotEmpty) {
      _currentPage = int.tryParse(newCurrentPage);
    }
  }

  void _saveComment(String? newComment) {
    _comment = newComment;
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    ref.read(bookDetailPageStateNotifierProvider.notifier).saveBook(BookReadingDetail(
          book: widget.bookReadingDetail.book,
          status: _readingStatus,
          currentPage: _currentPage,
          rating: _rating,
          comment: _comment,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
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
                        child: Text(getReadingStatusDisplayText(readingStatus, context)),
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
                  decoration: InputDecoration(hintText: AppLocalizations.of(context)!.currentPage),
                  keyboardType: TextInputType.number,
                  validator: _validateCurrentPage,
                  onSaved: _saveCurrentPage,
                  initialValue: _currentPage != null ? '$_currentPage' : '',
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
              itemBuilder: (_, __) => const Icon(Icons.star, color: AppColors.primaryColor),
              onRatingUpdate: _changeRating,
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              maxLines: 3,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(hintText: AppLocalizations.of(context)!.comment),
              onSaved: _saveComment,
              initialValue: _comment,
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(onPressed: _submitForm, child: Text(AppLocalizations.of(context)!.save)),
          ],
        ));
  }
}
