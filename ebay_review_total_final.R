####4\>n :s55 
summary(iphone.review$rating)
library(ggplot2)
ggplot(iphone.review, aes(x=rating))+
  geom_bar(color='darkblue', fill='cadetblue', width=0.6)+
  scale_x_continuous(breaks=c(1,2,3,4,5),
                     labels=c('1 star', '2 star', '3 star', '4 star', '5 star'))+
  labs(x='Rating', y='Frequency',
       title="Review of iPhone",
       subtitle='Rating distribution',
       caption="Source: Ebay")+
  theme_gray()+
  theme(plot.title=element_text(face='bold'),
        axis.text = element_text(face='bold'))

summary(nchar(iphone.review$review))
ggplot(iphone.review, aes(x=nchar(review)))+
  geom_histogram(color='brown', fill='coral')+
  labs(x='Review length', y='Frequency',
       title="Review of iPhone",
       subtitle='Distribution of review length',
       caption="Source: Ebay")+
  theme_gray()+
  theme(plot.title=element_text(face='bold'),
        axis.text = element_text(face='bold'))
nrow(iphone.review[nchar(iphone.review$review) > 3000,])

ggplot(iphone.review[nchar(iphone.review$review) <= 3000,],
       aes(x=as.factor(rating), y=nchar(review)))+
  geom_boxplot(fill="goldenrod", color='dimgray')+
  scale_x_discrete(breaks=c(1, 2, 3, 4, 5),
                   labels=c('1 star', '2 star', '3 star', '4 star', '5 star'))+
  labs(x='Rating', y='Review Length',
       title='Review of iPhone',
       subtitle="Distribution of review length by rating",
       caption='Source: Ebay')+
  theme_gray()+
  theme(plot.title = element_text(face='bold'),
        axis.text = element_text(face='bold'))

library(dplyr)

library(tidytext)
afinn.score<- get_sentiments(lexicon='afinn')
summary(afinn.score)
library(magrittr)
iphone.review.words<- unnest_tokens(tbl= iphone.review, output=word, input=review, token='words') %>% 
  anti_join(stop_words, by='word') %>% select(-c(product, date)) %>% as_tibble(.)

iphone.review.words<- unnest_tokens(tbl= iphone.review, output=word, input=review, token='words')
iphone.review.words
left_join(iphone.review.words, afinn.score, by='word')
iphone.sent.review <- iphone.review.words %>% left_join(afinn.score, by='word') %>% group_by(id, rating) %>% summarise(score_avg=mean(score, na.rm=T)) %>% ungroup()
iphone.sent.review
#8.:d 0(A$A!<v Fr1U0z :0A! 
ggplot(iphone.sent.review, aes(x=as.factor(rating), y=score_avg))+
  geom_boxplot(fill='lavenderblush', color='black')+
  scale_x_discrete(breaks=c(1, 2, 3, 4, 5),
                   labels=c('1 star', '2 star', '3 star', '4 ster', '5 star'))+
  labs(x='Rating', y='Average sentiment Score of words',
       title='Review of iPhone',
       subtitle='Distribution of average sentiment score by review rating',
       caption="Source: Ebay")+
  theme_gray()+
  theme(plot.title = element_text(face='bold'),
        axis.text = element_text(face='bold'))
iphone.sent.word<- iphone.review.words %>% count(id, rating, word) %>% group_by(word) %>%
  summarise(in_review=n(), in_use=sum(n), rating_avg=mean(rating)) %>%
  filter(in_review >=3) %>% arrange(rating_avg) %>% inner_join(get_sentiments(lexicon='afinn'), by='word')%>% ungroup
iphone.sent.word
#0(A$;g@| 
ggplot(iphone.sent.word, aes(x=as.factor(score), y=rating_avg))+
  geom_boxplot(fill='aquamarine', color='black')+
  scale_y_continuous(breaks=c(1, 2, 3, 4, 5),
                     labels=c('1 star', '2 star', '3 star', '4 star', '5 star'))+
  labs(x='Sentiment Score', y='Average Rating of Reviews',
       title='Review of iPhone',
       subtitle='Distribution of average review rationg by sentiment score of word',
       caption='Source: Ebay')+
  theme_gray()+
  theme(plot.title = element_text(face='bold'),
        axis.text = element_text(face='bold'))
