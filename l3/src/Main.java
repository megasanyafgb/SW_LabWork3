public class Main {
    public static void main(String[] args) {
        // Create a teacher
        Teacher teacher = new Teacher("John Doe", 40, "Mathematics", 15);

        // Create students
        Student student1 = new Student("Alice", 20, "Mathematics", "Group A");
        Student student2 = new Student("Bob", 21, "Mathematics", "Group A");

        // Assign teacher to students
        student1.setTeacher(teacher);
        student2.setTeacher(teacher);

        // Print information
        System.out.println(teacher);
        System.out.println(student1);
        System.out.println(student2);
    }
}