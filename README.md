# Task Manger Task

Hey there! This is my task management app built with Flutter. I created it for the JODDB task.

## How I Built It

### Database
I chose **SQLite** (using the sqflite package) as my database solution. It's lightweight and perfect for storing tasks locally on the device. I implemented a repository pattern to keep the database code separate from the rest of the app.

What it does:
- Saves all your tasks locally on your device
- Handles creating, reading, updating, and deleting tasks
- Filters tasks based on user accounts
- Keeps track of which tasks are done and which are still pending

### Architecture & State Management
I went with an **MVVM (Model-View-ViewModel)** architecture paired with the **Cubit pattern** from the flutter_bloc package. This combination keeps the code clean and the app responsive:

- **Models** handle data structures and business logic
- **ViewModels** (implemented as Cubits) manage UI state and handle user interactions
- **Views** display the UI and respond to state changes

My main Cubits include:
- `TasksHomeCubit`: Handles the home screen and task listing
- `AddTasksCubit`: Manages the task creation process
- `CalendarCubit`: Deals with the calendar view and date selection
- `AuthCubit`: Takes care of user login and registration

I made sure these components talk to each other efficiently, so when you add or complete a task, the changes show up instantly across the app.

### Authentication
I integrated Firebase Authentication to handle user accounts, making it easy to:
- Sign up with email and password
- Keep your tasks private and secure
- Access your tasks across different devices