review<- xpathSApply(e.parsed, path="//p[@itemprop='reviewBody']", xmlValue)


#=E0f8A
library(RTextTools)
ebay.dtm<- create_matrix(textColumns = ebay.review$review, language = 'english', removeNumbers = T,
                         removePunctuation = T, removeStopwords = T, stemWords = F, stripWhitespace = T, toLower = T, removeSparseTerms = .99)
ebay.dtm
ebay.dtm<-as_tibble(as.matrix(ebay.dtm), row.names=ebay.review$id)
ebay.dtm
train.end<- round(nrow(ebay.dtm)* 0.7, 0)
test.end<- nrow(ebay.dtm)
train.end; test.end - train.end
my.container<- create_container(matrix=ebay.dtm, labels=ebay.review$rating,
                                trainSize = 1:train.end, testSize = (train.end+1):test.end, virgin = F)
my.classifier <- train_models(container = my.container, algorithms = c('RF', 'SVM'))
print_algorithms()
my.predictions<- classify_models(container = my.container, models=my.classifier)
head(my.predictions)
table(ebay.review$rating[(train.end+1):test.end],
      my.predictions$FORESTS_LABEL, dnn=c("Actual", "Predicted"))
mean(ebay.review$rating[(train.end+1):test.end]==my.predictions$FORESTS_LABEL)
mean(ebay.review$rating[(train.end+1):test.end]==my.predictions$SVM_LABEL)
train.end
test.end
View(ebay.dtm)
#=C0h?-
library(lubridate)
library(dplyr)
date<-xpathSApply(e.parsed, '//span[@class="review-item-date"]', xmlValue)
date2<-as.Date(date, format='%B %d, %Y')
Sys.setlocale("LC_TIME", "C")
date2
Sys.setlocale("LC_TIME", "C")
iphone.review$date<-as.Date(iphone.review$date, format='%B %d, %Y')
iphone.review$ym<- floor_date(x=iphone.review$date, unit='month') 
iphone.review$ym
ebay.agg<- iphone.review %>% group_by(product, ym) %>% summarise(rating=mean(rating, na.rm=T), n=n())%>% ungroup()
ebay.agg
library(ggplot2)
ggplot(ebay.agg, aes(x=ym, y=rating))+
  geom_line(color='khaki4', size=1)+
  geom_smooth(method='loess', color='dodgerblue', size=1)+
  scale_x_date(date_labels="%Y", date_breaks='2 years')+
  scale_y_continuous(limits=c(1, 5), breaks=c(1, 2, 3, 4, 5),
                     labels=c('1 star', '2 star', '3 star', '4 star', '5 star'))+
  theme_gray()+
  theme(text=element_text(family='sans'),
        plot.title=element_text(face='bold'))+
  labs(x=NULL, y='Rating',
       title= 'Review of iPhone',
       subtitle= 'Rating scores over time',
       caption='Source: ebay')
ggplot(ebay.agg, aes(x=ym, y=n))+
  geom_line(color='khaki4', size=1)+
  geom_smooth(method='loess', color='dodgerblue', size=1)+
  scale_x_date(date_labels="%Y", date_breaks='2 years')+
  theme_gray()+
  theme(text=element_text(family='sans'),
        plot.title=element_text(face='bold'))+
  labs(x=NULL, y='Numbers of Reviews',
       title= 'Review of iPhone',
       subtitle= 'Rating scores over time',
       caption='Source: ebay')

#:q=AGQ A&G0 :q13
url2<- 'https://www.ebay.com/urw/Apple-MacBook-Pro-A1278-13-3-Laptop-MD102LL-A-June-2012-/product-reviews/115139414?_itm=153251278603&pgn=1'
url3<- 'https://www.ebay.com/urw/Apple-MacBook-Air-A1466-13-3-Laptop-MD231LL-A-June-2012-/product-reviews/115136931?_itm=163361173182&pgn=1'
ebay.review3<- ebayreview(baseurl = url2, n=7)
iphone5s.review$product <- regmatches(iphone5s.review$product,gregexpr(pattern, iphone5s.review$product))
a$product <-regmatches(a$product,gregexpr(pattern, a$product))
 
