resource "aws_sns_topic" "alerts_topic" {
  name = "cloud-alerts-topic"
}

resource "aws_sns_topic_subscription" "email_alerts" {
  topic_arn = aws_sns_topic.alerts_topic.arn

  protocol = "email"

  endpoint = "elokajosephine10@gmail.com"
}
