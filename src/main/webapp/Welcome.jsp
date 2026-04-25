<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<script type="text/javascript">
$(document).ready(function(){
	$('#lcolumn').html('<c:if test="${not empty user.picture}"> <img src="${user.picture}" alt="Profile Picture" class="w3-circle w3-margin-bottom" style="width:100px;height:100px;object-fit:cover;"> </c:if>');
});
</script>

<div class="w3-container w3-padding-24 w3-white">
	<p class="w3-large">Login successful!</p>
	<p>Hello <strong>${user.name}</strong>, you can now enjoy all the features.</p>
</div>
