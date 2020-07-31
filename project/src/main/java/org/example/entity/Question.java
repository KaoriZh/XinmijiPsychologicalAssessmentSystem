package org.example.entity;

public class Question {

    private long qid;
    private String text;
    private long power;

    @Override
    public String toString() {
        return "Question{" +
                "qid=" + qid +
                ", text='" + text + '\'' +
                ", power=" + power +
                '}';
    }

    public long getQid() {
        return qid;
    }

    public void setQid(long qid) {
        this.qid = qid;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public long getPower() {
        return power;
    }

    public void setPower(long power) {
        this.power = power;
    }

}