#iphone6
Sys.setlocale("LC_TIME", "C")
iphone6.review.last$date<-as.Date(iphone6.review.last$date, format='%B %d, %Y')
iphone6.review.last$ym<- floor_date(x=iphone6.review.last$date, unit='month')
iphone6.review.last$product <- regmatches(iphone6.review.last$product,gregexpr(pattern, iphone6.review.last$product))

#ebay.review4<- ebayreview(baseurl = url3, n=10)

#iphone6s
Sys.setlocale("LC_TIME", "C")
iphone6s.review$date<-as.Date(iphone6s.review$date, format='%B %d, %Y')
iphone6s.review$ym<- floor_date(x=iphone6s.review$date, unit='month')
iphone6s.review$product <- regmatches(iphone6s.review$product,gregexpr(pattern, iphone6s.review$product))

#iphone7
Sys.setlocale("LC_TIME", "C")
iphone7.review.last2$date<-as.Date(iphone7.review.last2$date, format='%B %d, %Y')
iphone7.review.last2$ym<- floor_date(x=iphone7.review.last2$date, unit='month')
iphone7.review.last2$product <- regmatches(iphone7.review.last2$product,gregexpr(pattern, iphone7.review.last2$product))

#iphone8
Sys.setlocale("LC_TIME", "C")
iphone8.review$date<-as.Date(iphone8.review$date, format='%B %d, %Y')
iphone8.review$ym<- floor_date(x=iphone8.review$date, unit='month')
iphone8.review$product <- regmatches(iphone8.review$product,gregexpr(pattern, iphone8.review$product))

#iphonex
Sys.setlocale("LC_TIME", "C")
iphonex.review$date<-as.Date(iphonex.review$date, format='%B %d, %Y')
iphonex.review$ym<- floor_date(x=iphonex.review$date, unit='month')
iphonex.review$product <- regmatches(iphonex.review$product,gregexpr(pattern, iphonex.review$product))


ebay.reviewp<-rbind(iphone6.review.last,iphone6s.review, iphone7.review.last2, iphone8.review, iphonex.review)
nrow(ebay.reviewp)
stime<- max(min(iphone6.review.last[iphone6.review.last$product=="iPhone 6",]$date),
            min(iphone6s.review[iphone6s.review$product=="iPhone 6s" ,]$date),
            min(iphone7.review.last2[iphone7.review.last2$product=="iPhone 7",]$date),
            min(iphone8.review[iphone8.review$product=="iPhone 8",]$date),
            min(iphonex.review[iphonex.review$product=="iPhone X",]$date)         )
stime
View(stime)
ebay.reviewp<- filter(ebay.reviewp, date>= stime)
View(ebay.reviewp)
ebay.reviewp$ym<- floor_date(x=ebay.reviewp$date, unit='month')
ebay.agg<- ebay.reviewp %>% group_by(product, ym) %>% summarise(rating=mean(rating, na.rm=T), n=n())%>% ungroup()

ggplot(ebay.agg, aes(x=ym, y=rating, color=product))+
  geom_line(linetype='dotted')+
  geom_point(shape=21, fill='gray30')+
  geom_smooth(method='loess')+
  scale_x_date(date_labels='%Y', date_breaks = 'years')+
  scale_y_continuous(limits=c(1, 5), breaks=seq(1, 5, by=1),
                     labels=c('1 star', '2 star', '3 star', '4 star', '5 star'))+
  theme_bw()+
  theme(text=element_text(family='sans'),
        plot.title=element_text(face='bold'),
        axis.text=element_text(size=8),
        legend.position='bottom',
        legend.title=element_blank())+
  labs(x=NULL, y='Rating',
       title='Review of iPhone',
       subtitle='Rating scores of iPhone',
       caption='Source: ebay')
#;!0-:i7 3<<4k 7%8g / CJ7O: i5 3<<4k 7%4g / FD6{: i5 2<<4k 7%2g / 


#wordcloud
library(SnowballC)
library(tm)
trace(utils:::unpackPkgZip, edit=TRUE)
doc <- Corpus(VectorSource(health.review))
class(doc)
inspect(doc)

