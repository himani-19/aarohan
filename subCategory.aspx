<%@ Page Title="" Language="C#" MasterPageFile="~/Site2.Master" AutoEventWireup="true" CodeBehind="subCategory.aspx.cs" Inherits="Project_UI.subCategory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet" />

    <style>
        /* Browse Sub Category Styles */
        .browse-sub-category {
            padding: 40px 0;
            /*background-color: #f9f9f9;*/
        }

        .browse-sub-category .section-heading {
            text-align: left;
            margin-bottom: 40px;
            padding-left:7rem;
        }

        .browse-sub-category .section-heading h4 {
            /*font-size: 2rem;*/
            color: #333;
        }

        

        .browse-sub-category .container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 30px;
        }

        .browse-sub-category-item {
            flex: 1 1 calc(25% - 30px); /* 4 items per row with spacing */
            max-width: calc(25% - 30px);
            background: #ffffff;
            border-radius: 15px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 20px;
            text-align: center;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .browse-sub-category-item:hover {
            transform: translateY(-10px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
        }

        .browse-sub-category-item h4 {
            font-size: 1.2rem;
            color: #333;
            margin-bottom: 10px;
        }

        .browse-sub-category-item h5 a {
            color: #007bff;
            text-decoration: none;
            font-size: 0.9rem;
            transition: color 0.3s ease;
        }

        .browse-sub-category-item h5 a:hover {
            color: #ff4757;
        }

       
        .advocate-container {
            display: flex;
            flex-wrap: wrap;
            justify-content:flex-start;
            padding: 20px;
        }

       
        .advocate-card {
            border: 1px solid #ddd;
            padding: 20px;
            margin: 10px;
            text-align: center;
            width: 250px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            background-color: #f9f9f9;
            transition: transform 0.2s, box-shadow 0.2s;
        }

            .advocate-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2);
                cursor: pointer;
            }

        .rating i {
            color: gold; /* Full stars */
            font-size: 18px;
        }

            .rating i.far {
                color: #ccc; /* Empty stars */
            }

            .rating i.fas.fa-star-half-alt {
                color: orange; /* Half stars */
            }

        /* Box containing the profile image */
        .profile-picture-box {
            width: 150px;
            height: 150px;
            margin: 0 auto 10px;
            overflow: hidden;
            border-radius: 50%;
            border: 2px solid #ddd;
        }

        .profile-picture {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        h4 {
            font-size: 18px;
            margin: 10px 0;
        }

        p {
            font-size: 14px;
            margin: 5px 0;
        }

        .icon-text {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 5px;
        }

            .icon-text i {
                color: #555;
            }

        @media (max-width: 768px) {
            .advocate-card {
                width: 100%;
                max-width: 300px;
            }
        }
       
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Browse Sub Category Section -->
    <section class="browse-sub-category">
        <div class="col-lg-12"  >
            <div class="section-heading">
                <h4>Browse <em>Sub Category</em></h4>
            </div>
        </div>
        <div class="container" style="margin-top:60px">
            <asp:Repeater ID="CategoryRepeater" runat="server">
                <ItemTemplate>
                    <div class="browse-sub-category-item">
                        <h4><%# Eval("SubCategoryName") %></h4>
                        <h5><a href="#">Know more</a></h5>
                    </div>
                </ItemTemplate>
                
            </asp:Repeater>
        </div>
    </section>

    <!-- Contact a Lawyer Section (Inactive) -->
      <section class="services" id="services" style="margin-top:40px">
      <div class="container">
          <div class="row">
              <div class="col-lg-12">
                  <div class="section-heading" style="text-align:left">
                      
                      <h4 >Recommended <em>Lawyers</em></h4>
                  </div>
              </div>
              <div class="advocate-container">
       <asp:Repeater ID="RepeaterAdvocates" runat="server">
    <ItemTemplate>
        <div class="advocate-card" style="cursor: pointer;">
            <a href='Advocate_Details.aspx?advocateId=<%# Eval("AdvocateID") %>' style="text-decoration: none; color: inherit;">
                <!-- Advocate's photo -->
                <div class="profile-picture-box">
                    <img src='<%# ResolveUrl(GetPhotoUrl(Eval("Photograph").ToString())) %>' alt="Advocate Image" class="profile-picture" />
                </div>
                
                <!-- Advocate's Information -->
                <h4><%# Eval("FullName") %></h4>

                <!-- Rating -->
                <p class="rating">
                    <%# GetStarRating(Convert.ToInt32(Eval("AdvocateID"))) %>
                </p>

                <p class="icon-text">
                    <i class="fas fa-map-marker-alt"></i> <%# Eval("City") %>, <%# Eval("State") %>
                </p>

                <p class="icon-text">
                    <i class="fas fa-briefcase"></i> <%# Eval("YearsOfExperience") %> years experience
                </p>
                <p><strong>Practice Areas:</strong> <%# Eval("AreaOfSpecialization") %></p>
            </a>
        </div>
    </ItemTemplate>
</asp:Repeater>

    </div>
              <%--<div class="col-lg-12">
                  <div class="owl-service-item owl-carousel">
                      <div class="item">
                          <div class="service-item">
                              <div class="icon">
                                  <img src="Images/service-icon-01.png" alt="">
                              </div>
                              <h4>Family Law Cases</h4>
                              <p>Issues related to dissolution of marriage, Child Custody and Support, Alimony and Domestic Violence.</p>
                          </div>
                      </div>
                      <div class="item">
                          <div class="service-item">
                              <div class="icon">
                                  <img src="Images/service-icon-02.png" alt="">
                              </div>
                              <h4>Criminal Law Cases</h4>
                              <p>Cases including Dowry Harassment and Deaths, Sexual Offenses, Acid Attacks ,Online stalking, blackmail, or distribution of private material without consent.</p>
                          </div>
                      </div>
                      <div class="item">
                          <div class="service-item">
                              <div class="icon">
                                  <img src="Images/service-icon-03.png" alt="">
                              </div>
                              <h4>Workplace Cases</h4>
                              <p>Cases seeking redress for gender pay gaps, wrongful termination due to pregnancy, maternity leave, or gender bias.</p>
                          </div>
                      </div>
                      <div class="item">
                          <div class="service-item">
                              <div class="icon">
                                  <img src="Images/service-icon-04.png" alt="">
                              </div>
                              <h4>Property and Inheritance Cases</h4>
                              <p>Cases related to disputes over equal access to ancestral property, property ownership due to gender discrimination</p>
                          </div>
                      </div>
                      <div class="item">
                          <div class="service-item">
                              <div class="icon">
                                  <img src="Images/service-icon-01.png" alt="">
                              </div>
                              <h4>Reproductive and Healthcare Rights</h4>
                              <p>Cases involving the right to terminate a pregnancy, women's access to safe medical services</p>
                          </div>
                      </div>
                      <div class="item">
                          <div class="service-item">
                              <div class="icon">
                                  <img src="Images/service-icon-02.png" alt="">
                              </div>
                              <h4>Constitutional Rights Cases</h4>
                              <p>Cases involving gender discrimination in laws or policies, right to make personal choices like marriage, education, or dress</p>
                          </div>
                      </div>
                      <div class="item">
                          <div class="service-item">
                              <div class="icon">
                                  <img src="Images/service-icon-03.png" alt="">
                              </div>
                              <h4>Social Welfare and Employment Cases</h4>
                              <p>Cases related to denial of maternity leave or related entitlements, labor rights.</p>
                          </div>
                      </div>
                      <div class="item">
                          <div class="service-item">
                              <div class="icon">
                                  <img src="Images/service-icon-04.png" alt="">
                              </div>
                              <h4>Cyber and Online Harassment Cases</h4>
                              <p>Issues related to legal action for sharing intimate content without consent, to protect against digital threats.</p>
                          </div>
                      </div>
                      <div class="item">
                          <div class="service-item">
                              <div class="icon">
                                  <img src="Images/service-icon-01.png" alt="">
                              </div>
                              <h4>Cultural or Religious Issues</h4>
                              <p>Issues related to marriage, divorce, and inheritance under religious laws (e.g., Muslim personal law).</p>
                          </div>
                      </div>
                      <div class="item">
                          <div class="service-item">
                              <div class="icon">
                                  <img src="Images/service-icon-02.png" alt="">
                              </div>
                              <h4>Trafficking and Exploitation</h4>
                              <p>Cases related to illegal trafficking for labor or sexual exploitation</p>
                          </div>
                      </div>
                      <div class="item">
                          <div class="service-item">
                              <div class="icon">
                                  <img src="Images/service-icon-03.png" alt="">
                              </div>
                              <h4>Consumer Protection Cases</h4>
                              <p>Cases involving harm caused by unsafe beauty, healthcare, or other products marketed to women.</p>
                          </div>
                      </div>
                      <div class="item">
                          <div class="service-item">
                              <div class="icon">
                                  <img src="Images/service-icon-04.png" alt="">
                              </div>
                              <h4>Senior Women and Elder Abuse</h4>
                              <p>Cases of neglect, financial exploitation, or physical abuse of senior women , legal action for denial of pensions or retirement benefits..</p>
                          </div>
                      </div>
                  </div>
              </div>--%>
          </div>
      </div>
  </section>
   
</asp:Content>
