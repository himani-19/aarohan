<%@ Page Title="" Language="C#" MasterPageFile="~/Site2.Master" AutoEventWireup="true" CodeBehind="category.aspx.cs" Inherits="Project_UI.category" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .services {
            padding: 20px 0;
        }

            .services .container {
                display: flex;
                flex-wrap: wrap;
                justify-content: center;
                gap: 20px;
            }


                .services .container .service-item:hover {
                    box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.06);
                }

        .service-item {
            flex: 1 1 calc(33.333% - 20px); /* 3 items per row with spacing */
            max-width: calc(33.333% - 20px);
            border-radius: 10px;
            padding: 20px;
            text-align: center;
            /*box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);*/ /*box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);*/
        }

            .service-item img {
                width: 50px;
                height: 50px;
                margin-bottom: 10px;
            }

            .service-item h4 {
                font-size: 1.2rem;
                margin-bottom: 10px;
            }

            .service-item p {
                font-size: 0.9rem;
                color: #666;
            }

        .services .col-lg-12 .section-heading h6 {
            font-size: 13px;
            text-transform: uppercase;
            color: #7a7a7a;
            font-weight: 600;
        }
    </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="services" id="services">
        <div class="col-lg-12">
            <div class="section-heading">

                <h4>Explore <em>Category</em></h4>

            </div>
        </div>
        <div class="container">

            <asp:Repeater ID="CategoryRepeater" runat="server">
                <ItemTemplate>
                    <a href="subCategory.aspx?id=<%# Eval("categoryId") %>" class="service-item">

                        <div class="icon">
                            <img src="<%# Eval("categoryImg") %>" alt="Category Icon">
                        </div>
                        <h4><%# Eval("categoryName") %></h4>
                        <p><%# Eval("categoryDesc") %></p>

                    </a>

                </ItemTemplate>
            </asp:Repeater>
        </div>
    </section>
</asp:Content>
