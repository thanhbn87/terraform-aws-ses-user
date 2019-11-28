{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "SesSendingEmails",
            "Effect": "Allow",
            "Action": "ses:SendRawEmail",
            "Resource": ${resources},
            "Condition": {
                "ForAnyValue:IpAddress": {
                    "aws:SourceIp": ${whitelist_ips}
                }
            }
        }
    ]
}
