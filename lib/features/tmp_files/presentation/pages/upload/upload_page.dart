import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tempfiles_mobile_beta/core/utils/convert_time.dart';
import 'package:tempfiles_mobile_beta/features/tmp_files/data/models/params/file_upload_params.dart';
import 'package:tempfiles_mobile_beta/features/tmp_files/presentation/bloc/upload/upload_file_bloc.dart';
import 'package:tempfiles_mobile_beta/features/tmp_files/presentation/cubit/checkbox_group_cubit.dart';
import 'package:tempfiles_mobile_beta/features/tmp_files/presentation/widgets/custom_header_text.dart';

import '../../cubit/slider_cubit.dart';
import '../../cubit/times_cubit.dart';
import '../../widgets/custom_bottom_navigator.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  final int _currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<UploadFileBloc, UploadFileState>(
        listener: (context, state) {
          if (state is FileNotSelected) {
            _showSnackBar('파일을 선택해주세요');
          } else if (state is FileUploadDone) {
            _showSnackBar('파일이 정상적으로 업로드 되었습니다.');
            Future.delayed(const Duration(milliseconds: 50));
            _onFolderPressed(context, state.data!.folderId!);
          } else if (state is FileUploadError) {
            _showSnackBar(state.error.toString());
          }
        },
        builder: (context, uploadState) {
          return Center(
            child: Column(
              children: [
                const SizedBox(height: 100),
                buildHeaderText(text: 'File Upload'),
                const SizedBox(height: 30),
                BlocBuilder<CheckBoxCubit, Set<CheckBoxState>>(
                  builder: (context, checkBoxState) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildCheckBoxListTile('숨기기', CheckBoxState.checkbox1),
                        _buildCheckBoxListTile(
                            '다운로드 횟수: ${checkBoxState.contains(CheckBoxState.checkbox2) ? context.select((SliderCubit slider) => slider.state) : 100}회',
                            CheckBoxState.checkbox2),
                        if (checkBoxState.contains(CheckBoxState.checkbox2))
                          _buildDownloadLimitSlider(),
                        _buildCheckBoxListTile(
                            '유지 기간: ${checkBoxState.contains(CheckBoxState.checkbox3) ? convertTime(context.select((ExpireTimeCubit time) => time.state)) : convertTime(180)}',
                            CheckBoxState.checkbox3),
                        if (checkBoxState.contains(CheckBoxState.checkbox3))
                          Column(
                            children: [
                              _buildExpirationTimeContainer(),
                              _buildExpireTimeButtons(),
                            ],
                          ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(200, 45),
                        elevation: 2,
                        padding: const EdgeInsets.all(10),
                        backgroundColor: const Color(0xff60626E),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: _onUploadButtonPressed,
                      child: const Text(
                        '파일을 선택해주세요',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'NotoSansKR',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                if (uploadState is FileUploadLoadInProgress)
                  TweenAnimationBuilder<double>(
                    tween: Tween<double>(begin: 0, end: 1),
                    duration: const Duration(milliseconds: 50),
                    builder: (context, value, _) {
                      return CircularProgressIndicator(
                        value: uploadState.progress.toDouble() / 100,
                      );
                    },
                  ),
                const SizedBox(height: 25),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) =>
            NavigationUtils.onBottomNavigationBarTap(context, index),
      ),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  Widget _buildCheckBoxListTile(String title, CheckBoxState checkBoxState) {
    return CheckboxListTile(
        checkColor: Colors.white,
        activeColor: const Color(0xff252728),
        title: Text(
          title,
          style: const TextStyle(
            fontFamily: 'NotoSansKR',
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        value: context.read<CheckBoxCubit>().state.contains(checkBoxState),
        onChanged: (_) {
          BlocProvider.of<CheckBoxCubit>(context).toggleCheckBox(checkBoxState);
        });
  }

  Widget _buildDownloadLimitSlider() {
    return BlocBuilder<SliderCubit, int>(
      builder: (context, sliderValue) {
        return Slider(
          value: sliderValue.toDouble(),
          onChanged: (value) {
            BlocProvider.of<SliderCubit>(context)
                .updateSliderValue(value.round());
          },
          onChangeEnd: (value) {
            BlocProvider.of<SliderCubit>(context)
                .updateSliderValue(value.round());
          },
          min: 0,
          max: 100,
          divisions: 100,
          inactiveColor: const Color(0xff252728),
          activeColor: const Color(0xff757bab),
        );
      },
    );
  }

  Widget _buildExpireTimeButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildExpireTimeButton('+1 day', 24 * 60),
        _buildExpireTimeButton('+1 hour', 60),
        _buildExpireTimeButton('+10 min', 10),
        _buildExpireTimeButton('+1 min', 1),
      ],
    );
  }

  Widget _buildExpireTimeButton(String label, int duration) {
    return ElevatedButton(
      onPressed: () {
        BlocProvider.of<ExpireTimeCubit>(context).updateExpireTime(duration);
      },
      style: ElevatedButton.styleFrom(
        elevation: 1,
        padding: const EdgeInsets.all(12),
        backgroundColor: const Color(0xff757bab),
      ),
      child: Text(label),
    );
  }

  Widget _buildExpirationTimeContainer() {
    return BlocBuilder<ExpireTimeCubit, int>(
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: const Color(0xff252728),
            border: Border.all(color: Colors.white, width: 0.5),
          ),
          child: Text(
            convertTime(state),
            style: const TextStyle(
              fontFamily: 'NotoSansKR',
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        );
      },
    );
  }

  void _onUploadButtonPressed() async {
    final checkBoxCubit = context.read<CheckBoxCubit>().state;
    final sliderValue = context.read<SliderCubit>().state;
    final expireTimeValue = context.read<ExpireTimeCubit>().state;

    BlocProvider.of<UploadFileBloc>(context).add(
      RequestUploadFile(
        fileUploadParams: FileUploadParams(
          isHidden: checkBoxCubit.contains(CheckBoxState.checkbox1),
          downloadLimit: checkBoxCubit.contains(CheckBoxState.checkbox2)
              ? sliderValue
              : 100,
          expireTime: checkBoxCubit.contains(CheckBoxState.checkbox3)
              ? expireTimeValue
              : 180,
        ),
      ),
    );
  }

  void _onFolderPressed(BuildContext context, String folderId) async {
    final result =
        await Navigator.pushNamed(context, '/folder', arguments: folderId);

    if (!mounted) return;
    if (result == null) return;

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('$result')));
  }
}
