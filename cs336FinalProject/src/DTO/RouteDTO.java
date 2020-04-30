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
public class RouteDTO {
    private int id;
      private String name;
      private String origin;
      private String destination;
      private double fare;
      private double timeDuration;
      private String stops;

    public RouteDTO() {
    }

    public RouteDTO(int id, String name, String origin, String destination, double fare, double timeDuration, String stops) {
        this.id = id;
        this.name = name;
        this.origin = origin;
        this.destination = destination;
        this.fare = fare;
        this.timeDuration = timeDuration;
        this.stops = stops;
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

    public String getOrigin() {
        return origin;
    }

    public void setOrigin(String origin) {
        this.origin = origin;
    }

    public String getDestination() {
        return destination;
    }

    public void setDestination(String destination) {
        this.destination = destination;
    }

    public double getFare() {
        return fare;
    }

    public void setFare(double fare) {
        this.fare = fare;
    }

    public double getTimeDuration() {
        return timeDuration;
    }

    public void setTimeDuration(double timeDuration) {
        this.timeDuration = timeDuration;
    }

    public String getStops() {
        return stops;
    }

    public void setStops(String stops) {
        this.stops = stops;
    }

    @Override
    public String toString() {
        return "Route{" + "id=" + id + ", name=" + name + ", origin=" + origin + ", destination=" + destination + ", fare=" + fare + ", timeDuration=" + timeDuration + ", stops=" + stops + '}';
    }
    
    
}
