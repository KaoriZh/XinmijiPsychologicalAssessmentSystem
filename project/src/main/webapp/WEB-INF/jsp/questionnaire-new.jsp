<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"  isELIgnored="false" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>制作新的测评</title>
    <link rel="stylesheet" href="/static/layui-v2.5.6/layui/css/layui.css">
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
    <div class="layui-header">
        <div class="layui-logo">心秘籍</div>
        <ul class="layui-nav layui-layout-left">
            <li class="layui-nav-item">
                <h1>制作新的测评</h1>
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
            <form action="" class="layui-form">
                <fieldset class="layui-elem-field layui-field-title">
                    <legend>
                        新建心理测评
                        <button id="btn-add-question" type="button" class="layui-btn layui-btn-sm">
                            <i class="layui-icon layui-icon-addition"></i>
                            添加问题
                        </button>
                    </legend>
                </fieldset>

                <div class="layui-card">
                    <div class="layui-card-header">基本信息</div>
                    <div class="layui-card-body layui-form-item">
                        <label class="layui-form-label">标题</label>
                        <div class="layui-input-block">
                            <input type="text"
                                   name="title"
                                   placeholder="测评标题"
                                   autocomplete="off"
                                   lay-verify="not_empty"
                                   class="layui-input">
                        </div>
                    </div>
                    <div class="layui-card-body layui-form-item">
                        <label class="layui-form-label">简介</label>
                        <div class="layui-input-block">
                            <textarea placeholder="测评简介"
                                      name="abs"
                                      class="layui-textarea"
                                      style="margin-top: 0px; margin-bottom: 0px; height: 129px;"></textarea>
                        </div>
                    </div>
                </div>

                <div id="questionnaire-list">



                </div>

                <fieldset class="layui-elem-field layui-field-title">
                    <legend>
                        设定测评结果
                        <button id="btn-add-answer" type="button" class="layui-btn layui-btn-sm">
                            <i class="layui-icon layui-icon-addition"></i>
                            添加区间
                        </button>
                    </legend>
                </fieldset>

                <div class="layui-card">
                    <div class="layui-card-header">
                        测评结果设定
                    </div>
                    <div class="layui-card-body">
                        <div id="default-answer">
                            <div class="layui-form-item">
                                <label class="layui-form-label">默认结果</label>
                                <div class="layui-input-block">
                            <textarea placeholder="当测评分数不在以下所有结果区间之内时显示"
                                      lay-verify="not_empty"
                                      name="def_conclusion"
                                      class="layui-textarea"
                                      style="margin-top: 0px; margin-bottom: 0px; height: 129px;"></textarea>
                                </div>
                            </div>
                        </div>
                        <div id="answer-list">



                        </div>
                    </div>
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
            layer.alert(JSON.stringify(data.field));
            $.post('/api/questionnaire/new', data.field, function (data) {
                if(data.length > 0) {
                    layer.alert(data);
                } else {
                    layer.msg("添加成功", function () {
                        window.location.href = '/page/questionnaire-list';
                    });
                }
            });
            return false;
        });
    });
    $(function () {
        function gene_ques(index) {
            let temp = $('\n' +
                '<div class="layui-card" id="q1">\n' +
                '    <div class="layui-card-header">\n' +
                '        <span>问题1</span>\n' +
                '        <button type="button" class="layui-btn layui-btn-sm" id="btn-del-q1">\n' +
                '            <i class="layui-icon layui-icon-delete"></i>\n' +
                '            删除该问题\n' +
                '        </button>\n' +
                '    </div>\n' +
                '    <div class="layui-card-body">\n' +
                '        <div class="layui-form-item">\n' +
                '            <label class="layui-form-label">问题</label>\n' +
                '            <div class="layui-input-block">\n' +
                '                <input type="text"\n' +
                '                       name="q1-title"\n' +
                '                       lay-verify="not_empty"\n' +
                '                       autocomplete="off"\n' +
                '                       placeholder="请输入问题"\n' +
                '                       class="layui-input">\n' +
                '            </div>\n' +
                '        </div>\n' +
                '        <div class="layui-form-item">\n' +
                '            <label class="layui-form-label">设定权值</label>\n' +
                '            <div class="layui-input-block">\n' +
                '                <div class="layui-input-inline">\n' +
                '                    <input type="text"\n' +
                '                           name="q1-power"\n' +
                '                           lay-verify="is_number"\n' +
                '                           placeholder="数值"\n' +
                '                           autocomplete="off"\n' +
                '                           class="layui-input">\n' +
                '                </div>\n' +
                '            </div>\n' +
                '        </div>\n' +
                '    </div>\n' +
                '</div>');
            let q1_card = temp.find('#q1');
            let title_elem = temp.find('.layui-card-header>span');
            let input_power = temp.find('input[name="q1-power"]');
            let input_title = temp.find('input[name="q1-title"]');
            let del_btn = temp.find('#btn-del-q1');

            let prefix = "q" + index;

            q1_card.attr("id", prefix);
            title_elem.text("问题 " + index);
            input_power.attr("name", prefix + "-power");
            input_title.attr("name", prefix + "-title");
            input_power.val("1");
            del_btn.attr("id", "btn-del-" + prefix);
            del_btn.click(function () {
                temp.remove();
            });
            return temp;
        }

        let question_cnt = 0;
        $("#btn-add-question").click(function () {
            question_cnt += 1;
            let q = gene_ques("" + question_cnt);
            $("#questionnaire-list").append(q);
        });

        $("#btn-add-question").click();
        $("#btn-del-q1").remove();

        function gene_ans(index) {
            let temp = $('\n' +
                '<div class="layui-form-item">\n' +
                '    <label class="layui-form-label">' +
                '       <span>区间1</span>' +
                '       <button type="button" id="btn-del-a1">' +
                '           <i class="layui-icon layui-icon-delete"></i>' +
                '       </button>' +
                '    </label>\n' +
                '    <div class="layui-input-block">\n' +
                '        <div class="layui-inline">\n' +
                '            <label class="layui-form-label">分数区间</label>\n' +
                '            <div class="layui-input-inline" style="width: 100px;">\n' +
                '                <input type="text"\n' +
                '                       name="a1-range-min"\n' +
                '                       placeholder="分数下限(含)"\n' +
                '                       autocomplete="off"\n' +
                '                       lay-verify="is_number"\n' +
                '                       class="layui-input">\n' +
                '            </div>\n' +
                '            <div class="layui-form-mid">到</div>\n' +
                '            <div class="layui-input-inline" style="width: 100px;">\n' +
                '                <input type="text"\n' +
                '                       name="a1-range-max"\n' +
                '                       placeholder="分数上限(含)"\n' +
                '                       autocomplete="off"\n' +
                '                       lay-verify="is_number"\n' +
                '                       class="layui-input">\n' +
                '            </div>\n' +
                '        </div>\n' +
                '        <textarea placeholder="当测评分数在上述结果区间之内时显示"\n' +
                '                  lay-verify="not_empty"\n' +
                '                  name="a1-result"\n' +
                '                  class="layui-textarea"\n' +
                '                  style="margin-top: 0px; margin-bottom: 0px; height: 100px;"></textarea>\n' +
                '    </div>\n' +
                '</div>\n');

            let lbl_title = temp.find('.layui-form-label>span');
            let a1_min = temp.find('input[name=a1-range-min]');
            let a1_max = temp.find('input[name=a1-range-max]');
            let a1_result = temp.find('textarea[name=a1-result]');
            let btn_del_a1 = temp.find('#btn-del-a1');

            let prefix = 'a' + index;

            lbl_title.text('区间 ' + index);
            btn_del_a1.attr('id', 'btn-del-' + prefix);
            a1_min.attr('name', prefix + '-range-min');
            a1_max.attr('name', prefix + '-range-max');
            a1_result.attr('name', prefix + '-result');

            btn_del_a1.click(function () {
                temp.remove();
            });

            return temp;
        }

        let answer_cnt = 0;
        $("#btn-add-answer").click(function () {
            answer_cnt += 1;
            let a = gene_ans("" + answer_cnt);
            $("#answer-list").append(a);
        });
    });
</script>
</body>
</html>
