<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Advocate_Register.aspx.cs" Inherits="Project_UI.Advocate_Register" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <title>Advocate Registration</title>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">

    <style>
        body {
            font-family: 'Open Sans', sans-serif;
            background: linear-gradient(to right, #f8b693, #d67ac1);
            color: #333;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
            height: 100vh;
            overflow-y: auto;
            position: relative;
        }

        .logo {
            position: absolute; /* Position the logo absolutely */
            top: 20px; /* Distance from the top */
            left: 20px; /* Distance from the left */
            z-index: 100; /* Ensure the logo stays on top */
        }

        .form-container {
            background-color: #fff;
            width: 100%;
            min-width: 650px;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0px 4px 20px rgba(0, 0, 0, 0.1);
            text-align: left;
            margin: 20px 0;
            box-sizing: border-box;
            margin-left: auto;
            margin-right: auto;
            margin-top: 60px;
        }

        h2 {
            color: #b85697;
            font-size: 2rem;
            font-weight: bold;
            text-align: center;
            margin-bottom: 15px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .form-group {
            margin-bottom: 20px;
            position: relative;
        }

            .form-group label {
                font-weight: 600;
                display: block;
                margin-bottom: 8px;
            }

            .form-group input,
            .form-group select {
                width: 100%;
                padding: 12px;
                font-size: 16px;
                border: 2px solid #ddd;
                border-radius: 5px;
                box-sizing: border-box;
                transition: border-color 0.3s ease-in-out;
            }


        .eye-icon {
            position: absolute;
            top: 50%;
            right: 10px;
            transform: translateY(-50%);
            cursor: pointer;
            color: #b85697;
            font-size: 18px;
        }


        .form-group input:focus,
        .form-group select:focus {
            border-color: rgb(173, 112, 193);
            outline: none;
        }

        .form-group .radio-group {
            display: flex;
            gap: 15px; 
            align-items: center; 
        }

        .radio-group input {
            margin-right: 5px;
        }

        .submit-btn {
            background: #d67ac1;
            color: white;
            padding: 14px 20px;
            font-size: 18px;
            border: none;
            border-radius: 5px;
            width: 100%;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

            .submit-btn:hover {
                background-color: #b85697;
            }

        .link-btn {
            text-align: center;
            margin-top: 20px;
        }

            .link-btn a {
                color: #b85697;
                text-decoration: none;
                font-size: 16px;
            }

                .link-btn a:hover {
                    text-decoration: underline;
                }
    </style>
</head>
<body>
    <div class="logo">
        <img src="Images/LoginLogo.png" alt="logo" height="150" width="auto" />
    </div>
    <form id="registrationForm" runat="server">

        <div class="form-container">

            <asp:ScriptManager ID="ScriptManager1" runat="server" />
            <!-- Page 1 -->
            <asp:Panel ID="page1" runat="server" Visible="true">
                <h2>Step 1: Personal Details</h2>
                <div class="form-group">
                    <label for="FullName">Full Name:</label>
                    <asp:TextBox ID="FullName" runat="server" MaxLength="30" required="true" />
                </div>
                <div class="form-group">
                    <label for="Email">Email:</label>
                    <asp:TextBox ID="Email" runat="server" MaxLength="50" TextMode="Email" required="true" />
                </div>
                <div class="form-group">
                    <label for="PhoneNumber">Phone Number:</label>
                    <asp:TextBox
                        ID="PhoneNumber"
                        runat="server"
                        TextMode="Phone"
                        CssClass="form-control"
                        MaxLength="15"></asp:TextBox>

                    <asp:RegularExpressionValidator
                        ID="PhoneValidator"
                        runat="server"
                        ControlToValidate="PhoneNumber"
                        ErrorMessage="Enter a valid phone number."
                        ValidationExpression="^\+?[0-9]{7,15}$"
                        ForeColor="Red"></asp:RegularExpressionValidator>

                </div>
                <div class="form-group">
                    <label for="ddlStates">State:</label>
                    <asp:DropDownList ID="ddlStates" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlStates_SelectedIndexChanged">
                        <asp:ListItem Text="-- Select State --" Value="" />
                        <asp:ListItem Text="Rajasthan" Value="Rajasthan" />
                        <asp:ListItem Text="Maharashtra" Value="Maharashtra" />
                        <asp:ListItem Text="Karnataka" Value="Karnataka" />
                        <asp:ListItem Text="Tamil Nadu" Value="Tamil Nadu" />
                        <asp:ListItem Text="Punjab" Value="Punjab" />
                    </asp:DropDownList>
                </div>
                <div class="form-group">
                    <label for="ddlCities">City:</label>
                    <asp:DropDownList ID="ddlCities" runat="server">
                        <asp:ListItem Text="-- Select City --" Value="" />
                    </asp:DropDownList>
                </div>
                <div class="form-group">
                    <label for="ddlGender">Gender:</label>
                    <asp:DropDownList ID="ddlGender" runat="server">
                        <asp:ListItem Text="-- Select Gender --" Value="" />
                        <asp:ListItem Text="Male" Value="Male" />
                        <asp:ListItem Text="Female" Value="Female" />
                        <asp:ListItem Text="Other" Value="Other" />
                    </asp:DropDownList>
                </div>
                <div class="form-group">
                    <label for="Password">Password:</label>
                    <asp:TextBox ID="Password" runat="server" required="true" />
                    <span class="eye-icon" onclick="togglePasswordVisibility('Password')">
                        <i class="fas fa-eye"></i>
                        <!-- Eye Icon -->
                    </span>
                    <asp:RegularExpressionValidator
                        ID="PasswordValidator"
                        runat="server"
                        ControlToValidate="Password"
                        ValidationExpression="^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$"
                        ErrorMessage="Password must be at least 8 characters long!"
                        ForeColor="Red" />
                </div>

                <div class="form-group">
                    <label for="ConfirmPassword">Confirm Password:</label>
                    <asp:TextBox ID="ConfirmPassword" runat="server" required="true" />
                    <span class="eye-icon" onclick="togglePasswordVisibility('ConfirmPassword')">
                        <i class="fas fa-eye"></i>
                        <!-- Eye Icon -->
                    </span>
                    <asp:CompareValidator
                        ID="ComparePasswordValidator"
                        runat="server"
                        ControlToValidate="ConfirmPassword"
                        ControlToCompare="Password"
                        ErrorMessage="Passwords do not match."
                        ForeColor="Red" />
                </div>

                <div class="form-group">
                    <asp:Button ID="NextButton" runat="server" Text="Next" CssClass="submit-btn" OnClick="NextButton_Click" />
                </div>
            </asp:Panel>

            <!-- Page 2 -->
            <asp:Panel ID="page2" runat="server" Visible="false">
                <h2>Step 2: Professional Details</h2>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>

                        <div class="form-group">
                            <label for="YearsOfExperience">Years of Experience:</label>
                            <asp:TextBox ID="YearsOfExperience" runat="server" TextMode="Number" Text="" />
                        </div>
                        <div class="form-group">
                            <label for="BCIEnrolmentCertificate">BCI Enrolment Certificate:</label>
                            <asp:FileUpload ID="BCIEnrolmentCertificate" runat="server" />
                        </div>
                        <div class="form-group">
                            <label for="AreaOfSpecialization">Area of Specialization:</label>
                            <asp:DropDownList ID="AreaOfSpecialization" runat="server">
                                <asp:ListItem Text="Select Specialization" Value="" />
                                <asp:ListItem Text="Civil Law" Value="1" />
                                <asp:ListItem Text="Criminal Law" Value="2" />
                                <asp:ListItem Text="Corporate Law" Value="3" />
                            </asp:DropDownList>
                        </div>
                        <div class="form-group">
                            <label for="Photograph">Photograph:</label>
                            <asp:FileUpload ID="Photograph" runat="server" />
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
                <div class="form-group">
                    <asp:Button ID="BackButton" runat="server" Text="Back" CssClass="submit-btn" OnClick="BackButton_Click" />
                    <asp:Button ID="SubmitButton" runat="server" Text="Submit" CssClass="submit-btn" OnClick="SubmitButton_Click" />
                </div>
            </asp:Panel>
            <div class="link-btn">
                <a href="LoginPage.aspx">Already have an account? Login here</a>
            </div>
        </div>
        <script type="text/javascript">
            function togglePasswordVisibility(id) {
              
                var passwordField = document.getElementById(id);
                var icon = passwordField.nextElementSibling.querySelector('i');

             
                if (passwordField.type === "password") {
                    passwordField.type = "text";
                    icon.classList.remove('fa-eye');
                    icon.classList.add('fa-eye-slash');
                } else {
                    passwordField.type = "password";
                    icon.classList.remove('fa-eye-slash');
                    icon.classList.add('fa-eye');
                }
            }
        </script>

    </form>
</body>
</html>
