<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="home.aspx.cs" Inherits="Project_UI.home" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- ***** Main Banner Area Start ***** -->
    <section class="main-banner" id="top">
        <div class="container">
            <div class="row">
                <div class="col-lg-6 align-self-center">
                    <div class="header-text">
                        <h6>Welcome to <em style="color: #dc8cdb">Aarohan!</em></h6>
                        <h2>Where <em>Women's Rights</em> Comes First </h2>
                        <div class="main-button-gradient">
                            <div class="scroll-to-section"><a href="#contact-section">Join Us Now!</a></div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="right-image">
                        <img src="Images/banner-right-image.png" alt="">
                    </div>
                </div>
            </div>
        </div>
    </section>


    <section class="services" id="services2">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="section-heading">
                        <h6>Our Categories</h6>
                        <h4>Explore <em>Category</em></h4>
                    </div>
                </div>
                <div class="col-lg-12">
                    <div class="owl-service-item owl-carousel">
                        <asp:Repeater ID="Repeater1" runat="server">
                            <ItemTemplate>
                                <div class="item">
                                    <a href="subCategory.aspx?id=<%# Eval("categoryId") %>" class="service-item">
                                        <div class="icon">
                                            <%--<img src="Images/service-icon-01.png" alt="">--%>
                                            <%--<img src="Images/pngtree-family-law-color-icon-style-hammer-justice-vector-png-image_12463857-removebg-preview.png" />--%>
                                            <img src="<%#Eval("categoryImg") %>" />
                                        </div>
                                        <h4><%#Eval("categoryName") %></h4>
                                        <p><%#Eval("categoryDesc") %></p>
                                    </a>
                                </div>
                            </ItemTemplate>

                        </asp:Repeater>

                    </div>

                </div>
            </div>
        </div>
    </section>
    <section class="our-courses" id="courses">
        <div class="container">
            <div class="row">
                <div class="col-lg-6 offset-lg-3">
                    <div class="section-heading">
                        <h6>Benefits</h6>
                        <h4>Why <em>Choose Us?</em></h4>
                        <p></p>
                    </div>
                </div>
                <div class="col-sm-12 col-md-12 advantage_margin">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="row">
                                <div class="col-sm-12 col-md-4">
                                    <div class="advantge_box">
                                        <i>
                                            <img src="Images/person_consult.svg" alt="Consultation"></i>
                                        <h4>Online/Phone Legal Advice </h4>
                                        <p>
                                            Saves your transportation cost, saves time, provide urgent solutions also convenient for busy clients, privacy maintained while discussing over phone and emails.

                             
                                        </p>
                                    </div>
                                </div>
                                <div class="col-sm-12 col-md-4">
                                    <div class="advantge_box">
                                        <i>
                                            <img src="Images/process.svg" alt="Less Running"></i>
                                        <h4>Less Running</h4>
                                        <p>
                                            This entire process is very fuzz-free one can gain advice over a short period without worrying about it much.
                             
                                        </p>
                                    </div>
                                </div>
                                <div class="col-sm-12 col-md-4">
                                    <div class="advantge_box">
                                        <i>
                                            <img src="Images/advice_1.svg" alt="Appropriate Advice"></i>
                                        <h4>Appropriate Advice</h4>
                                        <p>Our team of counsel has sound knowledge and would guide you according to your requirement.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-12 col-md-4">
                                    <div class="advantge_box">
                                        <i>
                                            <img src="Images/privacy.svg" alt="Maintaining Confidentiality"></i>
                                        <h4>Maintaining Confidentiality</h4>
                                        <p>We maintain an end to end privacy concerning any of our clients and provide undisclosed service.</p>
                                    </div>
                                </div>
                                <div class="col-sm-12 col-md-4">
                                    <div class="advantge_box">
                                        <i>
                                            <img src="Images/nohidden_charges.svg" alt="No hidden charges"></i>
                                        <h4>No hidden charges</h4>
                                        <p>
                                            There are no hidden charges levied.
                                 
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </section>
    <section class="services" id="lawyers">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="section-heading">
                        <h6>Our lawyers</h6>
                        <h4>Contact a <em>Lawyer</em></h4>
                    </div>
                </div>
                <div class="col-lg-12">
                    <div class="owl-service-item owl-carousel">

                        <asp:Repeater ID="Repeater2" runat="server">
                            <ItemTemplate>
                           
                                <div class="card">
                                    <div class="image">
                                       <img src="<%#Eval("Photograph") %>" id="photo"/>
                                    </div>
                                    <div class="details">
                                        <h3><%#Eval("FullName") %></h3>
                                        <p><b>Specialization: </b><br /><%#Eval("categoryName") %> </p>
                                    </div>
                            
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>

                    
                    </div>
                </div>
            </div>
        </div>
    </section>
    <section class="simple-cta">
        <div class="container">
            <div class="row">
                <div class="col-lg-5 offset-lg-1">
                    <div class="left-image">
                        <img src="Images/cta-left-image.png" alt="">
                    </div>
                </div>
                <div class="col-lg-5 align-self-center">
                    <h6>Get the sale right now!</h6>
                    <h4>Up to 50% OFF For 1+ courses</h4>
                    <p>Kogi VHS freegan bicycle rights try-hard green juice probably haven't heard of them cliche la croix af chillwave.</p>
                    <div class="white-button">
                        <a href="contact-us.html">View Courses</a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="testimonials" id="testimonials">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="section-heading">
                        <h6>Testimonials</h6>
                        <h4>What They <em>Think</em></h4>
                    </div>
                </div>
                <div class="col-lg-12">
                    <div class="owl-testimonials owl-carousel" style="position: relative; z-index: 5;">
                        <div class="item">
                            <p>“just think about TemplateMo if you need free CSS templates for your website”</p>
                            <h4>Catherine Walk</h4>
                            <span>CEO &amp; Founder</span>
                            <img src="Images/quote.png" alt="">
                        </div>
                        <div class="item">
                            <p>“think about our website first when you need free HTML templates for your website”</p>
                            <h4>David Martin</h4>
                            <span>CTO of Tech Company</span>
                            <img src="Images/quote.png" alt="">
                        </div>
                        <div class="item">
                            <p>“just think about our website wherever you need free templates for your website”</p>
                            <h4>Sophia Whity</h4>
                            <span>CEO and Co-Founder</span>
                            <img src="Images/quote.png" alt="">
                        </div>
                        <div class="item">
                            <p>“Praesent accumsan condimentum arcu, id porttitor est semper nec. Nunc diam lorem.”</p>
                            <h4>Helen Shiny</h4>
                            <span>Tech Officer</span>
                            <img src="Images/quote.png" alt="">
                        </div>
                        <div class="item">
                            <p>“Praesent accumsan condimentum arcu, id porttitor est semper nec. Nunc diam lorem.”</p>
                            <h4>George Soft</h4>
                            <span>Gadget Reviewer</span>
                            <img src="Images/quote.png" alt="">
                        </div>
                        <div class="item">
                            <p>“Praesent accumsan condimentum arcu, id porttitor est semper nec. Nunc diam lorem.”</p>
                            <h4>Andrew Hall</h4>
                            <span>Marketing Manager</span>
                            <img src="Images/quote.png" alt="">
                        </div>
                        <div class="item">
                            <p>“Praesent accumsan condimentum arcu, id porttitor est semper nec. Nunc diam lorem.”</p>
                            <h4>Maxi Power</h4>
                            <span>Fashion Designer</span>
                            <img src="Images/quote.png" alt="">
                        </div>
                        <div class="item">
                            <p>“Praesent accumsan condimentum arcu, id porttitor est semper nec. Nunc diam lorem.”</p>
                            <h4>Olivia Too</h4>
                            <span>Creative Designer</span>
                            <img src="Images/quote.png" alt="">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>


</asp:Content>
