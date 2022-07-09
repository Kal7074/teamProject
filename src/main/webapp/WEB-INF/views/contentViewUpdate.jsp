<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% 
	  String userID = (String)session.getAttribute("userID"); 
	  String userPassword = (String)session.getAttribute("userPassword");
	  boolean login = userID != null ? true : false;
%> <!-- 세션에 저장된 로그인 정보 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MY TRIP</title>
<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>


<style type="text/css">
	body {
	    margin: 0;
		padding: 0;
	    height: 100%;
	}
	
	.board_title {	
		font-weight : 700;	
		font-size : 22pt;	
		margin : 10pt;
	}
	.board_info_box {
		color : #6B6B6B;	
		margin : 10pt;
	}
	.board_author {	
		font-size : 10pt;	
		margin-right : 10pt;
	}
	.board_date {	
		font-size : 10pt;
	}
	.board_content {	
		color : #444343;	
		font-size : 12pt;	
		margin : 10pt;
	}
	.board_tag {	
		font-size : 11pt;	
		margin : 10pt;	
		padding-bottom : 10pt;
	}
	
	.text {
		
		    display: flex;
		    justify-content: center;
		    align-items: center;
		    height: 100%;
		    font-family: 'Roboto', Arial, sans-serif;
		    font-size: 40px;
		    font-weight: bold;
		    line-height: 1.2;
		    letter-spacing: 0.05em;
		    white-space: nowrap;
		    text-transform: uppercase;
		    color: #fff;
		    background-color: #000;
		    mix-blend-mode: multiply;
		    opacity: 0;
		    animation: fadeInText 3s 2s ease-out forwards;
		
		}
		@keyframes scaleImage {
		    100% {
		        transform: scale(1);
		    }
		}
		@keyframes fadeInText {
		    100% {
		        opacity: 1;
		    }
		}
</style>

<script type="text/javascript">
	function reservation() {
		let idx = document.getElementById('idx').value; // 콘텐츠 번호
		let userID = '<c:out value="${co.userID}"/>'; //콘텐츠 소유자
		let resID = '<%=(String)session.getAttribute("userID")%>'; //콘텐츠 신청자
		let subject = '<c:out value="${co.subject}"/>' //콘텐츠 제목
		console.log(idx)
		console.log(resID)
		console.log(userID)
		console.log(subject)
		$.ajax({
			type: 'POST',
			url: './Reservation',
			data: {
				idx: idx,
				userID: userID,
				resID: resID,
				subject: subject,
			},
			success: response => {
				console.log('요청성공: ', response);
				
				switch (response) {
				case '1':
					$('#messageType').html('에러메시지');
					$('#messageContent').html('먼저 로그인 해야합니다.');
					$('#messageCheck').attr('class', 'modal-content panel-warning');
					break;
				case '2':
					$('#messageType').html('에러메시지');
					$('#messageContent').html('콘텐츠 소유자는 예약이 불가능합니다.');
					$('#messageCheck').attr('class', 'modal-content panel-danger');
					break;
				case '3':
					$('#messageType').html('성공메시지');
					$('#messageContent').html('예약에 성공했습니다.');
					$('#messageCheck').attr('class', 'modal-content panel-success');
					break;
				case '4':
					$('#messageType').html('에러메시지');
					$('#messageContent').html('예약에 실패했습니다.');
					$('#messageCheck').attr('class', 'modal-content panel-info');
					break;
			}
			$('#messageModal').modal('show');
			},
			error: error => {
				console.log('요청실패: ', error.status);
			}
		});
	}

