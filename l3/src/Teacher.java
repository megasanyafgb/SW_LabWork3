import java.util.List;
import java.util.ArrayList;

public class Teacher extends Person {
    private String course;
    private int workExperience;
    private List<Student> students;

    public Teacher(String name, int age, String course, int workExperience) {
        super(name, age);
        this.course = course;
        this.workExperience = workExperience;
        this.students = new ArrayList<>();
    }

    public String getCourse() {
        return course;
    }

    public void setCourse(String course) {
        this.course = course;
    }

    public int getWorkExperience() {
        return workExperience;
    }

    public void setWorkExperience(int workExperience) {
        this.workExperience = workExperience;
    }

    public List<Student> getStudents() {
        return students;
    }

    public void addStudent(Student student) {
        students.add(student);
        if (student.getTeacher() != this) {
            student.setTeacher(this);
        }
    }

    @Override
    public String toString() {
        return "Teacher{" +
                "name='" + getName() + '\'' +
                ", age=" + getAge() +
                ", course='" + course + '\'' +
                ", workExperience=" + workExperience +
                ", students=" + students.size() +
                '}';
    }
}