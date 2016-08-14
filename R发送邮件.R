#install.packages('mailR')
library("mailR")

sender <- "zhoutaor2013@163.com"
recipients <- c("zhoutaonihao1988@163.com", "372814616@qq.com")
email <- send.mail(
  from = sender,
  to = recipients,
  subject="Subject of the email",
  body = "Body of the email",
  smtp = list(
    host.name = "zhoutaor2013@163.com", 
    user.name = "zhoutaor2013@163.com",
    passwd = "ztnh372814616110",
    port = 465, ssl=TRUE
  ),
  authenticate = TRUE,
  send = TRUE
)

#install.packages("sendmailR")
library("sendmailR")
control <- list(smtpServer = "smtp.datayes.com", smtpPortSMTP = 465)
from = "sender@126.com"
to = "recipent@126.com"
subj = "testing mail"
msg = "sent by R"
sendmail(from, to, subj, msg, control = control)