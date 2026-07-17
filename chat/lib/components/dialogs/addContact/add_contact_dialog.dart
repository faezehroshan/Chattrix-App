import 'package:chat/components/buttons/primary_buttons.dart';
import 'package:chat/components/buttons/underline_buttons.dart';
import 'package:chat/components/dialogs/addContact/add_contact_get.dart';
import 'package:chat/components/loading.dart';
import 'package:chat/components/textfields/primary_textfield.dart';
import 'package:chat/constants/colors.dart';
import 'package:chat/constants/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddContactDialog extends StatelessWidget {
  AddContactDialog({Key? key}) : super(key: key);

final addContactGet = Get.put(AddContactGet());
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop:false,
        child: AlertDialog(
          backgroundColor: MyColors.backColor,
          content: Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Add Contact', style: MyTextStyles.header2),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: PrimaryTextfield(
                    hint: 'Enter username',
                    maxLength: 40,
                    prefixIcon: CupertinoIcons.person,
                    onChanged: (newVal) =>
                        addContactGet.username.value = newVal,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Obx(() => addContactGet.loading.value
                      ? const MyLoading()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: UnderlineButton(
                                title: 'Cancel',
                                onPressed: () => Get.back(),
                              ),
                            ),
                            PrimaryButton(
                                title: 'Add', onPressed: addContactGet.add)
                          ],
                        )),
                )
              ],
            ),
          ),
        ));
  }
}