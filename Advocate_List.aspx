<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Advocate_List.aspx.cs" Inherits="Project_UI.Advocate_List" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet" />

    <style>
        h1 {
            margin-top: 100px;
            font-size: 28px;
            text-align: center;
        }

        .advocate-container {
            display: flex;
            flex-wrap: wrap;
            justify-content:center;
            padding: 20px;
        }

        /* Container for each advocate's card */
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
    <h1>Find a Lawyer</h1>
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
</asp:Content>
