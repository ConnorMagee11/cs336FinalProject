/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DataBase;

import DTO.TrainDTO;
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
public class TrainDBHandler extends DB {
     public ArrayList<TrainDTO> getAllTrain() {
        ArrayList<TrainDTO> array = null; //statement
        TrainDTO obj = null;
        String query = "Select * from train";
        Statement st = null;
        ResultSet rs = null;
        try {
            st = conn.createStatement();
            rs = st.executeQuery(query);
            if (rs != null) {
                array = new ArrayList<TrainDTO>();
                while (rs.next()) {

                    obj = new TrainDTO();
                    obj.setId(rs.getInt(1));
                    obj.setName(rs.getString(2));
                    obj.setCapacity(rs.getInt(3));
                    obj.setDescription(rs.getString(4));
                    array.add(obj);

                }
            }

        } catch (SQLException ex) {
            Logger.getLogger(TrainDBHandler.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException ex) {
                    Logger.getLogger(TrainDBHandler.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

            if (st != null) {
                try {
                    st.close();
                } catch (SQLException ex) {
                    Logger.getLogger(TrainDBHandler.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
        if (array==null || array.isEmpty() ) {
            return null;
        }
        return array;
    }

    public boolean insertTrain(TrainDTO obj) {
        int affectedRows = 0;
        String query = "INSERT INTO `train` (`id`, `name`,capacity ,`description`) VALUES (NULL, ?, ?,?)";
        PreparedStatement pst = null;
        try {
            pst = conn.prepareStatement(query);
            pst.setString(1, obj.getName());
            pst.setInt(2,obj.getCapacity());
            pst.setString(3, obj.getDescription());

            affectedRows = pst.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(TrainDBHandler.class.getName()).log(Level.SEVERE, null, ex);
        }
        return affectedRows > 0;
    }

    public TrainDTO getTrainByID(int id) {
        if (id < 0) {
            return null;
        }
        TrainDTO obj = null;
        String query = "Select * from train where id=?";
        PreparedStatement pst = null;
        ResultSet rs = null;

        try {
            pst = conn.prepareStatement(query);
            pst.setInt(1, id);
            System.out.println(pst);
            rs = pst.executeQuery();
            if (rs != null) {
                if (rs.next()) {

                    obj = new TrainDTO();
                    obj.setId(rs.getInt(1));
                    obj.setName(rs.getString(2));
                    obj.setCapacity(rs.getInt(3));
                    obj.setDescription(rs.getString(4));
                    

                }
            }

        } catch (SQLException ex) {
            Logger.getLogger(TrainDBHandler.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException ex) {
                    Logger.getLogger(TrainDBHandler.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

            if (pst != null) {
                try {
                    pst.close();
                } catch (SQLException ex) {
                    Logger.getLogger(TrainDBHandler.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }

        return obj;
    }

   
    

  
    public boolean updateTrain(TrainDTO obj)//id will never be updated
    {
        int affectedRows = 0;
        String query = "update `train` set name=?,capacity=?,	description=? where id=?";
        PreparedStatement pst = null;
        try {
            pst = conn.prepareStatement(query);
         
            pst.setString(1, obj.getName());
            pst.setInt(2, obj.getCapacity());
            pst.setString(3, obj.getDescription());
            pst.setInt(4, obj.getId());
            System.out.println(pst);

            affectedRows = pst.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(TrainDBHandler.class.getName()).log(Level.SEVERE, null, ex);
        }
        return affectedRows > 0;
    }

    public boolean removeTrainById(int id) {
        if (id <= 0) {
            return false;
        }
        int affectedRows = 0;
        String query = "delete from `train`  where id=?";
        PreparedStatement pst = null;
        try {
            pst = conn.prepareStatement(query);
            pst.setInt(1, id);
            affectedRows = pst.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(TrainDBHandler.class.getName()).log(Level.SEVERE, null, ex);
        }
        return affectedRows != 0;

    }
     public String[][] getCounts() {
        String[][] array = new String[6][2];
        String query = "SELECT table_name, table_rows\n"
                + "FROM INFORMATION_SCHEMA.TABLES\n"
                + "WHERE TABLE_SCHEMA = 'tms'";
        Statement st = null;
        ResultSet rs = null;
        try {
            st = conn.createStatement();
            rs = st.executeQuery(query);
            int i=0;
            if (rs != null) {

                while (rs.next() && i<6) {
                    array[i][0]=rs.getString(1);
                     array[i][1]=rs.getString(2);
                     i++;
                }
            }

        } catch (SQLException ex) {
            Logger.getLogger(TrainDBHandler.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException ex) {
                    Logger.getLogger(TrainDBHandler.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

            if (st != null) {
                try {
                    st.close();
                } catch (SQLException ex) {
                    Logger.getLogger(TrainDBHandler.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }

        return array;
    }
    
}
