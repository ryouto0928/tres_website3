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
	width: 100%;
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

/* ここからハンバーガーメニュー */

/* --- ハンバーガーアイコン（サイズ・位置：相対指定） --- */
.menu-trigger {
    position: relative;   /* ← fixed をやめる */
    width: 32px;
    height: 24px;
    cursor: pointer;
    z-index: 300;
}

/* span のサイズは px にした方がヘッダー向き */
.menu-trigger span {
    height: 3px;
    border-radius: 2px;
}

/* 理論値計算に基づいた三本線の配置 */
.menu-trigger span:nth-of-type(1) {
	top: 0;
}
/* 2本目：50%の位置から太さ(2.4vw)の半分である1.2vwを引いて中央配置 */
.menu-trigger span:nth-of-type(2) {
	top: calc(50% - 1.2vw);
}

.menu-trigger span:nth-of-type(3) {
	bottom: 0;
}

/* アクティブ時（×印）：計算式 (H - T) / 2 = (15 - 2.4) / 2 = 6.3vw */
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

/* --- ボタンのデザイン（スマホ横幅いっぱい・大型化） --- */
.center-link-btn {
	display: block;
	width: 100%;
	text-align: center;
	padding: 6vw 0; /* 縦方向の幅を大きく */
	font-size: 5vw; /* 文字サイズを画面幅に連動 */
	font-weight: bold;
	background-color: #007bff;
	color: white;
	text-decoration: none;
	border-radius: 2vw;
	box-shadow: 0 1vw 2.5vw rgba(0, 0, 0, 0.3);
	transition: all 0.2s;
	box-sizing: border-box;
}

/* クリック時のフィードバック */
.center-link-btn.clicked {
	background-color: #ffc107 !important; /* オレンジに変更 */
	color: #333 !important;
	transform: scale(0.95);
}

/* ホバー演出（スマホでは主にタップ時） */
.center-link-btn:active {
	opacity: 0.8;
}

/* 曜日ボタン用 */

/* チェックボックスは非表示 */
.weekday-buttons input[type="checkbox"] {
    display: none;
}

