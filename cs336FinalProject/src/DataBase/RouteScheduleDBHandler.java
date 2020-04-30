/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DataBase;

import DTO.RouteDTO;
import DTO.RouteScheduleDTO;
import DTO.TrainDTO;
import java.sql.Date;
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
public class RouteScheduleDBHandler extends DB {

    public ArrayList<RouteScheduleDTO> getAllRouteSchedule() {
        ArrayList<RouteScheduleDTO> array = null; //statement
        RouteScheduleDTO obj = null;
        String query = "Select * from route_schedule";
        Statement st = null;
        ResultSet rs = null;
        try {
            st = conn.createStatement();
            rs = st.executeQuery(query);
            if (rs != null) {
                array = new ArrayList<RouteScheduleDTO>();
                while (rs.next()) {

                    obj = new RouteScheduleDTO();
                    obj.setId(rs.getInt(1));
                    obj.setDate(rs.getDate(2));
                    obj.setRoute_id(rs.getInt(3));
                    obj.setTrain_id(rs.getInt(4));
                    obj.setArrivaltime(rs.getTime(5));
                    obj.setDeparuretime(rs.getTime(6));
                    obj.setTrain(this.getTrainByID(obj.getTrain_id()));
                    obj.setRoute(this.getRouteByID(obj.getRoute_id()));
                    array.add(obj);

                }
            }

        } catch (SQLException ex) {
            Logger.getLogger(RouteScheduleDBHandler.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException ex) {
                    Logger.getLogger(RouteScheduleDBHandler.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

            if (st != null) {
                try {
                    st.close();
                } catch (SQLException ex) {
                    Logger.getLogger(RouteScheduleDBHandler.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
        if (array == null || array.isEmpty()) {
            return null;
        }
        return array;
    }
    public ArrayList<RouteScheduleDTO> getAllRouteScheduleQuery(String origin,String destination,String date) {
        ArrayList<RouteScheduleDTO> array = null; //statement
        RouteScheduleDTO obj = null;
        String query = "SELECT * FROM `route_schedule` rs WHERE rs.route_id in (SELECT id from route r where ";
        if(origin==null || origin.trim().isEmpty())
        {
            query+=" 1 and ";
        }
        else
        {
            query+=" lower(r.origin)=lower(\'"+ origin+"\') and";
        }
        if(destination==null || destination.trim().isEmpty())
        {
            query+=" 1 ) and ";
        }
        else
        {
            query+=" lower(r.destination)=lower(\'"+ destination+"\')) and ";
        }
        if(date==null || date.trim().isEmpty())
        {
            query+=" 1  ";
        }
        else
        {
            query+="rs.date_schedule=\'"+ date+"\'";
        }
        
        System.out.println(query);
        
        
        Statement st = null;
        ResultSet rs = null;
        try {
            st = conn.createStatement();
            rs = st.executeQuery(query);
            if (rs != null) {
                array = new ArrayList<RouteScheduleDTO>();
                while (rs.next()) {

                    obj = new RouteScheduleDTO();
                    obj.setId(rs.getInt(1));
                    obj.setDate(rs.getDate(2));
                    obj.setRoute_id(rs.getInt(3));
                    obj.setTrain_id(rs.getInt(4));
                    obj.setArrivaltime(rs.getTime(5));
                    obj.setDeparuretime(rs.getTime(6));
                    obj.setTrain(this.getTrainByID(obj.getTrain_id()));
                    obj.setRoute(this.getRouteByID(obj.getRoute_id()));
                    array.add(obj);

                }
            }

        } catch (SQLException ex) {
            Logger.getLogger(RouteScheduleDBHandler.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException ex) {
                    Logger.getLogger(RouteScheduleDBHandler.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

            if (st != null) {
                try {
                    st.close();
                } catch (SQLException ex) {
                    Logger.getLogger(RouteScheduleDBHandler.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
        if (array == null || array.isEmpty()) {
            return null;
        }
        return array;
    }

    public ArrayList<RouteScheduleDTO> getAllRouteScheduleByRouteID(int route) {
        ArrayList<RouteScheduleDTO> array = null; //statement
        RouteScheduleDTO obj = null;
        String query = "Select * from route_schedule where route_id=?";
        PreparedStatement st = null;
        ResultSet rs = null;
        try {
            st = conn.prepareStatement(query);
            st.setInt(1, route);
            System.out.println(st);
            rs = st.executeQuery();

            if (rs != null) {
                array = new ArrayList<RouteScheduleDTO>();
                while (rs.next()) {

                    obj = new RouteScheduleDTO();
                    obj.setId(rs.getInt(1));
                    obj.setDate(rs.getDate(2));
                    obj.setRoute_id(rs.getInt(3));
                    obj.setTrain_id(rs.getInt(4));
                    obj.setArrivaltime(rs.getTime(5));
                    obj.setDeparuretime(rs.getTime(6));
                    obj.setTrain(this.getTrainByID(obj.getTrain_id()));
                    obj.setRoute(this.getRouteByID(obj.getRoute_id()));
                    array.add(obj);

                }
            }

        } catch (SQLException ex) {
            Logger.getLogger(RouteScheduleDBHandler.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException ex) {
                    Logger.getLogger(RouteScheduleDBHandler.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

            if (st != null) {
                try {
                    st.close();
                } catch (SQLException ex) {
                    Logger.getLogger(RouteScheduleDBHandler.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
        if (array == null || array.isEmpty()) {
            return null;
        }
        return array;
    }

    public ArrayList<RouteScheduleDTO> getAllRouteScheduleByTrain(int train) {
        ArrayList<RouteScheduleDTO> array = null; //statement
        RouteScheduleDTO obj = null;
        String query = "Select * from route_schedule where train_id=?";
        PreparedStatement st = null;
        ResultSet rs = null;
        try {
            st = conn.prepareStatement(query);
            st.setInt(1, train);
            System.out.println(st);
            rs = st.executeQuery();
            if (rs != null) {
                array = new ArrayList<RouteScheduleDTO>();
                while (rs.next()) {

                    obj = new RouteScheduleDTO();
                    obj.setId(rs.getInt(1));
                    obj.setDate(rs.getDate(2));
                    obj.setRoute_id(rs.getInt(3));
                    obj.setTrain_id(rs.getInt(4));
                    obj.setArrivaltime(rs.getTime(5));
                    obj.setDeparuretime(rs.getTime(6));
                    obj.setTrain(this.getTrainByID(obj.getTrain_id()));
                    obj.setRoute(this.getRouteByID(obj.getRoute_id()));
                    array.add(obj);

                }
            }

        } catch (SQLException ex) {
            Logger.getLogger(RouteScheduleDBHandler.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException ex) {
                    Logger.getLogger(RouteScheduleDBHandler.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

            if (st != null) {
                try {
                    st.close();
                } catch (SQLException ex) {
                    Logger.getLogger(RouteScheduleDBHandler.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
        if (array == null || array.isEmpty()) {
            return null;
        }
        return array;
    }

    public ArrayList<RouteScheduleDTO> getAllRouteScheduleByDate(Date d) {
        ArrayList<RouteScheduleDTO> array = null; //statement
        RouteScheduleDTO obj = null;
        String query = "Select * from route_schedule where date_schedule=?";
        PreparedStatement st = null;
        ResultSet rs = null;
        try {

            st = conn.prepareStatement(query);
            System.out.println(st);
            st.setDate(1, d);
            System.out.println(st);
            rs = st.executeQuery();
            if (rs != null) {
                array = new ArrayList<RouteScheduleDTO>();
                while (rs.next()) {

                    obj = new RouteScheduleDTO();
                    obj.setId(rs.getInt(1));
                    obj.setDate(rs.getDate(2));
                    obj.setRoute_id(rs.getInt(3));
                    obj.setTrain_id(rs.getInt(4));
                    obj.setArrivaltime(rs.getTime(5));
                    obj.setDeparuretime(rs.getTime(6));
                    obj.setTrain(this.getTrainByID(obj.getTrain_id()));
                    obj.setRoute(this.getRouteByID(obj.getRoute_id()));
                    array.add(obj);

                }
            }

        } catch (SQLException ex) {
            Logger.getLogger(RouteScheduleDBHandler.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException ex) {
                    Logger.getLogger(RouteScheduleDBHandler.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

            if (st != null) {
                try {
                    st.close();
                } catch (SQLException ex) {
                    Logger.getLogger(RouteScheduleDBHandler.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
        if (array == null || array.isEmpty()) {
            return null;
        }
        return array;
    }

    public boolean insertRouteSchedule(RouteScheduleDTO obj) {
        int affectedRows = 0;
        String query = "INSERT INTO `route_schedule` (`id`, `date_schedule`, `route_id`, `train_id`, `arrivaltime`, `departuretime`) VALUES (NULL, ?, ?, ?, ?, ?)";
        PreparedStatement pst = null;
        try {
            pst = conn.prepareStatement(query);
            pst.setDate(1, obj.getDate());
            pst.setInt(2, obj.getRoute_id());
            pst.setInt(3, obj.getTrain_id());
            pst.setTime(4, obj.getArrivaltime());
            pst.setTime(5, obj.getDeparuretime());

            affectedRows = pst.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(RouteScheduleDBHandler.class.getName()).log(Level.SEVERE, null, ex);
        }
        return affectedRows > 0;
    }

    public RouteScheduleDTO getRouteScheduleByID(int id) {
        if (id < 0) {
            return null;
        }
        RouteScheduleDTO obj = null;
        String query = "Select * from route_schedule where id=?";
        PreparedStatement pst = null;
        ResultSet rs = null;

        try {
            pst = conn.prepareStatement(query);
            pst.setInt(1, id);
            System.out.println(pst);
            rs = pst.executeQuery();
            if (rs != null) {
                if (rs.next()) {

                    obj = new RouteScheduleDTO();
                    obj.setId(rs.getInt(1));
                    obj.setDate(rs.getDate(2));
                    obj.setRoute_id(rs.getInt(3));
                    obj.setTrain_id(rs.getInt(4));
                    obj.setArrivaltime(rs.getTime(5));
                    obj.setDeparuretime(rs.getTime(6));
                    obj.setTrain(this.getTrainByID(obj.getTrain_id()));
                    obj.setRoute(this.getRouteByID(obj.getRoute_id()));

                }
            }

        } catch (SQLException ex) {
            Logger.getLogger(RouteScheduleDBHandler.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException ex) {
                    Logger.getLogger(RouteScheduleDBHandler.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

            if (pst != null) {
                try {
                    pst.close();
                } catch (SQLException ex) {
                    Logger.getLogger(RouteScheduleDBHandler.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }

        return obj;
    }

    public RouteScheduleDTO getRouteScheduleByDateAndRoute(int route_id, Date d) {
        if (route_id < 0) {
            return null;
        }
        RouteScheduleDTO obj = null;
        String query = "Select * from route_schedule where route_id=? and date_schedule=?";
        PreparedStatement pst = null;
        ResultSet rs = null;

        try {
            pst = conn.prepareStatement(query);
            pst.setInt(1, route_id);
            pst.setDate(2, d);
            System.out.println(pst);
            rs = pst.executeQuery();
            if (rs != null) {
                if (rs.next()) {

                    obj = new RouteScheduleDTO();
                    obj.setId(rs.getInt(1));
                    obj.setDate(rs.getDate(2));
                    obj.setRoute_id(rs.getInt(3));
                    obj.setTrain_id(rs.getInt(4));
                    obj.setArrivaltime(rs.getTime(5));
                    obj.setDeparuretime(rs.getTime(6));
                    obj.setTrain(this.getTrainByID(obj.getTrain_id()));
                    obj.setRoute(this.getRouteByID(obj.getRoute_id()));

                }
            }

        } catch (SQLException ex) {
            Logger.getLogger(RouteScheduleDBHandler.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException ex) {
                    Logger.getLogger(RouteScheduleDBHandler.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

            if (pst != null) {
                try {
                    pst.close();
                } catch (SQLException ex) {
                    Logger.getLogger(RouteScheduleDBHandler.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }

        return obj;
    }

    public boolean updateRouteSchedule(RouteScheduleDTO obj)//id will never be updated
    {
        int affectedRows = 0;
        String query = "update `route_schedule` set 	date_schedule=?,	route_id=?,	train_id=?,"
                + "	arrivaltime=?,	departuretime=? where id=?";
        PreparedStatement pst = null;
        try {
            pst = conn.prepareStatement(query);

            pst = conn.prepareStatement(query);
            pst.setDate(1, obj.getDate());
            pst.setInt(2, obj.getRoute_id());
            pst.setInt(3, obj.getTrain_id());
            pst.setTime(4, obj.getArrivaltime());
            pst.setTime(5, obj.getDeparuretime());

            pst.setInt(6, obj.getId());
            System.out.println(pst);

            affectedRows = pst.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(RouteScheduleDBHandler.class.getName()).log(Level.SEVERE, null, ex);
        }
        return affectedRows > 0;
    }

    public boolean removeRouteScheduleById(int id) {
        if (id <= 0) {
            return false;
        }
        int affectedRows = 0;
        String query = "delete from `route_schedule`  where id=?";
        PreparedStatement pst = null;
        try {
            pst = conn.prepareStatement(query);
            pst.setInt(1, id);
            affectedRows = pst.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(RouteScheduleDBHandler.class.getName()).log(Level.SEVERE, null, ex);
        }
        return affectedRows != 0;

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

}
