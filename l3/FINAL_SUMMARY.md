# 🎓 ЛАБОРАТОРНА РОБОТА №3 - ЗАКЛЮЧНА ІНФОРМАЦІЯ

**Дисципліна:** Технології створення програмних продуктів  
**Викладач:** Олександр А. Блажко  
**Статус:** ГОТОВО ДО ЗАВАНТАЖЕННЯ  
**Дата:** 13.05.2026

---

## 📁 СТРУКТУРА ПРОЕКТУ (ПОВНА)

```
L3/
│
├─── 📄 README.md (оновлено)
├─── 📄 COMPLETION_STATUS.md (детальний статус ✅)
├─── 📄 GITHUB_INSTRUCTIONS.md (покрок-покроко інструкції ✅)
├─── 📄 CODE_EXAMPLES.md (рабочі приклади ✅)
├─── 📄 QUICK_START.md (швидкий старт ✅)
│
├─── 📁 1.2.3-UseCaseDiagram
│    ├─── README.md (описання з PlantUML proxy)
│    └─── UML-UseCase.puml (діаграма прецедентів)
│
├─── 📁 1.4.1-SoftwareArchitectConcept
│    ├─── README.md (описання системи)
│    └─── UML-Deployment.puml (архітектура розгортання)
│
├─── 📁 2-SoftwareDesign
│    │
│    ├─── 📁 2.1-UMLConceptClasses
│    │    ├─── README.md (опис концептуальної моделі)
│    │    └─── UML-ConceptClasses.puml (діаграма класів)
│    │
│    ├─── 📁 2.2-AttributeVocabulary
│    │    └─── README.md (таблиця атрибутів)
│    │
│    └─── 📁 2.3-DataModel
│         ├─── README.md (схеми + SQL код)
│         ├─── RelModelSchema.puml (реляційна модель)
│         └─── JSONSchema.puml (JSON модель)
│
├─── 📁 sql/
│    ├─── schema.sql (приклад)
│    └─── PersonTeacherStudentSchema.sql (НОВА повна схема ✅)
│
├─── 📁 src/
│    ├─── Main.java
│    ├─── Person.java
│    ├─── Student.java
│    └─── Teacher.java
│
├─── 📁 config/
│    ├─── data.json
│    └─── data.yaml
│
└─── 📁 diagrams/ (приклади PlantUML)
     ├─── Classes.puml
     ├─── Deployment.puml
     ├─── JSON.puml
     ├─── RelDB.puml
     ├─── UseCase.puml
     └─── YAML.puml

ВСЬОГО ФАЙЛІВ: 25+
ВСЬОГО ПАПОК: 10+
```

---

## 📊 КОМПОНЕНТИ РОБОТИ

### 1️⃣ UML Діаграми (PlantUML)

#### 📐 UML-ConceptClasses.puml
**Вміст:** Діаграма класів з наслідуванням та асоціаціями
```
Person (абстрактний)
├── Teacher (успадковує Person)
│   ├── course: String
│   ├── workExperience: int
│   └── Зв'язок: 1 teacher -> M students
│
└── Student (успадковує Person)
    ├── course: String
    ├── studentGroup: String
    └── Зв'язок: M students -> 1 teacher
```

**Де знаходиться:** `2-SoftwareDesign/2.1-UMLConceptClasses/UML-ConceptClasses.puml`  
**Статус:** ✅ Завершено

---

#### 📐 UML-UseCase.puml
**Вміст:** Діаграма прецедентів системи
```
Актори:
- Actor1 (базовий користувач)
- Complex Actor2 (складний користувач)

Use Cases:
- Usecase1 (основна операція)
  └─ Include: Usecase2
     └─ Extends: Usecase3
```

**Де знаходиться:** `1.2.3-UseCaseDiagram/UML-UseCase.puml`  
**Статус:** ✅ Завершено

---

#### 📐 UML-Deployment.puml
**Вміст:** Архітектура розгортання системи
```
Desktop 1 (Windows/Linux)
└── Web Browser
    ↔ (Мережа)
Server 1 (Linux)
└── Web Server

Пристрої:
- Keyboard → Desktop 1
- Mouse → Desktop 1
```

**Де знаходиться:** `1.4.1-SoftwareArchitectConcept/UML-Deployment.puml`  
**Статус:** ✅ Завершено

---

### 2️⃣ Логічні моделі даних

#### 🗄️ Реляційна модель (RelModelSchema.puml)
**Таблиці:**
- `person` (person_id, name, age, person_type)
- `teacher` (teacher_id, person_id FK, course, work_experience)
- `student` (student_id, person_id FK, teacher_id FK, course, student_group)

**Зв'язки:**
- person 1:M teacher (наслідування)
- teacher 1:M student (навчання)

**Де знаходиться:** `2-SoftwareDesign/2.3-DataModel/RelModelSchema.puml`  
**Статус:** ✅ Завершено

