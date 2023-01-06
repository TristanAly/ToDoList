# ToDoList

A task management application with Core Data and reminder notification 

# 💻 Tech Stack:
![Swift](https://img.shields.io/badge/swift-F54A2A?style=for-the-badge&logo=swift&logoColor=white)

## 🔗 Links
[![portfolio](https://img.shields.io/badge/my_portfolio-000?style=for-the-badge&logo=ko-fi&logoColor=white)](https://thunderous-froyo-792aa8.netlify.app/)
[![linkedin](https://img.shields.io/badge/linkedin-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/tristan-aly)

# Core Data Build

#### Category


| Parameter | Type     |
| :-------- | :------- |
| `name`    | `string` |
| `icon`    | `string` |
| `id`      | `Int64`  |


#### TaskItem

| Parameter | Type     |
| :-------- | :------- |
| `name`    | `string` |
| `note`    | `string` |
| `isComplete`| `Boolean` |
| `timestamp` | `Date` |
| `id`      | `Int64`  |


## RelationShip Entity

#### Category

| RelationShip | Destination  | Inverse |
| :-------- | :------- | :------- |
| `tasks` | `TaskItem` | `categories` |

#### TaskItem

| RelationShip | Destination  | Inverse |
| :-------- | :------- | :------- |
| `categories` | `Category` | `tasks` |

