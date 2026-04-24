<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>


<form id="registerForm" action="Register" method="POST" enctype="multipart/form-data">

    <div>
        <label class="w3-text-theme">Username</label>
        <input class="w3-input w3-border w3-light-grey" type="text" id="name" name="name" required minlength="5" maxlength="20"
            value="${user.name}" title="Username must be between 5 and 20 characters." />
    </div>

    <div>
        <label class="w3-text-theme">Password</label>
        <input class="w3-input w3-border w3-light-grey" type="password" id="password" name="password" required
            pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*]).{8,}$" value="${user.password}"
            title="Minimum 8 characters, including uppercase, numbers, and a special character (@#$%^&*)." />
    </div>

    <div>
        <label class="w3-text-theme">Repeat password</label>
        <input class="w3-input w3-border w3-light-grey" type="password" id="confirmPassword"
            name="confirmPassword" required value="${user.password}"
            title="Passwords must match" />
    </div>

    <button type="submit" class="w3-button w3-theme w3-section">Submit Registration</button>

</form>


<script>
	App.Errors = {
		  <c:forEach var="error" items="${errors}">
		    "${error.key}": "${error.value}",
		  </c:forEach>
	};
	App.initRegisterValidation(App.Errors);
</script>
