/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DTO;

/**
 *
 * @author silen
 */
public class UserDTO {

    private int id;
    private String first_name;
    private String last_name;
    private String email;
    private String password;
    private String address;
    private String gender;
    private int user_type;
    private String profilePicture;
    UserTypeDTO userType;
    public UserDTO() {
    }

    public UserTypeDTO getUserType() {
        return userType;
    }

    public void setUserType(UserTypeDTO userType) {
        this.userType = userType;
    }

   

    public UserDTO(int id, String first_name, String last_name, String email, String password, String address, String gender, int user_type, String profilePicture) {
        this.id = id;
        this.first_name = first_name;
        this.last_name = last_name;
        this.email = email;
        this.password = password;
        this.address = address;
        this.gender = gender;
        this.user_type = user_type;
        this.profilePicture = profilePicture;
       
    }

   

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFirst_name() {
        return first_name;
    }

    public void setFirst_name(String first_name) {
        this.first_name = first_name;
    }

    public String getLast_name() {
        return last_name;
    }

    public void setLast_name(String last_name) {
        this.last_name = last_name;
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

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public int getUser_type() {
        return user_type;
    }

    public void setUser_type(int user_type) {
        this.user_type = user_type;
    }

   

    public String getProfilePicture() {
        return profilePicture;
    }

    public void setProfilePicture(String profilePicture) {
        this.profilePicture = profilePicture;
    }

    @Override
    public String toString() {
        return "UserDTO{" + "id=" + id + ", first_name=" + first_name + ", last_name=" + last_name + ", email=" + email + ", password=" + password + ", address=" + address + ", gender=" + gender + ", user_type=" + user_type + ", profilePicture=" + profilePicture + ", userType=" + userType + '}';
    }

    

    

}
