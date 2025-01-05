<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="User_Register.aspx.cs" Inherits="Project_UI.User_Register" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <title>User Registration</title>
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
            height: 100%;
            overflow-y: auto;
            position: relative;
        }

        .logo {
            position: absolute;
            top: 20px;
            left: 20px;
            z-index: 100;
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
            margin-top: 20px;
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

                .form-group input:focus,
                .form-group select:focus {
                    border-color: rgb(173, 112, 193);
                    outline: none;
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
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>

                    <h2>Create An Account</h2>

                    <!-- Full Name -->
                    <div class="form-group">
                        <label for="FullName">Full Name:</label>
                        <asp:TextBox ID="FullName" runat="server" MaxLength="30" CssClass="form-control" required="true" />
                        <asp:RequiredFieldValidator ID="rfvFullName" runat="server" ControlToValidate="FullName" ErrorMessage="Full Name is required" ForeColor="Red" />
                    </div>

                    <!-- Email -->
                    <div class="form-group">
                        <label for="Email">Email:</label>
                        <asp:TextBox ID="Email" runat="server" MaxLength="50" CssClass="form-control" TextMode="Email" required="true" />
                        <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="Email" ErrorMessage="Email is required" ForeColor="Red" />
                    </div>

                    <!-- Phone Number -->
                    <div class="form-group">
                        <label for="PhoneNumber">Phone Number:</label>
                        <asp:TextBox ID="PhoneNumber" runat="server" CssClass="form-control" MaxLength="15" />
                        <asp:RegularExpressionValidator ID="PhoneValidator" runat="server" ControlToValidate="PhoneNumber" ErrorMessage="Enter a valid phone number." ValidationExpression="^\+?[0-9]{7,15}$" ForeColor="Red" />
                    </div>

                    <!-- Gender -->
                    <div class="form-group">
                        <label for="ddlGender">Gender:</label>
                        <asp:DropDownList ID="ddlGender" runat="server" CssClass="form-control">
                            <asp:ListItem Text="-- Select Gender --" Value="" />
                            <asp:ListItem Text="Male" Value="Male" />
                            <asp:ListItem Text="Female" Value="Female" />
                            <asp:ListItem Text="Other" Value="Other" />
                        </asp:DropDownList>
                    </div>

                    <!-- Date of Birth -->
                    <div class="form-group">
                        <label for="DateOfBirth">Date of Birth:</label>
                        <asp:TextBox ID="DateOfBirth" runat="server" TextMode="Date" CssClass="form-control" required="true" />
                        <asp:RequiredFieldValidator ID="rfvDateOfBirth" runat="server" ControlToValidate="DateOfBirth" ErrorMessage="Date of Birth is required" ForeColor="Red" />
                    </div>

                    <!-- State -->
                    <div class="form-group">
                        <label for="ddlStates">State:</label>
                        <asp:DropDownList ID="ddlStates" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlStates_SelectedIndexChanged">
                            <asp:ListItem Text="-- Select State --" Value="" />
                            <asp:ListItem Text="Rajasthan" Value="Rajasthan" />
                            <asp:ListItem Text="Maharashtra" Value="Maharashtra" />
                            <asp:ListItem Text="Karnataka" Value="Karnataka" />
                            <asp:ListItem Text="Tamil Nadu" Value="Tamil Nadu" />
                            <asp:ListItem Text="Punjab" Value="Punjab" />
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="rfvState" runat="server" ControlToValidate="ddlStates" ErrorMessage="State is required" ForeColor="Red" />
                    </div>

                    <!-- City -->
                    <div class="form-group">
                        <label for="ddlCities">City:</label>
                        <asp:DropDownList ID="ddlCities" runat="server" CssClass="form-control">
                            <asp:ListItem Text="-- Select City --" Value="" />
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="rfvCity" runat="server" ControlToValidate="ddlCities" ErrorMessage="City is required" ForeColor="Red" />
                    </div>

                    <!-- Profile Picture -->
                    <div class="form-group">
                        <label for="ProfilePicture">Profile Picture:</label>
                        <asp:FileUpload ID="ProfilePicture" runat="server" CssClass="form-control" />

                    </div>

                    <!-- Password -->
                    <div class="form-group">
                        <label for="Password">Password:</label>
                        <asp:TextBox ID="Password" runat="server" TextMode="Password" CssClass="form-control" required="true" />
                        <span class="eye-icon" onclick="togglePasswordVisibility('Password')"><i class="fas fa-eye"></i></span>
                        <asp:RegularExpressionValidator ID="PasswordValidator" runat="server" ControlToValidate="Password" ValidationExpression="^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$" ErrorMessage="Password must be at least 8 characters long!" ForeColor="Red" />
                    </div>

                    <!-- Confirm Password -->
                    <div class="form-group">
                        <label for="ConfirmPassword">Confirm Password:</label>
                        <asp:TextBox ID="ConfirmPassword" runat="server" TextMode="Password" CssClass="form-control" required="true" />
                        <span class="eye-icon" onclick="togglePasswordVisibility('ConfirmPassword')"><i class="fas fa-eye"></i></span>
                        <asp:CompareValidator ID="ComparePasswordValidator" runat="server" ControlToCompare="Password" ControlToValidate="ConfirmPassword" ErrorMessage="Passwords do not match!" ForeColor="Red" />
                    </div>
                    <%-- <asp:HiddenField ID="HiddenPassword" runat="server" />
                    <asp:HiddenField ID="HiddenConfirmPassword" runat="server" />--%>
                </ContentTemplate>
            </asp:UpdatePanel>

            <!-- Submit Button -->
            <div class="form-group">
                <asp:Button ID="SubmitButton" runat="server" Text="Submit" CssClass="submit-btn" OnClick="SubmitButton_Click" />
            </div>


            <!-- Link to Login -->
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
