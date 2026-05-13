### UML-діаграма концептуальних класів

Концептуальна модель даних описує основні класи предметної області:
- **Person** - базовий клас, що представляє людину з атрибутами ім'я та вік
- **Teacher** - клас для викладачів, що успадковує Person, додає атрибути курс та досвід роботи
- **Student** - клас для студентів, що успадковує Person, додає атрибути курс та група

Взаємозв'язки:
- Один викладач може викладати багатьох студентів (1:M)
- Один студент навчається у одного викладача (M:1)

![](http://www.plantuml.com/plantuml/proxy?cache=no&src=https://raw.githubusercontent.com/megasanyafgb/SW_LabWork3/main/2-SoftwareDesign/2.1-UMLConceptClasses/UML-ConceptClasses.puml)
