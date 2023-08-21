<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../testHeader.jsp" %>

<main id="main">

    <!-- ======= Breadcrumbs ======= -->
    <section id="breadcrumbs" class="breadcrumbs" style="margin-top: 70px;">
      <div class="container">

        <div class="d-flex justify-content-between align-items-center">
          <h2>Blog Single</h2>
          <ol>
            <li><a href="index.html">Home</a></li>
            <li><a href="blog.html">Blog</a></li>
            <li>Blog Single</li>
          </ol>
        </div>

      </div>
    </section><!-- End Breadcrumbs -->

    <!-- ======= Blog Single Section ======= -->
    <section id="blog" class="blog">
      <div class="container" data-aos="fade-up">

        <div class="row">

          <div class="col-lg-8 entries">

            <article class="entry entry-single">
              <div class="row">
              	<div class="col-lg-9">
              	  <h2 class="entry-title">
	              	${store.sname }
	              </h2>
	
	              <div class="entry-meta"><!-- 우측 정렬 후 거리정보 제공  -->
	                <ul>
	                  <li class="d-flex align-items-center"><i class="bi bi-pin-map-fill"></i>${store.saddress }</li>
	                  <li class="d-flex align-items-center"><i class="bi bi-cursor-fill"></i><span id="distance">거리정보</span></li>
	                </ul>
	              </div>
              	</div>
              	<div class="col-lg-3" style="border: 1px solid black; height: 150px;">
              		<p style="text-align: center;">지도 영역</p>
              	</div>
              </div>
              

              <div class="entry-content">
              	<div class="imgArea" style="border: 2px solid black; width: 50%; height: 200px;"><!-- owl carousel 및 lightbox적용하여 이미지 영역 구축  -->
              		<p style="text-align: center;">이미지 영역</p>
              	</div>
                <p>이름 : ${store.sname }<span id="distance"></span></p>
				<p>휴무일 : ${dayOff }</p>
				<p>영업시간 : ${store.openHour }</p>
				<p>예약금 : ${store.sdepo }</p>
				<p>
					<c:choose>
						<c:when test="${store.sdeli eq 1 }">
							배달 o
						</c:when>
						<c:otherwise>
							배달 x
						</c:otherwise>
					</c:choose>
				</p>
				<div id="utilBox" style="text-align: left;">
					<c:choose>
						<c:when test="${isLike }">
							<span class="enabledLike">좋아요 ${store.slike }</span>
						</c:when>
						<c:otherwise>
							<span id="likeBtn">좋아요 ${store.slike }</span>
						</c:otherwise>
					</c:choose>
					<p>평점 평균 ${store.sstar }</p>
				</div>

              </div>

              <div class="entry-footer"><!-- tag 사용  -->
                <i class="bi bi-folder"></i>
                <ul class="cats">
                  <li><a href="#">bigTag</a></li>
                </ul>

                <i class="bi bi-tags"></i>
                <ul class="tags">
                  <li><a href="#">smallTag 1</a></li>
                  <li><a href="#">smallTag 2</a></li>
                  <li><a href="#">smallTag 3</a></li>
                </ul>
              </div>

            </article><!-- End blog entry -->

            

            <div class="blog-comments">

              <h4 class="comments-count">reviews</h4><br>
			  <div class="blog-author d-flex align-items-center">
	              <img src="assets/img/blog/blog-author.jpg" class="rounded-circle float-left" alt="">
	              <div>
	                <h4>Jane Smith</h4>
	                <div class="social-links">
	                  <a href="https://twitters.com/#"><i class="bi bi-twitter"></i></a>
	                  <a href="https://facebook.com/#"><i class="bi bi-facebook"></i></a>
	                  <a href="https://instagram.com/#"><i class="biu bi-instagram"></i></a>
	                </div>
	                <p>
	                  Itaque quidem optio quia voluptatibus dolorem dolor. Modi eum sed possimus accusantium. Quas repellat voluptatem officia numquam sint aspernatur voluptas. Esse et accusantium ut unde voluptas.
	                </p>
	              </div>
	            </div><!-- End blog author bio -->
	            
			  <div class="blog-author d-flex align-items-center">
	              <img src="assets/img/blog/blog-author.jpg" class="rounded-circle float-left" alt="">
	              <div>
	                <h4>Jane Smith</h4>
	                <div class="social-links">
	                  <a href="https://twitters.com/#"><i class="bi bi-twitter"></i></a>
	                  <a href="https://facebook.com/#"><i class="bi bi-facebook"></i></a>
	                  <a href="https://instagram.com/#"><i class="biu bi-instagram"></i></a>
	                </div>
	                <p>
	                  Itaque quidem optio quia voluptatibus dolorem dolor. Modi eum sed possimus accusantium. Quas repellat voluptatem officia numquam sint aspernatur voluptas. Esse et accusantium ut unde voluptas.
	                </p>
	              </div>
	            </div><!-- End blog author bio -->
	            
			  <div class="blog-author d-flex align-items-center">
	              <img src="assets/img/blog/blog-author.jpg" class="rounded-circle float-left" alt="">
	              <div>
	                <h4>Jane Smith</h4>
	                <div class="social-links">
	                  <a href="https://twitters.com/#"><i class="bi bi-twitter"></i></a>
	                  <a href="https://facebook.com/#"><i class="bi bi-facebook"></i></a>
	                  <a href="https://instagram.com/#"><i class="biu bi-instagram"></i></a>
	                </div>
	                <p>
	                  Itaque quidem optio quia voluptatibus dolorem dolor. Modi eum sed possimus accusantium. Quas repellat voluptatem officia numquam sint aspernatur voluptas. Esse et accusantium ut unde voluptas.
	                </p>
	              </div>
	            </div><!-- End blog author bio -->
			  
			  


              <div class="reply-form" style="display: none;"><!-- 숨겼다가 모달로 사용  -->
                <h4>Leave a Reply</h4>
                <p>Your email address will not be published. Required fields are marked * </p>
                <form action="">
                  <div class="row">
                    <div class="col-md-6 form-group">
                      <input name="name" type="text" class="form-control" placeholder="Your Name*">
                    </div>
                    <div class="col-md-6 form-group">
                      <input name="email" type="text" class="form-control" placeholder="Your Email*">
                    </div>
                  </div>
                  <div class="row">
                    <div class="col form-group">
                      <input name="website" type="text" class="form-control" placeholder="Your Website">
                    </div>
                  </div>
                  <div class="row">
                    <div class="col form-group">
                      <textarea name="comment" class="form-control" placeholder="Your Comment*"></textarea>
                    </div>
                  </div>
                  <button type="submit" class="btn btn-primary">Post Comment</button>

                </form>

              </div>

            </div><!-- End blog comments -->

          </div><!-- End blog entries list -->

          <div class="col-lg-4">

            <div class="sidebar">

              <h3 class="sidebar-title">비슷한 매장 추천</h3>
              <div class="sidebar-item recent-posts">
                <div class="post-item clearfix">
                  <img src="assets/img/blog/blog-recent-1.jpg" alt="">
                  <h4><a href="blog-single.html">Nihil blanditiis at in nihil autem</a></h4>
                  <time datetime="2020-01-01">Jan 1, 2020</time>
                </div>

                <div class="post-item clearfix">
                  <img src="assets/img/blog/blog-recent-2.jpg" alt="">
                  <h4><a href="blog-single.html">Quidem autem et impedit</a></h4>
                  <time datetime="2020-01-01">Jan 1, 2020</time>
                </div>

                <div class="post-item clearfix">
                  <img src="assets/img/blog/blog-recent-3.jpg" alt="">
                  <h4><a href="blog-single.html">Id quia et et ut maxime similique occaecati ut</a></h4>
                  <time datetime="2020-01-01">Jan 1, 2020</time>
                </div>

                <div class="post-item clearfix">
                  <img src="assets/img/blog/blog-recent-4.jpg" alt="">
                  <h4><a href="blog-single.html">Laborum corporis quo dara net para</a></h4>
                  <time datetime="2020-01-01">Jan 1, 2020</time>
                </div>

                <div class="post-item clearfix">
                  <img src="assets/img/blog/blog-recent-5.jpg" alt="">
                  <h4><a href="blog-single.html">Et dolores corrupti quae illo quod dolor</a></h4>
                  <time datetime="2020-01-01">Jan 1, 2020</time>
                </div>

              </div><!-- End sidebar recent posts-->

              <h3 class="sidebar-title">Tags</h3>
              <div class="sidebar-item tags">
                <ul>
                  <li><a href="#">App</a></li>
                  <li><a href="#">IT</a></li>
                  <li><a href="#">Business</a></li>
                  <li><a href="#">Mac</a></li>
                  <li><a href="#">Design</a></li>
                  <li><a href="#">Office</a></li>
                  <li><a href="#">Creative</a></li>
                  <li><a href="#">Studio</a></li>
                  <li><a href="#">Smart</a></li>
                  <li><a href="#">Tips</a></li>
                  <li><a href="#">Marketing</a></li>
                </ul>
              </div><!-- End sidebar tags-->

            </div><!-- End sidebar -->

          </div><!-- End blog sidebar -->

        </div>

      </div>
    </section><!-- End Blog Single Section -->

  </main><!-- End #main -->

<%@ include file="../testFooter.jsp" %>    