# Пошагова інструкція: Завантаження на GitHub

## Крок 1: Підготовка локального репозиторію

### 1.1 Перевірити статус Git

```bash
cd c:\Users\plcds\Desktop\l3
git status
```

Якщо бачите "Not a git repository", виконайте ініціалізацію:

```bash
git init
```

### 1.2 Налаштування Git користувача (якщо не налаштовано)

```bash
git config user.name "Your Full Name"
git config user.email "your.email@gmail.com"

# Для перевірки:
git config --list
```

## Крок 2: Додавання всіх файлів

```bash
# Додати всі файли
git add .

# Перевірити що буде додано
git status
```

Мають бути додані:
- ✅ 1.2.3-UseCaseDiagram/README.md та UML-UseCase.puml
- ✅ 1.4.1-SoftwareArchitectConcept/README.md та UML-Deployment.puml
- ✅ 2-SoftwareDesign/2.1-UMLConceptClasses/... (всі файли)
- ✅ 2-SoftwareDesign/2.2-AttributeVocabulary/README.md
- ✅ 2-SoftwareDesign/2.3-DataModel/... (всі файли)
- ✅ sql/PersonTeacherStudentSchema.sql
- ✅ README.md (оновлено)
- ✅ COMPLETION_STATUS.md

## Крок 3: Створення першого комміту

```bash
git commit -m "Laboratory Work #3: Complete UML conceptual and logical design

- Created directory structure according to requirements
- Added UML diagrams: Use Case, Deployment, Concept Classes
- Implemented relational and JSON data models
- Created comprehensive SQL schema
- Added attribute vocabulary documentation
- Updated main README with project structure"
```

## Крок 4: Налаштування remote репозиторію

### 4.1 Якщо ви вже маєте репозиторій на GitHub:

```bash
git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO.git
```

**Замініть:**
- `YOUR_USERNAME` - ваш GitHub username
- `YOUR_REPO` - назва вашого репозиторію

### 4.2 Якщо ви щойно створили репозиторій:

На GitHub:
1. Перейти на https://github.com/new
2. Ввести назву репозиторію (наприклад: `software-design-lab`)
3. Клікнути "Create repository"
4. Скопіювати посилання (git@github.com:YOUR_USERNAME/YOUR_REPO.git)

Потім локально:

```bash
git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO.git
```

### 4.3 Перевірка remote

```bash
git remote -v

# Вихід повинен показати:
# origin  https://github.com/YOUR_USERNAME/YOUR_REPO.git (fetch)
# origin  https://github.com/YOUR_USERNAME/YOUR_REPO.git (push)
```

## Крок 5: Завантаження на GitHub

### 5.1 Для нового репозиторію:

```bash
git branch -M main
git push -u origin main
```

### 5.2 Для існуючого репозиторію:

```bash
git push origin main
```

## Крок 6: Перевірка на GitHub

1. Перейти на https://github.com/YOUR_USERNAME/YOUR_REPO
2. Переконатись що всі файли завантажені
3. Перевірити що PlantUML діаграми відображаються через PlantUML proxy

## Крок 7: Оновлення посилань у README

Якщо ви змінилиUsername або Repo, оновіть посилання у файлах:

### 7.1 Відкрити файли для редагування:
- `1.2.3-UseCaseDiagram/README.md`
- `1.4.1-SoftwareArchitectConcept/README.md`
- `2-SoftwareDesign/2.1-UMLConceptClasses/README.md`
- `2-SoftwareDesign/2.3-DataModel/README.md`

### 7.2 Замінити в кожному файлі:

**Було:**
```markdown
![](http://www.plantuml.com/plantuml/proxy?cache=no&src=https://raw.githubusercontent.com/yourusername/repo/laboratory-work-3/...)
```

**Має бути:**
```markdown
![](http://www.plantuml.com/plantuml/proxy?cache=no&src=https://raw.githubusercontent.com/YOUR_USERNAME/YOUR_REPO/main/...)
```

### 7.3 Приклад для UML-UseCase.puml:

```markdown
![](http://www.plantuml.com/plantuml/proxy?cache=no&src=https://raw.githubusercontent.com/plcds/software-design-lab/main/1.2.3-UseCaseDiagram/UML-UseCase.puml)
```

### 7.4 Комміт та push змін:

```bash
git add .
git commit -m "Update PlantUML links to correct repository path"
git push origin main
```

---

# Тестування проекту

## 1. Тестування Java коду

```bash
# Навігація до директорії
cd c:\Users\plcds\Desktop\l3

# Компіляція
javac src/*.java

# Запуск
java -cp src Main
```

**Очікуваний вихід:**
```
Teacher{name='John Doe', age=40, course='Mathematics', workExperience=15, students=2}
Student{name='Alice', age=20, course='Mathematics', studentGroup='Group A', teacher=John Doe}
Student{name='Bob', age=21, course='Mathematics', studentGroup='Group A', teacher=John Doe}
```

## 2. Тестування SQL схеми

### 2.1 Створення бази даних

```bash
# Linux/Mac:
mysql -u root -p < sql/PersonTeacherStudentSchema.sql

# Windows (PowerShell):
# Спочатку перейти до папки MySQL
cd "C:\Program Files\MySQL\MySQL Server 8.0\bin"
mysql -u root -p information_system < "c:\Users\plcds\Desktop\l3\sql\PersonTeacherStudentSchema.sql"
```

