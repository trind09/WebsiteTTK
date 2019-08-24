<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="all">
        <div id="content">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <div id="main-slider" class="owl-carousel owl-theme">
                            <div class="item" style="background: url('img/main-slider2.jpg'); height: 520px; text-align: center;
vertical-align: middle; color: #a53f3f; text-shadow: #DA7A7A 1px 0 10px; padding: 150px; font-family: 'Pacifico script=latin rev=2';">
                                </div>
                            <div class="item" style="background: url('img/main-slider3.jpg'); height: 520px; text-align: center;
vertical-align: middle; color: #a53f3f; text-shadow: #DA7A7A 1px 0 10px; padding: 150px; font-family: 'Pacifico script=latin rev=2';">
                                </div>
                            <div class="item" style="background: url('img/main-slider1.jpg'); height: 520px; text-align: center;
vertical-align: middle; color: #a53f3f; text-shadow: #DA7A7A 1px 0 10px; padding: 150px; font-family: 'Pacifico script=latin rev=2';">
                                </div>
                        </div>
                        <!-- /#main-slider-->
                    </div>
                </div>
            </div>
            <!--
        *** ADVANTAGES HOMEPAGE ***
        _________________________________________________________
        -->
            <div id="advantages">
                <div class="container">
                    <div class="row mb-4">
                        <div class="col-md-4">
                            <div class="box clickable d-flex flex-column justify-content-center mb-0 h-100" style="vertical-align: top;">
                                <div class="icon"><i class="fa fa-magic"></i></div>
                                <h3><a href="#">Design</a></h3>
                                <p class="mb-0">We strategically design websites that elevate your brand and communicate your message effectively.</p>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="box clickable d-flex flex-column justify-content-center mb-0 h-100" style="vertical-align: top;">
                                <div class="icon"><i class="fa fa-cogs"></i></div>
                                <h3><a href="#">Development</a></h3>
                                <p class="mb-0">We develop fast and effective websites that speech up your business to sell your products and services online.</p>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="box clickable d-flex flex-column justify-content-center mb-0 h-100" style="vertical-align: top;">
                                <div class="icon"><i class="fa fa-bullhorn"></i></div>
                                <h3><a href="#">Online Marketing</a></h3>
                                <p class="mb-0">We provide SEO service includes Facebook ads, Google ads, Fanpage, Email Marketing or advertising apps on online games.</p>
                            </div>
                        </div>
                    </div>
                    <!-- /.row-->
                </div>
                <!-- /.container-->
            </div>
            <!-- /#advantages-->
            <!-- *** ADVANTAGES END ***-->
            <!--
        *** HOT PRODUCT SLIDESHOW ***
        _________________________________________________________
        -->
            <div id="hot">
                <div class="box py-4">
                    <div class="container">
                        <div class="row">
                            <div class="col-md-12">
                                <h2 class="mb-0">TTK Shop</h2>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="container">
                    <div class="product-slider owl-carousel owl-theme" id="ttk_shop_slider" runat="server">
                        <!-- /.product-slider-->
                    </div>
                    <!-- /.container-->
                </div>
                <!-- /#hot-->
                <!-- *** HOT END ***-->
            </div>
            <!--
        *** GET INSPIRED ***
        _________________________________________________________
        -->
            <div class="container" runat="server" id="collection_panel">
            </div>
            <!-- *** GET INSPIRED END ***-->
            <!--
        *** BLOG HOMEPAGE ***
        _________________________________________________________
        -->
            <div class="box text-center">
                <div class="container">
                    <div class="col-md-12">
                        <h3 class="text-uppercase">From our blog</h3>
                        <p class="lead mb-0">What's new in the world of fashion? <a href="blog.aspx">Check our blog!</a></p>
                    </div>
                </div>
            </div>
            <div class="container">
                <div class="col-md-12">
                    <div id="blog-homepage" class="row">
                        <div class="col-sm-6">
                            <div class="post">
                                <h4><a href="post.aspx">Fashion now</a></h4>
                                <p class="author-category">By <a href="#">John Slim</a> in <a href="">Fashion and style</a></p>
                                <hr>
                                <p class="intro">Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet, ante. Donec eu libero sit amet quam egestas semper. Aenean ultricies mi vitae est. Mauris placerat eleifend leo.</p>
                                <p class="read-more"><a href="post.aspx" class="btn btn-primary">Continue reading</a></p>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="post">
                                <h4><a href="post.aspx">Who is who - example blog post</a></h4>
                                <p class="author-category">By <a href="#">John Slim</a> in <a href="">About Minimal</a></p>
                                <hr>
                                <p class="intro">Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet, ante. Donec eu libero sit amet quam egestas semper. Aenean ultricies mi vitae est. Mauris placerat eleifend leo.</p>
                                <p class="read-more"><a href="post.aspx" class="btn btn-primary">Continue reading</a></p>
                            </div>
                        </div>
                    </div>
                    <!-- /#blog-homepage-->
                </div>
            </div>
            <!-- /.container-->
            <!-- *** BLOG HOMEPAGE END ***-->
        </div>
    </div>
</asp:Content>

