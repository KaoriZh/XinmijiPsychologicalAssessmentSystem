package org.example.entity;

public class Conclusion {



    private long score;
    private String text;

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

    public Conclusion(long score, String text) {
        this.score = score;
        this.text = text;
    }

    @Override
    public String toString() {
        return "Conclusion{" +
                "score=" + score +
                ", text='" + text + '\'' +
                '}';
    }
}
