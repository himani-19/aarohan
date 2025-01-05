<%@ Page Title="Advocate Details" Language="C#" MasterPageFile="~/Site2.Master" AutoEventWireup="true" CodeBehind="Advocate_Details.aspx.cs" Inherits="Project_UI.Advocate_Details" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet" />
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }

        
        .lawyer-details-container {
          
            max-width: 1000px;
            max-height: 800px;
            margin: 50px auto;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            flex-wrap: wrap;
        }

        .profile-picture-box {
            width: 150px;
            height: 150px;
            margin-bottom: 20px;
            overflow: hidden;
            border-radius: 10%;
            border: 2px solid #ddd;
        }

        .profile-picture {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .details-box {
            text-align: left;
            margin-bottom: 30px;
            margin-left: 30px;
            margin-right: auto;
            flex: 1 1 50%;
        }

        h2 {
            margin-top: 0;
        }

        p {
            font-size: 16px;
            margin: 10px 0;
        }

        .rating i {
            color: gold; 
            font-size: 18px;
        }

        .rating i.far {
            color: #ccc; 
        }

        .rating i.fas.fa-star-half-alt {
            color: orange;
        }

        .contact-info {
            display: flex;
            flex-direction: column;
            align-items: flex-end;
            gap: 15px;
            flex: 0 1 250px;
        }

        .contact-button {
            display: inline-block;
            text-decoration: none;
            padding: 10px 20px;
            font-size: 16px;
            color: white;
            border-radius: 5px;
            transition: background-color 0.3s ease;
            text-align: center;
            width: 200px;
        }

        .phone-button {
            background-color: #2196F3;
        }

        .phone-button:hover {
            background-color: #1976D2;
        }

        .email-button {
            background-color: #FF5722;
        }

        .email-button:hover {
            background-color: #E64A19;
        }

        .description-box {
            width: 100%;
            margin-top: 30px;
            text-align: left;
            padding-top: 20px;
            border-top: 1px solid #ddd; 
        }

        .category-desc {
            font-size: 16px;
            color: #555;
        }
       .feedback-section {
    margin-top: 30px;
    padding: 20px;
    background-color: #f9f9f9;
    border-top: 2px solid #ddd;
}

.feedback-section h3 {
    margin-bottom: 10px;
    font-size: 18px;
    color: #333;
}

.feedback-item {
    padding: 10px;
    border-bottom: 1px solid #ccc;
    margin-bottom: 10px;
}

.feedback-item i {
    color: gold;
}


    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="lawyer-details-container">
        <!-- Profile Picture -->
        <div class="profile-picture-box">
            <asp:Image ID="imgLawyerPhoto" runat="server" CssClass="profile-picture" AlternateText="Advocate Image" />
        </div>

        <!-- Details Section -->
        <div class="details-box">
            <h2><asp:Label ID="lblFullName" runat="server"></asp:Label></h2>
            <div class="rating">
    <asp:Label ID="lblRating" runat="server"></asp:Label>
    <asp:Label ID="lblFeedbackCount" runat="server" CssClass="feedback-count"></asp:Label> <!-- Feedback count label -->
</div>
            <p><strong>Location:</strong> <asp:Label ID="lblLocation" runat="server"></asp:Label></p>
            <p><strong>Experience:</strong> <asp:Label ID="lblExperience" runat="server"></asp:Label> years</p>
            <p><strong>Areas of Specialization:</strong> <asp:Label ID="lblSpecialization" runat="server"></asp:Label></p>
        </div>

        <!-- Contact Section -->
        <div class="contact-info">
            <a id="btnPhone" runat="server" class="contact-button phone-button">
                <i class="fa fa-phone"></i> Call Advocate
            </a>
            <a id="btnEmail" runat="server" class="contact-button email-button">
                <i class="fa fa-envelope"></i> Email Advocate
            </a>
        </div>

        <!-- Description Section (Placed Below All Info) -->
        <div class="description-box">
            <p class="category-desc">
                
                <span>With over <asp:Label ID="Label2" runat="server"></asp:Label> years of experience, 
                    Advocate <asp:Label ID="Label1" runat="server"></asp:Label>
                 specializes in <asp:Label ID="Label4" runat="server"></asp:Label>. 
                As an advocate practicing in <asp:Label ID="Label5" runat="server"></asp:Label>, they have represented numerous clients in legal matters, offering a deep understanding in cases of  
                 <asp:Label ID="lblCategoryDesc" runat="server"></asp:Label>. 
                Their commitment to justice and passion for helping people have made them a respected figure in the field.</span>
            </p>
        </div>

        
    </div>
    <div class="feedback-section">
    <h3><strong>Client Feedbacks</strong></h3>
    <asp:Label ID="Label3" runat="server"></asp:Label>
    <div id="feedbackContainer" runat="server">
     
    </div>
  
    <asp:Panel ID="pnlFeedbackForm" runat="server">
        <h3>Submit Your Feedback</h3>
        <asp:TextBox ID="txtFeedback" runat="server" TextMode="MultiLine" CssClass="feedback-input" Rows="5" Columns="50" placeholder="Write your feedback..."></asp:TextBox>
        <asp:DropDownList ID="ddlRating" runat="server" CssClass="rating-dropdown">
            <asp:ListItem Text="1 Star" Value="1"></asp:ListItem>
            <asp:ListItem Text="2 Stars" Value="2"></asp:ListItem>
            <asp:ListItem Text="3 Stars" Value="3"></asp:ListItem>
            <asp:ListItem Text="4 Stars" Value="4"></asp:ListItem>
            <asp:ListItem Text="5 Stars" Value="5"></asp:ListItem>
        </asp:DropDownList>
        <asp:Button ID="btnSubmitFeedback" runat="server" Text="Submit Feedback" CssClass="feedback-button" OnClick="SubmitFeedback_Click" />
    </asp:Panel>
</div>

</asp:Content>
