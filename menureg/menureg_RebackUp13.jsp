<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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

.test-table-container {
  /*width: 500px;*/
  max-width: 100%; /* コンテナの最大幅を親要素に合わせる */
  height: 250px; /* コンテナの高さを設定 */
  overflow: none; /* スクロールバーを表示 */
}

.test-table {
  width:90%;
  border-collapse: collapse; /* セルの境界線を重ねる */
}

.test-table-header {
  display: block; /* ヘッダーをブロック表示 */
  position: sticky; /* スクロール時に位置を固定する */
  top: 0; /* ヘッダーを上部に固定 */
  background-color: #FFF; /* ヘッダーの背景色 */
  z-index: 1; /* スクロールしてもヘッダーが上に表示されるように */
}

.test-table-body {
  display: block; /* ボディをブロック表示 */
  overflow: auto; /* スクロールバーを表示 */
  height: 200px; /* ボディの高さを設定 */
}

.test-table .test-column,
.test-table .test-cell {
  padding: 0px 5px; /* セルの内側にスペースを追加 */
  text-align: center; /* テキストを左揃え */
  border: 1px solid #ddd; /* セルの境界線 */
}

.test-table .test-cell {
  display: table-cell; /* セルをテーブルセルとして表示 */
}
/* ここからハンバーガーメニュー */
/* --- ハンバーガーアイコン --- */
#js-hamburger {
	position: fixed; /* 画面上の決まった位置に固定する */
	top: 1.2%;
	right: 6%;
	font-size: 32px; /* ← サイズ変更はこれだけ */
	line-height: 1; /* 行の高さを1にして余白を最小化する */
	cursor: pointer; /* マウスを乗せた時に指マークにする */
	z-index: 200; /*奥行をつける。値が大きいほど前に表示される*/
	user-select: none;  /* テキスト選択（反転）を禁止する */
}

#js-hamburger.active {
	color: #fff;
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

