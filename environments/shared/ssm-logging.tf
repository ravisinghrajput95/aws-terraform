# Session Manager audit logging to CloudWatch.
resource "aws_cloudwatch_log_group" "ssm_sessions" {
  name              = "/cloudcart/ssm/session-logs"
  retention_in_days = 90
}

# Session Manager preferences. NOTE: this document name is account/region-global,
# so it sets Session Manager logging for the whole account in this region.
resource "aws_ssm_document" "session_prefs" {
  name            = "SSM-SessionManagerRunShell"
  document_type   = "Session"
  document_format = "JSON"

  content = jsonencode({
    schemaVersion = "1.0"
    description   = "CloudCart Session Manager preferences (log sessions to CloudWatch)"
    sessionType   = "Standard_Stream"
    inputs = {
      cloudWatchLogGroupName      = aws_cloudwatch_log_group.ssm_sessions.name
      cloudWatchEncryptionEnabled = false
      cloudWatchStreamingEnabled  = true
      idleSessionTimeout          = "20"
      runAsEnabled                = false
      shellProfile                = { linux = "" }
    }
  })
}
