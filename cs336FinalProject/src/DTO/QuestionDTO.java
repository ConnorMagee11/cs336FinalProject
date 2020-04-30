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
public class QuestionDTO {
    private int id;
    private String question;
    private String answer;
    private int questioner_id;
    private int answerer_id;
    private boolean is_answered;
    private String questioner_name;
     private String answerer_name;

    public QuestionDTO() {
    }

    public QuestionDTO(int id, String question, String answer, int questioner_id, int answerer_id, boolean is_answered, String questioner_name, String answerer_name) {
        this.id = id;
        this.question = question;
        this.answer = answer;
        this.questioner_id = questioner_id;
        this.answerer_id = answerer_id;
        this.is_answered = is_answered;
        this.questioner_name = questioner_name;
        this.answerer_name = answerer_name;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getQuestion() {
        return question;
    }

    public void setQuestion(String question) {
        this.question = question;
    }

    public String getAnswer() {
        return answer;
    }

    public void setAnswer(String answer) {
        this.answer = answer;
    }

    public int getQuestioner_id() {
        return questioner_id;
    }

    public void setQuestioner_id(int questioner_id) {
        this.questioner_id = questioner_id;
    }

    public int getAnswerer_id() {
        return answerer_id;
    }

    public void setAnswerer_id(int answerer_id) {
        this.answerer_id = answerer_id;
    }

    public boolean isIs_answered() {
        return is_answered;
    }

    public void setIs_answered(boolean is_answered) {
        this.is_answered = is_answered;
    }

    public String getQuestioner_name() {
        return questioner_name;
    }

    public void setQuestioner_name(String questioner_name) {
        this.questioner_name = questioner_name;
    }

    public String getAnswerer_name() {
        return answerer_name;
    }

    public void setAnswerer_name(String answerer_name) {
        this.answerer_name = answerer_name;
    }

    @Override
    public String toString() {
        return "Question{" + "id=" + id + ", question=" + question + ", answer=" + answer + ", questioner_id=" + questioner_id + ", answerer_id=" + answerer_id + ", is_answered=" + is_answered + ", questioner_name=" + questioner_name + ", answerer_name=" + answerer_name + '}';
    }
     
    

    
}