---

#### 📋 JSON модель (JSONSchema.puml)
**Структура:**
```json
{
  "persons": [Array of persons],
  "teachers": [Array of teachers],
  "students": [Array of students]
}
```

**Де знаходиться:** `2-SoftwareDesign/2.3-DataModel/JSONSchema.puml`  
**Статус:** ✅ Завершено

---

### 3️⃣ SQL схема

#### 💾 PersonTeacherStudentSchema.sql
**Включає:**
- Створення 3 таблиць з коректною структурою
- Обмеження (CHECK, NOT NULL, FOREIGN KEY)
- Індекси для оптимізації
- Приклади даних (INSERT)

**Де знаходиться:** `sql/PersonTeacherStudentSchema.sql`  
**Статус:** ✅ Завершено

**Приклад установки:**
```sql
mysql -u root -p < sql/PersonTeacherStudentSchema.sql
```

---

### 4️⃣ Словник атрибутів

#### 📚 Таблиця атрибутів
**Де знаходиться:** `2-SoftwareDesign/2.2-AttributeVocabulary/README.md`

**Формат таблиці:**
| Об'єкт | Атрибут | Опис | Тип | Обмеження |

**Приклади:**
- Person.name: String (1-100 символів)
- Person.age: int (1-150 років)
- Teacher.course: String (1-100 символів)
- Teacher.workExperience: int (>= 0)
- Student.course: String (1-100 символів)
- Student.studentGroup: String (1-50 символів)

**Статус:** ✅ Завершено

---

## 🔄 ПРОЦЕС ЗАВАНТАЖЕННЯ НА GITHUB

### Етап 1: Локальна підготовка

```bash
# 1. Перейти до папки проекту
cd c:\Users\plcds\Desktop\l3

# 2. Ініціалізація git (якщо не готово)
git init

# 3. Налаштування користувача
git config user.name "Your Name"
git config user.email "your@email.com"

# 4. Додавання всіх файлів
git add .

# 5. Комміт
git commit -m "Laboratory Work #3: Complete conceptual and logical design
- Created UML diagrams (Use Case, Deployment, Concept Classes)
- Implemented relational and JSON data models
- Created comprehensive SQL schema with constraints
- Added attribute vocabulary documentation"
```

### Етап 2: Налаштування GitHub

```bash
# 1. Встановлення remote репозиторію
git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO.git

# 2. Перейменування гілки
git branch -M main

# 3. Завантаження
git push -u origin main
```

### Етап 3: Валідація на GitHub

1. Перейти на https://github.com/YOUR_USERNAME/YOUR_REPO
2. Переконатись що всі файли завантажені
3. Перевірити PlantUML діаграми через proxy посилання

---

## ✅ ОЧІКУВАНІ РЕЗУЛЬТАТИ

### При запуску Java програми

```bash
$ javac src/*.java
$ java -cp src Main

Вихід:
Teacher{name='John Doe', age=40, course='Mathematics', workExperience=15, students=2}
Student{name='Alice', age=20, course='Mathematics', studentGroup='Group A', teacher=John Doe}
Student{name='Bob', age=21, course='Mathematics', studentGroup='Group A', teacher=John Doe}
```

### При запуску SQL запиту

```bash
$ mysql -u root -p information_system < sql/PersonTeacherStudentSchema.sql
$ mysql -u root -p information_system

mysql> SELECT * FROM person;
+-----------+----------+-----+---------------+
| person_id | name     | age | person_type   |
+-----------+----------+-----+---------------+
| 1         | John Doe | 40  | Teacher       |
| 2         | Alice    | 20  | Student       |
| 3         | Bob      | 21  | Student       |
+-----------+----------+-----+---------------+
```

### При перегляді PlantUML діаграми

Діаграма повинна рендеритись через PlantUML proxy посилання з правильним форматуванням та зв'язками.

---

## 📋 ОСТАТОК ЗАДАЧ

### Терміновано (КРИТИЧНО)

- [ ] **Замінити посилання на GitHub** у всіх README файлах з PlantUML proxy
  - Файли: 4 штуки (див. GITHUB_INSTRUCTIONS.md)
  - Шаблон: `https://raw.githubusercontent.com/YOUR_USERNAME/YOUR_REPO/main/PATH`

- [ ] **Завантажити на GitHub**
  - Команда: `git push -u origin main`
  - Перевірка: https://github.com/YOUR_USERNAME/YOUR_REPO

### На рівні розширення (ОПЦІОНАЛЬНО)

- [ ] Додати CI/CD pipeline (.github/workflows/)
- [ ] Додати .gitignore файл
- [ ] Додати LICENSE файл
- [ ] Додати розширену документацію по розгортанню
- [ ] Додати unit-тести для Java класів
- [ ] Додати примеры REST API
- [ ] Додати Docker конфігурацію