### 2.2 Перевірка даних

```bash
mysql -u root -p information_system
```

Виконати запити:

```sql
-- 1. Показати всіх людей
SELECT * FROM person;

-- 2. Показати всіх викладачів з їхніми даними
SELECT p.person_id, p.name, p.age, t.course, t.work_experience
FROM person p
JOIN teacher t ON p.person_id = t.person_id;

-- 3. Показати всіх студентів з їхніми викладачами
SELECT 
    s.student_id,
    p_student.name as student_name,
    p_student.age,
    s.course,
    s.student_group,
    p_teacher.name as teacher_name,
    t.course as teacher_course
FROM student s
JOIN person p_student ON s.person_id = p_student.person_id
JOIN teacher t ON s.teacher_id = t.teacher_id
JOIN person p_teacher ON t.person_id = p_teacher.person_id;

-- 4. Статистика
SELECT 
    COUNT(DISTINCT t.teacher_id) as teacher_count,
    COUNT(DISTINCT s.student_id) as student_count
FROM teacher t, student s;
```

## 3. Валідація PlantUML діаграм

### 3.1 Онлайн редактор

1. Перейти на https://www.planttext.com/
2. Для кожного файлу .puml:
   - Скопіювати вміст файлу
   - Вставити в редактор
   - Переконатись що діаграма рендериться

### 3.2 Приклади для перевірки:

**UML-ConceptClasses.puml** повинен показати:
- Person клас з name та age
- Teacher клас з course та workExperience
- Student клас з course та studentGroup
- Успадкування (стрілки від Teacher/Student до Person)
- Асоціації (1:M зв'язок "teaches" та "studies")

**UML-Deployment.puml** повинен показати:
- Desktop 1 вузол з браузером
- Server 1 вузол з веб-сервером
- Клавіатура та миша підключені до Desktop 1
- Зв'язок між Desktop та Server

**UML-UseCase.puml** повинен показати:
- Двох акторів
- Три use case
- Include та extends зв'язки

## 4. Перевірка структури проекту

```bash
# Показати всю структуру
tree /F

# Або через PowerShell:
Get-ChildItem -Recurse -Name
```

**Очікувана структура:**
```
l3/
├── 1.2.3-UseCaseDiagram/
│   ├── README.md
│   └── UML-UseCase.puml
├── 1.4.1-SoftwareArchitectConcept/
│   ├── README.md
│   └── UML-Deployment.puml
├── 2-SoftwareDesign/
│   ├── 2.1-UMLConceptClasses/
│   │   ├── README.md
│   │   └── UML-ConceptClasses.puml
│   ├── 2.2-AttributeVocabulary/
│   │   └── README.md
│   └── 2.3-DataModel/
│       ├── README.md
│       ├── RelModelSchema.puml
│       └── JSONSchema.puml
├── config/
│   ├── data.json
│   └── data.yaml
├── diagrams/
│   ├── Classes.puml
│   ├── Deployment.puml
│   ├── JSON.puml
│   ├── RelDB.puml
│   ├── UseCase.puml
│   └── YAML.puml
├── sql/
│   ├── schema.sql
│   └── PersonTeacherStudentSchema.sql
├── src/
│   ├── Main.java
│   ├── Person.java
│   ├── Student.java
│   └── Teacher.java
├── COMPLETION_STATUS.md
├── GITHUB_INSTRUCTIONS.md
└── README.md
```

---

# Рекомендації щодо кодування

## 1. Правила найменування

- **Класи:** PascalCase (Person, Teacher, Student)
- **Методи:** camelCase (getName, setAge)
- **Константи:** UPPER_CASE
- **Пакети:** lowercase (com.university.system)

## 2. Документація коду

Додайте JavaDoc коментарі:

```java
/**
 * Represents a person in the information system.
 * This is a base class for both Teachers and Students.
 * 
 * @author Your Name
 * @version 1.0
 */
public class Person {
    /**
     * The person's full name.
     */
    private String name;
    
    /**
     * Gets the person's name.
     * @return the name of the person
     */
    public String getName() {
        return name;
    }
}
```

## 3. Відповідність Java коду UML моделі

**Карта відповідності:**

| UML | Java |
|-----|------|
| Class | class |
| Inheritance | extends |
| Association | field (reference) |
| Aggregation | field (Collection) |
| Multiplicity 1:1 | single field |
| Multiplicity 1:M | List/ArrayList |
| Multiplicity M:M | Set/HashSet |

---

# Наступні кроки (для подальшого розвитку)

1. **Підключення до БД:**
   - Додати JDBC драйвер
   - Реалізувати DAO класи
   - Додати конекшну池

2. **REST API:**
   - Додати Spring Boot
   - Реалізувати @RestController
   - Додати операції CRUD

3. **Веб-інтерфейс:**
   - HTML + CSS + JavaScript
   - Форми для додавання студентів/вчителів
   - Таблиці для відображення даних

4. **Розгортання:**
   - Docker контейнер
   - Розміщення на серверу
   - Конфігурація Nginx/Apache

---

**Дата остаточного оновлення:** 13.05.2026
