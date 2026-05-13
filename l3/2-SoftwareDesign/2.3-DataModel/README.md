### Схема моделі даних

#### Реляційна модель

<img width="256" height="488" alt="DataModel" src="https://github.com/user-attachments/assets/60889a81-e944-4b9a-a070-81d092538883" />


#### JSON модель

<img width="1203" height="458" alt="-DataModel" src="https://github.com/user-attachments/assets/442e93d6-ec16-429d-837f-e075d4e8162e" />

#### SQL схема

```sql
CREATE TABLE person (
    person_id    NUMBER PRIMARY KEY,
    name         VARCHAR(100) NOT NULL,
    age          NUMBER NOT NULL CHECK (age > 0 AND age <= 150),
    person_type  VARCHAR(50) NOT NULL
);

CREATE TABLE teacher (
    teacher_id      NUMBER PRIMARY KEY,
    person_id       NUMBER NOT NULL,
    course          VARCHAR(100) NOT NULL,
    work_experience NUMBER DEFAULT 0,
    CONSTRAINT fk_teacher_person 
        FOREIGN KEY (person_id) REFERENCES person(person_id)
);

CREATE TABLE student (
    student_id    NUMBER PRIMARY KEY,
    person_id     NUMBER NOT NULL,
    teacher_id    NUMBER NOT NULL,
    course        VARCHAR(100) NOT NULL,
    student_group VARCHAR(50) NOT NULL,
    CONSTRAINT fk_student_person 
        FOREIGN KEY (person_id) REFERENCES person(person_id),
    CONSTRAINT fk_student_teacher 
        FOREIGN KEY (teacher_id) REFERENCES teacher(teacher_id)
);
```
