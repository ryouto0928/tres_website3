<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="theme-color" content="#0000FF">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${applicationScope.appProperties['app.title']}</title>
<style type="text/css">
/* スマートフォン向けのスタイル (例: 画面幅が600px以下の場合) */
@media screen and (max-width: 600px) {
    .container {
        /* スタイルを調整 */
        width: 100%;
        /* ... */
    }
    /* 横並びの要素を縦積みに変更するなど */
    .sidebar {
        display: none; /* 例: サイドバーを非表示にする */
    }
}

　　#table1 {
    border-collapse: collapse;
    border: 1px solid #ccc;
  }
  
  #table1 td.center-cell {
    text-align: center;
  }
  
  td, th {
  padding: 3px;
  }
  
  /* ここからハンバーガーメニュー */
/* --- ハンバーガーアイコン（サイズ・位置：相対指定） --- */
.menu-trigger {
	display: inline-block;
	width: 9vw; /* 幅 W = 18vw */
	height: 7.5vw; /* 高さ H = 15vw */
	cursor: pointer;
	position: fixed;
	top: 2.5%; /* 画面上端から3% */
	right: 5%; /* 画面右端から5% */
	z-index: 100;
}

.menu-trigger span {
	display: inline-block;
	width: 100%;
	height: 1.2vw; /* 太さ T = 2.4vw */
	background-color: #333;
	position: absolute;
	transition: all .4s;
	border-radius: 1vw;
}

/* 理論値計算に基づいた三本線の配置 */
.menu-trigger span:nth-of-type(1) {
	top: 0;
}
/* 2本目：50%の位置から太さ(2.4vw)の半分である1.2vwを引いて中央配置 */
.menu-trigger span:nth-of-type(2) {
	top: calc(50% - 0.6vw);
}

.menu-trigger span:nth-of-type(3) {
	bottom: 0;
}

/* アクティブ時（×印）：計算式 (H - T) / 2 = (15 - 2.4) / 2 = 6.3vw */
.menu-trigger.active span {
	background-color: #fff;
}

.menu-trigger.active span:nth-of-type(1) {
	transform: translateY(3.15vw) rotate(-45deg);
}

.menu-trigger.active span:nth-of-type(2) {
	opacity: 0;
}

.menu-trigger.active span:nth-of-type(3) {
	transform: translateY(-3.15vw) rotate(45deg);
}

/* --- 全画面メニュー（オーバーレイ） --- */
#overlay-menu {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.9);
	z-index: 150;
	display: flex;
	justify-content: center;
	align-items: center;
	opacity: 0;
	visibility: hidden;
	transition: opacity 0.3s, visibility 0.3s;
}

#overlay-menu.open {
	opacity: 1;
	visibility: visible;
}

/* ボタンをまとめるコンテナ（隙間クリック対策） */
.menu-container {
	display: flex;
	flex-direction: column;
	gap: 4vw; /* ボタン間の隙間（相対指定） */
	width: 100%;
	padding: 0 8%; /* 左右に8%の余白 */
	box-sizing: border-box;
}

/* 通常 */
.center-link-btn {
    display: block;
    width: 100%;
    text-align: center;
    padding: 6vw 0;
    font-size: 5vw;
    font-weight: bold;
    background-color: #007bff;
    color: white;
    border: none;
    border-radius: 2vw;
    cursor: pointer;
    box-shadow: 0 1vw 2.5vw rgba(0, 0, 0, 0.3);
    transition: all 0.2s;
}

/* 押した後の色 */
.center-link-btn.clicked {
    background-color: #ffc107;
    color: #333;
    transform: scale(0.95);
}

/* タップ中（保険） */
.center-link-btn:active {
    opacity: 0.85;
}


/* 曜日ボタン用 */
/* チェックボックスは非表示 */
.weekday-buttons input[type="checkbox"] {
	display: none;
}

/* ボタン風デザイン */
.weekday-buttons label {
	display: inline-block;
	padding: 4vw 3.5vw;
	margin-right: 6px;
	border-radius: 6px;
	background-color: #007bff;
	color: #fff;
	font-weight: bold;
	cursor: pointer;
	user-select: none;
	transition: all 0.2s;
}

/* 押された（checked）状態 → グレーアウト */
.weekday-buttons input[type="checkbox"]:checked+label {
	background-color: #ccc;
	color: #666;
}

/* タップ時の視覚効果 */
.weekday-buttons label:active {
	transform: scale(0.95);
}

/* ここから固定用ヘッダー */
/* ===== 固定ヘッダー ===== */
.fixed-header {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 60px;
	background-color: #00f;
	display: flex;
	align-items: center;
	justify-content: space-between;
	padding: 0 12px;
	z-index: 200;
}

/* 左側（ロゴ＋店名） */
.header-left {
	display: flex;
	align-items: center;
	gap: 10px;
}

.header-left img {
	height: 40px;
	width: auto;
}

.shop-name {
	font-size: 16px;
	font-weight: bold;
	white-space: nowrap;
}