doc <- tm_map(doc, removePunctuation)
doc <- tm_map(doc, content_transformer(tolower))
mystopwords <- c(stopwords("english"),
                 c("also","among","but","even","four","get","one","said","the","there",
                   "two","three","with","this","and","<99>"))
doc <- tm_map(doc, removeWords, mystopwords)
doc <- tm_map(doc, stripWhitespace)
doc <- tm_map(doc, stemDocument)
dtm <- DocumentTermMatrix(doc)
dtm
inspect(dtm[,1:10])
term.freq <- colSums(as.matrix(dtm))
term.freq[order(term.freq, decreasing = TRUE)][1:10]


library(wordcloud)
library(RColorBrewer)
set.seed(1234)
term.freq <- colSums(as.matrix(dtm))
wordcloud(words = names(term.freq), freq = term.freq, scale = c(4,0.2),min.freq = 3, rot.per = 0, random.order = FALSE,
          random.color = FALSE, colors = brewer.pal(6, "Set2"))


####4\>n :s55 
summary(health.review$rating)
library(ggplot2)
ggplot(health.review, aes(x=rating))+
  geom_bar(color='darkblue', fill='gold', width=0.6)+
  scale_x_continuous(breaks=c(1,2,3,4,5),
                     labels=c('1 star', '2 star', '3 star', '4 star', '5 star'))+
  labs(x='Rating', y='Frequency',
       title="Health catergory product",
       subtitle='Rating distribution',
       caption="Source: Ebay")+
  mytheme

summary(nchar(iphone.review$review))
ggplot(iphone.review, aes(x=nchar(review)))+
  geom_histogram(color='brown', fill='chocolate')+
  labs(x='Review length', y='Frequency',
       title="iPhone",
       subtitle='Distribution of review length',
       caption="Source: Ebay")+
  mytheme
nrow(health.review[nchar(health.review$review) > 3000,])

ggplot(iphone.review[nchar(iphone.review$review) <= 3000,],
       aes(x=as.factor(rating), y=nchar(review)))+
  geom_boxplot(fill="khaki1", color='indianred')+
  scale_x_discrete(breaks=c(1, 2, 3, 4, 5),
                   labels=c('1 star', '2 star', '3 star', '4 star', '5 star'))+
  labs(x='Rating', y='Review Length',
       title='Review of iPhone',
       subtitle="Distribution of review length by rating",
       caption='Source: Ebay')+
  theme_gray()+
  mytheme

library(dplyr)

library(tidytext)
affin.score<- get_sentiments(lexicon='afinn')
summary(afinn.score)
library(magrittr)
health.review.words<- unnest_tokens(tbl= health.review, output=word, input=review, token='words') %>% 
  anti_join(stop_words, by='word') %>% select(-c(product, date)) %>% as_tibble(.)

health.review.words<- unnest_tokens(tbl= v.review, output=word, input=review, token='words')
health.review.words
left_join(health.review.words, afinn.score, by='word')
health.sent.review <- health.review.words %>% left_join(afinn.score, by='word') %>% group_by(id, rating) %>% summarise(score_avg=mean(score, na.rm=T)) %>% ungroup()
health.sent.review
#8.:d 0(A$A!<v Fr1U0z :0A! 
ggplot(health.sent.review, aes(x=as.factor(rating), y=score_avg))+
  geom_boxplot(fill='navyblue', color='aquamarine4', size=0.7)+
  geom_line(size =0.7, color='aquamarine4')+
  scale_x_discrete(breaks=c(1, 2, 3, 4, 5),
                   labels=c('1 star', '2 star', '3 star', '4 ster', '5 star'))+
  labs(x='Rating', y='Average sentiment Score of words',
       title='Review of Health catergory product',
       subtitle='Distribution of average sentiment score by review rating',
       caption="Source: Ebay")+
  mytheme
health.sent.word<- health.review.words %>% count(id, rating, word) %>% group_by(word) %>%
  summarise(in_review=n(), in_use=sum(n), rating_avg=mean(rating)) %>%
  filter(in_review >=3) %>% arrange(rating_avg) %>% inner_join(get_sentiments(lexicon='afinn'), by='word')%>% ungroup
