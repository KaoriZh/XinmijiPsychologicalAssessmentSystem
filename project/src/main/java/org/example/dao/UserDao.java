package org.example.dao;

import org.apache.ibatis.annotations.Param;
import org.example.entity.User;

import java.util.List;

public interface UserDao {

    User getUserByUid(long uid);
    User getUserByNameAndPsw(@Param("name") String name, @Param("psw") String psw);
    int createUser(@Param("name") String name, @Param("psw") String psw);
    List<User> getAllUsers();
    int setUserPriority(@Param("uid") long uid, @Param("is_admin") boolean is_admin);

}
