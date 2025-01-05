<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoginPage.aspx.cs" Inherits="Project_UI.LoginPage" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <title>Login</title>
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
        }

        .logo {
            text-align: center;
            margin-top: 0px;
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


        .custom-radio-group {
            display: flex;
            align-items: center;
        }

        .radio-inline {
            display: flex;
            margin-right: 20px;
        }

        .custom-radio {
            appearance: none;
            margin-right: 8px;
            display: inline-block;
            position: relative;
            cursor: pointer;
        }

            .custom-radio:checked {
                background-color: #b85697;
                border-color: #b85697;
            }

                .custom-radio:checked::after {
                    content: '';
                    display: block;
                    width: 10px;
                    height: 10px;
                    background-color: white;
                    border-radius: 50%;
                    position: absolute;
                    top: 50%;
                    left: 50%;
                    transform: translate(-50%, -50%);
                }

        .custom-label {
            font-size: 16px;
            color: #333;
        }
    </style>
</head>
<body>
    <div class="logo">
        <img src="Images/LoginLogo.png" alt="logo" height="150" width="auto" />
    </div>

    <form id="loginForm" runat="server">
        <div class="form-container">
            <h2>Login</h2>

            <div class="form-group">
                <label for="EmailPhone">Email or Phone Number:</label>
                <asp:TextBox ID="EmailPhone" runat="server" MaxLength="50" required="true" placeholder="Enter Email or Phone" />
                <asp:RequiredFieldValidator
                    ID="rfvEmailPhone"
                    runat="server"
                    ControlToValidate="EmailPhone"
                    InitialValue=""
                    ErrorMessage="Email or Phone is required"
                    ForeColor="Red" />
            </div>

            <div class="form-group">
                <label for="Password">Password:</label>
                <asp:TextBox ID="Password" runat="server" MaxLength="15" TextMode="Password" required="true" placeholder="Enter Password" />
                <span class="eye-icon" onclick="togglePasswordVisibility('Password')">
                    <i class="fas fa-eye"></i>
                    <!-- Eye Icon -->
                </span>
                <asp:RequiredFieldValidator
                    ID="rfvPassword"
                    runat="server"
                    ControlToValidate="Password"
                    InitialValue=""
                    ErrorMessage="Password is required"
                    ForeColor="Red" />
            </div>


            <div class="form-group">
                <label>User Type:</label>
                <div class="custom-radio-group">
                    <span class="radio-inline">
                        <asp:RadioButton ID="UserRadio" runat="server" GroupName="UserType" Value="User" Checked="True" CssClass="custom-radio" />
                        <label for="UserRadio" class="custom-label">User</label>
                    </span>
                    <span class="radio-inline">
                        <asp:RadioButton ID="AdvocateRadio" runat="server" GroupName="UserType" Value="Advocate" CssClass="custom-radio" />
                        <label for="AdvocateRadio" class="custom-label">Advocate</label>
                    </span>
                    <span class="radio-inline">
                        <asp:RadioButton ID="AdminRadio" runat="server" GroupName="UserType" Value="Admin" CssClass="custom-radio" />
                        <label for="AdminRadio" class="custom-label">Admin</label>
                    </span>
                </div>
            </div>


            <div class="form-group">
                <asp:Button ID="LoginButton" runat="server" Text="Login" CssClass="submit-btn" OnClick="LoginButton_Click" />
            </div>

            <div class="link-btn">
                <p>
                    Don't have an account? 
                    <a href="User_Register.aspx">Sign Up as User</a> | 
                    <a href="Advocate_Register.aspx">Sign Up as Advocate</a>
                </p>
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