health.sent.word
#0(A$;g@| 
ggplot(health.sent.word, aes(x=as.factor(score), y=rating_avg))+
  geom_boxplot(fill='slateblue3', color='orange', size=0.7)+
  scale_y_continuous(breaks=c(1, 2, 3, 4, 5),
                     labels=c('1 star', '2 star', '3 star', '4 star', '5 star'))+
  labs(x='Sentiment Score', y='Average Rating of Reviews',
       title='Review of Health catergory product',
       subtitle='Distribution of average review rating by sentiment score of word',
       caption='Source: Ebay')+
  mytheme
review<- xpathSApply(e.parsed, path="//p[@itemprop='reviewBody']", xmlValue)


#=E0f8A
library(RTextTools)
library(tibble)
health.dtm<- create_matrix(textColumns = health.review$review, language = 'english', removeNumbers = T,
                           removePunctuation = T, removeStopwords = T, stemWords = F, stripWhitespace = T, toLower = T, removeSparseTerms = .99)
health.dtm
health.dtm<-as_tibble(as.matrix(health.dtm), row.names=health.review$id)
health.dtm
train.end<- round(nrow(health.dtm)* 0.7, 0)
test.end<- nrow(health.dtm)
train.end; test.end - train.end
my.container<- create_container(matrix=health.dtm, labels=health.review$rating,
                                trainSize = 1:train.end, testSize = (train.end+1):test.end, virgin = F)
my.classifier <- train_models(container = my.container, algorithms = c('RF', 'SVM'))
print_algorithms()
my.predictions<- classify_models(container = my.container, models=my.classifier)
head(my.predictions)
table(health.review$rating[(train.end+1):test.end],
      my.predictions$FORESTS_LABEL, dnn=c("Actual", "Predicted"))
mean(health.review$rating[(train.end+1):test.end]==my.predictions$FORESTS_LABEL)
mean(health.review$rating[(train.end+1):test.end]==my.predictions$SVM_LABEL)
train.end
test.end
View(health.dtm)
#=C0h?-
windowsFonts(
  Arial   = windowsFont("Arial"),
  Calibri = windowsFont("Calibri"),
  Cambria = windowsFont("Cambria")
)
windowsFonts()
library(lubridate)
library(dplyr)
health.agg<- health.review %>% group_by(product, date) %>% summarise(rating=mean(rating, na.rm=T), n=n())%>% ungroup()
health.agg
library(ggplot2)
ggplot(health.agg, aes(x=date, y=rating))+
  geom_line(color='khaki4', size=1)+
  geom_smooth(method='loess', color='firebrick4', size=1.5)+
  scale_x_date(date_labels="%Y", date_breaks='1 years')+
  scale_y_continuous(limits=c(1, 5), breaks=c(1, 2, 3, 4, 5),
                     labels=c('1 star', '2 star', '3 star', '4 star', '5 star'))+
  labs(x=NULL, y='Rating',
       title= 'Review of Vitamin product',
       subtitle= 'Rating scores over time',
       caption='Source: ebay')+ mytheme
ggplot(health.agg, aes(x=date, y=n))+
  geom_line(color='khaki4', size=1)+
  geom_smooth(method='loess', color='firebrick4', size=1.5)+
  scale_x_date(date_labels="%Y", date_breaks='1 years')+
  labs(x=NULL, y='Numbers of Reviews',
       title= 'Review of Health catergory product',
       subtitle= 'Rating scores over time',
       caption='Source: ebay') + mytheme

##0(A$4\>n  
install.packages("tidytext")
library(tidytext)
install.packages("backports")
bing <- get_sentiments("bing")
bing

install.packages("tidyverse")
library(tidyverse)
iphone.review.words <-
  unnest_tokens(tbl=iphone.review, output=word, input=review, token="words")%>%
  anti_join(stop_words, by="word")%>%
  as_tibble(.)

iphone.review.words

iphone.sent.review <- iphone.review.words %>%
  inner_join(bing, by="word") %>%
  count(id, word, sentiment)%>%
  spread(sentiment, n, fill=0) %>%
  mutate(sentiments=positive - negative) %>%
  ungroup()

iphone.sent.review

summary(iphone.sent.review$sentiments)

iphone.sent.review <- iphone.review.words %>%
  inner_join(bing, by="word")%>%
  count(sentiment, word)%>%
  ungroup() %>%
  filter(n >10)%>%
  mutate(nsign=ifelse(sentiment=="negative",-n,n))

