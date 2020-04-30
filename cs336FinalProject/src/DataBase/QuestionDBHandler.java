/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DataBase;

import DTO.QuestionDTO;
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
public class QuestionDBHandler extends DB {

    public ArrayList<QuestionDTO> getAllQuestion() {
        ArrayList<QuestionDTO> array = null; //statement
        QuestionDTO obj = null;
        String query = "SELECT q.* ,u.first_name as \"questionername\",u1.first_name as \"answerer name\" FROM `question` q \n"
                + "left join user u on u.id=q.questioner_id\n"
                + "left join user u1 on u1.id=q.answerer_id";
        Statement st = null;
        ResultSet rs = null;
        try {
            st = conn.createStatement();
            rs = st.executeQuery(query);
            if (rs != null) {
                array = new ArrayList<QuestionDTO>();
                while (rs.next()) {

                    obj = new QuestionDTO();
                    obj.setId(rs.getInt(1));
                    obj.setQuestion(rs.getString(2));
                    obj.setAnswer(rs.getString(3));
                    obj.setQuestioner_id(rs.getInt(4));
                    obj.setAnswerer_id(rs.getInt(5));
                    obj.setIs_answered(rs.getBoolean(6));
                    obj.setQuestioner_name(rs.getString(7));
                    obj.setAnswerer_name(rs.getString(8));
                    array.add(obj);

                }
            }

        } catch (SQLException ex) {
            Logger.getLogger(QuestionDBHandler.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException ex) {
                    Logger.getLogger(QuestionDBHandler.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

            if (st != null) {
                try {
                    st.close();
                } catch (SQLException ex) {
                    Logger.getLogger(QuestionDBHandler.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
        if (array == null || array.isEmpty()) {
            return null;
        }
        return array;
    }

    public ArrayList<QuestionDTO> getAllAnsweredQuestion() {
        ArrayList<QuestionDTO> array = null; //statement
        QuestionDTO obj = null;
        String query = "SELECT q.* ,u.first_name as \"questionername\",u1.first_name as \"answerer name\" FROM `question` q \n"
                + "left join user u on u.id=q.questioner_id\n"
                + "left join user u1 on u1.id=q.answerer_id "
                + " where is_answered=true";
        Statement st = null;
        ResultSet rs = null;
        try {
            st = conn.createStatement();
            rs = st.executeQuery(query);
            if (rs != null) {
                array = new ArrayList<QuestionDTO>();
                while (rs.next()) {

                    obj = new QuestionDTO();
                    obj.setId(rs.getInt(1));
                    obj.setQuestion(rs.getString(2));
                    obj.setAnswer(rs.getString(3));
                    obj.setQuestioner_id(rs.getInt(4));
                    obj.setAnswerer_id(rs.getInt(5));
                    obj.setIs_answered(rs.getBoolean(6));
                    obj.setQuestioner_name(rs.getString(7));
                    obj.setAnswerer_name(rs.getString(8));
                    array.add(obj);

                }
            }

        } catch (SQLException ex) {
            Logger.getLogger(QuestionDBHandler.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException ex) {
                    Logger.getLogger(QuestionDBHandler.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

            if (st != null) {
                try {
                    st.close();
                } catch (SQLException ex) {
                    Logger.getLogger(QuestionDBHandler.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
        if (array == null || array.isEmpty()) {
            return null;
        }
        return array;
    }

    public ArrayList<QuestionDTO> getAllUnAnsweredQuestion() {
        ArrayList<QuestionDTO> array = null; //statement
        QuestionDTO obj = null;
        String query = "SELECT q.* ,u.first_name as \"questionername\",u1.first_name as \"answerer name\" FROM `question` q \n"
                + "left join user u on u.id=q.questioner_id\n"
                + "left join user u1 on u1.id=q.answerer_id "
                + " where is_answered=false";
        Statement st = null;
        ResultSet rs = null;
        try {
            st = conn.createStatement();
            rs = st.executeQuery(query);
            if (rs != null) {
                array = new ArrayList<QuestionDTO>();
                while (rs.next()) {

                    obj = new QuestionDTO();
                    obj.setId(rs.getInt(1));
                    obj.setQuestion(rs.getString(2));
                    obj.setAnswer(rs.getString(3));
                    obj.setQuestioner_id(rs.getInt(4));
                    obj.setAnswerer_id(rs.getInt(5));
                    obj.setIs_answered(rs.getBoolean(6));
                    obj.setQuestioner_name(rs.getString(7));
                    obj.setAnswerer_name(rs.getString(8));
                    array.add(obj);

                }
            }

        } catch (SQLException ex) {
            Logger.getLogger(QuestionDBHandler.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException ex) {
                    Logger.getLogger(QuestionDBHandler.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

            if (st != null) {
                try {
                    st.close();
                } catch (SQLException ex) {
                    Logger.getLogger(QuestionDBHandler.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
        if (array == null || array.isEmpty()) {
            return null;
        }
        return array;
    }

    public ArrayList<QuestionDTO> getAllQuestionByAnswereId(int id) {
        ArrayList<QuestionDTO> array = null; //statement
        QuestionDTO obj = null;
        String query = "SELECT q.* ,u.first_name as \"questionername\",u1.first_name as \"answerer name\" FROM `question` q \n"
                + "left join user u on u.id=q.questioner_id\n"
                + "left join user u1 on u1.id=q.answerer_id"
                + " where q.answerer_id=?";

        PreparedStatement st = null;
        ResultSet rs = null;
        try {
            st = conn.prepareStatement(query);
            st.setInt(1, id);
            rs = st.executeQuery();
            if (rs != null) {
                array = new ArrayList<QuestionDTO>();
                while (rs.next()) {

                    obj = new QuestionDTO();
                    obj = new QuestionDTO();
                    obj.setId(rs.getInt(1));
                    obj.setQuestion(rs.getString(2));
                    obj.setAnswer(rs.getString(3));
                    obj.setQuestioner_id(rs.getInt(4));
                    obj.setAnswerer_id(rs.getInt(5));
                    obj.setIs_answered(rs.getBoolean(6));
                    obj.setQuestioner_name(rs.getString(7));
                    obj.setAnswerer_name(rs.getString(8));
                    array.add(obj);

                }
            }

        } catch (SQLException ex) {
            Logger.getLogger(QuestionDBHandler.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException ex) {
                    Logger.getLogger(QuestionDBHandler.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

            if (st != null) {
                try {
                    st.close();
                } catch (SQLException ex) {
                    Logger.getLogger(QuestionDBHandler.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
        if (array == null || array.isEmpty()) {
            return null;
        }
        return array;
    }

    public ArrayList<QuestionDTO> getAllQuestionByQuestionerId(int id) {
        ArrayList<QuestionDTO> array = null; //statement
        QuestionDTO obj = null;
        String query = "SELECT q.* ,u.first_name as \"questionername\",u1.first_name as \"answerer name\" FROM `question` q \n"
                + "left join user u on u.id=q.questioner_id\n"
                + "left join user u1 on u1.id=q.answerer_id"
                + " where q.questioner_id=?";

        PreparedStatement st = null;
        ResultSet rs = null;
        try {
            st = conn.prepareStatement(query);
            st.setInt(1, id);
            rs = st.executeQuery();
            if (rs != null) {
                array = new ArrayList<QuestionDTO>();
                while (rs.next()) {

                  
                    obj = new QuestionDTO();
                    obj.setId(rs.getInt(1));
                    obj.setQuestion(rs.getString(2));
                    obj.setAnswer(rs.getString(3));
                    obj.setQuestioner_id(rs.getInt(4));
                    obj.setAnswerer_id(rs.getInt(5));
                    obj.setIs_answered(rs.getBoolean(6));
                    obj.setQuestioner_name(rs.getString(7));
                    obj.setAnswerer_name(rs.getString(8));
                    array.add(obj);

                }
            }

        } catch (SQLException ex) {
            Logger.getLogger(QuestionDBHandler.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException ex) {
                    Logger.getLogger(QuestionDBHandler.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

            if (st != null) {
                try {
                    st.close();
                } catch (SQLException ex) {
                    Logger.getLogger(QuestionDBHandler.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
        if (array == null || array.isEmpty()) {
            return null;
        }
        return array;
    }

    public boolean AskQuestion(QuestionDTO obj) {
        int affectedRows = 0;
        String query = "INSERT INTO `question` (`id`,question,questioner_id) VALUES (NULL, ?, ?)";
        PreparedStatement pst = null;
        try {
            pst = conn.prepareStatement(query);
            pst.setString(1, obj.getQuestion());
            pst.setInt(2, obj.getQuestioner_id());

            affectedRows = pst.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(QuestionDBHandler.class.getName()).log(Level.SEVERE, null, ex);
        }
        return affectedRows > 0;
    }

    public QuestionDTO getQuestionByID(int id) {
        if (id < 0) {
            return null;
        }
        QuestionDTO obj = null;
        String query = "SELECT q.* ,u.first_name as \"questionername\",u1.first_name as \"answerer name\" FROM `question` q \n"
                + "left join user u on u.id=q.questioner_id\n"
                + "left join user u1 on u1.id=q.answerer_id \n"
                + "where q.id=?";
        PreparedStatement pst = null;
        ResultSet rs = null;

        try {
            pst = conn.prepareStatement(query);
            pst.setInt(1, id);
            System.out.println(pst);
            rs = pst.executeQuery();
            if (rs != null) {
                if (rs.next()) {

                    obj = new QuestionDTO();
                    obj.setId(rs.getInt(1));
                    obj.setQuestion(rs.getString(2));
                    obj.setAnswer(rs.getString(3));
                    obj.setQuestioner_id(rs.getInt(4));
                    obj.setAnswerer_id(rs.getInt(5));
                    obj.setIs_answered(rs.getBoolean(6));
                    obj.setQuestioner_name(rs.getString(7));
                    obj.setAnswerer_name(rs.getString(8));

                }
            }

        } catch (SQLException ex) {
            Logger.getLogger(QuestionDBHandler.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException ex) {
                    Logger.getLogger(QuestionDBHandler.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

            if (pst != null) {
                try {
                    pst.close();
                } catch (SQLException ex) {
                    Logger.getLogger(QuestionDBHandler.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }

        return obj;
    }

    public boolean updateQuestion(QuestionDTO obj)//id will never be updated
    {
        int affectedRows = 0;
        String query = " UPDATE `question` SET `question`=?,`answer`=?,"
                + "questioner_id=? ,`answerer_id`=?,`is_answered`=? where id=?";
        PreparedStatement pst = null;
        try {
            pst = conn.prepareStatement(query);
            pst.setString(1, obj.getQuestion());
            pst.setString(2, obj.getAnswer());
            pst.setInt(3, obj.getQuestioner_id());
            pst.setInt(4, obj.getAnswerer_id());
            pst.setBoolean(5, obj.isIs_answered());
            pst.setInt(6, obj.getId());

            System.out.println(pst);

            affectedRows = pst.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(QuestionDBHandler.class.getName()).log(Level.SEVERE, null, ex);
        }
        return affectedRows > 0;
    }

    public boolean removeQuestionById(int id) {
        if (id <= 0) {
            return false;
        }
        int affectedRows = 0;
        String query = "delete from `question`  where id=?";
        PreparedStatement pst = null;
        try {
            pst = conn.prepareStatement(query);
            pst.setInt(1, id);
            affectedRows = pst.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(QuestionDBHandler.class.getName()).log(Level.SEVERE, null, ex);
        }
        return affectedRows != 0;

    }

}
