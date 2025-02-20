import 'package:flutter/material.dart';
import 'package:ionob_task/utils/constants/colors.dart';
import 'package:ionob_task/utils/constants/diementions.dart';
import 'package:ionob_task/utils/extension/upperfstring_ext.dart';
import 'package:ionob_task/utils/helper/help_screensize.dart';
import 'package:ionob_task/utils/helper/pagenavigator.dart';
import 'package:ionob_task/view/components/apptext.dart';
import 'package:ionob_task/view/components/apptextfeild.dart';
import 'package:ionob_task/view/ui/home/controller/homeprovider.dart';
import 'package:ionob_task/view/ui/home/model/taskmodel.dart';
import 'package:provider/provider.dart';

class HomeScree extends StatefulWidget {
  const HomeScree({super.key});

  @override
  State<HomeScree> createState() => _HomeScreeState();
}

class _HomeScreeState extends State<HomeScree> {
  TextEditingController titleCtrl  = TextEditingController(),
  descCtrl = TextEditingController();
  int editedid = 0;
  @override
  void initState() {
    context.read<HomeProvider>().gettasks(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      appBar: AppBar(title: AppText(text: 'ioNob Test'),),
      body: SizedBox(
        width: ScreenUtil.screenWidth,
        height: ScreenUtil.screenHeight,
        child: Padding(
          padding:  EdgeInsets.all(paddingx),
          child: Column(children: [
          Expanded(
            child:context.watch<HomeProvider>().tasklist.isEmpty?Center(child: AppText(text: 'No Data'),): ListView.builder(
              itemCount:context.watch<HomeProvider>().tasklist.length,
              itemBuilder: (context, index) {
                Task data =context.read<HomeProvider>().tasklist[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Container(
                  width: ScreenUtil.screenWidth,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(paddingx),
                    color: Colors.grey.withOpacity(0.4)
                  ),
                  child: Padding(
                    padding:  EdgeInsets.all(paddingx),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AppText(text: data.title??'',weight: FontWeight.w500,),
                              gap,
                              AppText(text: data.desc??'',color: ColorResources.subtextcolor,)
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: data.iscomplete==1?Colors.green:Colors.redAccent.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10),

                          ),
                          child: Padding(
                            padding:  EdgeInsets.all(paddingx),
                            child: AppText(text:data.iscomplete==1? 'Complted':'Pending'),
                          ),
                        ),
                        Column(
                          children: [
                            IconButton(
                              onPressed: () async {
                                titleCtrl.text = data.title??'';
                                descCtrl.text = data.desc??'';
                                editedid = data.id??0;
                                setState(() {
                                  
                                });
                                await TaskAdd(context,true);
                              },
                              icon: Icon(Icons.edit)),
                            IconButton(onPressed: () async  {
                              await context.read<HomeProvider>().deletetask(context, data.id!);
                            }, icon: Icon(Icons.delete))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            },),
          )
          ],),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async{
        await TaskAdd(context,false);
      },child: Icon(Icons.add,),backgroundColor: ColorResources.amber,),
    );
  }

  Future<dynamic> TaskAdd(BuildContext context,bool isedit) {
    return showDialog(context: context, builder: (context) => AlertDialog(
        content: SizedBox(
          child: Padding(
            padding:  EdgeInsets.all(paddingx),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
            AppTextFeild(controller: titleCtrl,hinttext: 'Title',),
            gap,
            AppTextFeild(controller: descCtrl,hinttext: 'Description',multiline: 2,),
            gap,
            Row(
              children: [
                AppText(text: 'Comleted'),
                Checkbox(value: context.watch<HomeProvider>().iscomplete, onChanged:(value) {
                  context.read<HomeProvider>().togglecomplete();
                }, )
              ],
            ),
            gap,
            SizedBox(
              width: ScreenUtil.screenWidth,

              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(ColorResources.blackcolor)
                ),
                onPressed: () async {
                  Task body = Task();
                  body.title = titleCtrl.text;
                  body.desc = descCtrl.text;
                  body.iscomplete = context.read<HomeProvider>().iscomplete?1:0;
                  if (isedit) {
                    body.id = editedid;
                  await context.read<HomeProvider>().inserttask(context, body,true);
                    
                  }else{
                  await context.read<HomeProvider>().inserttask(context, body,false);

                  }
                  titleCtrl.clear();
                  descCtrl.clear();
                  Screen.close(context);
                
              }, child: AppText(text: 'Submit'.upperFirst,color: ColorResources.whitecolor,)),
            )
            
              ],
            ),
          ),
        ),
      ),);
  }
}