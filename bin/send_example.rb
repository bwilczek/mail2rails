require 'net/smtp'

data = <<END_OF_DATA
From: Your Name <your@mail.address>
To: Destination Address <someone@example.com>
Subject: test message
X-Dupa: Koza 1234

This is a test message.
END_OF_DATA

smtp = Net::SMTP.start('smtp', 25)
smtp.send_message data, 'from@address', 'to@address'
smtp.finish
