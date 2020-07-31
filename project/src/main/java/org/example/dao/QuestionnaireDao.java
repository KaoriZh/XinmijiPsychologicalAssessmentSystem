package org.example.dao;

import org.apache.ibatis.annotations.Param;
import org.example.entity.Answer;
import org.example.entity.Question;
import org.example.entity.Questionnaire;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.List;

public interface QuestionnaireDao {

    List<Questionnaire> getAllQuestionnaires();

    int createQuestionnaire(Questionnaire qn);

    int destroyQuestionnaire(long qnid);

    int createQuestion(@Param("qnid") long qnid, @Param("text") String text, @Param("power") long power);

    int createConclusion(@Param("qnid") long qnid, @Param("min") long min, @Param("max") long max, @Param("text") String text);

    Questionnaire getQuestionnaireInfo(long qnid);

    List<Question> getAllQuestions(long qnid);

    int postAnswers(@Param("uid") long uid, @Param("qid") long qid, @Param("score") long score);

    List<Answer> getAllAnswers(@Param("uid") long uid, @Param("qnid") long qnid);

    int deleteAnswer(@Param("uid") long uid, @Param("qnid") long qnid);

    long getTotalScore(@Param("uid") long uid, @Param("qnid") long qnid);

    String getConclusion(@Param("qnid") long qnid, @Param("score") long score);

    List<Questionnaire> getAllValidQuestionnaire(long uid);

}
