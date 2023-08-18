import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handees/apps/artisan_app/features/home/providers/current-offer.provider.dart';
import 'package:handees/shared/data/handees/handee_approval.dart';
import 'package:handees/shared/data/handees/handee_options.dart';

final handeeApprovalDetailsProvider =
    StateNotifierProvider<HandeeApprovalDetailsStateNotifier, HandeeApproval>(
        (ref) => HandeeApprovalDetailsStateNotifier(
            ref.read(currentOfferProvider).bookingId));

class HandeeApprovalDetailsStateNotifier extends StateNotifier<HandeeApproval> {
  final String bookingId;
  HandeeApprovalDetailsStateNotifier(this.bookingId)
      : super(HandeeApproval.empty(bookingId: bookingId));

  void updateWorkDuration(String workDuration) {
    if (workDuration == WorkDurationTypes.oneTime ||
        workDuration == WorkDurationTypes.contract) {
      state = state.copywith(workDurationType: workDuration);
    }
  }

  void updatePaymentOption(String paymentOption) {
    if (paymentOption == PaymentOptionTypes.hourly ||
        paymentOption == PaymentOptionTypes.negotiated) {
      state = state.copywith(settlementPaymentType: paymentOption);
    }
  }

  void updatePaymentAmount(double amount) {
    state = state.copywith(settlementAmount: amount);
  }

  void updateDuration(int duration) {
    state = state.copywith(duration: duration);
  }

  void updateDurationUnit(String durationUnit) {
    if (durationUnit == DurationUnits.days ||
        durationUnit == DurationUnits.weeks) {
      state = state.copywith(durationUnit: durationUnit);
    }
  }

  String validateHandeeApproval() {
    if (state.workDurationType.isEmpty) {
      return 'A work duration must be selected';
    }
    if (state.settlement.paymentType.isEmpty) {
      return 'A payment type must be selected';
    }
    if (state.settlement.amount <= 0) {
      return 'Invalid job payment amount';
    }
    if (state.workDurationType == WorkDurationTypes.contract) {
      if (state.duration! <= 0) {
        return 'Work Duration must be up to a day';
      }
      if (state.durationUnit!.isEmpty) {
        return 'Work duration unit must be selected';
      }
    }

    return '';
  }
}
