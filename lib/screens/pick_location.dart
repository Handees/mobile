import 'package:flutter/material.dart';
import 'package:handee/handee_colors.dart';
import 'package:handee/widgets/button.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PickLocation extends StatefulWidget {
  const PickLocation({Key? key}) : super(key: key);

  final recentAdresses = const [
    '1 Church Road, London, E3 5GP',
    '27 Church Street, Wolverhampton, WV7 9KO',
    '94 Queens Road, Enfield, London, EN10 8KT',
    '12 The Crescent, Hereford, HR56 0IO',
  ];

  @override
  State<PickLocation> createState() => _PickLocationState();
}

class _PickLocationState extends State<PickLocation> {
  final _searchFocus = FocusNode();

  @override
  void dispose() {
    _searchFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: HandeeColors.white,
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(0, 0),
              ),
            ),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              curve: Curves.decelerate,
              opacity: _searchFocus.hasFocus ? 1.0 : 0.0,
              child: Container(
                color: HandeeColors.white,
                height: double.infinity,
                width: double.infinity,
              ),
            ),
            // if (_searchFocus.hasFocus)
            //   Container(
            //     color: HandeeColors.white,
            //     height: double.infinity,
            //     width: double.infinity,
            //   ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 45,
                            height: 40,
                            child: IconButton(
                              icon: const Icon(
                                Icons.arrow_back,
                                color: HandeeColors.white,
                              ),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                            decoration: BoxDecoration(
                              color: HandeeColors.black,
                              boxShadow: const [
                                BoxShadow(
                                    color: HandeeColors.shadowBlack,
                                    blurRadius: 4),
                              ],
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          const SizedBox(width: 13),
                          Expanded(
                            child: Container(
                              //alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: HandeeColors.white,
                                boxShadow: const [
                                  BoxShadow(
                                      color: HandeeColors.shadowBlack,
                                      blurRadius: 4),
                                ],
                                borderRadius: BorderRadius.circular(5),
                              ),
                              height: 40,
                              child: GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  _searchFocus.requestFocus();
                                  Future.delayed(Duration(milliseconds: 300))
                                      .then((value) {
                                    setState(() {});
                                  });
                                },
                                child: IgnorePointer(
                                  child: TextField(
                                    // onTap: () => setState(() {
                                    //   _searchFocus.r
                                    // }),
                                    onSubmitted: (_) {
                                      Future.delayed(
                                              Duration(milliseconds: 100))
                                          .then((value) {
                                        setState(() {});
                                      });
                                    },
                                    autofocus: false,
                                    focusNode: _searchFocus,
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.all(8),
                                      prefixIcon: Icon(
                                        Icons.search,
                                        color: HandeeColors.grey89,
                                        size: 20,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.decelerate,
                        opacity: _searchFocus.hasFocus ? 1.0 : 0.0,
                        child: Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: HandeeColors.lightBlue,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Container(height: 10,color: Colors.red,),
                                for (int i = 0;
                                    i < widget.recentAdresses.length;
                                    ++i)
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(
                                          Icons.location_on_outlined,
                                          color: HandeeColors.blue,
                                          size: 18,
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Text(
                                            widget.recentAdresses[i],
                                            //softWrap: true,
                                            style: const TextStyle(
                                                color: HandeeColors.blue),
                                          ),
                                        ),
                                        const SizedBox(width: 20),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  HandeeButton(text: 'Done', onTap: () {}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