windows(width = 20.0, height = 20)
ggplot(iphone.sent.review,
       aes(x=reorder(word,nsign), y=nsign,
           fill=factor(sentiment,levels = c("positive","negative"))))+
  geom_bar(stat = "identity", color="lightslategray", width=0.8)+
  geom_text(aes(label=n),size=3, color="black",
            hjust=ifelse(iphone.sent.review$nsign <0, 1.1, -0.1))+
  scale_fill_manual(values=c("cornflowerblue","tomato"))+
  coord_flip()+
  labs(x="Word",y="Count",
       title="Review of iPhone",
       subtitle="Top words contributing to sentiment",
       caption="Source : Ebay")+
  theme_minimal()+
  theme(text=element_text(family = "sans"),
        plot.title = element_text(face="bold"),
        axis.text = element_text(size=10),
        legend.position = "bottom",
        legend.title = element_blank())

windowsFonts(
  Arial   = windowsFont("Arial"),
  Calibri = windowsFont("Calibri"),
  Cambria = windowsFont("Cambria")
)
mytheme<- theme(plot.title = element_text(family='Arial', 
                                          size = '21', color='darkmagenta'),
                panel.border = element_rect(color = "black", fill=NA, size = 1.2),
                axis.title = element_text(face='plain',
                                          size = '17', color='tomato'),
                axis.text = element_text(face = 'bold.italic',
                                         size='14', color='dodgerblue3'),
                plot.subtitle=element_text(family = 'Cambria',
                                           size='18', color='forestgreen'),
                plot.caption = element_text(family= 'Calibri', size='12'),
                panel.background = element_rect(fill='snow', color='darkblue'),
                panel.grid.major.y=element_line(color='gray', linetype = 'solid'),
                panel.grid.minor.y=element_line(color='gray', linetype = 'dashed'),
                legend.position='top')  


#8.:d1f@L:0 FrA!  
windows(20,20)
ggplot(iphone.sent.word, aes(x=as.factor(score), y=rating_avg))+
  geom_boxplot(fill='slateblue3', color='orange', size=0.7)+
  scale_y_continuous(breaks=c(1, 2, 3, 4, 5),
                     labels=c('1 star', '2 star', '3 star', '4 star', '5 star'))+
  labs(x='Sentiment Score', y='Average Rating of Reviews',
       title='Review of iPhone',
       subtitle='Distribution of average review rating by sentiment score of word',
       caption='Source: Ebay')+
  mytheme

stime<- iphone6s.review[3,]$date
stime
iphone.review$review<-gsub("[^[:alnum:]///' ]", "",iphone.review$review)
iphone.review$date
Sys.setlocale("LC_ALL", "C")
i.review<- filter(iphone.review, date>= stime)

install.packages("lubridate")
library(lubridate)
library(ggplot2)
i.review$product <- unlist(i.review$product)
i.review$review <- gsub("[^[:alnum:]///' ]", "",i.review$review)

i.review$product <- unlist(i.review$product)
i.review$date<- floor_date(x=i.review$date, unit='month')
i.agg<- i.review %>% group_by(product, date) %>% summarise(rating=mean(rating, na.rm=T), n=n())%>% ungroup()
head(i.review$date)

windows(50,50)
ggplot(i.agg, aes(x=as.Date(date,"%Y-%m-%d"), y=rating, color=product))+
  geom_line(linetype='dotted')+
  geom_point(shape=19, fill='gray30')+
  geom_smooth(method='loess')+
  scale_x_date(date_labels='%m', date_breaks = 'month')+
  scale_y_continuous(limits=c(1, 5), breaks=seq(1, 5, by=1),
                     labels=c('1 star', '2 star', '3 star', '4 star', '5 star'))+
  scale_colour_discrete(labels=c("5s", "6", "6s","7","8","X"))+
  theme_bw()+
  theme(text=element_text(family='sans'),
        plot.title=element_text(face='bold'),
        axis.text=element_text(size=8),
        legend.position= c(.8, .32),
        legend.title=element_blank(),
        legend.background = element_rect(color = 'red', size = 2,linetype = 'dashed'),
        legend.key.size = unit(12, 'mm'))+
  
  
  labs(x=NULL, y='Rating',
       title='Review of iPhones',
       subtitle='Rating scores of iPhone 5s/ 6/ 6s/ 7/ 8/ X ver',
       caption='Source: Ebay')
