# Приклади коду та SQL запитів

## 1. Java примеры розширення функціоналу

### 1.1 Поліморфізм та типи даних

```java
// DatabaseConnection.java
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DatabaseConnection {
    private static final String URL = "jdbc:mysql://localhost:3306/information_system";
    private static final String USER = "root";
    private static final String PASSWORD = "password";

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            System.err.println("MySQL JDBC Driver not found!");
            e.printStackTrace();
        }
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }

    public static void main(String[] args) {
        try {
            Connection conn = getConnection();
            System.out.println("✓ Database connected successfully!");
            
            // Test query
            testQueries(conn);
            
            conn.close();
            System.out.println("✓ Database connection closed.");
        } catch (SQLException e) {
            System.err.println("✗ Database error: " + e.getMessage());
            e.printStackTrace();
        }
    }

    private static void testQueries(Connection conn) throws SQLException {
        System.out.println("\n--- Testing Database Queries ---\n");

        // Query 1: All persons
        System.out.println("1. All Persons:");
        String query1 = "SELECT * FROM person";
        try (Statement stmt = conn.createStatement(); 
             ResultSet rs = stmt.executeQuery(query1)) {
            while (rs.next()) {
                System.out.printf("  ID: %d, Name: %s, Age: %d, Type: %s%n",
                    rs.getInt("person_id"),
                    rs.getString("name"),
                    rs.getInt("age"),
                    rs.getString("person_type"));
            }
        }

        // Query 2: Teachers with their courses
        System.out.println("\n2. Teachers:");
        String query2 = "SELECT p.person_id, p.name, t.course, t.work_experience " +
                       "FROM person p JOIN teacher t ON p.person_id = t.person_id";
        try (Statement stmt = conn.createStatement(); 
             ResultSet rs = stmt.executeQuery(query2)) {
            while (rs.next()) {
                System.out.printf("  %s (%s) - Experience: %d years%n",
                    rs.getString("name"),
                    rs.getString("course"),
                    rs.getInt("work_experience"));
            }
        }

        // Query 3: Students with their teachers
        System.out.println("\n3. Students and their Teachers:");
        String query3 = "SELECT p_s.name as student_name, s.student_group, " +
                       "p_t.name as teacher_name, t.course " +
                       "FROM student s " +
                       "JOIN person p_s ON s.person_id = p_s.person_id " +
                       "JOIN teacher t ON s.teacher_id = t.teacher_id " +
                       "JOIN person p_t ON t.person_id = p_t.person_id";
        try (Statement stmt = conn.createStatement(); 
             ResultSet rs = stmt.executeQuery(query3)) {
            while (rs.next()) {
                System.out.printf("  %s (Group %s) teaches by %s (%s)%n",
                    rs.getString("student_name"),
                    rs.getString("student_group"),
                    rs.getString("teacher_name"),
                    rs.getString("course"));
            }
        }

        // Query 4: Statistics
        System.out.println("\n4. Statistics:");
        String query4 = "SELECT " +
                       "(SELECT COUNT(*) FROM teacher) as teacher_count, " +
                       "(SELECT COUNT(*) FROM student) as student_count, " +
                       "(SELECT COUNT(*) FROM person) as total_count";
        try (Statement stmt = conn.createStatement(); 
             ResultSet rs = stmt.executeQuery(query4)) {
            if (rs.next()) {
                System.out.printf("  Total People: %d%n", rs.getInt("total_count"));
                System.out.printf("  Teachers: %d%n", rs.getInt("teacher_count"));
                System.out.printf("  Students: %d%n", rs.getInt("student_count"));
            }
        }
    }
}
```

### 1.2 Розширена версія Person класу

```java
// Person.java (розширена версія)
import java.time.LocalDate;

public class Person implements Comparable<Person> {
    private int id;
    private String name;
    private int age;
    private LocalDate dateOfBirth;
    private String email;
    private String phone;

    public Person(String name, int age) {
        this.name = name;
        this.age = age;
        this.dateOfBirth = LocalDate.now().minusYears(age);
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public int getAge() { return age; }
    public void setAge(int age) { this.age = age; }

    public LocalDate getDateOfBirth() { return dateOfBirth; }
    public void setDateOfBirth(LocalDate dateOfBirth) { this.dateOfBirth = dateOfBirth; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    // Методи
    public void printInfo() {
        System.out.printf("ID: %d%n", id);
        System.out.printf("Name: %s%n", name);
        System.out.printf("Age: %d%n", age);
        if (email != null) System.out.printf("Email: %s%n", email);
        if (phone != null) System.out.printf("Phone: %s%n", phone);
    }

    @Override
    public int compareTo(Person other) {
        return this.name.compareTo(other.name);
    }

    @Override
    public String toString() {
        return String.format("Person{id=%d, name='%s', age=%d}", id, name, age);
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (!(obj instanceof Person)) return false;
        Person person = (Person) obj;
        return this.id == person.id && this.name.equals(person.name);
    }
}
```

---

## 2. SQL Запити для кожної операції

### 2.1 INSERT операції

