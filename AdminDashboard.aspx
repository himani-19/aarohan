<%@ Page Title="Admin Dashboard" Language="C#" MasterPageFile="~/Admin/AdminSiteMaster.Master" AutoEventWireup="true" CodeBehind="AdminDashboard.aspx.cs" Inherits="Project_UI.Admin.AdminDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        /* Flex Layout for Dashboard */
        .dashboard-container {
            display: flex;
            justify-content: space-around;
            flex-wrap: wrap;
            gap: 20px;
            margin: 20px 0;
        }

        /* Individual Dashboard Cards */
        .dashboard-card {
            background: #f4f4f4;
            border-radius: 8px;
            padding: 20px;
            text-align: center;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            width: 22%;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .dashboard-card:hover {
            transform: scale(1.05);
            box-shadow: 0px 6px 12px rgba(0, 0, 0, 0.2);
        }

        .dashboard-card h3 {
            color: #333;
            margin-bottom: 10px;
        }

        .dashboard-card p {
            font-size: 32px;
            font-weight: bold;
            color: #b85697;
        }

        /* Dashboard Summary Section */
        .dashboard-summary {
            display: flex;
            justify-content: space-between;
            gap: 20px;
            margin-bottom: 30px;
        }

        .dashboard-item {
            width: 23%;
            padding: 15px;
            background: #ffffff;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            text-align: center;
        }

        .dashboard-item h3 {
            margin-bottom: 15px;
            color: #333;
        }

        .summary-value {
            font-size: 30px;
            color: #ff7b7b;
            font-weight: bold;
        }

        /* Recent Activity Table Styling */
        .recent-activity {
            margin-top: 30px;
        }

        .recent-activity h2 {
            color: #333;
            margin-bottom: 15px;
        }

        .grid {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        .grid th, .grid td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: left;
        }

        .grid th {
            background-color: #f4f4f4;
            font-weight: bold;
        }

        /* Animation for Data Loading */
        .loading {
            font-size: 18px;
            color: #f0ad4e;
            text-align: center;
            margin-top: 20px;
        }

        /* Icon Styling */
        .dashboard-card i {
            font-size: 50px;
            color: #6c757d;
            margin-bottom: 15px;
        }

        /* Media Queries for Mobile Optimization */
        @media (max-width: 768px) {
            .dashboard-container {
                flex-direction: column;
                align-items: center;
            }

            .dashboard-card {
                width: 90%;
                margin-bottom: 20px;
            }

            .dashboard-summary {
                flex-direction: column;
                align-items: center;
            }

            .dashboard-item {
                width: 100%;
                margin-bottom: 20px;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2>Admin Dashboard</h2>

    <!-- Dashboard Summary Section -->
    <div class="dashboard-summary">
        <div class="dashboard-item">
            <i class="fa fa-users"></i>
            <h3>Total Users</h3>
            <asp:Label ID="lblTotalUsers" runat="server" Text="0" CssClass="summary-value" />
        </div>
        <div class="dashboard-item">
            <i class="fa fa-gavel"></i>
            <h3>Total Advocates</h3>
            <asp:Label ID="lblTotalAdvocates" runat="server" Text="0" CssClass="summary-value" />
        </div>
        <div class="dashboard-item">
            <i class="fa fa-cogs"></i>
            <h3>Total Categories</h3>
            <asp:Label ID="lblTotalCategories" runat="server" Text="0" CssClass="summary-value" />
        </div>
        <div class="dashboard-item">
            <i class="fa fa-cogs"></i>
            <h3>Total Subcategories</h3>
            <asp:Label ID="lblTotalSubCategories" runat="server" Text="0" CssClass="summary-value" />
        </div>
    </div>

  

       
    </div>
</asp:Content>
