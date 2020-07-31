<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"  isELIgnored="false" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>查看${ obju.name }的${ qn.title }的测评结果</title>
    <link rel="stylesheet" href="/static/layui-v2.5.6/layui/css/layui.css">
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
    <div class="layui-header">
        <div class="layui-logo">心秘籍</div>
        <ul class="layui-nav layui-layout-left">
            <li class="layui-nav-item">
                <h1>查看${ obju.name }的${ qn.title }的测评结果</h1>
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
                    ${ obju.name }的${ qn.title }的测评结果
                </legend>
            </fieldset>

            <div class="layui-card">
                <div class="layui-card-header">
                    ${ obju.name }的${ qn.title }的测评结果 <button type="button" id="btn-del-ans" class="layui-btn layui-btn-primary layui-btn-xs">删除答卷并重测</button>
                </div>
                <div class="layui-card-body">

                    <c:if test="${ result_is_exist }">
                        <pre>${ result_text }</pre>
                        &emsp;&emsp;以上测评意见仅供参考，如有实际心理需求建议咨询心理医生。
                    </c:if>
                    <c:if test="${ !result_is_exist }">
                        &emsp;&emsp;你还未进行测评, 点击 <a href="/page/questionnaire/${ qn.qnid }" class="layui-btn layui-btn-sm">这里</a> 开始测评。
                    </c:if>

                </div>
            </div>

            <fieldset class="layui-elem-field layui-field-title">
                <legend>
                    测评具体情况
                </legend>
            </fieldset>

            <c:forEach var="i" begin="1" end="${ answers.size() }">

                <div class="layui-card">
                    <div class="layui-card-header">
                        问题 ${ i }: ${ answers[i - 1].text }
                    </div>
                    <div class="layui-card-body">
                        <form class="layui-form">
                            <div class="layui-form-item">
                                <label class="layui-form-label">请评分</label>
                                <div class="layui-input-block">
                                    <select>
                                        <option value=""></option>
                                        <option value="${ answers[i - 1].score }" selected=""><c:if test="${ answers[i - 1].score == 0 }">不符合</c:if><c:if test="${ answers[i - 1].score == 1 }">不太符合</c:if><c:if test="${ answers[i - 1].score == 2 }">不清楚</c:if><c:if test="${ answers[i - 1].score == 3 }">有点符合</c:if><c:if test="${ answers[i - 1].score == 4 }">很符合</c:if></option>
                                    </select>
                                </div>
                            </div>
                            <c:if test="${ user.is_admin }">
                                本题获得${ answers[i - 1].score }分，本题权值为${ answers[i - 1].power }。
                            </c:if>
                        </form>
                    </div>
                </div>

            </c:forEach>

        </div>
    </div>

    <div class="layui-footer">
        第14组 心秘籍
    </div>
</div>
<script src="/static/jquery-3.4.1/dist/jquery-3.4.1.min.js" charset="utf-8"></script>
<script src="/static/layui-v2.5.6/layui/layui.js" charset="utf-8"></script>
<script>
    layui.use(['element', 'form'], function(){

    });
    $("#btn-del-ans").click(function () {
        $.post('/api/answer/delete', {
            qnid: ${ qn.qnid },
            uid: ${ obju.uid }
        }, function (data) {
            if(data > 0) {
                layer.alert(data);
            } else {
                layer.msg('删除成功', function () {
                    window.location.href = '/page/questionnaire/${ qn.qnid }';
                });
            }
        })
    });
</script>
</body>
</html>

