package org.example.test;

import org.example.dao.QuestionnaireDao;
import org.example.entity.Question;
import org.example.entity.Questionnaire;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

public class QuestionaireDaoTest extends BaseTest {

    @Autowired
    private QuestionnaireDao questionnaireDao;

    @Test
    public void testGetAllQuestionnaires() {
        List<Questionnaire> questionnaires = questionnaireDao.getAllQuestionnaires();
        System.out.println("Questionnaires:");
        for (Questionnaire q : questionnaires) {
            System.out.println(q);
        }
    }

    @Test
    public void testCreateQuestionnaire() {
        Questionnaire qn = new Questionnaire();
        qn.setTitle("title");
        qn.setAbs("abstract");
        qn.setDef_conclusion("def_conclusion");
        questionnaireDao.createQuestionnaire(qn);
        System.out.println(qn);
    }

    @Test
    public void testCreateQuestion() {
        questionnaireDao.createQuestion(2, "text", 4);
    }

    @Test
    public void testCreateConclusion() {
        questionnaireDao.createConclusion(2, 0, 40, "0~40");
        questionnaireDao.createConclusion(2, 41, 80, "41~80");
        questionnaireDao.createConclusion(2, 81, 100, "81~100");
    }

    @Test
    public void testGetQuestionnaireInfo() {
        Questionnaire qn = questionnaireDao.getQuestionnaireInfo(10);
        System.out.println(qn);

        List<Question> qs = questionnaireDao.getAllQuestions(10);
        System.out.println(qs);
    }

    @Test
    public void testGetAllValidQuestionnaire() {
        List<Questionnaire> qns = questionnaireDao.getAllValidQuestionnaire(2);
        System.out.println(qns);
    }

}
