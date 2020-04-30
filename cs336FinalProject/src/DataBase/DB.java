/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DataBase;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Usman
 */
public class DB {
    private final String connectionUrl = "jdbc:mysql://cs336db.cbzyabpupplo.us-east-2.rds.amazonaws.com:3306/TrainSystem";
    
    protected Connection conn;

    public DB() {
        this.openConnection();
    }
    
    /**
     *
     */
    @Override
    protected void finalize()  
    {
        this.closeConnection();
        try {
            super.finalize();
        } catch (Throwable ex) {
            Logger.getLogger(DB.class.getName()).log(Level.SEVERE, null, ex);
        }
        
    }
    
    public void openConnection() {
        if (conn != null) {
            return;
        }

        try {
			//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
			Class.forName("com.mysql.jdbc.Driver").newInstance();
		} catch (InstantiationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {
			//Create a connection to your DB
			conn = DriverManager.getConnection(connectionUrl,"CS336Spr2020", "[{CS336}]");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
        // TODO Auto-generated catch block
        System.out.println("Connection Open");

    }

    public void closeConnection() {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
        
    }
    
}
