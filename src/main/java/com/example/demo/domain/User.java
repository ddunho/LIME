package com.example.demo.domain;

import java.util.Date;

public class User {

    private Long userUid;
    private String username;
    private String email;
    private String password;
    private String phone;
    private String address;
    private String addressDetail;
    private String addressExtra;
    private String zipcode;
    private Date signupDate;

    // getter / setter
    public Long getUserUid() {
        return userUid;
    }

    public void setUserUid(Long userUid) {
        this.userUid = userUid;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }
    
    public void setPassword(String password) {
        this.password = password;
    }

    public String getPhone() {
        return phone;
    }
    
    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }
    
    public void setAddress(String address) {
        this.address = address;
    }

    public String getAddressDetail() {
        return addressDetail;
    }
    
    public void setAddressDetail(String addressDetail) {
        this.addressDetail = addressDetail;
    }

    public String getAddressExtra() {
        return addressExtra;
    }
    
    public void setAddressExtra(String addressExtra) {
        this.addressExtra = addressExtra;
    }

    public String getZipcode() {
        return zipcode;
    }
    
    public void setZipcode(String zipcode) {
        this.zipcode = zipcode;
    }

    public Date getSignupDate() {
        return signupDate;
    }
}
