import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_task/core/routing/routes.dart';
import 'package:todo_task/core/theming/colors.dart';
import 'package:todo_task/core/theming/styles.dart';
import 'package:todo_task/features/authentication/presentation/logic/auth_cubit.dart';
import 'package:todo_task/features/authentication/presentation/logic/auth_state.dart';
import 'package:todo_task/features/tasks/presentation/logic/cubit/tasks_home/tasks_home_cubit.dart';
import 'package:todo_task/features/tasks/presentation/logic/cubit/tasks_home/tasks_home_state.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tasksHomeCubit = context.watch<TasksHomeCubit>();
    final authCubit = context.read<AuthCubit>();
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings', 
          style: TextStyles.font24DarkBlueSemiBold,
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Profile Section
            FutureBuilder<Map<String, dynamic>>(
              future: authCubit.getCurrentUserData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error loading user data'));
                } else if (snapshot.hasData) {
                  final userData = snapshot.data!;
                  final name = userData['name'] ?? 'User';
                  final email = userData['email'] ?? 'No email';
                  
                  return _buildUserProfileCard(name, email);
                } else {
                  return _buildUserProfileCard('User', 'No user data');
                }
              },
            ),
            
            SizedBox(height: 30.h),
            
            // Task Statistics Section
            BlocBuilder<TasksHomeCubit, TasksHomeState>(
              builder: (context, state) {
                int totalTasks = 0;
                int completedTasks = 0;
                int ongoingTasks = 0;
                
                if (state is TasksLoaded) {
                  totalTasks = state.allTasks.length;
                  completedTasks = state.completedTasks.length;
                  ongoingTasks = state.ongoingTasks.length;
                } else {
                  totalTasks = tasksHomeCubit.allTasks.length;
                  completedTasks = tasksHomeCubit.completedTasks.length;
                  ongoingTasks = tasksHomeCubit.ongoingTasks.length;
                }
                
                return _buildTaskStatisticsCard(totalTasks, completedTasks, ongoingTasks);
              },
            ),
            
            SizedBox(height: 30.h),
            
            // Logout Button
            BlocListener<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is LogoutSuccess || state is Unauthenticated) {
                  // Navigate to login screen
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    Routes.login,
                    (route) => false, // Remove all previous routes
                  );
                } else if (state is LogoutError) {
                  // Show error message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Logout failed: ${state.message}'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 50.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.redAccent.shade200,
                        Colors.red,
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: ElevatedButton(
                    onPressed: () => authCubit.logout(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    child: Text(
                      'Logout',
                      style: TextStyles.font16WhiteSemiBold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // User Profile Card Widget
  Widget _buildUserProfileCard(String name, String email) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ColorsManger.gradientPurple,
            ColorsManger.gradientBlue,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          // Avatar Circle
          Container(
            width: 60.w,
            height: 60.w,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                name.isNotEmpty ? name[0].toUpperCase() : 'U',
                style: TextStyles.font24DarkBlueSemiBold.copyWith(
                  color: Colors.white,
                  fontSize: 28.sp,
                ),
              ),
            ),
          ),
          SizedBox(width: 15.w),
          // User Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyles.font18WhiteRegular.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 5.h),
                Text(
                  email,
                  style: TextStyles.font16WhiteSemiBold.copyWith(
                    fontWeight: FontWeight.normal,
                    fontSize: 14.sp,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Task Statistics Card Widget
  Widget _buildTaskStatisticsCard(int totalTasks, int completedTasks, int ongoingTasks) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
        border: Border.all(
          color: Colors.grey.shade200,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Task Statistics',
            style: TextStyles.font17DarkBlueSemiBold.copyWith(
              fontSize: 18.sp,
            ),
          ),
          SizedBox(height: 15.h),
          _buildStatisticItem('Total Tasks', totalTasks),
          SizedBox(height: 10.h),
          _buildStatisticItem('Completed Tasks', completedTasks, color: Colors.green),
          SizedBox(height: 10.h),
          _buildStatisticItem('Ongoing Tasks', ongoingTasks, color: Colors.orange),
        ],
      ),
    );
  }

  // Individual Statistic Item
  Widget _buildStatisticItem(String label, int count, {Color color = Colors.blue}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyles.font14DarkBlueBold,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: Text(
            count.toString(),
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 14.sp,
            ),
          ),
        ),
      ],
    );
  }
}