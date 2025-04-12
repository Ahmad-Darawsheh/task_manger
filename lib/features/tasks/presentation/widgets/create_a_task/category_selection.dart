import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_task/core/theming/colors.dart';
import 'package:todo_task/core/theming/styles.dart';
import 'package:todo_task/features/tasks/presentation/logic/cubit/add_tasks/add_tasks_cubit.dart';
import 'package:todo_task/features/tasks/presentation/logic/cubit/add_tasks/add_tasks_state.dart';

class CategorySelection extends StatelessWidget {
  const CategorySelection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddTasksCubit>();
    final categories = cubit.categories;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Category',
          style: TextStyles.font14DarkBlueBold,
        ),
        SizedBox(height: 15.h),
        
        // 3x2 Grid layout for categories
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // 3 items per row
            mainAxisSpacing: 10.h,
            crossAxisSpacing: 10.w,
            childAspectRatio: 2.5, // Adjust for desired height/width ratio
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return BlocBuilder<AddTasksCubit, AddTasksState>(
              buildWhen: (previous, current) => 
                previous != current && current is CategorySelected,
              builder: (context, state) {
                final isSelected = state is CategorySelected 
                    ? state.category == categories[index] 
                    : cubit.selectedCategory == categories[index];
                
                return GestureDetector(
                  onTap: () => cubit.selectCategory(categories[index]),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.r),
                      gradient: isSelected
                          ? LinearGradient(
                              colors: [
                                ColorsManger.gradientPurple,
                                ColorsManger.gradientBlue,
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            )
                          : null,
                      color: isSelected ? null : ColorsManger.tasksColor,
                    ),
                    child: Text(
                      categories[index],
                      textAlign: TextAlign.center,
                      style: isSelected
                          ? TextStyles.font14WhiteRegular
                          : TextStyles.font14DarkBlueRegular,
                    ),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}