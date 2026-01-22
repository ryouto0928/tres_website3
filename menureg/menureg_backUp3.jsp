<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${applicationScope.appProperties['app.title']}</title>

<style>
/* ===== 共通 ===== */
body {
    margin: 0;
    font-family: sans-serif;
    background-color: #fafafa;
}

/* ===== コンテンツ ===== */
.main-container {
    padding: 16px;
}

/* ===== タイトル ===== */
.page-title {
    font-size: 20px;
    font-weight: bold;
    margin: 12px 0;
}

/* ===== メッセージ ===== */
.message-area li {
    color: red;
}

/* ===== フォーム ===== */
.form-group {
    margin-bottom: 12px;
}

.form-group label {
    display: block;
    font-weight: bold;
    margin-bottom: 4px;
}

.form-group input[type="text"] {
    width: 100%;
    padding: 10px;
    font-size: 16px;
}

/* 曜日チェック */
.weekdays {
    display: flex;
    flex-wrap: wrap;
    gap: 8px;
    font-size: 14px;
}

/* ===== ボタン ===== */
.action-buttons {
    display: flex;
    flex-direction: column;
    gap: 10px;
    margin: 16px 0;
}

.action-buttons input[type="submit"] {
    padding: 14px;
    font-size: 16px;
    font-weight: bold;
}

/* ===== メニュー一覧（カード） ===== */
.menu-list {
    display: flex;
    flex-direction: column;
    gap: 12px;
}

.menu-card {
    border: 1px solid #ccc;
    border-radius: 8px;
    padding: 12px;
    background-color: #fff;
}

.menu-card-header {
    display: flex;
    align-items: center;
    gap: 8px;
}

.menu-name {
    font-size: 16px;
    font-weight: bold;
}

.week-icons {
    margin-top: 8px;
    font-size: 12px;
    display: flex;
    gap: 6px;
}

/* ===== ハンバーガーメニュー ===== */
.menu-trigger {
    display: inline-block;
    width: 18vw;
    height: 15vw;
    cursor: pointer;
    position: fixed;
    top: 6%;
    right: 6%;
    z-index: 100;
}

.menu-trigger span {
    display: inline-block;
    width: 100%;
    height: 2.4vw;
    background-color: #333;
    position: absolute;
    transition: all .4s;
    border-radius: 1vw;
}

.menu-trigger span:nth-of-type(1) { top: 0; }
.menu-trigger span:nth-of-type(2) { top: calc(50% - 1.2vw); }
.menu-trigger span:nth-of-type(3) { bottom: 0; }

.menu-trigger.active span {
    background-color: #fff;
}

.menu-trigger.active span:nth-of-type(1) {
    transform: translateY(6.3vw) rotate(-45deg);
}
.menu-trigger.active span:nth-of-type(2) {
    opacity: 0;
}
.menu-trigger.active span:nth-of-type(3) {
    transform: translateY(-6.3vw) rotate(45deg);
}

#overlay-menu {
    position: fixed;
    inset: 0;
    background-color: rgba(0,0,0,0.9);
    display: flex;
    justify-content: center;
    align-items: center;
    opacity: 0;
    visibility: hidden;
    transition: .3s;
}

#overlay-menu.open {
    opacity: 1;
    visibility: visible;
}

.menu-container {
    width: 100%;
    padding: 0 8%;
    display: flex;
    flex-direction: column;
    gap: 16px;
}

.center-link-btn {
    padding: 6vw 0;
    font-size: 5vw;
    text-align: center;
    background-color: #007bff;
    color: #fff;
    border-radius: 2vw;
    text-decoration: none;
    font-weight: bold;
}
</style>

<script>
function confirmAndInsSubmit() {
    if (confirm("メニューを登録します、よろしいですか？")) {
        document.getElementById("action").value = "新規";
        document.getElementById("myForm").submit();
    }
}
function confirmAndUpdSubmit() {
    if (confirm("選択されたメニューを変更します、よろしいですか？")) {
        document.getElementById("action").value = "変更";
        document.getElementById("myForm").submit();
    }
}
function confirmAndDelSubmit() {
    if (confirm("選択されたメニューを削除します、よろしいですか？")) {
        document.getElementById("action").value = "削除";
        document.getElementById("myForm").submit();
    }
}

