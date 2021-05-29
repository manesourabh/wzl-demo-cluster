<html>
<body>

Your form has been submitted successfully.
<table>
	<?php 


	    foreach ($_POST as $key => $value) {
	        echo "<tr>";
	        echo "<td>";
	        echo $key;
	        echo "</td>";
	        echo "<td>";
	        echo $value;
	        echo "</td>";
	        echo "</tr>";
	    }


	?>
</table>

</body>
</html>