package org.example.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.apache.ibatis.annotations.Param;
import org.example.dao.ArticleDao;
import org.example.dao.QuestionnaireDao;
import org.example.dao.UserDao;
import org.example.entity.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/page")
public class PageController {

    @Autowired
    UserDao userDao;

    @Autowired
    QuestionnaireDao qnDao;

    @Autowired
    ArticleDao articleDao;

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public ModelAndView login() {
        ModelAndView mv = new ModelAndView("login");
        return mv;
    }

    @RequestMapping(value = "/register", method = RequestMethod.GET)
    public ModelAndView register() {
        ModelAndView mv = new ModelAndView("register");
        return mv;
    }

    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public String logout(HttpSession session) {
        session.removeAttribute("uid");
        return "redirect:/page/login";
    }

    @RequestMapping(value = "/home", method = RequestMethod.GET)
    public ModelAndView home(HttpSession session) {
        long uid = (Long)session.getAttribute("uid");
        User u = userDao.getUserByUid(uid);
        ModelAndView mv = new ModelAndView("home");
        mv.addObject("user", u);
        return mv;
    }

    @RequestMapping(value = "/article-new", method = RequestMethod.GET)
    public ModelAndView articleNew(HttpSession session) {
        long uid = (Long)session.getAttribute("uid");
        User u = userDao.getUserByUid(uid);
        ModelAndView mv = new ModelAndView("article-new");
        mv.addObject("user", u);
        return mv;
    }

    @RequestMapping(value = "/article/{nid}", method = RequestMethod.GET)
    public ModelAndView article(HttpSession session, @PathVariable("nid") long nid) {
        long uid = (Long)session.getAttribute("uid");
        User u = userDao.getUserByUid(uid);
        Article a = articleDao.getArticle(nid);
        ModelAndView mv = new ModelAndView("article");
        mv.addObject("user", u);
        mv.addObject("article", a);
        return mv;
    }

    @RequestMapping(value = "/new-questionnaire", method = RequestMethod.GET)
    public ModelAndView new_questionnaire(HttpSession session) {
        long uid = (Long)session.getAttribute("uid");
        User u = userDao.getUserByUid(uid);
        ModelAndView mv = new ModelAndView("questionnaire-new");
        mv.addObject("user", u);
        return mv;
    }

    @RequestMapping(value = "/questionnaire/{qnid}", method = RequestMethod.GET)
    public ModelAndView questionnaire(HttpSession session, @PathVariable("qnid") long qnid) {
        long uid = (Long)session.getAttribute("uid");
        User u = userDao.getUserByUid(uid);
        Questionnaire qn = qnDao.getQuestionnaireInfo(qnid);
        List<Question> qs = qnDao.getAllQuestions(qnid);
        ModelAndView mv = new ModelAndView("questionnaire");
        mv.addObject("user", u);
        mv.addObject("qn", qn);
        mv.addObject("qs", qs);
        return mv;
    }

    @RequestMapping(value = "/questionnaire-result/{qnid}", method = RequestMethod.GET)
    public ModelAndView questionnaire_result(
            HttpSession session,
            @RequestParam("obj_uid") long obj_uid,
            @PathVariable("qnid") long qnid) {
        long uid = (Long)session.getAttribute("uid");
        User u = userDao.getUserByUid(uid);
        User obju = userDao.getUserByUid(obj_uid);
        Questionnaire qn = qnDao.getQuestionnaireInfo(qnid);
        long totalScore = qnDao.getTotalScore(obj_uid, qnid);
        List<Answer> answers = qnDao.getAllAnswers(obj_uid, qnid);
        String conclusion = null;
        if(totalScore >= 0) {
            conclusion = qnDao.getConclusion(qnid, totalScore);
            if(conclusion == null) {
                conclusion = qn.getDef_conclusion();
            }
        }
        ModelAndView mv = new ModelAndView("questionnaire-result");
        mv.addObject("answers", answers);
        mv.addObject("user", u);
        mv.addObject("obju", obju);
        mv.addObject("qn", qn);
        mv.addObject("result_is_exist", conclusion != null);
        mv.addObject("result_text", conclusion);
        return mv;
    }


