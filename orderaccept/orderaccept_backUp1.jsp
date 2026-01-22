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
</script>
</head>
<body>
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