```sql
-- Додавання нового викладача
INSERT INTO person (name, age, person_type) VALUES ('Jane Smith', 35, 'Teacher');
INSERT INTO teacher (person_id, course, work_experience) 
SELECT person_id, 'Physics', 10 FROM person WHERE name = 'Jane Smith';

-- Додавання нового студента
INSERT INTO person (name, age, person_type) VALUES ('Charlie Brown', 19, 'Student');
INSERT INTO student (person_id, teacher_id, course, student_group) 
SELECT p.person_id, t.teacher_id, 'Physics', 'Group B'
FROM person p, teacher t 
WHERE p.name = 'Charlie Brown' AND t.work_experience > 5
LIMIT 1;

-- Додавання декількох студентів одразу
INSERT INTO person (name, age, person_type) VALUES 
('David Wilson', 20, 'Student'),
('Eva Davis', 22, 'Student'),
('Frank Miller', 21, 'Student');
```

### 2.2 SELECT операції

```sql
-- Всі студенти упорядковані за прізвищем
SELECT p.name, s.student_group, s.course
FROM student s
JOIN person p ON s.person_id = p.person_id
ORDER BY p.name ASC;

-- Студенти конкретного викладача
SELECT p.name, s.student_group
FROM student s
JOIN person p ON s.person_id = p.person_id
JOIN teacher t ON s.teacher_id = t.teacher_id
WHERE t.person_id = (SELECT person_id FROM person WHERE name = 'John Doe');

-- Середній вік студентів
SELECT AVG(p.age) as average_age
FROM student s
JOIN person p ON s.person_id = p.person_id;

-- Кількість студентів на викладача
SELECT p.name, t.course, COUNT(s.student_id) as student_count
FROM teacher t
JOIN person p ON t.person_id = p.person_id
LEFT JOIN student s ON t.teacher_id = s.teacher_id
GROUP BY t.teacher_id, p.name, t.course;

-- Студенти з фільтром за віком
SELECT p.name, p.age, s.student_group
FROM student s
JOIN person p ON s.person_id = p.person_id
WHERE p.age BETWEEN 18 AND 21
ORDER BY p.age DESC;
```

### 2.3 UPDATE операції

```sql
-- Оновлення досвіду викладача
UPDATE teacher
SET work_experience = work_experience + 1
WHERE person_id = (SELECT person_id FROM person WHERE name = 'John Doe');

-- Зміна групи студента
UPDATE student
SET student_group = 'Group C'
WHERE student_id = 2;

-- Перевід студента до іншого викладача
UPDATE student
SET teacher_id = (SELECT teacher_id FROM teacher WHERE person_id = 
    (SELECT person_id FROM person WHERE name = 'Jane Smith'))
WHERE student_id = 1;

-- Масове оновлення
UPDATE person
SET age = age + 1
WHERE YEAR(CURDATE()) - YEAR(DATE_SUB(CURDATE(), INTERVAL age YEAR)) = 0;
```

### 2.4 DELETE операції

```sql
-- Видалення студента (CASCADE видалить дані з person)
DELETE FROM student WHERE student_id = 1;

-- Видалення викладача (потребує видалення студентів спочатку)
DELETE FROM student WHERE teacher_id = (
    SELECT teacher_id FROM teacher 
    WHERE person_id = (SELECT person_id FROM person WHERE name = 'Jane Smith')
);
DELETE FROM teacher WHERE person_id = (
    SELECT person_id FROM person WHERE name = 'Jane Smith'
);
DELETE FROM person WHERE name = 'Jane Smith';
```

### 2.5 Аналітичні запити

```sql
-- Top 3 найбільш завантажені викладачі
SELECT p.name, COUNT(s.student_id) as student_load
FROM teacher t
JOIN person p ON t.person_id = p.person_id
LEFT JOIN student s ON t.teacher_id = s.teacher_id
GROUP BY t.teacher_id
ORDER BY student_load DESC
LIMIT 3;

-- Студенти без призначеного викладача (якби система це дозволяла)
SELECT p.name
FROM student s
JOIN person p ON s.person_id = p.person_id
WHERE s.teacher_id IS NULL;

-- Звіт по курсам
SELECT 
    t.course as course_name,
    COUNT(DISTINCT t.teacher_id) as teacher_count,
    COUNT(DISTINCT s.student_id) as student_count,
    ROUND(AVG(p.age), 1) as average_student_age
FROM teacher t
LEFT JOIN student s ON t.teacher_id = s.teacher_id
LEFT JOIN person p ON s.person_id = p.person_id
GROUP BY t.course
ORDER BY student_count DESC;

-- Деталізований звіт по кожному викладачу
SELECT 
    p.name as teacher_name,
    p.age,
    t.course,
    t.work_experience,
    COUNT(DISTINCT s.student_id) as number_of_students,
    GROUP_CONCAT(DISTINCT p_s.name ORDER BY p_s.name SEPARATOR ', ') as student_names
FROM teacher t
JOIN person p ON t.person_id = p.person_id
LEFT JOIN student s ON t.teacher_id = s.teacher_id
LEFT JOIN person p_s ON s.person_id = p_s.person_id
GROUP BY t.teacher_id
ORDER BY p.name;
```