    @RequestMapping(value = "/questionnaire-list", method = RequestMethod.GET)
    public ModelAndView questionnairesList(
            HttpSession session,
            @RequestParam(value = "pageNum", defaultValue = "1") int pageNum,
            @RequestParam(value = "pageSize", defaultValue = "10") int pageSize) {
        long uid = (Long)session.getAttribute("uid");
        User u = userDao.getUserByUid(uid);
        PageHelper.startPage(pageNum, pageSize);
        List<Questionnaire> qns = qnDao.getAllQuestionnaires();
        ModelAndView mv = new ModelAndView("questionnaire-list");
        mv.addObject("pageInfo", new PageInfo<Questionnaire>(qns));
        mv.addObject("user", u);
        mv.addObject("qns", qns);
        return mv;
    }

    @RequestMapping(value = "/article-list", method = RequestMethod.GET)
    public ModelAndView articlesList(
            HttpSession session,
            @RequestParam(value = "pageNum", defaultValue = "1") int pageNum,
            @RequestParam(value = "pageSize", defaultValue = "10") int pageSize) {
        long uid = (Long)session.getAttribute("uid");
        User u = userDao.getUserByUid(uid);
        PageHelper.startPage(pageNum, pageSize);
        List<Article> articles = articleDao.getAllArticles();
        ModelAndView mv = new ModelAndView("article-list");
        mv.addObject("pageInfo", new PageInfo<Article>(articles));
        mv.addObject("user", u);
        mv.addObject("articles", articles);
        return mv;
    }

    @RequestMapping(value = "/user/my-questionnaire-list", method = RequestMethod.GET)
    public ModelAndView getMyQuestionnaires(
            HttpSession session,
            @RequestParam("obj_uid") long obj_uid,
            @RequestParam(value = "pageNum", defaultValue = "1") int pageNum,
            @RequestParam(value = "pageSize", defaultValue = "10") int pageSize) {
        long uid = (Long)session.getAttribute("uid");
        User u = userDao.getUserByUid(uid);
        User obju = userDao.getUserByUid(obj_uid);
        PageHelper.startPage(pageNum, pageSize);
        List<Questionnaire> qns = qnDao.getAllValidQuestionnaire(obj_uid);
        List<Conclusion> cs = new ArrayList<>();
        for(Questionnaire qn : qns) {
            long totalScore = qnDao.getTotalScore(obj_uid, qn.getQnid());
            String text = null;
            if(totalScore >= 0) {
                text = qnDao.getConclusion(qn.getQnid(), totalScore);
                if(text == null) {
                    text = qn.getDef_conclusion();
                }
            }
            cs.add(new Conclusion(totalScore, text));
        }
        ModelAndView mv = new ModelAndView("my-questionnaire-list");
        mv.addObject("pageInfo", new PageInfo<Questionnaire>(qns));
        mv.addObject("user", u);
        mv.addObject("obju", obju);
        mv.addObject("cs", cs);
        mv.addObject("qns", qns);
        return mv;
    }

    @RequestMapping(value = "/users", method = RequestMethod.GET)
    public ModelAndView users(
            HttpSession session,
            @RequestParam(value = "pageNum", defaultValue = "1") int pageNum,
            @RequestParam(value = "pageSize", defaultValue = "10") int pageSize) {
        long uid = (Long)session.getAttribute("uid");
        User u = userDao.getUserByUid(uid);
        PageHelper.startPage(pageNum, pageSize);
        List<User> users = userDao.getAllUsers();
        ModelAndView mv = new ModelAndView("user-list");
        mv.addObject("pageInfo", new PageInfo<User>(users));
        mv.addObject("user", u);
        mv.addObject("users", users);
        return mv;
    }

}
