/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DataBase;

import DTO.UserTypeDTO;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author silen
 */
public class UserTypeDBHandler extends DB {

    public ArrayList<UserTypeDTO> getAllUserType() {
        ArrayList<UserTypeDTO> array = null; //statement
        UserTypeDTO obj = null;
        String query = "Select * from user_type";
        Statement st = null;
        ResultSet rs = null;
        try {
            st = conn.createStatement();
            rs = st.executeQuery(query);
            if (rs != null) {
                array = new ArrayList<UserTypeDTO>();
                while (rs.next()) {

                    obj = new UserTypeDTO();
                    obj.setId(rs.getInt(1));
                    obj.setName(rs.getString(2));
                    obj.setDescription(rs.getString(3));
                    array.add(obj);

                }
            }

        } catch (SQLException ex) {
            Logger.getLogger(UserTypeDBHandler.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException ex) {
                    Logger.getLogger(UserTypeDBHandler.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

            if (st != null) {
                try {
                    st.close();
                } catch (SQLException ex) {
                    Logger.getLogger(UserTypeDBHandler.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
        if (array==null || array.isEmpty() ) {
            return null;
        }
        return array;
    }
    public int searchType(String type) {
        int array = 0; //statement
        UserTypeDTO obj = null;
        String query = "Select id from user_type where lower(name)=lower(\'"+type+"\')";
        System.out.println(query);
        Statement st = null;
        ResultSet rs = null;
        try {
            st = conn.createStatement();
            rs = st.executeQuery(query);
            if (rs != null) {
                
                while (rs.next()) {

                    
                  array=rs.getInt(1);
                    

                }
            }

        } catch (SQLException ex) {
            Logger.getLogger(UserTypeDBHandler.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException ex) {
                    Logger.getLogger(UserTypeDBHandler.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

            if (st != null) {
                try {
                    st.close();
                } catch (SQLException ex) {
                    Logger.getLogger(UserTypeDBHandler.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
       
        return array;
    }

    public boolean insertUserType(UserTypeDTO obj) {
        int affectedRows = 0;
        String query = "INSERT INTO `user_type` (`id`, `name`, `description`) VALUES (NULL, ?, ?)";
        PreparedStatement pst = null;
        try {
            pst = conn.prepareStatement(query);
            pst.setString(1, obj.getName());
            pst.setString(2, obj.getDescription());

            affectedRows = pst.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(UserTypeDBHandler.class.getName()).log(Level.SEVERE, null, ex);
        }
        return affectedRows > 0;
    }

    public UserTypeDTO getUserTypeByID(int id) {
        if (id < 0) {
            return null;
        }
        UserTypeDTO obj = null;
        String query = "Select * from user_type where id=?";
        PreparedStatement pst = null;
        ResultSet rs = null;

        try {
            pst = conn.prepareStatement(query);
            pst.setInt(1, id);
            System.out.println(pst);
            rs = pst.executeQuery();
            if (rs != null) {
                if (rs.next()) {

                    obj = new UserTypeDTO();
                    obj.setId(rs.getInt(1));
                    obj.setName(rs.getString(2));
                    obj.setDescription(rs.getString(3));

                }
            }

        } catch (SQLException ex) {
            Logger.getLogger(UserTypeDBHandler.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException ex) {
                    Logger.getLogger(UserTypeDBHandler.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

            if (pst != null) {
                try {
                    pst.close();
                } catch (SQLException ex) {
                    Logger.getLogger(UserTypeDBHandler.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }

        return obj;
    }

   
    

  
    public boolean updateUserType(UserTypeDTO obj)//id will never be updated
    {
        int affectedRows = 0;
        String query = "update `user_type` set name=?	description=? where id=?";
        PreparedStatement pst = null;
        try {
            pst = conn.prepareStatement(query);
         
            pst.setString(1, obj.getName());
            pst.setString(2, obj.getDescription());
            pst.setInt(3, obj.getId());
            System.out.println(pst);

            affectedRows = pst.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(UserTypeDBHandler.class.getName()).log(Level.SEVERE, null, ex);
        }
        return affectedRows > 0;
    }

    public boolean removeUserTypeById(int id) {
        if (id <= 0) {
            return false;
        }
        int affectedRows = 0;
        String query = "delete from `user_type`  where id=?";
        PreparedStatement pst = null;
        try {
            pst = conn.prepareStatement(query);
            pst.setInt(1, id);
            affectedRows = pst.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(UserTypeDBHandler.class.getName()).log(Level.SEVERE, null, ex);
        }
        return affectedRows != 0;

    }

}
