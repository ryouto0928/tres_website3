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
  max-width: 500px; 
  height: 250px; /* コンテナの高さを設定 */
  overflow: none; /* スクロールバーを表示 */
}

.test-table {
  width:100%;
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
  height: 100%; /* ボディの高さを設定 */
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
/* ===== ハンバーガーアイコン ===== */
#js-hamburger {
	position: fixed; /* 画面上の決まった位置に固定する */
	top: 1.2%;
	right: 6%;
	font-size: 32px; /* アイコンサイズ */
	line-height: 1; /* 行の高さを1にして余白を最小化する */
	z-index: 200; /*奥行をつける。値が大きいほど前に表示される*/
	user-select: none;  /* テキスト選択（反転）を禁止する */
}

#js-hamburger.active {
	color: #fff; /* activeクラスがついた時（開いた時）の色を白にする */
}
/* ===== 全画面メニュー（オーバーレイ） ===== */
#overlay-menu {
	position: fixed; /* 全画面を覆うように固定する */
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.9); /* 不透明の黒にする */
	z-index: 150;
	display: flex; /* 中のボタンを中央配置するためにFlexboxを使う */
	justify-content: center; /* 左右中央に配置する */
	align-items: center;  /* 上下中央に配置する */
	opacity: 0;  /* 最初は透明にする */
	visibility: hidden;  /* 最初は隠してクリックもできないようにする */
}

#overlay-menu.open {
	opacity: 1; /* openクラスがついたら表示する */
	visibility: visible; /* クリック可能な状態にする */
}

/* 画面中央ボタンをまとめるコンテナ（隙間クリック対策） */
.menu-container {
	display: flex; /* ボタンを並べるためにFlexboxを使う */
	flex-direction: column; /* ボタンを縦に並べる */
	gap: 4vw; /* ボタン同士の隙間を画面幅の4%空ける */
	width: 80%; /* 操作エリアの幅を80%にする */
	margin: auto; /* 中央に寄せる */
	padding: 0; /* 余白をなしにする(画面中央ボタンの左右をクリックできるようにする) */
	box-sizing: border-box; /* パディングを含めたサイズ計算にする */
}

/* 通常 */
.center-link-btn {
	display: block; /* ブロック要素にして幅いっぱいに広げる */
	width: 100%;
	text-align: center; /* 文字を中央にする */
	padding: 6vw 0; /* 上下に画面幅の余白を作る */
	font-size: 5vw; /* 文字サイズを画面幅に比例させる */
	background-color: #007bff; /* 青色の背景にする */
	color: white; /* 文字を白にする */
}

/* ===== 固定ヘッダー ===== */
.fixed-header {
	position: fixed; /* 画面上部に固定する */
	top: 0;
	left: 0;
	width: 100%; /* 横幅いっぱいに広げる */
	height: 60px; 
	background-color: #007bff; /* 青色の背景にする */
	display: flex; /* 中身を横並びにする */
	align-items: center; /* 中身を上下中央にする */
	justify-content: space-between; /* ロゴとメニューを両端に配置する */
	padding: 0 12px; /* 左右に余白を作る */
	z-index: 200; /* 他の要素より前面に表示する */
}

body {
	padding-top: 60px; /* ヘッダーに隠れないよう、ヘッダー分だけ上に余白を作る */
}

/* 左側（ロゴ＋店名） */
.header-left {
	display: flex; /* ロゴと店名を横並びにする */
	align-items: center; /* 上下中央にする */
	gap: 10px; /* ロゴと店名の間に10pxの隙間を作る */
}

.header-left img {
	height: 40px; /* ロゴの高さを40pxにする */

}

.shop-name {
	font-size: 16px; /* 店名の文字サイズを16pxにする */
	font-weight: bold; /* 太文字にする */
	white-space: nowrap; /* 改行させない */
}

/* ===== 曜日ボタン ===== */
/* 曜日ボタンの親要素 */
.weekday-buttons {
	display: flex;          /* 子要素（label）を横並びにする */
	flex-wrap: nowrap;     /* 絶対に折り返さない設定 */
}

.weekday-buttons input[type="checkbox"] {
	display: none; /* 本来のチェックボックスを隠す */
}

/* ボタン風デザイン */
.weekday-buttons label {
	display: inline-block; /* 横に並ぶブロック要素にする */
	padding: 4vw 3.5vw; /* 画面幅に応じた余白を作る */
	margin-right: 6px; /* ボタンの右側に隙間を作る */
	background-color: #007bff; /* 青色の背景にする */
	color: #fff; /* 文字を白にする */
	user-select: none; /* 文字選択を禁止する */
}

/* 押された（checked）状態 → グレーアウト */
.weekday-buttons input[type="checkbox"]:checked+label {
/* チェックボックスにチェックが入った瞬間、そのすぐ後ろにあるラベルの見た目を変える */
/* :checked（疑似クラス）「チェックが入っている状態のときだけ」という条件を追加します。 */
/* + label（隣接兄弟結合子）「その要素のすぐ後ろにある label 要素」をターゲットにします。*/

	background-color: #ccc; /* チェックされた時（オフ状態の演出）背景をグレーにする */
	color: #666; /* 文字を濃いグレーにする */
}

/* ===== 新規・変更・削除ボタン ===== */
.action-btn {
    margin: 10px 4px; /* 上下10px、左右4pxの外側余白を作る */
    padding: 10px 18px; /* 内側に余白を作る */
    background: #aaa; /* グレーの背景にする */
    color: #000; /* 文字を黒にする */
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
//ハンバーガーアイコン
// メニューの開閉
function toggleMenu(event) {
	// イベントが発生している場合、親要素へのイベント伝播（連鎖）を止める
	if (event) event.stopPropagation();

	// ハンバーガーアイコンの要素を取得
	const btn = document.getElementById('js-hamburger');
	// 全画面メニュー（オーバーレイ）の要素を取得
	const menu = document.getElementById('overlay-menu');

	// アイコンに「active」クラスがあれば消し、なければ付ける（CSSでの色変更用）
	btn.classList.toggle('active')
	// メニューに「open」クラスがあれば消し、なければ付ける。その結果（開いたか閉じたか）をisOpenに代入
	const isOpen = menu.classList.toggle('open');
	// メニューが開いたなら「✕」に、閉じたなら「☰」にアイコンの文字を書き換える
	btn.textContent = isOpen ? '✕' : '☰';
}
//背景（黒い部分）クリックで閉じる
function closeMenuByBg(event) {
	// ハンバーガーアイコンの要素を取得
	const btn = document.getElementById('js-hamburger');
	// 全画面メニュー（オーバーレイ）の要素を取得
	const menu = document.getElementById('overlay-menu');
	
	// 「実際にクリックされた場所」が「メニューの背景自体」であるか判定する
	// ※中のボタンをクリックした時には反応させないための処理
	if (event.target === menu) {
		// メニューから「open」クラスを取り除いて非表示にする
		menu.classList.remove('open');
		// アイコンから「active」クラスを取り除く
		btn.classList.remove('active');
		// アイコンの文字を「☰」に戻す
		btn.textContent = '☰';
	}
}
//ボタン同士の隙間でのクリック伝播を止める
function stopProp(event) {
	// イベントが親要素（この場合は背景のcloseMenuByBg）に伝わるのを阻止する
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
  メニュー名:&nbsp;<input style="width: 300px;" type="text" name="menuName" value="${menuReg.menuName}"><br>
  提供曜日:&nbsp;&nbsp;
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