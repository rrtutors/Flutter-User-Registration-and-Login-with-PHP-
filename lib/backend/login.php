<?php
require_once('./mysqli_connect.php');
$keys=array('email','password');

for ($i = 0; $i < count($keys); $i++){
	if(!isset($_POST[$keys[$i]]))

	 {
		  $response['error'] = true;
			$response['message'] = 'Required Filed Missed';
			echo json_encode($response);
		  return;
	 }

}
$email=$_POST['email'];
$password=$_POST['password'];

$stmt = $con->prepare("SELECT * FROM z_dummy_users WHERE email = ? AND password = ?");
					$stmt->bind_param("ss", $email, $password);
					$stmt->execute();
					$stmt->store_result();
					if($stmt->num_rows > 0){

						$stmt->bind_result( $id, $name,  $email,$password);
							$stmt->fetch();

							$user = array(
								'id'=>$id,
								'name'=>$name,
								'mobile'=>$mobile,
								'password'=>$password,
								'email'=>$email

							);

							$stmt->close();
							$response['error'] = false;
							$response['message'] = 'User Loggedin';
							$response['data'] = $user;
					}else
					{
						$response['error'] = true;
						$response['message'] = 'Invalid User Name or Mobile';
						$stmt->close();

					}
					echo json_encode($response);

?>