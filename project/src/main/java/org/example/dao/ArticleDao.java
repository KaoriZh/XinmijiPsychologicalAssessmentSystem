package org.example.dao;

import org.apache.ibatis.annotations.Param;
import org.example.entity.Article;

import java.util.List;

public interface ArticleDao {

    List<Article> getAllArticles();

    Article getArticle(long nid);

    int delArticle(long nid);

    int newArticle(@Param("title") String title, @Param("text") String text);

}
