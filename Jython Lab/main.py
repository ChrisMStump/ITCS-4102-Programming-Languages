'''
Created on Jul 26, 2017

@author: Chris
'''

import Student

name = raw_input("Enter the name of the student: ")
birthDate = raw_input("Enter students birth date in format (MM-dd-yyyy): ")
print("Next the students marks and total points possible will be asked. (These are Integers)")
marks = input("Enter students marks: ")
total = input("Enter total points possible: ")

student = Student()
student.setName(name)
student.setBirthDate(birthDate)
student.setMarks(marks)
student.setOutOf(total)

print("We are now going to call the calculateGrade() method in the Student.java.")
print(name + "'s grade is: "), student.calculateGrade(), "%"

print("We are going to call the calculateAge() method in the Student.java.")
print(name + "'s age is: "), int(student.calculateAge())

print("We are going to call the displayDetails() method in the Student.java.")
print(student.displayDetails())