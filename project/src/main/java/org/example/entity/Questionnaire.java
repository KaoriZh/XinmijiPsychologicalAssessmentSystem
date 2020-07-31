package org.example.entity;

public class Questionnaire {

    private long qnid;
    private String title;
    private String abs;
    private long qcnt;
    private String def_conclusion;

    public long getQnid() {
        return qnid;
    }

    public void setQnid(long qnid) {
        this.qnid = qnid;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getAbs() {
        return abs;
    }

    public void setAbs(String abs) {
        this.abs = abs;
    }

    public long getQcnt() {
        return qcnt;
    }

    public void setQcnt(long qcnt) {
        this.qcnt = qcnt;
    }

    public String getDef_conclusion() {
        return def_conclusion;
    }

    public void setDef_conclusion(String def_conclusion) {
        this.def_conclusion = def_conclusion;
    }

    @Override
    public String toString() {
        return "Questionnaire{" +
                "qnid=" + qnid +
                ", title='" + title + '\'' +
                ", abs='" + abs + '\'' +
                ", qcnt=" + qcnt +
                ", def_conclusion='" + def_conclusion + '\'' +
                '}';
    }
}