body {
	padding-top: 60px; /* ヘッダーの高さ分 */
}
</style>
<script type="text/javascript">
    // 送信確認を行うJavaScript関数
    function confirmAndSubmit() {
        // confirm()メソッドは、OKがクリックされると true、キャンセルなら false を返す
        var isConfirmed = confirm("注文を登録します、よろしいですか？");

        if (isConfirmed) {
        	document.getElementById('action').value = "決定";
            // OKがクリックされた場合、フォームを送信する
            // document.getElementById('myForm') でフォーム要素を取得し、submit() を実行
            document.getElementById('myForm').submit();
        } else {
            // キャンセルがクリックされた場合、何もしない（フォーム送信は行われない）
            //alert("キャンセルされました");
        }
    }
    // 指定された年月日のメニューを検索後に選択コンボBOXに表示するJavaScript関数
    function submitForSearch() {
        	document.getElementById('action').value = "メニュー検索";
            // document.getElementById('myForm') でフォーム要素を取得し、submit() を実行
            document.getElementById('myForm').submit();
    }
 	// ここからハンバーガーメニュー
    // メニューの開閉
    function toggleMenu(event) {
        if (event) event.stopPropagation();
        const hamburger = document.getElementById('js-hamburger');
        const menu = document.getElementById('overlay-menu');
        
        hamburger.classList.toggle('active');
        menu.classList.toggle('open');
    }
    // 背景（黒い部分）クリックで閉じる
    function closeMenuByBg(event) {
        const menu = document.getElementById('overlay-menu');
        // クリックされたのがメニュー自体（背景）なら閉じる
        if (event.target === menu) {
            const hamburger = document.getElementById('js-hamburger');
            hamburger.classList.remove('active');
            menu.classList.remove('open');
        }
    }
</script>
</head>
<body>
	<!-- ハンバーガーアイコン -->
	<!-- 固定ヘッダー -->
	<header class="fixed-header">
		<div class="header-left">
			<img src="images/Tres.jpg" alt="Billiards Cafe Tres"> 
			<span class="shop-name">ビリヤード カフェ トレス</span>
		</div>
		<!-- ハンバーガーアイコン -->
		<div class="menu-trigger" id="js-hamburger"
			onclick="toggleMenu(event)">
			<span></span> <span></span> <span></span>
		</div>
	</header>
	<!-- 全画面オーバーレイ -->
	
<nav id="overlay-menu" onclick="closeMenuByBg(event)">
    <div class="menu-container" onclick="stopProp(event)">

        <form action="/AcsTresOrder/orderaccept" method="post">
            <button type="submit"
                class="center-link-btn"
                onclick="submitWithEffect(this, event)">
                注文
            </button>
        </form>

        <form action="/AcsTresOrder/orderconfirm" method="post">
            <button type="submit"
                class="center-link-btn"
                onclick="submitWithEffect(this, event)">
                注文確認
            </button>
        </form>

        <form action="/AcsTresOrder/menureg" method="post">
            <button type="submit"
                class="center-link-btn"
                onclick="submitWithEffect(this, event)">
                メニュー登録
            </button>
        </form>

        <form action="/AcsTresOrder/staffreg" method="post">
            <button type="submit"
                class="center-link-btn"
                onclick="submitWithEffect(this, event)">
                通知先登録
            </button>
        </form>

    </div>
</nav>

<!-- 処理結果表示  -->
<c:if test="${not empty orderAccept.message}">
  <ul>
    <c:forEach var="message" items="${orderAccept.message}">
      <li style="color: red;">${message}</li>
    </c:forEach>
  </ul>
</c:if>

<table>
<tr>
<td style="background-color: blue;white-space: nowrap;vertical-align: top;">
<!-- メニュー  -->
<%@ include file="/WEB-INF/views/menu.jsp" %>
</td>
<td>
</tr>
<tr>
&nbsp;&nbsp;
</td>
<td style="background-color: white;">
<!-- 対応画面詳細  -->
&nbsp;&nbsp;&nbsp;注文
<br>
<img style="width: 300px; height: 8px;" src="images/Que.jpg" alt="Billiards Cafe Tres">
<form id="myForm" action="orderaccept" method="post">
  日付:&nbsp;<input size="4" type="text" name="year" value="${orderAccept.year}">年&nbsp;
           <input size="2" type="text" name="month" value="${orderAccept.month}">月&nbsp;
           <input size="2" type="text" name="day" value="${orderAccept.day}">日<br>
  名前:&nbsp;<input size="15" type="text" name="name" value="${orderAccept.name}"><br>
  注文メニュー:&nbsp;
　　<select name="selectedOrderName">
  　　<c:forEach var="option" items="${orderAccept.orderMenuList}">
      <c:if test="${orderAccept.selectedId == option.value}">
  　　　　 <option value="${option.value}" selected>${option.label}</option>
      </c:if>
      <c:if test="${orderAccept.selectedId != option.value}">
  　　　　 <option value="${option.value}">${option.label}</option>
      </c:if>
  　　</c:forEach>
  </select>
  <br><br>
  <input type="button" name="action" value="決定" onclick="confirmAndSubmit(); return false;">
  <input type="button" name="action" value="メニュー検索" onclick="submitForSearch()">
  <input id="action" type="hidden" name="action" value="">
  <!-- hidden -->
  <%-- 注文確認画面から変更ボタンを選択された時に設定して画面遷移する.--%>
  <input type="hidden" name="updateFl" value="${orderAccept.updateFl}">
  <input type="hidden" name="orderId" value="${orderAccept.orderId}">
</form>
</td>
</tr>
</table>
</body>
</html>