</script>
</head>
<body>
<% 
	if(login){
%>
<!-- Navigation-->
<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<div class="container px-4 px-lg-5">
			<a class="navbar-brand" href="./index1.nhn" style="margin-right:30px;">MY TRIP</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<form action="contentSearch.nhn" class="d-flex"
				style="margin-right: 20px;">
				<input id="item" name="item" class="form-control me-2" type="text"
					placeholder="Search" autocomplete="off">
				<button class="btn btn-dark" name="item-submit" id="item-submit"
					type="submit">Search</button>
			</form>
			<!-- 글쓰기 버튼 -->
			<ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4" style="text-align:center;">
				<li class="btn btn-light"><a class="nav-link"
					href="./content.nhn">여행 등록하기</a></li>
			</ul>
			<ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4">
				<li class="btn btn-light"><a class="nav-link"
					href="./mypageView.nhn">여행지 관리</a></li>
			</ul>
			<form action="logout.nhn">
				<button class="btn btn-outline-dark" type="submit"
					style="margin: 10px">
					<a href="./login.nhn" style="text-decoration: none; color: black;">로그아웃</a>
				</button>
			</form>
		</div>
	</nav>
	<article>
	
	
	
	
	
	
	<form action="contentViewUpdateCheck">
		<div class="container" role="main">	
			<table width="98%" style="margin: 20px;" align="center" border="1" cellpadding="5" cellspacing="0">
				<tr>
					<th colspan="4" style="display:flex;" border="1 solid black">게시글 보기</th>
				</tr>
				<tr>
					<th align ="right" width="10%" border="1 solid black">글번호</th>
					<th align ="center" width="40%" border="1 solid black">userID</th>
					<th align ="center" width="30%" border="1 solid black">작성일</th>
					<th align ="center" width="10%" border="1 solid black">조회수</th>
				</tr>
				<tr>
					<td>
					<input name="idx" align="center" width="10%" value="${co.idx}" readonly="readonly" style="border: none;"/>
					</td>
					<td>
					<input name="userID2" align="center" width="40%" value="${co.userID}" readonly="readonly" style="border: none;"/>
					</td>
					<td align="left" width="30%">
						<fmt:formatDate value="${co.writeDate}" pattern="yyyy/MM/dd(E)"/>
					</td>
					<td>
					<input name="hit" align="center" width="10%" value="${co.hit}" readonly="readonly" style="border: none;"/>
					</td>
				</tr>
				<tr>
					<th>제목</th>
					<td colspan="3">
						<input type="text" name="subject" value="${co.subject}" style="width: 98%;">
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td colspan="4">
						<textarea rows="10" name="content" style="resize: none; width: 98%;">${co.content}</textarea>
					</td>
				</tr>
				<tr>
					<td colspan="4" align="center">
						<input class="btn btn-outline-dark" type="submit" value="입력완료" />
					</td>
				</tr>
			</table>
		</div>
	</form>
			

	
		
	</article>
<%	
	} else{
%>
<!-- <h1>로그인하지 않은 상태</h1> -->
<!-- Navigator -->
 <!-- Navigation-->
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <div class="container px-4 px-lg-5">
                <a class="navbar-brand" href="./index1.nhn">MY TRIP</a>
                	<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
               			 <div class="collapse navbar-collapse" id="navbarSupportedContent">
					<!--  <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">Shop</a>
                            <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                                <li><a class="dropdown-item" href="#!">All Products</a></li>
                                <li><hr class="dropdown-divider" /></li>
                                <li><a class="dropdown-item" href="#!">Popular Items</a></li>
                                <li><a class="dropdown-item" href="#!">New Arrivals</a></li>
                            </ul>
                        </li> -->
                      	  <form action="contentSearch.nhn" class="d-flex" style="margin-right: 20px;">
						        <input id="item" name="item" class="form-control me-2" type="text" placeholder="Search" autocomplete="off">
						        <button class="btn btn-dark" name="item-submit" id="item-submit" type="submit">Search</button>
      						</form>
      						
                 			   <ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4" style="float: right">
                    			<li class="btn btn-light"><a class="nav-link" href="./login.nhn">여행지 등록하기</a></li>
                   				 </ul>
                   			   <ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4" style="float: right">
                    			<li class="btn btn-light"><a class="nav-link" href="./login.nhn">로그인</a></li>
                   				 </ul>
                    
              
                    <form action="register.nhn" class="d-flex">
                        <button class="btn btn-outline-dark" type="submit">
                            <i class="bi bi-person-circle"></i>
                            회원가입
                        </button>
                    </form>
                </div>
            </div>
        </nav>
<!-- main -->
	<article>
		<div class="container" role="main">
			<form action="login.nhn" method="post">
				<div class="bg-white rounded shadow-sm">
					<div class="board_title">${co.subject}</div>
					<div class="board_info_box">
						<span class="board_author">${co.idx},</span><span" class="board_author">${co.userID},</span><span class="board_date"><fmt:formatDate value="${co.writeDate}" pattern="yyyy/MM/dd(E)"/></span>
					</div>
					<div class="board_content">${co.content}</div>
				</div>
	
				<div style="margin-top : 20px">
					<button type="submit" tabindex="2" class="btn btn-outline-dark">예약하기</button>	
				</div>		
			</form>	
		</div>
</article>

<%  
	}