/* ボタン風デザイン */
.weekday-buttons label {
    display: inline-block;
    padding: 8px 14px;
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
.weekday-buttons input[type="checkbox"]:checked + label {
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
    background-color: #fff;
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 0 12px;
    box-shadow: 0 2px 6px rgba(0,0,0,0.15);
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
    function handleLinkClick(element, event) {
        // 標準の遷移を止める
        if (event) event.preventDefault();
        
        // 色変更のクラス追加
        element.classList.add('clicked');
        
        const targetUrl = element.getAttribute('href');
        
        // 0.3秒後に遷移
        setTimeout(() => {
            window.location.href = targetUrl;
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
    window.addEventListener('pageshow', (event) => {
        if (event.persisted) {
            const links = document.querySelectorAll('.center-link-btn');
            links.forEach(link => link.classList.remove('clicked'));
            
            // script内のコメントアウトは // を使用してください
            //document.getElementById('js-hamburger').classList.remove('active');
            //document.getElementById('overlay-menu').classList.remove('open');
        }
    });
    //ここまでハンバーガーメニュー
</script>
</head>
<body>

	<!-- ハンバーガーアイコン -->
	<!-- 固定ヘッダー -->
<header class="fixed-header">

    <div class="header-left">
        <img src="images/Tres.jpg" alt="Billiards Cafe Tres">
        <span class="shop-name">ビリヤード　カフェ　トレス</span>
    </div>

    <!-- ハンバーガーアイコン -->
    <div class="menu-trigger" id="js-hamburger" onclick="toggleMenu(event)">
        <span></span>
        <span></span>
        <span></span>
    </div>

</header>
	
	<!-- 全画面オーバーレイ -->
	<nav id="overlay-menu" onclick="closeMenuByBg(event)">
		<div class="menu-container" id="js-menu-container"
			onclick="stopProp(event)">
			<a href="page1.jsp" class="center-link-btn"
				onclick="handleLinkClick(this, event)">マイページ</a> <a href="page2.jsp"
				class="center-link-btn" onclick="handleLinkClick(this, event)">お知らせ</a>
			<a href="page3.jsp" class="center-link-btn"
				onclick="handleLinkClick(this, event)">設定</a> <a href="page4.jsp"
				class="center-link-btn" onclick="handleLinkClick(this, event)">ログアウト</a>
		</div>
	</nav>


<div>
	<!-- 処理結果表示  -->
	<c:if test="${not empty menuReg.message}">
		<ul>
			<c:forEach var="message" items="${menuReg.message}">
				<li style="color: red;　display: flex-block">${message}</li>
			</c:forEach>
		</ul>
	</c:if>
</div>



	<table>
		<tr>
			<td
				style="background-color: blue; white-space: nowrap; vertical-align: top;">
				<!-- メニュー  --> <%@ include file="/WEB-INF/views/menu.jsp"%>
			</td>
		</tr>

		<tr>

			<td style="background-color: white;">
				<!-- 対応画面詳細  --> &nbsp;&nbsp;&nbsp;メニュー登録 <br> <img
				style="width: 400px; height: 8px;" src="images/Que.jpg"
				alt="Billiards Cafe Tres">
				<form id="myForm" action="menureg" method="post">
					メニュー名:&nbsp;<input style="width: 300px;" type="text"
						name="menuName" value="${menuReg.menuName}"><br>
					条件:&nbsp;&nbsp;

					<div class="weekday-buttons">
					
					    <input type="checkbox" id="mon" name="selectedWeekDays" value="monday"
					        <c:if test="${menuReg.monday == '1'}">checked</c:if>>
					    <label for="mon">月</label>
					
					    <input type="checkbox" id="tue" name="selectedWeekDays" value="tuesday"
					        <c:if test="${menuReg.tuesday == '1'}">checked</c:if>>
					    <label for="tue">火</label>
					
					    <input type="checkbox" id="wed" name="selectedWeekDays" value="wednesday"
					        <c:if test="${menuReg.wednesday == '1'}">checked</c:if>>
					    <label for="wed">水</label>
					
					    <input type="checkbox" id="thu" name="selectedWeekDays" value="thursday"
					        <c:if test="${menuReg.thursday == '1'}">checked</c:if>>
					    <label for="thu">木</label>
					
					    <input type="checkbox" id="fri" name="selectedWeekDays" value="friday"
					        <c:if test="${menuReg.friday == '1'}">checked</c:if>>
					    <label for="fri">金</label>
					
					    <input type="checkbox" id="sat" name="selectedWeekDays" value="saturday"
					        <c:if test="${menuReg.saturday == '1'}">checked</c:if>>
					    <label for="sat">土</label>
					
					    <input type="checkbox" id="sun" name="selectedWeekDays" value="sunday"
					        <c:if test="${menuReg.sunday == '1'}">checked</c:if>>
					    <label for="sun">日</label>
					
					</div>
					
					<br><br>
										
					 <input type="submit" name="action" value="新規"
						onclick="confirmAndInsSubmit(); return false;"> <input
						type="submit" name="action" value="変更"
						onclick="confirmAndUpdSubmit(); return false;"> <input
						type="submit" name="action" value="削除"
						onclick="confirmAndDelSubmit(); return false;"> <input
						id="action" type="hidden" name="action" value=""> <br>
					<div class="test-table-container">
						<table class="test-table"
							style="border-collapse: collapse; border: 1px solid #ddd;">
							<thead class="test-table-header">
								<tr>
									<th class="test-column"
										style="width: 30px; white-space: nowrap;">選択</th>
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
										<td class="test-cell"
											style="width: 30px; white-space: nowrap;"><input
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
	</table>
</body>
</html>