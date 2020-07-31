<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"  isELIgnored="false" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>发表新专栏</title>
    <link rel="stylesheet" href="/static/layui-v2.5.6/layui/css/layui.css">
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
    <div class="layui-header">
        <div class="layui-logo">心秘籍</div>
        <ul class="layui-nav layui-layout-left">
            <li class="layui-nav-item">
                <h1>发表新专栏</h1>
            </li>
        </ul>
        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item">
                <a href="javascript:;">
                    <span>${ user.is_admin ? "管理员" : "用户" }</span>
                    <span>${ user.name }</span>
                </a>
                <dl class="layui-nav-child">
                    <dd><a href="/page/user/my-questionnaire-list?obj_uid=${ user.uid }">我的心理报告</a></dd>
                    <dd><a href="/page/logout">退出登录</a></dd>
                </dl>
            </li>
        </ul>
    </div>
    <span style="opacity: 0.3; position: fixed;">
    <img style="width:100%; " src="/static/pic/鹿乃晴天女子.png">
    </span>

    <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll">
            <ul class="layui-nav layui-nav-tree">
                <li class="layui-nav-item">
                    <a href="/page/home">主页</a>
                </li>
                <li class="layui-nav-item layui-nav-itemed">
                    <a href="javascript:;">心理测评</a>
                    <dl class="layui-nav-child">
                        <dd><a href="/page/questionnaire-list">心理测评大全</a></dd>
                        <c:if test="${ user.is_admin }">
                            <dd><a href="/page/new-questionnaire">新建心理测评</a></dd>
                        </c:if>
                        <dd><a href="/page/user/my-questionnaire-list?obj_uid=${ user.uid }">查看我的心理报告</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a href="javascript:;">心理科普</a>
                    <dl class="layui-nav-child">
                        <dd><a href="/page/article-list">专栏大全</a></dd>
                        <c:if test="${ user.is_admin }">
                            <dd><a href="/page/article-new">添加专栏</a></dd>
                        </c:if>
                    </dl>
                </li>
                <c:if test="${ user.is_admin }">
                    <li class="layui-nav-item">
                        <a href="javascript:;">系统管理</a>
                        <dl class="layui-nav-child">
                            <dd><a href="/page/users">用户管理</a></dd>
                        </dl>
                    </li>
                </c:if>
            </ul>
        </div>
    </div>

    <div class="layui-body">
        <div class="layui-container" style="margin-top: 15px">
            <c:if test="${ user.is_admin }">

                <fieldset class="layui-elem-field layui-field-title">
                    <legend>发表新的专栏</legend>
                </fieldset>

                <form class="layui-form">
                    <div class="layui-form-item">
                        <label class="layui-form-label">专栏标题</label>
                        <div class="layui-input-block">
                            <input type="text" name="article-title" lay-verify="not_empty" autocomplete="off" placeholder="" class="layui-input">
                        </div>
                    </div>

                    <div class="layui-form-item layui-form-text">
                        <label class="layui-form-label">正文</label>
                        <div class="layui-input-block">
                            <textarea lay-verify="not_empty" name="article-content" placeholder="" class="layui-textarea"></textarea>
                        </div>
                    </div>

                    <div class="layui-form-item">
                        <div class="layui-input-block">
                            <button type="submit" class="layui-btn" lay-submit="" lay-filter="btn-submit">发布</button>
                        </div>
                    </div>

                </form>

            </c:if>
        </div>
    </div>

    <div class="layui-footer">
        第14组 心秘籍
    </div>
</div>
<script src="/static/jquery-3.4.1/dist/jquery-3.4.1.min.js" charset="utf-8"></script>
<script src="/static/layui-v2.5.6/layui/layui.js" charset="utf-8"></script>
<script>
    layui.use(['element', 'form'], function () {
        layui.form.verify({
            not_empty: function (value) {
                if(value.length == 0) {
                    return "此处不能为空";
                }
            }
        });
        layui.form.on("submit(btn-submit)", function (data) {
            // layer.alert(JSON.stringify(data.field));
            $.post('/api/article/new', {
                title: data.field['article-title'],
                text: data.field['article-content']
            }, function (data) {
                if(data.length > 0) {
                    layer.msg(data);
                } else {
                    layer.msg('发布成功', function () {
                        window.location.reload();
                    });
                }
            });
            return false;
        });
    });

</script>
</body>
</html>
