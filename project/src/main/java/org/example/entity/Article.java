package org.example.entity;

public class Article {

    public long getNid() {
        return nid;
    }

    public void setNid(long nid) {
        this.nid = nid;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    private long nid;
    private String title;
    private String text;

    @Override
    public String toString() {
        return "Article{" +
                "nid=" + nid +
                ", title='" + title + '\'' +
                ", text='" + text + '\'' +
                '}';
    }
}
