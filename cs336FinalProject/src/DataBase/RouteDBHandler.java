/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DataBase;

import DTO.RouteDTO;
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
public class RouteDBHandler extends DB {

    public ArrayList<RouteDTO> getAllRoute() {
        ArrayList<RouteDTO> array = null; //statement
        RouteDTO obj = null;
        String query = "Select * from route";
        Statement st = null;
        ResultSet rs = null;
        try {
            st = conn.createStatement();
            rs = st.executeQuery(query);
            if (rs != null) {
                array = new ArrayList<RouteDTO>();
                while (rs.next()) {

                    obj = new RouteDTO();
                    obj.setId(rs.getInt(1));
                    obj.setName(rs.getString(2));
                    obj.setOrigin(rs.getString(3));
                    obj.setDestination(rs.getString(4));
                    obj.setFare(rs.getDouble(5));
                    obj.setTimeDuration(rs.getDouble(6));
                    obj.setStops(rs.getString(7));
                    array.add(obj);

                }
            }

        } catch (SQLException ex) {
            Logger.getLogger(RouteDBHandler.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException ex) {
                    Logger.getLogger(RouteDBHandler.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

            if (st != null) {
                try {
                    st.close();
                } catch (SQLException ex) {
                    Logger.getLogger(RouteDBHandler.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
        if (array == null || array.isEmpty()) {
            return null;
        }
        return array;
    }

    public ArrayList<RouteDTO> getAllRouteByOrigin(String origin) {
        ArrayList<RouteDTO> array = null; //statement
        RouteDTO obj = null;
        String query = "Select * from route where lower(origin)=?";
        PreparedStatement st = null;
        ResultSet rs = null;
        try {
            st = conn.prepareStatement(query);
            st.setString(1, origin.toLowerCase());
            System.out.println(st);
            rs = st.executeQuery();

            if (rs != null) {
                array = new ArrayList<RouteDTO>();
                while (rs.next()) {

                    obj = new RouteDTO();
                    obj.setId(rs.getInt(1));
                    obj.setName(rs.getString(2));
                    obj.setOrigin(rs.getString(3));
                    obj.setDestination(rs.getString(4));
                    obj.setFare(rs.getDouble(5));
                    obj.setTimeDuration(rs.getDouble(6));
                    obj.setStops(rs.getString(7));
                    array.add(obj);

                }
            }

        } catch (SQLException ex) {
            Logger.getLogger(RouteDBHandler.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException ex) {
                    Logger.getLogger(RouteDBHandler.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

            if (st != null) {
                try {
                    st.close();
                } catch (SQLException ex) {
                    Logger.getLogger(RouteDBHandler.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
        if (array == null || array.isEmpty()) {
            return null;
        }
        return array;
    }

    public ArrayList<RouteDTO> getAllRouteByOriginAndOrigin(String origin, String destination) {
        ArrayList<RouteDTO> array = null; //statement
        RouteDTO obj = null;
        String query = "Select * from route where lower(destination)=? and lower(origin)=?";
        PreparedStatement st = null;
        ResultSet rs = null;
        try {
            st = conn.prepareStatement(query);
            st.setString(1, destination.toLowerCase());
            st.setString(2, origin.toLowerCase());
            System.out.println(st);
            rs = st.executeQuery();
            if (rs != null) {
                array = new ArrayList<RouteDTO>();
                while (rs.next()) {

                    obj = new RouteDTO();
                    obj.setId(rs.getInt(1));
                    obj.setName(rs.getString(2));
                    obj.setOrigin(rs.getString(3));
                    obj.setDestination(rs.getString(4));
                    obj.setFare(rs.getDouble(5));
                    obj.setTimeDuration(rs.getDouble(6));
                    obj.setStops(rs.getString(7));
                    array.add(obj);

                }
            }

        } catch (SQLException ex) {
            Logger.getLogger(RouteDBHandler.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException ex) {
                    Logger.getLogger(RouteDBHandler.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

            if (st != null) {
                try {
                    st.close();
                } catch (SQLException ex) {
                    Logger.getLogger(RouteDBHandler.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
        if (array == null || array.isEmpty()) {
            return null;
        }
        return array;
    }

    public ArrayList<RouteDTO> getAllRouteByDestination(String destination) {
        ArrayList<RouteDTO> array = null; //statement
        RouteDTO obj = null;
        String query = "Select * from route where lower(destination)=?";
        PreparedStatement st = null;
        ResultSet rs = null;
        try {

            st = conn.prepareStatement(query);
            System.out.println(st);
            st.setString(1, destination.toLowerCase());
            System.out.println(st);
            rs = st.executeQuery();
            if (rs != null) {
                array = new ArrayList<RouteDTO>();
                while (rs.next()) {

                    obj = new RouteDTO();
                    obj.setId(rs.getInt(1));
                    obj.setName(rs.getString(2));
                    obj.setOrigin(rs.getString(3));
                    obj.setDestination(rs.getString(4));
                    obj.setFare(rs.getDouble(5));
                    obj.setTimeDuration(rs.getDouble(6));
                    obj.setStops(rs.getString(7));
                    array.add(obj);

                }
            }

        } catch (SQLException ex) {
            Logger.getLogger(RouteDBHandler.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException ex) {
                    Logger.getLogger(RouteDBHandler.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

            if (st != null) {
                try {
                    st.close();
                } catch (SQLException ex) {
                    Logger.getLogger(RouteDBHandler.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
        if (array == null || array.isEmpty()) {
            return null;
        }
        return array;
    }

    public boolean insertRoute(RouteDTO obj) {
        int affectedRows = 0;
        String query = "INSERT INTO `route` (`id`, `name`, `origin`, `destination`, `fare`, `timeDuration`, `stops`) VALUES (NULL, ?, ?, ?, ?, ?, ?)";
        PreparedStatement pst = null;
        try {
            pst = conn.prepareStatement(query);
            pst.setString(1, obj.getName());
            pst.setString(2, obj.getOrigin());
            pst.setString(3, obj.getDestination());
            pst.setDouble(4, obj.getFare());
            pst.setDouble(5, obj.getTimeDuration());
            pst.setString(6, obj.getStops());

            affectedRows = pst.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(RouteDBHandler.class.getName()).log(Level.SEVERE, null, ex);
        }
        return affectedRows > 0;
    }

    public RouteDTO getRouteByID(int id) {
        if (id < 0) {
            return null;
        }
        RouteDTO obj = null;
        String query = "Select * from route where id=?";
        PreparedStatement pst = null;
        ResultSet rs = null;

        try {
            pst = conn.prepareStatement(query);
            pst.setInt(1, id);
            System.out.println(pst);
            rs = pst.executeQuery();
            if (rs != null) {
                if (rs.next()) {

                    obj = new RouteDTO();
                    obj.setId(rs.getInt(1));
                    obj.setName(rs.getString(2));
                    obj.setOrigin(rs.getString(3));
                    obj.setDestination(rs.getString(4));
                    obj.setFare(rs.getDouble(5));
                    obj.setTimeDuration(rs.getDouble(6));
                    obj.setStops(rs.getString(7));

                }
            }

        } catch (SQLException ex) {
            Logger.getLogger(RouteDBHandler.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException ex) {
                    Logger.getLogger(RouteDBHandler.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

            if (pst != null) {
                try {
                    pst.close();
                } catch (SQLException ex) {
                    Logger.getLogger(RouteDBHandler.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }

        return obj;
    }

    public boolean updateRoute(RouteDTO obj)//id will never be updated
    {
        int affectedRows = 0;
        String query = "update `route` set 	name=?,	origin=? , destination=?,"
                + "	fare=?,	timeDuration=?,	stops=? where id=?";
        PreparedStatement pst = null;
        try {
            pst = conn.prepareStatement(query);

            pst.setString(1, obj.getName());
            pst.setString(2, obj.getOrigin());
            pst.setString(3, obj.getDestination());
            pst.setDouble(4, obj.getFare());
            pst.setDouble(5, obj.getTimeDuration());
            pst.setString(6, obj.getStops());

            pst.setInt(7, obj.getId());
            System.out.println(pst);

            affectedRows = pst.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(RouteDBHandler.class.getName()).log(Level.SEVERE, null, ex);
        }
        return affectedRows > 0;
    }

    public boolean removeRouteById(int id) {
        if (id <= 0) {
            return false;
        }
        int affectedRows = 0;
        String query = "delete from `route`  where id=?";
        PreparedStatement pst = null;
        try {
            pst = conn.prepareStatement(query);
            pst.setInt(1, id);
            affectedRows = pst.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(RouteDBHandler.class.getName()).log(Level.SEVERE, null, ex);
        }
        return affectedRows != 0;

    }

    public ArrayList<String> getAllOrigins() {
        ArrayList<String> array = null; //statement
        String query = "Select DISTINCT(origin) from route";
        Statement st = null;
        ResultSet rs = null;
        try {
            st = conn.createStatement();
            rs = st.executeQuery(query);
            if (rs != null) {
                array = new ArrayList<String>();
                while (rs.next()) {
                    array.add(rs.getString(1));

                }
            }

        } catch (SQLException ex) {
            Logger.getLogger(RouteDBHandler.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException ex) {
                    Logger.getLogger(RouteDBHandler.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

            if (st != null) {
                try {
                    st.close();
                } catch (SQLException ex) {
                    Logger.getLogger(RouteDBHandler.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
        if (array == null || array.isEmpty()) {
            return null;
        }
        return array;
    }

    public ArrayList<String> getDestinations() {
        ArrayList<String> array = null; //statement
        String query = "Select DISTINCT(destination) from route";
        Statement st = null;
        ResultSet rs = null;
        try {
            st = conn.createStatement();
            rs = st.executeQuery(query);
            if (rs != null) {
                array = new ArrayList<String>();
                while (rs.next()) {
                    array.add(rs.getString(1));

                }
            }

        } catch (SQLException ex) {
            Logger.getLogger(RouteDBHandler.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException ex) {
                    Logger.getLogger(RouteDBHandler.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

            if (st != null) {
                try {
                    st.close();
                } catch (SQLException ex) {
                    Logger.getLogger(RouteDBHandler.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
        if (array == null || array.isEmpty()) {
            return null;
        }
        return array;
    }
}
