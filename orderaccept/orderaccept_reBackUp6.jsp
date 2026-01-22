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

</style><script type="text/javascript">
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
<c:if test="${not empty orderAccept.message}">
  <ul>
    <c:forEach var="message" items="${orderAccept.message}">
      <li style="color: red;">${message}</li>
    </c:forEach>
  </ul>
</c:if>

<table>
<tr>
&nbsp;&nbsp;
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