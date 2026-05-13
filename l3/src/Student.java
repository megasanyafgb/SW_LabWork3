public class Student extends Person {
    private String course;
    private String studentGroup;
    private Teacher teacher;

    public Student(String name, int age, String course, String studentGroup) {
        super(name, age);
        this.course = course;
        this.studentGroup = studentGroup;
    }

    public String getCourse() {
        return course;
    }

    public void setCourse(String course) {
        this.course = course;
    }

    public String getStudentGroup() {
        return studentGroup;
    }

    public void setStudentGroup(String studentGroup) {
        this.studentGroup = studentGroup;
    }

    public Teacher getTeacher() {
        return teacher;
    }

    public void setTeacher(Teacher teacher) {
        this.teacher = teacher;
        if (!teacher.getStudents().contains(this)) {
            teacher.addStudent(this);
        }
    }

    @Override
    public String toString() {
        return "Student{" +
                "name='" + getName() + '\'' +
                ", age=" + getAge() +
                ", course='" + course + '\'' +
                ", studentGroup='" + studentGroup + '\'' +
                ", teacher=" + (teacher != null ? teacher.getName() : "none") +
                '}';
    }
}