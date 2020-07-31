package org.example.test;

import org.example.dao.QuestionnaireDao;
import org.example.dao.UserDao;
import org.example.entity.Questionnaire;
import org.example.entity.User;
import org.junit.Assert;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ResponseStatus;

import java.util.List;

public class UserDaoTest extends BaseTest {

    @Autowired
    private UserDao userDao;

    @Test
    public void testGetUser() {
        User u = userDao.getUserByUid(1);
        System.out.println(u);
        Assert.assertEquals(u.toString(), "User{uid=1, name='Name', psw='Psw', is_admin=true}");
    }

    @Test
    public void testCreateUser() {
        userDao.createUser("TestName", "TestPsw");
    }

}
