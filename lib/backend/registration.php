<?php
require_once('./mysqli_connect.php');
$keys=array('name','email','password');
//$keys=array('name','mobile','password','type');
for ($i = 0; $i < count($keys); $i++){
	if(!isset($_POST[$keys[$i]]))

	 {
		  $response['error'] = true;
			$response['message'] = 'Required Filed Missed';
			echo json_encode($response);
		  return;
	 }

}



$password=$_POST['password'];

$email=$_POST['email'];
$name=$_POST['name'];


//checking if the user is already exist with this username or email
					//as the email and username should be unique for every user
					$stmt = $con->prepare("SELECT id FROM z_dummy_users WHERE email = ? ");
					$stmt->bind_param("s", $email);
					$stmt->execute();
					$stmt->store_result();

					//if the user already exist in the database
					if($stmt->num_rows > 0){
						$response['error'] = true;
						$response['message'] = 'User already registered';
						$stmt->close();

					}else{

						//if user is new creating an insert query
						$stmt = $con->prepare("INSERT INTO z_dummy_users ( name,email, password) VALUES (?,?,  ?)");
						$stmt->bind_param("sss",  $name, $email, $password);

						//if the user is successfully added to the database
						if($stmt->execute()){

							//fetching the user back
							$stmt = $con->prepare("SELECT * FROM z_dummy_users WHERE email = ?");
							$stmt->bind_param("s",$email);
							$stmt->execute();
							$stmt->bind_result( $id, $name, $email,$password);
							$stmt->fetch();

							$user = array(
								'id'=>$id,
								'name'=>$name,
								'email'=>$email,
								'password'=>$password

							);

							$stmt->close();

							//adding the user data in response
							$response['error'] = false;
							$response['message'] = 'User registered successfully';
							$response['data'] = $user;

						}

					}
					echo json_encode($response);


?>