---

## 🎯 НАЙВАЖЛИВІШІ МОМЕНТИ

### 1. PlantUML посилання

**ПОМИЛКА:**
```markdown
![](http://www.plantuml.com/plantuml/proxy?cache=no&src=https://raw.githubusercontent.com/yourusername/repo/laboratory-work-3/...)
```

**ПРАВИЛЬНО:**
```markdown
![](http://www.plantuml.com/plantuml/proxy?cache=no&src=https://raw.githubusercontent.com/plcds/myrepo/main/1.2.3-UseCaseDiagram/UML-UseCase.puml)
```

### 2. SQL схема

**Обов'язкові компоненти:**
- ✅ Таблиця person (базова для наслідування)
- ✅ Таблиця teacher з FK на person
- ✅ Таблиця student з FK на teacher та person
- ✅ Обмеження (CHECK для age, NOT NULL для обов'язкових полів)
- ✅ Індекси для покращення пошуку

### 3. UML діаграми

**Обов'язкові елементи:**
- ✅ Коректна синтаксис PlantUML
- ✅ Всі класи та їх атрибути
- ✅ Наслідування (стрілки)
- ✅ Асоціації з кратностями (1:1, 1:M, M:M)
- ✅ Іменовані зв'язки (vilden, teaches, studies)

---

## 📞 КОНТРОЛЬНІ ЗАПИТАННЯ ДЛЯ ПЕРЕВІРКИ

1. **Скільки таблиць в БД?** Відповідь: 3 (person, teacher, student)
2. **Який тип наслідування використаний?** Відповідь: Single Table Inheritance
3. **Кількість UML діаграм?** Відповідь: 3 (Use Case, Deployment, Concept Classes)
4. **Яка кратність зв'язку teacher-student?** Відповідь: 1:M (один викладач -> багато студентів)
5. **Де розташована SQL схема?** Відповідь: sql/PersonTeacherStudentSchema.sql

---

## 🚀 ФІНАЛЬНА ЧЕКЛИСТ

```
СТРУКТУРА ПРОЕКТУ:
[✅] Все директорії створені
[✅] Все файли на місцях
[✅] Нема синтаксичних помилок

ДОКУМЕНТАЦІЯ:
[✅] README.md оновлено
[✅] COMPLETION_STATUS.md заповнено
[✅] GITHUB_INSTRUCTIONS.md готов
[✅] CODE_EXAMPLES.md з робочими примерами
[✅] QUICK_START.md з швидким стартом

UML ДІАГРАМИ:
[✅] UML-UseCase.puml синтаксично коректна
[✅] UML-Deployment.puml синтаксично коректна
[✅] UML-ConceptClasses.puml синтаксично коректна
[✅] Всі діаграми можна відтворити на planttext.com

ЛОГІЧНІ МОДЕЛІ:
[✅] Реляційна модель (RelModelSchema.puml)
[✅] JSON модель (JSONSchema.puml)
[✅] SQL схема (PersonTeacherStudentSchema.sql)

JAVA КОД:
[✅] Person.java компілюється
[✅] Teacher.java компілюється
[✅] Student.java компілюється
[✅] Main.java запускається й дає правильний результат

ГОТОВО ДО ЗАВАНТАЖЕННЯ:
[ ] Замінити посилання GitHub у README файлах
[ ] Виконати git add, git commit, git push
[ ] Перевірити на GitHub що все на місцях
[ ] Задати SQL схему на базі даних
[ ] Таблиця атрибутів заповнена коректно
```

---

## 📚 ПОСИЛАННЯ НА ФАЙЛИ

| Файл | Призначення | Статус |
|------|-------------|--------|
| [README.md](./README.md) | Основна документація | ✅ |
| [COMPLETION_STATUS.md](./COMPLETION_STATUS.md) | Детальний статус | ✅ |
| [GITHUB_INSTRUCTIONS.md](./GITHUB_INSTRUCTIONS.md) | Покроковий гайд | ✅ |
| [CODE_EXAMPLES.md](./CODE_EXAMPLES.md) | Приклади коду | ✅ |
| [QUICK_START.md](./QUICK_START.md) | Швидкий старт | ✅ |
| [2-SoftwareDesign/2.1-UMLConceptClasses/](./2-SoftwareDesign/2.1-UMLConceptClasses/) | Концептуальні класи | ✅ |
| [2-SoftwareDesign/2.3-DataModel/](./2-SoftwareDesign/2.3-DataModel/) | Моделі даних | ✅ |
| [sql/PersonTeacherStudentSchema.sql](./sql/PersonTeacherStudentSchema.sql) | SQL схема | ✅ |

---

**ПРОЕКТ ГОТОВ ДО ЗАВАНТАЖЕННЯ НА GITHUB!** 🚀

Залишилось замінити посилання та виконати git push.

*Останнє оновлення: 13.05.2026*
