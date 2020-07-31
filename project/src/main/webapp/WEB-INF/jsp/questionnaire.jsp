<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"  isELIgnored="false" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>测评: ${ qn.title }</title>
    <link rel="stylesheet" href="/static/layui-v2.5.6/layui/css/layui.css">
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
    <div class="layui-header">
        <div class="layui-logo">心秘籍</div>
        <ul class="layui-nav layui-layout-left">
            <li class="layui-nav-item">
                <h1>测评: ${ qn.title }</h1>
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
            <fieldset class="layui-elem-field layui-field-title">
                <legend>
                    测评: ${ qn.title }
                </legend>
            </fieldset>

            <form action="" class="layui-form">
                <div id="questionnaire-list">

                    <c:forEach var="i" begin="1" end="${ qn.qcnt }">

                        <div class="layui-card">
                            <div class="layui-card-header">
                                问题 ${ i }: ${ qs[i - 1].text }
                            </div>
                            <div class="layui-card-body">
                                <div class="layui-form-item">
                                    <label class="layui-form-label">请评分</label>
                                    <div class="layui-input-block">
                                        <select name="q${ qs[i - 1].qid }-score">
                                            <option value=""></option>
                                            <option value="0">不符合</option>
                                            <option value="1">不太符合</option>
                                            <option value="2" selected="">不清楚</option>
                                            <option value="3">有点符合</option>
                                            <option value="4">很符合</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </c:forEach>

                </div>
                <button type="button" class="layui-btn" lay-submit="" lay-filter="btn-submit" style="margin-top: 15px">
                    提交问卷
                </button>
            </form>

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
            not_empty: function(value) {
                if(value.length == 0) {
                    return "此处不应为空";
                }
            },
            is_number: function (value) {
                if (value.length == 0 || isNaN(value - 0)) {
                    return "此处应输入数值";
                }
            }
        });
        layui.form.on('submit(btn-submit)', function (data) {
            // layer.alert(JSON.stringify(data.field));
            data.field.uid = "${ user.uid }";
            $.post('/api/answer/new', data.field, function (data) {
                if(data.length > 0) {
                    layer.alert('提交失败');
                } else {
                    layer.msg('提交成功', function () {
                        window.location.href = '/page/questionnaire-result/${ qn.qnid }?obj_uid=' + ${ user.uid };
                    });
                }
            })
            return false;
        })
    });
</script>
</body>
</html>
