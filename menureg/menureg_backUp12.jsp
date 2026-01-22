<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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

body {
	padding-top: 60px; /* ヘッダーの高さ分 */
}

.test-table-container2 {
	width: 500px;
	height: 250px; /* コンテナの高さを設定 */
	overflow: none; /* スクロールバーを表示 */
}

.test-table-container {
	max-width: 100%;
	overflow-x: auto;
}

.test-table {
	/* widthを指定しなことでテーブルの要素の長さに合わせる */
	/*width: 100%;*/
	border-collapse: collapse; /* セルの境界線を重ねる */
}

.test-table2 {
	width: 500px; /* tableは固定幅のまま */
}

.test-table-header {
	display: block; /* ヘッダーをブロック表示 */
	position: sticky;
	top: 0; /* ヘッダーを上部に固定 */
	background-color: #FFF; /* ヘッダーの背景色 */
	z-index: 1; /* スクロールしてもヘッダーが上に表示されるように */
}

.test-table-body {
	display: block; /* ボディをブロック表示 */
	overflow: auto; /* スクロールバーを表示 */
	height: 200px; /* ボディの高さを設定 */
}

.test-table .test-column, .test-table .test-cell {
	padding: 0px 5px; /* セルの内側にスペースを追加 */
	text-align: center; /* テキストを左揃え */
	border: 1px solid #ddd; /* セルの境界線 */
}

.test-table .test-cell {
	display: table-cell; /* セルをテーブルセルとして表示 */
}

/* ===== 新規・変更・削除ボタン ===== */
.action-btn {
    margin: 10px 4px;
    padding: 10px 18px;
    border-radius: 6px;
    border: 1px solid #000;
    background: #aaa;
    color: #000;
    cursor: pointer;
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

// ここからハンバーガーメニュー
    // メニューの開閉
    function toggleMenu(event) {
        if (event) event.stopPropagation();
        const hamburger = document.getElementById('js-hamburger');
        const menu = document.getElementById('overlay-menu');
        
        hamburger.classList.toggle('active');
        menu.classList.toggle('open');
    }

    // リンククリック時の処理
    function submitWithEffect(button, event) {
        event.preventDefault(); // 即送信を止める

        // 色変更
        button.classList.add('clicked');

        // 0.3秒後に form を submit
        setTimeout(() => {
            button.closest('form').submit();
        }, 300);
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

    // ボタン同士の隙間でのクリック伝播を止める
    function stopProp(event) {
        event.stopPropagation();
    }

    // ブラウザの「戻る」ボタン対策（キャッシュ復元時にリセット）

    //ここまでハンバーガーメニュー
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

	
	<div>
		<!-- 処理結果表示  -->
		<c:if test="${not empty menuReg.message}">
			<ul>
				<c:forEach var="message" items="${menuReg.message}">
					<li style="color: red; 　display: flex-block">${message}</li>
				</c:forEach>
			</ul>
		</c:if>
	</div>
	<div class="test-table-container">
		<table>
			<tr>
				<td style="background-color: white;">
					<!-- 対応画面詳細  --> &nbsp;&nbsp;&nbsp;メニュー登録 <br> <img
					style="width: 360px; height: 8px;" src="images/Que.jpg"
					alt="Billiards Cafe Tres">
					<form id="myForm" action="menureg" method="post">
						メニュー名:&nbsp;
						<input style="width: 350px;" type="text" name="menuName"
							value="${menuReg.menuName}">
						<br> 提供曜日:&nbsp;&nbsp;
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
						<br> <br>
				</td>
			</tr>
		</table>
	</div>
	<input type="submit" name="action" value="新規" class="action-btn"
		onclick="confirmAndInsSubmit(); return false;">
	<input type="submit" name="action" value="変更" class="action-btn"
		onclick="confirmAndUpdSubmit(); return false;">
	<input type="submit" name="action" value="削除" class="action-btn"
		onclick="confirmAndDelSubmit(); return false;">
	<input id="action" type="hidden" name="action" value="">
	<br>
	<div class="test-table-container">
		<table class="test-table"
			style="border-collapse: collapse; border: 1px solid #ddd;">
<!--			tableタグで幅をして指定しないことで要素の幅がテーブルの幅になる-->
			<thead class="test-table-header">
				<tr>
					<th class="test-column" style="width: 30px; white-space: nowrap;">選択</th>
					<th class="test-column"
						style="width: 250px; word-break: break-all;">メニュー名</th>
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
						<td class="test-cell" style="width: 30px; white-space: nowrap;"><input
								type="checkbox" name="selectedItems" value="${idAndMenuName}"></td>
						<td class="test-cell"
							style="width: 250px; word-break: break-all; text-align: left;">${item.menuName}</td>
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
</body>
</html>