#??????:i7 3?????? ???8g / ??????: i5 3?????? ???4g / ??????: i5 2?????? ???2g / 



##:q13  
stime<- max(min(iphone5s.review$date),
            min(iphone6.review.last$date),
            min(iphone6s.review$date))
            min(iphone7.review.last2$date),
            min(iphone8.review$date),
            min(iphonex.review$date))
stime <- min(iphone6s.review$date)
stime
iphone.review$review<-gsub("[^[:alnum:]///' ]", "",iphone.review$review)
iphone.review$date
Sys.setlocale("LC_ALL", "C")
i.review<- filter(iphone.review, date>= stime)

install.packages("lubridate")
library(lubridate)
library(ggplot2)
a$product <- unlist(a$product)
a$review <- gsub("[^[:alnum:]///' ]", "",a$review)

i.review$product <- unlist(i.review$product)
i.review$date<- floor_date(x=i.review$date, unit='month')
i.agg<- i.review %>% group_by(product, date) %>% summarise(rating=mean(rating, na.rm=T), n=n())%>% ungroup()

windows(50,50)
ggplot(i.agg, aes(x=date, y=rating, color=product))+
  geom_line(linetype='dotted')+
  geom_point(shape=19, fill='gray30')+
  geom_smooth(method='loess')+
  scale_x_date(date_labels='%Y', date_breaks = 'years')+
  scale_y_continuous(limits=c(1, 5), breaks=seq(1, 5, by=1),
                     labels=c('1 star', '2 star', '3 star', '4 star', '5 star'))+
  scale_colour_discrete(labels=c("5s", "6", "6s","7","8","X"))+
  theme_bw()+
  theme(text=element_text(family='sans'),
        plot.title=element_text(face='bold'),
        axis.text=element_text(size=8),
        legend.position= c(.8, .32),
        legend.title=element_blank(),
        legend.background = element_rect(color = 'red', size = 2,linetype = 'dashed'),
        legend.key.size = unit(12, 'mm'))+
  
  
  labs(x=NULL, y='Rating',
       title='Review of iPhones',
       subtitle='Rating scores of iPhone 5s/ 6/ 6s/ 7/ 8/ X ver',
       caption='Source: Ebay')
#;!0-:i7 3<<4k 7%8g / CJ7O: i5 3<<4k 7%4g / FD6{: i5 2<<4k 7%2g / 


###????????? ?????? 
stime<- iphone6s.review[3,]$date
stime
m.review<- filter(iphone.review, date>= stime)
View(m.review)
m.review$date<- as.Date(floor_date(x=m.review$date, unit='month'))
m.agg<- m.review %>% group_by(product, date) %>% summarise(rating=mean(rating, na.rm=T), n=n())%>% ungroup()
windows(50,50)
ggplot(m.agg, aes(x=date, y=rating, color=product))+
  geom_line(linetype='dotted')+
  geom_point(shape=19, fill='gray30')+
  geom_smooth(method='loess')+
  scale_x_date(date_labels='%Y', date_breaks = 'years')+
  scale_y_continuous(limits=c(1, 5), breaks=seq(1, 5, by=1),
                     labels=c('1 star', '2 star', '3 star', '4 star', '5 star'))+
  scale_colour_discrete(labels=c("5s", "6", "6s","7","8","X"))+
  theme_bw()+
  theme(text=element_text(family='sans'),
        plot.title=element_text(face='bold'),
        axis.text=element_text(size=8),
        legend.position= c(.8, .32),
        legend.title=element_blank(),
        legend.background = element_rect(color = 'red', size = 2,linetype = 'dashed'),
        legend.key.size = unit(12, 'mm'))+
  
  labs(x=NULL, y='Rating',
       title='Review of iPhones',
       subtitle='Rating scores of iPhone 5s/ 6/ 6s/ 7/ 8/ X ver',
       caption='Source: Ebay')
  #??????:i7 3?????? ???8g / ??????: i5 3?????? ???4g / ??????: i5 2?????? ???2g /