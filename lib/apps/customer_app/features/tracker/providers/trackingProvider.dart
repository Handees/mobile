import 'package:flutter_riverpod/flutter_riverpod.dart';

final blurBackgroundProvider = StateNotifierProvider<BlurBackgroundNotifier, BottomSheetState>(
  (ref) => BlurBackgroundNotifier()
);

class BlurBackgroundNotifier extends StateNotifier<BottomSheetState>{
  BlurBackgroundNotifier(): super(BottomSheetState.minimized);

  void openSheet()
  {
    state = BottomSheetState.inView;
  }

  void closeSheet()
  {
    state = BottomSheetState.minimized;
  }
}

enum BottomSheetState {inView, minimized}
