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
public class UserTypeDTO {
    private int id;
    private String name;
    private String Description;

    public UserTypeDTO(int id, String name, String Description) {
        this.id = id;
        this.name = name;
        this.Description = Description;
    }

    public UserTypeDTO() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return Description;
    }

    public void setDescription(String Description) {
        this.Description = Description;
    }

    @Override
    public String toString() {
        return "UserType{" + "id=" + id + ", name=" + name + ", Description=" + Description + '}';
    }
    
    
}
