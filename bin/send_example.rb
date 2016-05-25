require 'net/smtp'

data = <<END_OF_DATA
From: Your Name <bob@example.com>
To: Destination Address <someone@testmail.myorg.intranet>
Subject: test message
X-Dupa: Koza 1234

This is a test message.
<strong>Kasia</strong>
END_OF_DATA

smtp = Net::SMTP.start('smtp', 25)
smtp.send_message data, 'bob@example.com', 'someone@testmail.myorg.intranet'
smtp.finish
