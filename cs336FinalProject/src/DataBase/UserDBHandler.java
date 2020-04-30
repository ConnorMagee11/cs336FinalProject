/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DataBase;

import DTO.UserDTO;
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
public class UserDBHandler extends DB {

    @Override
    public void finalize() {
        try {
            super.finalize();
        } catch (Throwable ex) {
            Logger.getLogger(DB.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public ArrayList<UserDTO> getAllUser() {
        ArrayList<UserDTO> array = null; //statement
        UserDTO obj = null;
        String query = "Select * from user";
        Statement st = null;
        ResultSet rs = null;
        try {
            st = conn.createStatement();
            rs = st.executeQuery(query);
            if (rs != null) {
                array = new ArrayList<UserDTO>();
                while (rs.next()) {

                    obj = new UserDTO();
                    obj.setId(rs.getInt(1));
                    obj.setFirst_name(rs.getString(2));
                    obj.setLast_name(rs.getString(3));
                    obj.setEmail(rs.getString(4));
                    obj.setPassword(rs.getString(5));
                    obj.setAddress(rs.getString(6));
                    obj.setGender(rs.getString(7));
                    obj.setUser_type(rs.getInt(8));
                    obj.setProfilePicture(rs.getString(9));
                    obj.setUserType(this.getUserTypeByID(obj.getUser_type()));
                    array.add(obj);

                }
            }

        } catch (SQLException ex) {
            Logger.getLogger(UserDBHandler.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException ex) {
                    Logger.getLogger(UserDBHandler.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

            if (st != null) {
                try {
                    st.close();
                } catch (SQLException ex) {
                    Logger.getLogger(UserDBHandler.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
        if (array == null || array.isEmpty()) {
            return null;
        }
        return array;
    }

    public ArrayList<UserDTO> getAllUserByTypeID(int id) {
        ArrayList<UserDTO> array = null; //statement
        UserDTO obj = null;
        String query = "Select * from user where user_type=" + id;
        Statement st = null;
        ResultSet rs = null;
        try {
            st = conn.createStatement();
            rs = st.executeQuery(query);
            if (rs != null) {
                array = new ArrayList<UserDTO>();
                while (rs.next()) {

                    obj = new UserDTO();
                    obj.setId(rs.getInt(1));
                    obj.setFirst_name(rs.getString(2));
                    obj.setLast_name(rs.getString(3));
                    obj.setEmail(rs.getString(4));
                    obj.setPassword(rs.getString(5));
                    obj.setAddress(rs.getString(6));
                    obj.setGender(rs.getString(7));
                    obj.setUser_type(rs.getInt(8));
                    obj.setProfilePicture(rs.getString(9));
                    obj.setUserType(this.getUserTypeByID(obj.getUser_type()));
                    array.add(obj);

                }
            }

        } catch (SQLException ex) {
            Logger.getLogger(UserDBHandler.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException ex) {
                    Logger.getLogger(UserDBHandler.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

            if (st != null) {
                try {
                    st.close();
                } catch (SQLException ex) {
                    Logger.getLogger(UserDBHandler.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
        if (array == null || array.isEmpty()) {
            return null;
        }
        return array;
    }

    public boolean insertUser(UserDTO obj) {
        int affectedRows = 0;
        String query = "INSERT INTO `user` (`id`, `first_name`, `last_name`, `email`, `password`, `address`, `gender`, `user_type`, `profilePicture`) VALUES (NULL, ?, ?, ?, ?, ?, ?, ?,NULL)";
        PreparedStatement pst = null;
        try {
            pst = conn.prepareStatement(query);
            pst.setString(1, obj.getFirst_name());
            pst.setString(2, obj.getLast_name());
            pst.setString(3, obj.getEmail());
            pst.setString(4, obj.getPassword());
            pst.setString(5, obj.getAddress());
            pst.setString(6, obj.getGender());
            pst.setInt(7, obj.getUser_type());

            affectedRows = pst.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(UserDBHandler.class.getName()).log(Level.SEVERE, null, ex);
        }
        return affectedRows > 0;
    }

    public UserDTO getUserByID(int id) {
        if (id < 0) {
            return null;
        }
        UserDTO obj = null;
        String query = "Select * from User where id=?";
        PreparedStatement pst = null;
        ResultSet rs = null;

        try {
            pst = conn.prepareStatement(query);
            pst.setInt(1, id);
            System.out.println(pst);
            rs = pst.executeQuery();
            if (rs != null) {
                if (rs.next()) {

                    obj = new UserDTO();
                    obj.setId(rs.getInt(1));
                    obj.setFirst_name(rs.getString(2));
                    obj.setLast_name(rs.getString(3));
                    obj.setEmail(rs.getString(4));
                    obj.setPassword(rs.getString(5));
                    obj.setAddress(rs.getString(6));
                    obj.setGender(rs.getString(7));
                    obj.setUser_type(rs.getInt(8));
                    obj.setProfilePicture(rs.getString(9));
                    obj.setUserType(this.getUserTypeByID(obj.getUser_type()));

                }
            }

        } catch (SQLException ex) {
            Logger.getLogger(UserDBHandler.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException ex) {
                    Logger.getLogger(UserDBHandler.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

            if (pst != null) {
                try {
                    pst.close();
                } catch (SQLException ex) {
                    Logger.getLogger(UserDBHandler.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }

        return obj;
    }

    public UserDTO getUserByAuthentication(String email, String password) {

        UserDTO obj = null;
        String query = "Select * from User where lower(email)=lower(?)";
        PreparedStatement pst = null;
        ResultSet rs = null;

        try {
            pst = conn.prepareStatement(query);
            pst.setString(1, email);
            System.out.println(pst);
            rs = pst.executeQuery();
            if (rs != null) {
                if (rs.next()) {

                    obj = new UserDTO();
                    obj.setId(rs.getInt(1));
                    obj.setFirst_name(rs.getString(2));
                    obj.setLast_name(rs.getString(3));
                    obj.setEmail(rs.getString(4));
                    obj.setPassword(rs.getString(5));
                    obj.setAddress(rs.getString(6));
                    obj.setGender(rs.getString(7));
                    obj.setUser_type(rs.getInt(8));
                    obj.setProfilePicture(rs.getString(9));
                    obj.setUserType(this.getUserTypeByID(obj.getUser_type()));

                }
            }

        } catch (SQLException ex) {
            Logger.getLogger(UserDBHandler.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException ex) {
                    Logger.getLogger(UserDBHandler.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

            if (pst != null) {
                try {
                    pst.close();
                } catch (SQLException ex) {
                    Logger.getLogger(UserDBHandler.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }

        return obj;
    }

    public int serachByEmail(String email) {
        int id = -1;
        String query = "Select id from user where lower(email)=lower(?)";

        PreparedStatement pst = null;
        ResultSet rs = null;
        try {
            pst = conn.prepareStatement(query);
            pst.setString(1, email);
            System.out.print(pst);
            rs = pst.executeQuery();
            if (rs.next()) {
                id = rs.getInt(1);
            }

        } catch (SQLException ex) {
            Logger.getLogger(UserDBHandler.class.getName()).log(Level.SEVERE, null, ex);
        }

        return id;
    }

    public int authenticate(String email, String pwd) {
        int id = -1;
        String query = "Select id from user where lower(email)=lower(?) and password=?";
        PreparedStatement pst = null;
        ResultSet rs = null;
        try {
            pst = conn.prepareStatement(query);
            pst.setString(1, email);
            pst.setString(2, pwd);
            rs = pst.executeQuery();
            if (rs.next()) {
                id = rs.getInt(1);
            }

        } catch (SQLException ex) {
            Logger.getLogger(UserDBHandler.class.getName()).log(Level.SEVERE, null, ex);
        }

        return id;
    }

    public boolean updateUser(UserDTO obj)//id will never be updated
    {
        int affectedRows = 0;
        String query = "update `User` set first_name =?,	last_name =?,	email =?,password =?,"
                + "	address =?,	gender =?,	user_type =?,	profilePicture =? where id=?";
        PreparedStatement pst = null;
        try {
            pst = conn.prepareStatement(query);
            pst.setString(1, obj.getFirst_name());
            pst.setString(2, obj.getLast_name());
            pst.setString(3, obj.getEmail());
            pst.setString(4, obj.getPassword());
            pst.setString(5, obj.getAddress());
            pst.setString(6, obj.getGender());
            pst.setInt(7, obj.getUser_type());
            pst.setString(8, obj.getProfilePicture());
            pst.setInt(9, obj.getId());
            System.out.println(pst);

            affectedRows = pst.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(UserDBHandler.class.getName()).log(Level.SEVERE, null, ex);
        }
        return affectedRows > 0;
    }

    public boolean removeUserById(int id) {
        if (id <= 0) {
            return false;
        }
        int affectedRows = 0;
        String query = "delete from `User`  where id=?";
        PreparedStatement pst = null;
        try {
            pst = conn.prepareStatement(query);
            pst.setInt(1, id);
            affectedRows = pst.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(UserDBHandler.class.getName()).log(Level.SEVERE, null, ex);
        }
        return affectedRows != 0;

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
}
