package com.Classes;

public class Student {
    private int studentNumber;
    private String fullName;
    private int birthYear;
    private String sex;
    private String address;
    private String phone;
    private String email;
    
    //constructor
    public Student() {}
    public Student(int studentNumber, String fullName, int birthYear, String sex, String address, String phone, String email){
    	this.studentNumber = studentNumber;
    	this.fullName = fullName;
    	this.birthYear = birthYear;
    	this.sex = sex;
    	this.address = address;
    	this.phone = phone;
    	this.email = email;
    }

    // Getters and Setters
    public int getStudentNumber() {
        return studentNumber;
    }

    public void setStudentNumber(int studentNumber) {
        this.studentNumber = studentNumber;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public int getBirthYear() {
        return birthYear;
    }

    public void setBirthYear(int birthYear) {
        this.birthYear = birthYear;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
}