---

## 3. Приклади використання Java Collection

```java
import java.util.*;
import java.util.stream.Collectors;

public class CollectionExamples {
    
    public static void main(String[] args) {
        // Приклад з використанням List для студентів
        List<Student> students = new ArrayList<>();
        List<Teacher> teachers = new ArrayList<>();
        
        // Створення даних
        Teacher teacher1 = new Teacher("John Doe", 40, "Mathematics", 15);
        Student student1 = new Student("Alice", 20, "Mathematics", "Group A");
        Student student2 = new Student("Bob", 21, "Mathematics", "Group A");
        Student student3 = new Student("Charlie", 19, "Physics", "Group B");
        
        teacher1.addStudent(student1);
        teacher1.addStudent(student2);
        
        students.add(student1);
        students.add(student2);
        students.add(student3);
        teachers.add(teacher1);
        
        // Операції зі список
        System.out.println("1. Всі студенти:");
        students.forEach(System.out::println);
        
        // Фільтрація через Stream API
        System.out.println("\n2. Студенти Mathematics:");
        students.stream()
            .filter(s -> s.getCourse().equals("Mathematics"))
            .forEach(s -> System.out.println("  " + s.getName()));
        
        // Сортування
        System.out.println("\n3. Студенти упорядковані за віком:");
        students.stream()
            .sorted(Comparator.comparingInt(Person::getAge))
            .forEach(s -> System.out.println("  " + s.getName() + " (" + s.getAge() + ")"));
        
        // Групування
        System.out.println("\n4. Студенти по курсам:");
        students.stream()
            .collect(Collectors.groupingBy(Student::getCourse))
            .forEach((course, stds) -> {
                System.out.printf("  %s: %s%n", course, 
                    stds.stream().map(Person::getName).collect(Collectors.joining(", ")));
            });
        
        // Set для унікальних значень
        Set<String> uniqueCourses = students.stream()
            .map(Student::getCourse)
            .collect(Collectors.toSet());
        System.out.println("\n5. Унікальні курси: " + uniqueCourses);
        
        // Map для швидкого пошуку
        Map<String, Student> studentsByName = students.stream()
            .collect(Collectors.toMap(Person::getName, student -> student));
        System.out.println("\n6. Знайти студента за ім'ям 'Alice':");
        Student found = studentsByName.get("Alice");
        if (found != null) System.out.println("  " + found);
    }
}
```

---

## 4. Приклади Middleware/Service Layer

```java
// PersonService.java
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PersonService {
    
    public List<Person> getAllPersons() throws SQLException {
        List<Person> persons = new ArrayList<>();
        String query = "SELECT * FROM person";
        
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            
            while (rs.next()) {
                Person person = new Person(
                    rs.getString("name"),
                    rs.getInt("age")
                );
                person.setId(rs.getInt("person_id"));
                persons.add(person);
            }
        }
        return persons;
    }
    
    public void addPerson(String name, int age, String type) throws SQLException {
        String query = "INSERT INTO person (name, age, person_type) VALUES (?, ?, ?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setString(1, name);
            pstmt.setInt(2, age);
            pstmt.setString(3, type);
            pstmt.executeUpdate();
            System.out.println("Person added successfully!");
        }
    }
    
    public void updatePerson(int id, String name, int age) throws SQLException {
        String query = "UPDATE person SET name = ?, age = ? WHERE person_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setString(1, name);
            pstmt.setInt(2, age);
            pstmt.setInt(3, id);
            pstmt.executeUpdate();
            System.out.println("Person updated successfully!");
        }
    }
    
    public void deletePerson(int id) throws SQLException {
        String query = "DELETE FROM student WHERE person_id = ?; " +
                      "DELETE FROM teacher WHERE person_id = ?; " +
                      "DELETE FROM person WHERE person_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setInt(1, id);
            pstmt.setInt(2, id);
            pstmt.setInt(3, id);
            pstmt.executeUpdate();
            System.out.println("Person deleted successfully!");
        }
    }
}
```

---

## 5. Обробка помилок та валідація

```java
// ValidationUtil.java
public class ValidationUtil {
    
    public static boolean isValidName(String name) {
        return name != null && !name.trim().isEmpty() && name.length() <= 100;
    }
    
    public static boolean isValidAge(int age) {
        return age > 0 && age <= 150;
    }
    
    public static boolean isValidEmail(String email) {
        return email != null && email.matches("^[A-Za-z0-9+_.-]+@(.+)$");
    }
    
    public static void validatePerson(String name, int age) throws IllegalArgumentException {
        if (!isValidName(name)) {
            throw new IllegalArgumentException("Invalid name: must be 1-100 characters");
        }
        if (!isValidAge(age)) {
            throw new IllegalArgumentException("Invalid age: must be between 1 and 150");
        }
    }
    
    public static void main(String[] args) {
        try {
            validatePerson("John Doe", 30);
            System.out.println("Validation passed!");
        } catch (IllegalArgumentException e) {
            System.err.println("Validation error: " + e.getMessage());
        }
    }
}
```

---

**Усі приклади готові до використання в проекті!**
