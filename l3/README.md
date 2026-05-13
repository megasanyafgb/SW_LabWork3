# Information System Project - Laboratory Work #3

Проектування концептуальних та логічних структур даних програмного продукту з використанням UML та PlantUML.

## Проектна структура

```
├── 1.2.3-UseCaseDiagram/         # UML діаграма прецедентів
│   ├── README.md
│   └── UML-UseCase.puml
├── 1.4.1-SoftwareArchitectConcept/  # UML діаграма розгортання
│   ├── README.md
│   └── UML-Deployment.puml
├── 2-SoftwareDesign/              # Проектування програмного продукту
│   ├── 2.1-UMLConceptClasses/     # UML діаграма концептуальних класів
│   │   ├── README.md
│   │   └── UML-ConceptClasses.puml
│   ├── 2.2-AttributeVocabulary/   # Словник атрибутів об'єктів
│   │   └── README.md
│   └── 2.3-DataModel/             # Схема моделі даних
│       ├── README.md
│       ├── RelModelSchema.puml
│       └── JSONSchema.puml
├── src/                            # Реалізація на Java
│   ├── Main.java
│   ├── Person.java
│   ├── Teacher.java
│   └── Student.java
├── sql/                            # Схеми баз даних
│   ├── schema.sql (приклад)
│   └── PersonTeacherStudentSchema.sql
├── config/                         # Конфігураційні файли
│   ├── data.json
│   └── data.yaml
└── diagrams/                       # Додаткові діаграми (PlantUML примери)
```

## UML Діаграми

### 1. Діаграма концептуальних класів (UML-ConceptClasses.puml)

Концептуальна модель включає три основні класи:

**Person** (базовий клас)
- `name: String` - ім'я особи
- `age: int` - вік особи

**Teacher** (успадковує Person)
- `course: String` - предмет, що викладається
- `workExperience: int` - роки роботи
- Зв'язок: викладає 1:M студентів

**Student** (успадковує Person)
- `course: String` - назва курсу
- `studentGroup: String` - номер групи
- Зв'язок: навчається у 1 викладача

### 2. Діаграма прецедентів (UML-UseCase.puml)

Визначає взаємодію акторів з системою:
- **Actor1** та **Complex Actor2** - користувачі системи
- **Usecase1, Usecase2, Usecase3** - основні операції системи
- Зв'язки: include, extends

### 3. Діаграма розгортання (UML-Deployment.puml)

Архітектура системи:
- **Desktop 1**: клієнтська машина з браузером (Windows/Linux)
- **Server 1**: серверна машина з веб-сервером (Linux)
- Пристрої введення-виведення: клавіатура, миша

## Логічне проектування

### Реляційна модель

Три таблиці з визначеними зв'язками:

```
person (person_id PK, name, age, person_type)
    ├─ teacher (teacher_id PK, person_id FK, course, work_experience)
    └─ student (student_id PK, person_id FK, teacher_id FK, course, student_group)
```

### JSON модель

Структура даних для JSON:
```json
{
  "persons": [...],
  "teachers": [...],
  "students": [...]
}
```

## Словник атрибутів об'єктів

| Об'єкт | Атрибут | Опис | Тип | Обмеження |
|--------|---------|------|-----|-----------|
| Person | name | Прізвище та ім'я | String | 1-100 символів |
| Person | age | Вік | int | 1-150 років |
| Teacher | course | Предмет | String | 1-100 символів |
| Teacher | workExperience | Роки досвіду | int | >= 0 |
| Student | course | Курс | String | 1-100 символів |
| Student | studentGroup | Група | String | 1-50 символів |

## Реалізація на Java

### Структура класів

**Person.java** - базовий клас
**Teacher.java** - клас викладача (успадковує Person)
**Student.java** - клас студента (успадковує Person)
**Main.java** - клас для запуску та демонстрації

### Компіляція та запуск

```bash
javac src/*.java
java -cp . Main
```

## База даних

### SQL схема

Основна схема розташована в `sql/PersonTeacherStudentSchema.sql`:

```sql
CREATE TABLE person (
    person_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    age INT NOT NULL CHECK (age > 0 AND age <= 150),
    person_type VARCHAR(50) NOT NULL
);

CREATE TABLE teacher (
    teacher_id INT PRIMARY KEY AUTO_INCREMENT,
    person_id INT NOT NULL UNIQUE,
    course VARCHAR(100) NOT NULL,
    work_experience INT NOT NULL DEFAULT 0,
    FOREIGN KEY (person_id) REFERENCES person(person_id)
);

CREATE TABLE student (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    person_id INT NOT NULL UNIQUE,
    teacher_id INT NOT NULL,
    course VARCHAR(100) NOT NULL,
    student_group VARCHAR(50) NOT NULL,
    FOREIGN KEY (person_id) REFERENCES person(person_id),
    FOREIGN KEY (teacher_id) REFERENCES teacher(teacher_id)
);
```

### Установка БД

```bash
mysql -u root -p < sql/PersonTeacherStudentSchema.sql
```

## Плани на подальший розвиток

1. ✅ Концептуальне проектування (UML діаграми)
2. ✅ Логічне проектування (Реляційна та JSON моделі)
3. ✅ Створення SQL схеми
4. ✅ Java реалізація класів
5. ⏳ Підключення до MySQL/MariaDB
6. ⏳ REST API для операцій CRUD
7. ⏳ Веб-інтерфейс (HTML/CSS/JavaScript)
8. ⏳ Розгортання на серверу (відповідно до діаграми розгортання)
9. ⏳ Юнит-тести
10. ⏳ Документація API