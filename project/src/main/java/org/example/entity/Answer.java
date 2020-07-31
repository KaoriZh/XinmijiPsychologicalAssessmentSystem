package org.example.entity;

public class Answer {

    private long qid;
    private String text;
    private long score;
    private long power;

    public long getQid() {
        return qid;
    }

    public void setQid(long qid) {
        this.qid = qid;
    }

    public long getScore() {
        return score;
    }

    public void setScore(long score) {
        this.score = score;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    @Override
    public String toString() {
        return "Answer{" +
                "qid=" + qid +
                ", text='" + text + '\'' +
                ", score=" + score +
                ", power=" + power +
                '}';
    }

    public long getPower() {
        return power;
    }

    public void setPower(long power) {
        this.power = power;
    }

}
