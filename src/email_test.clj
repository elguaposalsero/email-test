(ns email-test
  (:gen-class)
  (:import (org.apache.commons.mail HtmlEmail)))

(defn -main
  [& _args]
  
  (let [email (doto (HtmlEmail.)
                (.setHostName "localhost")
                (.setSmtpPort 1025)
                (.setFrom "albertdorfman@gmail.com")
                (.setSubject "Hey theres")
                (.setHtmlMsg "<p> Hey there</p>") ; use .setHtmlMsg instead of .setHtmlMessage
                (.addTo "albert.dorfman@owl.co"))]  ; add recipient email here
    (.send email)))