/* 画面中央ボタンをまとめるコンテナ（隙間クリック対策） */
.menu-container {
	display: flex;
	flex-direction: column;
	gap: 4vw;

	/* ここが重要 */
	width: 80%;          /* ← 中央80%だけ操作エリア */
	max-width: 500px;    /* ← PCでも広がりすぎない */
	margin: auto;

	padding: 0;
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

/* ここから固定用ヘッダー */
/* ===== 固定ヘッダー ===== */
.fixed-header {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 60px;
	background-color: #00f;
	display: flex; /* flex指定でalign-items:とjustify-content: space-between;が効く */
	align-items: center;
	justify-content: space-between;
	padding: 0 12px;
	z-index: 200;
}

body {
	padding-top: 60px; /* ヘッダーの高さ分 */
}

/* 左側（ロゴ＋店名） */
.header-left {
	display: flex; /* flex指定でalign-items:が効く */
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

/* ===== 新規・変更・削除ボタン ===== */
.action-btn {
    margin: 10px 4px;
    padding: 10px 18px;
    border-radius: 6px;
    border: 1px solid #000;
    background: #aaa;
    color: #000;
}

</style>
<script type="text/javascript">
//送信確認を行うJavaScript関数
function confirmAndInsSubmit() {
    // confirm()メソッドは、OKがクリックされると true、キャンセルなら false を返す
    var isConfirmed = confirm("メニューを登録します、よろしいですか？");

    if (isConfirmed) {
    	document.getElementById('action').value = "新規";
        // OKがクリックされた場合、フォームを送信する
        // document.getElementById('myForm') でフォーム要素を取得し、submit() を実行
        document.getElementById('myForm').submit();
    } else {
        // キャンセルがクリックされた場合、何もしない（フォーム送信は行われない）
        //alert("キャンセルされました");
    }
}// 送信確認を行うJavaScript関数
function confirmAndUpdSubmit() {
    // confirm()メソッドは、OKがクリックされると true、キャンセルなら false を返す
    var isConfirmed = confirm("選択されたメニューを変更します、よろしいですか？");

    if (isConfirmed) {
    	document.getElementById('action').value = "変更";
        // OKがクリックされた場合、フォームを送信する
        // document.getElementById('myForm') でフォーム要素を取得し、submit() を実行
        document.getElementById('myForm').submit();
    } else {
        // キャンセルがクリックされた場合、何もしない（フォーム送信は行われない）
        //alert("キャンセルされました");
    }
}
//送信確認を行うJavaScript関数
function confirmAndDelSubmit() {
    // confirm()メソッドは、OKがクリックされると true、キャンセルなら false を返す
    var isConfirmed = confirm("選択されたメニューを削除します、よろしいですか？");

    if (isConfirmed) {
    	document.getElementById('action').value = "削除";
        // OKがクリックされた場合、フォームを送信する
        // document.getElementById('myForm') でフォーム要素を取得し、submit() を実行
        document.getElementById('myForm').submit();
    } else {
        // キャンセルがクリックされた場合、何もしない（フォーム送信は行われない）
        //alert("キャンセルされました");
    }
}
//ここからハンバーガーメニュー
// メニューの開閉
function toggleMenu(event) {
	if (event)
		event.stopPropagation();

	const btn = document.getElementById('js-hamburger');
	const menu = document.getElementById('overlay-menu');

	btn.classList.toggle('active')
	const isOpen = menu.classList.toggle('open');
	btn.textContent = isOpen ? '✕' : '☰';
}
// 背景（黒い部分）クリックで閉じる
function closeMenuByBg(event) {
	const btn = document.getElementById('js-hamburger');
	const menu = document.getElementById('overlay-menu');
	// クリックされたのがメニュー自体（背景）なら閉じ、✕から☰に切り替える
	if (event.target === menu) {
		menu.classList.remove('open');
		btn.classList.remove('active');
		btn.textContent = '☰';
	}
}
// ボタン同士の隙間でのクリック伝播を止める
function stopProp(event) {
	event.stopPropagation();
}
</script>
</head>
<body>
<!-- ハンバーガーアイコン -->
<!-- 固定ヘッダー -->
<header class="fixed-header">
	<div class="header-left">
		<img src="images/Tres.jpg" alt="Billiards Cafe Tres"> <span
			class="shop-name">ビリヤード カフェ トレス</span>
	</div>
	<!-- ハンバーガーアイコン -->
	<div id="js-hamburger" onclick="toggleMenu(event)">☰</div>
</header>
<!-- 全画面オーバーレイ -->
<nav id="overlay-menu" onclick="closeMenuByBg(event)">
	<div class="menu-container" onclick="stopProp(event)">
		<form action="/AcsTresOrder/orderaccept" method="post">
			<button type="submit" class="center-link-btn">
				注文
			</button>
		</form>
		<form action="/AcsTresOrder/orderconfirm" method="post">
			<button type="submit" class="center-link-btn">
				注文確認
			</button>
		</form>
		<form action="/AcsTresOrder/menureg" method="post">
			<button type="submit" class="center-link-btn">
				メニュー登録
			</button>
		</form>
		<form action="/AcsTresOrder/staffreg" method="post">
			<button type="submit" class="center-link-btn">
				通知先登録
			</button>
		</form>
	</div>
</nav>
<!-- 処理結果表示  -->
<c:if test="${not empty menuReg.message}">
  <ul>
    <c:forEach var="message" items="${menuReg.message}">
      <li style="color: red;">${message}</li>
    </c:forEach>
  </ul>
</c:if>

<table>
<tr>
<td>
&nbsp;&nbsp;
</td>
<td style="background-color: white;">
<!-- 対応画面詳細  -->
&nbsp;&nbsp;&nbsp;メニュー登録
<br>
<img style="width: 360px; height: 8px;" src="images/Que.jpg" alt="Billiards Cafe Tres">
<form id="myForm" action="menureg" method="post">
  メニュー名:&nbsp;<input style="width: 350px;" type="text" name="menuName" value="${menuReg.menuName}"><br>
  条件:&nbsp;&nbsp;
<div class="weekday-buttons">
	<input type="checkbox" id="mon" name="selectedWeekDays"
		value="monday"
		<c:if test="${menuReg.monday == '1'}">checked</c:if>>
		<label for="mon">月</label>
	<input type="checkbox" id="tue" name="selectedWeekDays"
		value="tuesday"
		<c:if test="${menuReg.tuesday == '1'}">checked</c:if>>
		<label for="tue">火</label>
	<input type="checkbox" id="wed" name="selectedWeekDays"
		value="wednesday"
		<c:if test="${menuReg.wednesday == '1'}">checked</c:if>>
		<label for="wed">水</label>
	<input type="checkbox" id="thu" name="selectedWeekDays"
		value="thursday"
		<c:if test="${menuReg.thursday == '1'}">checked</c:if>>
		<label for="thu">木</label>
	<input type="checkbox" id="fri" name="selectedWeekDays"
		value="friday"
		<c:if test="${menuReg.friday == '1'}">checked</c:if>>
		<label for="fri">金</label>
	<input type="checkbox" id="sat" name="selectedWeekDays"
		value="saturday"
		<c:if test="${menuReg.saturday == '1'}">checked</c:if>>
		<label for="sat">土</label>
	<input type="checkbox" id="sun" name="selectedWeekDays"
		value="sunday"
		<c:if test="${menuReg.sunday == '1'}">checked</c:if>>
		<label for="sun">日</label>
</div>
  <br><br> 
  <input class="action-btn" type="submit" name="action" value="新規" onclick="confirmAndInsSubmit(); return false;">
  <input class="action-btn" type="submit" name="action" value="変更" onclick="confirmAndUpdSubmit(); return false;">
  <input class="action-btn" type="submit" name="action" value="削除" onclick="confirmAndDelSubmit(); return false;">
  <input id="action" type="hidden" name="action" value="">
  <br>
  <div class="test-table-container">
　　<table class="test-table" style="border-collapse: collapse;border: 1px solid #ddd;">
　　　　<thead class="test-table-header">
    　　<tr>
      　　<th class="test-column" style="width: 30px;white-space: nowrap;">選択</th>
      　　<th class="test-column" style="width: 250px;word-break: break-all;">メニュー名</th>
      　　<th class="test-column" style="width: 8px;">月</th>
      　　<th class="test-column" style="width: 8px;">火</th>
      　　<th class="test-column" style="width: 8px;">水</th>
      　　<th class="test-column" style="width: 8px;">木</th>
      　　<th class="test-column" style="width: 8px;">金</th>
      　　<th class="test-column" style="width: 8px;">土</th>
      　　<th class="test-column" style="width: 8px;">日</th>
    　　</tr>
    </thead>
    <tbody class="test-table-body" style="border: 1px solid #ddd;">
  　　<c:forEach var="item" items="${menuReg.menuInfoList}">
      <%-- 「メニューID」と「メニュー名」を結合しておくことで、変更時に利用する --%>
      <c:set var="idAndMenuName" value="${item.id}-${item.menuName}" />  
      <tr>
        <td class="test-cell" style="width: 30px;white-space: nowrap;"><input type="checkbox" name="selectedItems" value="${idAndMenuName}"></td>
        <td class="test-cell" style="width: 250px;word-break: break-all;text-align: left;">${item.menuName}</td>
        <td class="test-cell" style="width: 8px;">${item.mondaySelected}</td>
        <td class="test-cell" style="width: 8px;">${item.tuesdaySelected}</td>
        <td class="test-cell" style="width: 8px;">${item.wednesdaySelected}</td>
        <td class="test-cell" style="width: 8px;">${item.thursdaySelected}</td>
        <td class="test-cell" style="width: 8px;">${item.fridaySelected}</td>
        <td class="test-cell" style="width: 8px;">${item.saturdaySelected}</td>
        <td class="test-cell" style="width: 8px;">${item.sundaySelected}</td>
      </tr>
  　　</c:forEach>
    </tbody>
  </table>
  </div>
</form>
</td>
</tr>
</table>
</body>
</html>