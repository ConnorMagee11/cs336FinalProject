/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DTO;

import java.sql.Date;
import java.sql.Time;

/**
 *
 * @author silen
 */
public class RouteScheduleDTO {
    private int id;
    private Date date;
    private int route_id;
    private int train_id;
    private Time arrivaltime;
    private Time deparuretime;
    TrainDTO train;
    RouteDTO route;

    public RouteScheduleDTO(int id, Date date, int route_id, int train_id, Time arrivaltime, Time deparuretime, TrainDTO train, RouteDTO route) {
        this.id = id;
        this.date = date;
        this.route_id = route_id;
        this.train_id = train_id;
        this.arrivaltime = arrivaltime;
        this.deparuretime = deparuretime;
        this.train = train;
        this.route = route;
    }

    public TrainDTO getTrain() {
        return train;
    }

    public void setTrain(TrainDTO train) {
        this.train = train;
    }

    public RouteDTO getRoute() {
        return route;
    }

    public void setRoute(RouteDTO route) {
        this.route = route;
    }
    
   

    public RouteScheduleDTO() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public int getRoute_id() {
        return route_id;
    }

    public void setRoute_id(int route_id) {
        this.route_id = route_id;
    }

    public int getTrain_id() {
        return train_id;
    }

    public void setTrain_id(int train_id) {
        this.train_id = train_id;
    }

    public Time getArrivaltime() {
        return arrivaltime;
    }

    public void setArrivaltime(Time arrivaltime) {
        this.arrivaltime = arrivaltime;
    }

    public Time getDeparuretime() {
        return deparuretime;
    }

    public void setDeparuretime(Time deparuretime) {
        this.deparuretime = deparuretime;
    }

    @Override
    public String toString() {
        return "RouteScheduleDTO{" + "id=" + id + ", date=" + date + ", route_id=" + route_id + ", train_id=" + train_id + ", arrivaltime=" + arrivaltime + ", deparuretime=" + deparuretime + ", train=" + train + ", route=" + route + '}';
    }
    
    
}
