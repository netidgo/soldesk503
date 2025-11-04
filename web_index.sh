#!/bin/bash
instance_id=$(ec2-metadata -i | cut -d ' ' -f 2)
private_ip=$(ec2-metadata -o | cut -d ' ' -f 2)
az_name=$(ec2-metadata -z | cut -d ' ' -f 2)

cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Welcome | My Web Server</title>
  <style>
    @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap');

    body {
      font-family: 'Poppins', sans-serif;
      background: linear-gradient(135deg, #74b9ff, #0984e3);
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
      margin: 0;
      color: #2d3436;
    }

    .card {
      background: #fff;
      border-radius: 16px;
      box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
      padding: 40px 60px;
      text-align: center;
      width: 420px;
      max-width: 90%;
      transition: 0.3s;
    }

    .card:hover {
      transform: translateY(-5px);
      box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
    }

    h1 {
      margin-bottom: 20px;
      font-size: 30px;
      color: #0984e3;
    }

    .meta {
      background: #f1f2f6;
      padding: 15px;
      border-radius: 10px;
      margin-top: 10px;
      font-size: 16px;
      text-align: left;
      color: #2d3436;
      line-height: 1.6;
    }

    .meta strong {
      color: #0984e3;
    }

    footer {
      margin-top: 30px;
      font-size: 13px;
      color: #b2bec3;
    }
  </style>
</head>
<body>
  <div class="card">
    <h1>Welcome to My Web Server</h1>
    <div class="meta">
      <p><strong>Instance ID:</strong> ${instance_id}</p>
      <p><strong>Private IP:</strong> ${private_ip}</p>
      <p><strong>Availability Zone:</strong> ${az_name}</p>
    </div>
    <footer>&copy; 2025 NETID AWS Web Server</footer>
  </div>
</body>
</html>
EOF
