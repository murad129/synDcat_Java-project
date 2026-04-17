<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">
  <title>Register Farmers Details - synDcat</title>

  <!-- Bootstrap 5 + Icons + AOS (CDN) -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.css" rel="stylesheet">

  <!-- Your custom styles -->
  <link href="css/farmer.css" rel="stylesheet">
</head>

<body>

  <header id="header">
    <div class="container">
      <div id="logo" class="pull-left">
        <a href="index.html" class="scrollto">H.M.S</a>
      </div>
      <nav id="nav-menu-container">
        <ul class="nav-menu">
          <li><a href="index.html">Home</a></li>
          <li><a href="changes.jsp">Changes</a></li>
          <li class="menu-active"><a href="farmer.jsp">Farmer Register</a></li>
          <li><a href="farming.jsp">Add Farming</a></li>
          <li><a href="farmerdetails.jsp">Farmer Details</a></li>
          <li><a href="agroproducts.jsp">Agro Products</a></li>
          <li><a href="triggers.jsp">Records</a></li>
          <li class="buy-tickets"><a href="login.jsp">Signin</a></li>
        </ul>
      </nav>
    </div>
  </header>

  <section id="intro">
    <div class="intro-container" data-aos="zoom-in" data-aos-delay="100">
      <h1 class="mb-4 pb-0" style="color: #1e7eff;">
        WELCOME TO ??????? ??
      </h1>
      <p class="mb-4 pb-0" style="color: #4CAF50; font-family: 'PoppinsJaJaDiMJ';">
        ??????? ????? ?????, ??????? ?????? ??????!
        <span style="color: #888888; font-style: italic;">Scroll down to see more?</span>
      </p>
      <a href="agroproducts.jsp" class="about-btn scrollto">AGRO PRODUCTS</a>
    </div>
  </section>

  <main id="main">
    <section id="contact" class="section-with-bg" style="padding: 60px 0;">
      <div class="container" data-aos="fade-up">
        <div class="section-header">
          <h2>Register Farmers Details</h2>
          <p>Please enter the farmer's details accurately below.</p>
        </div>

        <div class="row justify-content-center">
          <div class="col-lg-8">
            <div class="form">
              <!-- Display session messages -->
              <%
                String errorMsg = (String) session.getAttribute("errorMsg");
                String successMsg = (String) session.getAttribute("successMsg");
                if (errorMsg != null) {
              %>
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                  <%= errorMsg %>
                  <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
              <%
                  session.removeAttribute("errorMsg");
                }
                if (successMsg != null) {
              %>
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                  <%= successMsg %>
                  <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
              <%
                  session.removeAttribute("successMsg");
                }
              %>

              <form action="RegisterFarmerServlet" method="POST" role="form">
                <div class="form-group">
                  <label for="farmerName">Farmer Name</label>
                  <input type="text" name="farmername" class="form-control" id="farmerName" placeholder="Enter Farmer Name" required />
                </div>

                <div class="form-group mt-3">
                  <label for="nidNumber">NID Number</label>
                  <input type="text" name="nidnumber" class="form-control" id="nidNumber" placeholder="Enter 10 or 17 digit NID Number" pattern="\d{10}|\d{17}" title="NID must be 10 or 17 digits" required />
                </div>

                <div class="form-group mt-3">
                  <label for="age">Age</label>
                  <input type="number" name="age" class="form-control" id="age" placeholder="Enter Age (18-120)" min="18" max="120" required />
                </div>

                <div class="form-group mt-3">
                  <label for="gender">Select Gender</label>
                  <select class="form-control" name="gender" id="gender" required>
                    <option value="" disabled selected>-- Select Gender --</option>
                    <option value="Male">Male</option>
                    <option value="Female">Female</option>
                  </select>
                </div>

                <div class="form-group mt-3">
                  <label for="phoneNumber">Phone Number</label>
                  <input type="tel" name="phonenumber" class="form-control" id="phoneNumber" placeholder="Enter Phone Number (e.g., 01712345678)" pattern="01[3-9]\d{8}" title="Enter a valid Bangladeshi mobile number (11 digits starting with 01)" required />
                </div>

                <div class="form-group mt-3">
                  <label for="address">Address</label>
                  <textarea class="form-control" name="address" rows="3" id="address" placeholder="Enter Full Address" required></textarea>
                </div>

                <div class="form-group mt-3">
                  <label for="farmingType">Select Farming Type</label>
                  <select class="form-control" name="farmingtype" id="farmingType" required>
                    <option value="" disabled selected>-- Select Farming Type --</option>
                    <option value="Agriculture">Agriculture</option>
                    <option value="Poultry">Poultry</option>
                    <option value="Dairy">Dairy</option>
                    <option value="Fisheries">Fisheries</option>
                  </select>
                </div>

                <div class="text-center mt-4">
                  <button type="submit" class="btn btn-primary" style="background: #1e7eff; border: 0; padding: 10px 24px; border-radius: 50px;">Save Records</button>
                </div>
              </form>
            </div>
          </div>
        </div>
      </div>
    </section>
  </main>

  <a href="#" class="back-to-top"><i class="fa fa-angle-up"></i></a>

  <!-- jQuery (required for main.js & Superfish) -->
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <!-- Bootstrap JS Bundle -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
  <!-- AOS -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.js"></script>
  <!-- Your custom JS (depends on jQuery, Superfish etc.) -->
  <script src="js/farmer.js"></script>
  <script>
    AOS.init();
  </script>
</body>

</html>