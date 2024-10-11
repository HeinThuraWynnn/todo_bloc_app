# Todo List Application - Flutter with Real-time Updates and Filtering

### Overview

This Flutter application allows users to manage a Todo List with real-time updates and task filtering. Users can add, edit, delete, filter, and mark tasks as completed. The app syncs with a mock backend API every 10 seconds, simulating real-time updates.

### Features

- **Add Task**: Users can create new tasks with a title and description.
- **Edit Task**: Users can modify existing tasks.
- **Delete Task**: Users can remove tasks from the list.
- **Mark Task as Completed**: Users can toggle the completion status of tasks.
- **Filter Tasks**: Users can filter the tasks based on their status:
  - All Tasks
  - Completed Tasks
  - Incomplete Tasks
- **Real-time Updates**: The app automatically fetches updated tasks from the backend every 10 seconds.
- **Local Persistence**: Tasks are saved to a local SQLite database to ensure data persistence even when the app is restarted.

### API

The app interacts with a mock API hosted on [mockapi.io](https://mockapi.io) with the following endpoint:

**API Endpoint**:
`https://6707e9e68e86a8d9e42d70fd.mockapi.io/task/`

#### API Endpoints

- **GET /todos**: Fetch all tasks from the mock API.
- **GET /todos/:id**: Fetch a specific task by ID.
- **POST /todos**: Add a new task to the mock API.
- **PUT /todos/:id**: Update an existing task by ID.
- **DELETE /todos/:id**: Remove a task from the mock API by ID.

### Mock API Details

- **Schema**:
  - `title`: Task title (Faker.js: `word.noun`)
  - `description`: Task description (Faker.js: `lorem.words`)
  - `isCompleted`: Task completion status (Faker.js: `datatype.boolean`)

Example of a response from the mock API:

```json
{
  "id": "1",
  "title": "Grocery shopping",
  "description": "Buy groceries for the week",
  "isCompleted": false
}
```

### Architecture

- **State Management**: The app uses **BloC** (Business Logic Component) for state management, using the `flutter_bloc` package.
- **Packages Used**:
  - `flutter_bloc`: For managing state using BloC.
  - `sqflite`: For local database storage using SQLite.
  - `connectivity_plus`: For checking internet connectivity.
  - `fluttertoast`: For displaying toast notifications to the user.

### Real-time Updates

The app fetches the latest list of tasks from the mock API every 10 seconds using a `Timer`. If there is no internet connection, tasks are fetched from the local SQLite database instead.

### Bloc Requirements

The `TaskBloc` handles all the business logic, including:

- Adding, editing, and deleting tasks.
- Toggling task completion status.
- Filtering tasks based on completion status.
- Syncing tasks with the mock API.
- Handling real-time updates every 10 seconds.

### UI

The app displays a list of tasks with their titles, descriptions, and completion status. Buttons are provided for filtering tasks (all, completed, incomplete), and input fields allow users to add or edit tasks. Snackbars and toast messages are used for user feedback.

### Installation

1. **Clone the repository**:

   ```bash
   git clone https://github.com/HeinThuraWynnn/todo_bloc_app.git
   ```
2. **Install dependencies**:

   ```bash
   flutter pub get
   ```
3. **Run the app**:

   ```bash
   flutter run
   ```

### Dependencies

Below are the key dependencies used in the project:

- **sqflite**: For SQLite database management.
- **flutter_bloc**: For Flutter state management.

### Bonus Features

- **Streams**: Real-time updates are handled using streams within BloC.
- **BlocListener**: Snackbars and toasts are shown for user actions like task creation, deletion, and updates.

### Contact

For any queries or support, please reach out at `heinthurawynn.developer@gmail.com`.