function toggleMenu(e) {
    e.stopPropagation();
    document.getElementById("js-hamburger").classList.toggle("active");
    document.getElementById("overlay-menu").classList.toggle("open");
}
function closeMenuByBg(e) {
    if (e.target.id === "overlay-menu") {
        document.getElementById("js-hamburger").classList.remove("active");
        document.getElementById("overlay-menu").classList.remove("open");
    }
}
</script>

</head>

<body>

<div class="menu-trigger" id="js-hamburger" onclick="toggleMenu(event)">
    <span></span><span></span><span></span>
</div>

<nav id="overlay-menu" onclick="closeMenuByBg(event)">
    <div class="menu-container">
        <a href="page1.jsp" class="center-link-btn">マイページ</a>
        <a href="page2.jsp" class="center-link-btn">お知らせ</a>
        <a href="page3.jsp" class="center-link-btn">設定</a>
        <a href="page4.jsp" class="center-link-btn">ログアウト</a>
    </div>
</nav>

<div class="main-container">

    <img src="images/Tres.jpg" style="width:120px;">
    <div>カフェ＆バー トレス</div>

    <c:if test="${not empty menuReg.message}">
        <ul class="message-area">
            <c:forEach var="message" items="${menuReg.message}">
                <li>${message}</li>
            </c:forEach>
        </ul>
    </c:if>

    <div class="page-title">メニュー登録</div>

    <form id="myForm" action="menureg" method="post">

        <div class="form-group">
            <label>メニュー名</label>
            <input type="text" name="menuName" value="${menuReg.menuName}">
        </div>

        <div class="form-group">
            <label>提供曜日</label>
            <div class="weekdays">
                <label><input type="checkbox" name="selectedWeekDays" value="monday" <c:if test="${menuReg.monday=='1'}">checked</c:if>>月</label>
                <label><input type="checkbox" name="selectedWeekDays" value="tuesday" <c:if test="${menuReg.tuesday=='1'}">checked</c:if>>火</label>
                <label><input type="checkbox" name="selectedWeekDays" value="wednesday" <c:if test="${menuReg.wednesday=='1'}">checked</c:if>>水</label>
                <label><input type="checkbox" name="selectedWeekDays" value="thursday" <c:if test="${menuReg.thursday=='1'}">checked</c:if>>木</label>
                <label><input type="checkbox" name="selectedWeekDays" value="friday" <c:if test="${menuReg.friday=='1'}">checked</c:if>>金</label>
                <label><input type="checkbox" name="selectedWeekDays" value="saturday" <c:if test="${menuReg.saturday=='1'}">checked</c:if>>土</label>
                <label><input type="checkbox" name="selectedWeekDays" value="sunday" <c:if test="${menuReg.sunday=='1'}">checked</c:if>>日</label>
            </div>
        </div>

        <div class="action-buttons">
            <input type="submit" value="新規" onclick="confirmAndInsSubmit();return false;">
            <input type="submit" value="変更" onclick="confirmAndUpdSubmit();return false;">
            <input type="submit" value="削除" onclick="confirmAndDelSubmit();return false;">
        </div>

        <input type="hidden" id="action" name="action">

        <div class="menu-list">
            <c:forEach var="item" items="${menuReg.menuInfoList}">
                <c:set var="idAndMenuName" value="${item.id}-${item.menuName}" />
                <div class="menu-card">
                    <div class="menu-card-header">
                        <input type="checkbox" name="selectedItems" value="${idAndMenuName}">
                        <div class="menu-name">${item.menuName}</div>
                    </div>
                    <div class="week-icons">
                        月:${item.mondaySelected}
                        火:${item.tuesdaySelected}
                        水:${item.wednesdaySelected}
                        木:${item.thursdaySelected}
                        金:${item.fridaySelected}
                        土:${item.saturdaySelected}
                        日:${item.sundaySelected}
                    </div>
                </div>
            </c:forEach>
        </div>

    </form>
</div>

</body>
</html>