%>		



	<!-- Footer -->
	<footer class="text-center text-lg-start bg-light text-muted" >
		<!-- Section: Social media -->
		<section
			class="d-flex justify-content-center justify-content-lg-between p-4 border-bottom">
		</section>
		<!-- Section: Social media -->
		
		<!-- Section: Links  -->
		<section class="">
			<div class="container text-center text-md-start mt-5">
				<!-- Grid row -->
				<div class="row mt-3">
					<!-- Grid column -->
					<div class="col-md-3 col-lg-4 col-xl-3 mx-auto mb-4">
						<!-- Content -->
						<h6 class="text-uppercase fw-bold mb-4">
						Customer Service
						</h6><br/>
						<h6 class="text-uppercase fw-bold mb-4">1234-1230</h6>
						<br/><br/>
						<p>AM 10:00 ~ PM 5:00 MON ~ FRI</p>
						<p>Lunch PM 12:00 ~ 1:00</p>
					</div>
					<!-- Grid column -->

					<!-- Grid column -->
					<div class="col-md-2 col-lg-2 col-xl-2 mx-auto mb-4">
						<!-- Links -->
						<h6 class="text-uppercase fw-bold mb-4">Products</h6>
						<p>
							<a href="#!" class="text-reset">Angular</a>
						</p>
						<p>
							<a href="#!" class="text-reset">React</a>
						</p>
						<p>
							<a href="#!" class="text-reset">Vue</a>
						</p>
						<p>
							<a href="#!" class="text-reset">Laravel</a>
						</p>
					</div>
					<!-- Grid column -->

					<div class="col-md-2 col-lg-2 col-xl-2 mx-auto mb-4">
						<h6 class="text-uppercase fw-bold mb-4">Products</h6>
						<p>
							<a href="https://ko-kr.facebook.com/" class="list-group-item" target="_blank">Facebook</a>
						</p>
						<p>
							<a href="https://www.instagram.com/?hl=ko" class="list-group-item" target="_blank">Instagram</a>
						</p>
						<p>
							<a href="https://twitter.com/?lang=ko" class="list-group-item" target="_blank">Twitter</a>
						</p>
				</div>

					<!-- Grid column -->
					<div class="col-md-4 col-lg-3 col-xl-3 mx-auto mb-md-0 mb-4">
						<!-- Links -->
						<h6 class="text-uppercase fw-bold mb-4">Contact</h6>
						<p>
							<i class="fas fa-home me-3"></i> New York, NY 10012, US
						</p>
						<p>
							<i class="fas fa-envelope me-3"></i> info@example.com
						</p>
						<p>
							<i class="fas fa-phone me-3"></i> + 01 234 567 88
						</p>
						<p>
							<i class="fas fa-print me-3"></i> + 01 234 567 89
						</p>
					</div>
					<!-- Grid column -->
				</div>
				<!-- Grid row -->
			</div>
		</section>
		<!-- Section: Links  -->
		
	</footer>
	
<!-- 모달창 -->
	<div id="messageModal" class="modal fade" role="dialog" aria-hidden="true">
		<div class="vertical-alignment-helper">
			<div class="modal-dialog vertical-align-center">
				<div>
						<!-- messageType id 추가 -->
						<div id="messageCheck">
						<div class="modal-header panel-heading">
							<!-- messageType id 추가 -->
							<h4 id="messageType" class="modal-title"></h4>
						</div>	
						<!-- messageType content 추가 -->
						<div id="messageContent" class="modal-body"></div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default" id="closeModalBtn">확인</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 로그인 메시지 모달 창 -->

</body>

</html>