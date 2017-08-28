install.packages("tm","wordcloud")
library(tm,wordcloud)
install.packages("rvest")
library("rvest")
install.packages("stringr")
library(stringr)


cvread<-read_html("https://www.ncbi.nlm.nih.gov/pubmed/?term=Harel+Dahari")
cvextract<-data.frame()
for(i in 1:60){
cvextract[i,1]<-cvread %>% html_node(stringr::str_c(".rprt:nth-child(",i,") .title a")) %>% html_text()
}

View(cvextract)


# installing selenium to roll over to the next page
install.packages("RSelenium")


library(RSelenium)
checkForServer()
startServer()

remDr<-remoteDriver(browserName='chrome',port=4444L,remoteServerAddr="localhost")
remDr$checkStatus()
remDr$queryRD(ipAddr ="10:88:97:56" )

remDr$getStatus()
remDr$open
remDr$navigate("http://www.google.com")


# installing wdman package 

install.packages("devtools")
library("devtools")
install_github("johndharrison/wdman")

help("RSelenium")


#################The code used for the wordcloud starts from here
##########################The code used above can be used to automatically 
#############fetch titles but it won't work when you are on Loyola server###


setwd(dir="C:/Users/achopra/Desktop/Research/Patient")
harel<-readLines("Wordmap2.txt")
text<-paste(harel,collapse = "")


#punctuation replacement
text2<-gsub(pattern = "\\W",replacement = " ",text)

# digits replacement
text2<-gsub(pattern="\\d",replacement = "",text2)
text2<-tolower(text2)

library(tm)

#remove stop words

stopwords()

text2<-removeWords(text2,stopwords())

text2<-gsub(pattern = "\\b[A-z]\\b{2}",replacement = "",text2)

text2<-stripWhitespace(text2)

install.packages("stringr")
library(stringr)


textbag<-str_split(text2,pattern="\\s+")
textbag<-unlist(textbag)

# sentiment analysis

poswords<-scan('positive-words.txt',what ='character',comment.char = ';' )
negwords<-scan('negative-words.txt',what ='character',comment.char = ';' )

sum(!is.na(match(textbag,poswords)))

sum(!is.na(match(textbag,negwords)))
       
install.packages("wordcloud")
library(wordcloud)
str(textbag)
wordcloud(textbag,min.freq = 2,random.order = FALSE,colors =rainbow(3),scale = c(4,0.5))










