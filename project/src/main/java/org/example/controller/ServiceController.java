package org.example.controller;

import org.apache.ibatis.annotations.Param;
import org.example.dao.ArticleDao;
import org.example.dao.QuestionnaireDao;
import org.example.dao.UserDao;
import org.example.entity.Questionnaire;
import org.example.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Enumeration;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Controller
@RequestMapping(value = "/api", produces = "text/html;charset=UTF-8")
public class ServiceController {

    @Autowired
    UserDao userDao;

    @Autowired
    ArticleDao articleDao;

    @Autowired
    QuestionnaireDao qnDao;

    @RequestMapping(value = "/hello", method = RequestMethod.GET)
    @ResponseBody
    public String hello(@Param("uid") long uid) {
        System.out.println("uid=" + uid);
        User u = userDao.getUserByUid(uid);
        return u.toString();
    }

    @RequestMapping(value = "/login", method = RequestMethod.POST)
    @ResponseBody
    public String login(HttpSession session, @Param("name") String name, @Param("psw") String psw) {
        System.out.printf("name=%s, psw=%s\n", name, psw);
        User u = userDao.getUserByNameAndPsw(name, psw);
        if(u == null) {
            String info = "账号或密码错误";
            System.out.println(info);
            return info;
        }
        session.setAttribute("uid", u.getUid());
        return "";
    }
    
    @RequestMapping(value = "/register", method = RequestMethod.POST)
    @ResponseBody
    public String register(@Param("name") String name, @Param("psw") String psw) {
        int r = userDao.createUser(name, psw);
        if(r == 0) {
            String info = "注册失败";
            System.out.println(info);
            return info;
        }
        return "";
    }

    @RequestMapping(value = "/article/new", method = RequestMethod.POST)
    @ResponseBody
    public String article_new(@Param("title") String title, @Param("text") String text) {
        int i = articleDao.newArticle(title, text);
        if(i == 0) {
            return "添加文章失败";
        }
        return "";
    }

    @RequestMapping(value = "/article/delete", method = RequestMethod.POST)
    @ResponseBody
    public String article_delete(@Param("nid") long nid) {
        int i = articleDao.delArticle(nid);
        if(i == 0) {
            return "删除文章失败";
        }
        return "";
    }

    @RequestMapping(value = "/questionnaire/new", method = RequestMethod.POST)
    @ResponseBody
    public String qn_new(
            @Param("title") String title,
            @Param("abs") String abs,
            @Param("def_conclusion") String def_conclusion,
            HttpServletRequest request) {

        Questionnaire qn = new Questionnaire();
        qn.setTitle(title);
        qn.setAbs(abs);
        qn.setDef_conclusion(def_conclusion);
        System.out.printf("title=%s, abstract=%s, def_conclusion=%s\n", title, abs, def_conclusion);
        System.out.println(qn);

        qnDao.createQuestionnaire(qn);

        Pattern intPattern = Pattern.compile("(\\d+)");

        Enumeration<String> keys = request.getParameterNames();
        System.out.println("questionnaire:");
        while(keys.hasMoreElements()) {
            String key = keys.nextElement();
            System.out.println(key);
            if(key.matches("q\\d+-title")) {
                Matcher intMatcher = intPattern.matcher(key);
                intMatcher.find();
                int ord = Integer.parseInt(intMatcher.group(1));
                String q_title = request.getParameter(key);
                long q_power = Long.parseLong(request.getParameter(String.format("q%d-power", ord)));
                System.out.printf("%d: title=%s, power=%s", ord, q_title, q_power);
                qnDao.createQuestion(qn.getQnid(), q_title, q_power);
            } else if(key.matches("a\\d+-result")) {
                Matcher intMatcher = intPattern.matcher(key);
                intMatcher.find();
                int ord = Integer.parseInt(intMatcher.group(1));
                String a_result = request.getParameter(key);
                long a_min = Long.parseLong(request.getParameter(String.format("a%d-range-min", ord)));
                long a_max = Long.parseLong(request.getParameter(String.format("a%d-range-max", ord)));
                System.out.printf("%d: result=%s, %d~%d", ord, a_result, a_min, a_max);
                qnDao.createConclusion(qn.getQnid(), a_min, a_max, a_result);
            }
        }

        return "";
    }

    @RequestMapping(value = "/questionnaire/delete", method = RequestMethod.POST)
    @ResponseBody
    public String qn_delete(@Param("qnid") long qnid) {
        if(qnDao.destroyQuestionnaire(qnid) == 0) {
            return "删除失败";
        }
        return "";
    }

    @RequestMapping(value = "/answer/new", method = RequestMethod.POST)
    @ResponseBody
    public String answer_post(@Param("uid") long uid, HttpServletRequest request) {
        Pattern intPattern = Pattern.compile("(\\d+)");
        Enumeration<String> keys = request.getParameterNames();
        System.out.println("answers:");
        while(keys.hasMoreElements()) {
            String key = keys.nextElement();
            System.out.println(key);
            if(key.matches("q\\d+-score")) {
                Matcher m = intPattern.matcher(key);
                m.find();
                long qid = Long.parseLong(m.group(1));
                long score = Long.parseLong(request.getParameter(key));
                System.out.printf("ans: uid=%d, qid=%d, score=%d\n", uid, qid, score);
                qnDao.postAnswers(uid, qid, score);
            }
        }
        return "";
    }

    @RequestMapping(value = "/answer/delete", method = RequestMethod.POST)
    @ResponseBody
    public String deleteAnswer(@Param("qnid") long qnid, @Param("uid") long uid) {
        qnDao.deleteAnswer(uid, qnid);
        return "";
    }

    @RequestMapping(value = "/user/priority", method = RequestMethod.POST)
    @ResponseBody
    public String setPriority(@Param("uid") long uid, @Param("is_admin") boolean is_admin) {
        userDao.setUserPriority(uid, is_admin);
        return "";
    }

}
