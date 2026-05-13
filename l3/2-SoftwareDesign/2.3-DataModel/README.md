### Схема моделі даних

#### Реляційна модель

<img width="256" height="488" alt="DataModel" src="https://github.com/user-attachments/assets/60889a81-e944-4b9a-a070-81d092538883" />


#### JSON модель

![](http://www.plantuml.com/plantuml/proxy?cache=no&src=https://raw.githubusercontent.com/megasanyafgb/SW_LabWork3/main/2-SoftwareDesign/2.3-DataModel/JSONSchema.puml)

#### SQL схема

```sql
-- Create Person table (base for inheritance)
CREATE TABLE person (
    person_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    age INT NOT NULL CHECK (age > 0 AND age <= 150),
    person_type VARCHAR(50) NOT NULL
);

-- Create Teacher table
CREATE TABLE teacher (
    teacher_id INT PRIMARY KEY AUTO_INCREMENT,
    person_id INT NOT NULL,
    course VARCHAR(100) NOT NULL,
    work_experience INT NOT NULL DEFAULT 0,
    FOREIGN KEY (person_id) REFERENCES person(person_id)
);

-- Create Student table
CREATE TABLE student (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    person_id INT NOT NULL,
    teacher_id INT NOT NULL,
    course VARCHAR(100) NOT NULL,
    student_group VARCHAR(50) NOT NULL,
    FOREIGN KEY (person_id) REFERENCES person(person_id),
    FOREIGN KEY (teacher_id) REFERENCES teacher(teacher_id)
);
```
