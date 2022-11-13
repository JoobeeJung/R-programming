####단어 빈도 
summary(smartphone.review$rating)
library(ggplot2)
windows(50,50)
ggplot(smartphone.review, aes(x=rating))+
  geom_bar(color='darkblue', fill='cadetblue', width=0.6)+
  scale_x_continuous(breaks=c(1,2,3,4,5),
                     labels=c('1 star', '2 star', '3 star', '4 star', '5 star'))+
  labs(x='Rating', y='Frequency',
       title="Review of smartphone",
       subtitle='Rating distribution',
       caption="Source: Ebay")+
  theme_gray()+
  theme(plot.title=element_text(face='bold'),
        axis.text = element_text(face='bold'))

summary(nchar(smartphone.review$review))
windows(50,50)
ggplot(smartphone.review, aes(x=nchar(review)))+
  geom_histogram(color='brown', fill='coral')+
  labs(x='Review length', y='Frequency',
       title="Review of smartphone",
       subtitle='Distribution of review length',
       caption="Source: Ebay")+
  theme_gray()+
  theme(plot.title=element_text(face='bold'),
        axis.text = element_text(face='bold'))
nrow(smartphone.review[nchar(smartphone.review$review) > 3000,])
windows(50,50)

ggplot(smartphone.review[nchar(smartphone.review$review) <= 3000,],
       aes(x=as.factor(rating), y=nchar(review)))+
  geom_boxplot(fill="goldenrod", color='dimgray')+
  scale_x_discrete(breaks=c(1, 2, 3, 4, 5),
                   labels=c('1 star', '2 star', '3 star', '4 star', '5 star'))+
  labs(x='Rating', y='Review Length',
       title='Review of smartphone',
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
smartphone.review.words<- unnest_tokens(tbl= smartphone.review, output=word, input=review, token='words') %>% 
  anti_join(stop_words, by='word') %>% select(-c(product, date)) %>% as_tibble(.)

smartphone.review.words<- unnest_tokens(tbl= smartphone.review, output=word, input=review, token='words')
smartphone.review.words
left_join(smartphone.review.words, afinn.score, by='word')
smartphone.sent.review <- smartphone.review.words %>% left_join(afinn.score, by='word') %>% group_by(id, rating) %>% summarise(score_avg=mean(score, na.rm=T)) %>% ungroup()
smartphone.sent.review
#리뷰 감정점수 평균과 별점 
windows(50,50)

ggplot(smartphone.sent.review, aes(x=as.factor(rating), y=score_avg))+
  geom_boxplot(fill='lavenderblush', color='black')+
  scale_x_discrete(breaks=c(1, 2, 3, 4, 5),
                   labels=c('1 star', '2 star', '3 star', '4 ster', '5 star'))+
  labs(x='Rating', y='Average sentiment Score of words',
       title='Review of smartphone',
       subtitle='Distribution of average sentiment score by review rating',
       caption="Source: Ebay")+
  theme_gray()+
  theme(plot.title = element_text(face='bold'),
        axis.text = element_text(face='bold'))
smartphone.sent.word<- smartphone.review.words %>% count(id, rating, word) %>% group_by(word) %>%
  summarise(in_review=n(), in_use=sum(n), rating_avg=mean(rating)) %>%
  filter(in_review >=3) %>% arrange(rating_avg) %>% inner_join(get_sentiments(lexicon='afinn'), by='word')%>% ungroup
smartphone.sent.word
#감정사전 
windows(50,50)

ggplot(smartphone.sent.word, aes(x=as.factor(score), y=rating_avg))+
  geom_boxplot(fill='aquamarine', color='black')+
  scale_y_continuous(breaks=c(1, 2, 3, 4, 5),
                     labels=c('1 star', '2 star', '3 star', '4 star', '5 star'))+
  labs(x='Sentiment Score', y='Average Rating of Reviews',
       title='Review of smartphone',
       subtitle='Distribution of average review rationg by sentiment score of word',
       caption='Source: Ebay')+
  theme_gray()+
  theme(plot.title = element_text(face='bold'),
        axis.text = element_text(face='bold'))
review<- xpathSApply(e.parsed, path="//p[@itemprop='reviewBody']", xmlValue)


#신경망
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
#시계열
library(lubridate)
library(dplyr)
date<-xpathSApply(e.parsed, '//span[@class="review-item-date"]', xmlValue)
date2<-as.Date(date, format='%B %d, %Y')
Sys.setlocale("LC_TIME", "C")
date2
Sys.setlocale("LC_TIME", "C")
smartphone.review$date<-as.Date(smartphone.review$date, format='%B %d, %Y')
smartphone.review$ym<- floor_date(x=smartphone.review$date, unit='month') 
smartphone.review$ym
ebay.agg<- smartphone.review %>% group_by(product, ym) %>% summarise(rating=mean(rating, na.rm=T), n=n())%>% ungroup()
ebay.agg
library(ggplot2)
windows(50,50)
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
       title= 'Review of smartphone',
       subtitle= 'Rating scores over time',
       caption='Source: ebay')
windows(50,50)
ggplot(ebay.agg, aes(x=ym, y=n))+
  geom_line(color='khaki4', size=1)+
  geom_smooth(method='loess', color='dodgerblue', size=1)+
  scale_x_date(date_labels="%Y", date_breaks='2 years')+
  theme_gray()+
  theme(text=element_text(family='sans'),
        plot.title=element_text(face='bold'))+
  labs(x=NULL, y='Numbers of Reviews',
       title= 'Review of smartphone',
       subtitle= 'Rating scores over time',
       caption='Source: ebay')

#비슷한 제품 비교
url2<- 'https://www.ebay.com/urw/Apple-MacBook-Pro-A1278-13-3-Laptop-MD102LL-A-June-2012-/product-reviews/115139414?_itm=153251278603&pgn=1'
url3<- 'https://www.ebay.com/urw/Apple-MacBook-Air-A1466-13-3-Laptop-MD231LL-A-June-2012-/product-reviews/115136931?_itm=163361173182&pgn=1'
ebay.review3<- ebayreview(baseurl = url2, n=7)
smartphone5s.review$product <- regmatches(smartphone5s.review$product,gregexpr(pattern, smartphone5s.review$product))
a$product <-regmatches(a$product,gregexpr(pattern, a$product))

#smartphone6
Sys.setlocale("LC_TIME", "C")
smartphone6.review.last$date<-as.Date(smartphone6.review.last$date, format='%B %d, %Y')
smartphone6.review.last$ym<- floor_date(x=smartphone6.review.last$date, unit='month')
smartphone6.review.last$product <- regmatches(smartphone6.review.last$product,gregexpr(pattern, smartphone6.review.last$product))

#ebay.review4<- ebayreview(baseurl = url3, n=10)

#smartphone6s
Sys.setlocale("LC_TIME", "C")
smartphone6s.review$date<-as.Date(smartphone6s.review$date, format='%B %d, %Y')
smartphone6s.review$ym<- floor_date(x=smartphone6s.review$date, unit='month')
smartphone6s.review$product <- regmatches(smartphone6s.review$product,gregexpr(pattern, smartphone6s.review$product))

#smartphone7
Sys.setlocale("LC_TIME", "C")
smartphone7.review.last2$date<-as.Date(smartphone7.review.last2$date, format='%B %d, %Y')
smartphone7.review.last2$ym<- floor_date(x=smartphone7.review.last2$date, unit='month')
smartphone7.review.last2$product <- regmatches(smartphone7.review.last2$product,gregexpr(pattern, smartphone7.review.last2$product))

#smartphone8
Sys.setlocale("LC_TIME", "C")
smartphone8.review$date<-as.Date(smartphone8.review$date, format='%B %d, %Y')
smartphone8.review$ym<- floor_date(x=smartphone8.review$date, unit='month')
smartphone8.review$product <- regmatches(smartphone8.review$product,gregexpr(pattern, smartphone8.review$product))

#smartphonex
Sys.setlocale("LC_TIME", "C")
smartphonex.review$date<-as.Date(smartphonex.review$date, format='%B %d, %Y')
smartphonex.review$ym<- floor_date(x=smartphonex.review$date, unit='month')
smartphonex.review$product <- regmatches(smartphonex.review$product,gregexpr(pattern, smartphonex.review$product))


ebay.reviewp<-rbind(smartphone6.review.last,smartphone6s.review, smartphone7.review.last2, smartphone8.review, smartphonex.review)
nrow(ebay.reviewp)
stime<- max(min(smartphone6.review.last[smartphone6.review.last$product=="smartphone 6",]$date),
            min(smartphone6s.review[smartphone6s.review$product=="smartphone 6s" ,]$date),
            min(smartphone7.review.last2[smartphone7.review.last2$product=="smartphone 7",]$date),
            min(smartphone8.review[smartphone8.review$product=="smartphone 8",]$date),
            min(smartphonex.review[smartphonex.review$product=="smartphone X",]$date)         )
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
       title='Review of smartphone',
       subtitle='Rating scores of smartphone',
       caption='Source: ebay')
#빨강:i7 3세대 램8g / 초록: i5 3세대 램4g / 파랑: i5 2세대 램2g / 


#wordcloud
library(SnowballC)
library(tm)
trace(utils:::unpackPkgZip, edit=TRUE)
doc <- Corpus(VectorSource(smartphone.review))
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


####단어 빈도 
summary(smartphone.review$rating)
library(ggplot2)
windows(50,50)
ggplot(smartphone.review, aes(x=rating))+
  geom_bar(color='darkblue', fill='gold', width=0.6)+
  scale_x_continuous(breaks=c(1,2,3,4,5),
                     labels=c('1 star', '2 star', '3 star', '4 star', '5 star'))+
  labs(x='Rating', y='Frequency',
       title="Smartphone category product",
       subtitle='Rating distribution',
       caption="Source: Ebay")+
  mytheme

summary(nchar(smartphone.review$review))
windows(50,50)

ggplot(smartphone.review, aes(x=nchar(review)))+
  geom_histogram(color='brown', fill='chocolate')+
  labs(x='Review length', y='Frequency',
       title="Smartphone category product",
       subtitle='Distribution of review length',
       caption="Source: Ebay")+
  mytheme
nrow(smartphone.review[nchar(smartphone.review$review) > 3000,])

windows(50,50)
ggplot(smartphone.review[nchar(smartphone.review$review) <= 3000,],
       aes(x=as.factor(rating), y=nchar(review)))+
  geom_boxplot(fill="khaki1", color='indianred')+
  scale_x_discrete(breaks=c(1, 2, 3, 4, 5),
                   labels=c('1 star', '2 star', '3 star', '4 star', '5 star'))+
  labs(x='Rating', y='Review Length',
       title='Review of smartphone',
       subtitle="Distribution of review length by rating",
       caption='Source: Ebay')+
  theme_gray()+
  mytheme

library(dplyr)

library(tidytext)
affin.score<- get_sentiments(lexicon='afinn')
summary(afinn.score)
library(magrittr)
smartphone.review.words<- unnest_tokens(tbl= smartphone.review, output=word, input=review, token='words') %>% 
  anti_join(stop_words, by='word') %>% select(-c(product, date)) %>% as_tibble(.)

smartphone.review.words<- unnest_tokens(tbl= v.review, output=word, input=review, token='words')
smartphone.review.words
left_join(smartphone.review.words, afinn.score, by='word')
smartphone.sent.review <- smartphone.review.words %>% left_join(afinn.score, by='word') %>% group_by(id, rating) %>% summarise(score_avg=mean(score, na.rm=T)) %>% ungroup()
smartphone.sent.review
#리뷰 감정점수 평균과 별점 
windows(50,50)
ggplot(smartphone.sent.review, aes(x=as.factor(rating), y=score_avg))+
  geom_boxplot(fill='navyblue', color='aquamarine4', size=0.7)+
  geom_line(size =0.7, color='aquamarine4')+
  scale_x_discrete(breaks=c(1, 2, 3, 4, 5),
                   labels=c('1 star', '2 star', '3 star', '4 ster', '5 star'))+
  labs(x='Rating', y='Average sentiment Score of words',
       title='Review of Smartphone category product',
       subtitle='Distribution of average sentiment score by review rating',
       caption="Source: Ebay")+
  mytheme
smartphone.sent.word<- smartphone.review.words %>% count(id, rating, word) %>% group_by(word) %>%
  summarise(in_review=n(), in_use=sum(n), rating_avg=mean(rating)) %>%
  filter(in_review >=3) %>% arrange(rating_avg) %>% inner_join(get_sentiments(lexicon='afinn'), by='word')%>% ungroup
smartphone.sent.word
#감정사전 이거 다시 그리기 갤럭시랑 애플 
windows(50,50)
ggplot(smartphone.sent.word, aes(x=as.factor(score), y=rating_avg))+
  geom_boxplot(fill='slateblue3', color='orange', size=0.7)+
  scale_y_continuous(breaks=c(1, 2, 3, 4, 5),
                     labels=c('1 star', '2 star', '3 star', '4 star', '5 star'))+
  labs(x='Sentiment Score', y='Average Rating of Reviews',
       title='Review of Smartphone category product',
       subtitle='Distribution of average review rating by sentiment score of word',
       caption='Source: Ebay')+  mytheme
review<- xpathSApply(e.parsed, path="//p[@itemprop='reviewBody']", xmlValue)


#신경망
library(RTextTools)
library(tibble)
smartphone.dtm<- create_matrix(textColumns = smartphone.review$review, language = 'english', removeNumbers = T,
                           removePunctuation = T, removeStopwords = T, stemWords = F, stripWhitespace = T, toLower = T, removeSparseTerms = .99)
smartphone.dtm
smartphone.dtm<-as_tibble(as.matrix(smartphone.dtm), row.names=smartphone.review$id)
smartphone.dtm
train.end<- round(nrow(smartphone.dtm)* 0.7, 0)
test.end<- nrow(smartphone.dtm)
train.end; test.end - train.end
my.container<- create_container(matrix=smartphone.dtm, labels=smartphone.review$rating,
                                trainSize = 1:train.end, testSize = (train.end+1):test.end, virgin = F)
my.classifier <- train_models(container = my.container, algorithms = c('RF', 'SVM'))
print_algorithms()
my.predictions<- classify_models(container = my.container, models=my.classifier)
head(my.predictions)
table(smartphone.review$rating[(train.end+1):test.end],
      my.predictions$FORESTS_LABEL, dnn=c("Actual", "Predicted"))
mean(smartphone.review$rating[(train.end+1):test.end]==my.predictions$FORESTS_LABEL)
mean(smartphone.review$rating[(train.end+1):test.end]==my.predictions$SVM_LABEL)
train.end
test.end
View(smartphone.dtm)
#시계열
windowsFonts(
  Arial   = windowsFont("Arial"),
  Calibri = windowsFont("Calibri"),
  Cambria = windowsFont("Cambria")
)
windowsFonts()
library(lubridate)
library(dplyr)
smartphone.agg<- smartphone.review %>% group_by(product, date) %>% summarise(rating=mean(rating, na.rm=T), n=n())%>% ungroup()
smartphone.agg
library(ggplot2)
windows(50,50)
ggplot(smartphone.agg, aes(x=date, y=rating))+
  geom_line(color='khaki4', size=1)+
  geom_smooth(method='loess', color='firebrick4', size=1.5)+
  scale_x_date(date_labels="%Y", date_breaks='1 years')+
  scale_y_continuous(limits=c(1, 5), breaks=c(1, 2, 3, 4, 5),
                     labels=c('1 star', '2 star', '3 star', '4 star', '5 star'))+
  labs(x=NULL, y='Rating',
       title= 'Review of Smartphone category product',
       subtitle= 'Rating scores over time',
       caption='Source: ebay')+ mytheme

windows(50,50)
ggplot(smartphone.agg, aes(x=date, y=n))+
  geom_line(color='khaki4', size=1)+
  geom_smooth(method='loess', color='firebrick4', size=1.5)+
  scale_x_date(date_labels="%Y", date_breaks='1 years')+
  labs(x=NULL, y='Numbers of Reviews',
       title= 'Review of smartphone catergory product',
       subtitle= 'Rating scores over time',
       caption='Source: ebay') + mytheme

##감정단어  
install.packages("tidytext")
library(tidytext)
install.packages("backports")
bing <- get_sentiments("bing")
bing

install.packages("tidyverse")
library(tidyverse)
smartphone.review.words <-
  unnest_tokens(tbl=smartphone.review, output=word, input=review, token="words")%>%
  anti_join(stop_words, by="word")%>%
  as_tibble(.)

smartphone.review.words

smartphone.sent.review <- smartphone.review.words %>%
  inner_join(bing, by="word") %>%
  count(id, word, sentiment)%>%
  spread(sentiment, n, fill=0) %>%
  mutate(sentiments=positive - negative) %>%
  ungroup()

smartphone.sent.review

summary(smartphone.sent.review$sentiments)

smartphone.sent.review <- smartphone.review.words %>%
  inner_join(bing, by="word")%>%
  count(sentiment, word)%>%
  ungroup() %>%
  filter(n >20)%>%
  mutate(nsign=ifelse(sentiment=="negative",-n,n))

windows(width = 50.0, height = 50)
ggplot(smartphone.sent.review,
       aes(x=reorder(word,nsign), y=nsign,
           fill=factor(sentiment,levels = c("positive","negative"))))+
  geom_bar(stat = "identity", color="lightslategray", width=0.8)+
  geom_text(aes(label=n),size=3, color="black",
            hjust=ifelse(smartphone.sent.review$nsign <0, 1.1, -0.1))+
  scale_fill_manual(values=c("cornflowerblue","tomato"))+
  coord_flip()+
  labs(x="Word",y="Count",
       title="Review of smartphone",
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


#리뷰길이별 평점  
windows(50,50)
ggplot(smartphone.sent.word, aes(x=as.factor(score), y=rating_avg))+
  geom_boxplot(fill='slateblue3', color='orange', size=0.7)+
  scale_y_continuous(breaks=c(1, 2, 3, 4, 5),
                     labels=c('1 star', '2 star', '3 star', '4 star', '5 star'))+
  labs(x='Sentiment Score', y='Average Rating of Reviews',
       title='Review of smartphone',
       subtitle='Distribution of average review rating by sentiment score of word',
       caption='Source: Ebay')+
  mytheme

##비교  
stime<- max(min(iphone.review$date),
            min(galaxy.review$date))
stime
smartphone.review$review<-gsub("[^[:alnum:]///' ]", "",smartphone.review$review)
smartphone.review$date
Sys.setlocale("LC_ALL", "C")
i.review<- filter(smartphone.review, date>= stime)

install.packages("lubridate")
library(lubridate)
library(ggplot2)
a$product <- unlist(a$product)
a$review <- gsub("[^[:alnum:]///' ]", "",a$review)

i.review$product <- unlist(i.review$product)
i.review$date<- floor_date(x=i.review$date, unit='month')
i.agg<- i.review %>% group_by(product, date) %>% summarise(rating=mean(rating, na.rm=T), n=n())%>% ungroup()
head(i.review$date)

windows(50,50)
ggplot(i.agg, aes(x=date, y=rating, color=product))+
  geom_line(linetype='dotted')+
  geom_point(shape=19, fill='gray30')+
  geom_smooth(method='loess')+
  scale_x_date(date_labels='%m', date_breaks = 'month')+
  scale_y_continuous(limits=c(1, 5), breaks=seq(1, 5, by=1),
                     labels=c('1 star', '2 star', '3 star', '4 star', '5 star'))+
  scale_colour_discrete(labels=c("iPhone", "Galaxy"))+
  theme_bw()+
  theme(text=element_text(family='sans'),
        plot.title=element_text(face='bold'),
        axis.text=element_text(size=8),
        legend.position= c(.8, .32),
        legend.title=element_blank(),
        legend.background = element_rect(color = 'red', size = 2,linetype = 'dashed'),
        legend.key.size = unit(12, 'mm'))+
  
  
  labs(x='2018', y='Rating',
       title='Review of smartphones',
       subtitle='Rating scores of iPhone/ Galaxy',
       caption='Source: Ebay')
#빨강:i7 3세대 램8g / 초록: i5 3세대 램4g / 파랑: i5 2세대 램2g / 

##스마트포 전체 클라우드 


review <- paste(smartphone.review$review, collapse = " ")
#install.packages("SnowballC")
library(SnowballC)
#install.packages("tm")
library(tm)

#trace(utils:::unpackPkgZip, edit=TRUE)
doc <- Corpus(VectorSource(review))
class(doc)
inspect(doc)

doc <- tm_map(doc, removePunctuation)
doc <- tm_map(doc, content_transformer(tolower))
mystopwords <- c(stopwords("english"),
                 c("also","among","but","even","four","get","one","said","the","there",
                   "two","three","with","this","and","<99>","iphon","phone"))
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
windows(100, 100)
wordcloud(words = names(term.freq), freq = term.freq, scale = c(7,1),min.freq = 40, rot.per = 0, random.order = FALSE,
          random.color = FALSE, colors = brewer.pal(5, "Set1"))
##도움 비도우
smartphone.review[297, ]$helpful <- 0 #잘못된 데이터. 없으면 코드 생략.
smarth<-smartphone.review[smartphone.review$helpful >= 3,]
smartuh<-smartphone.review[smartphone.review$unhelpful >=3, ]

library(reshape2)
smarth$unhelpful<-NA
smartuh$helpful<-NA
smarthuh<-rbind(smarth, smartuh)
smarthuh<-smarthuh[5:7]
m <- melt(smarthuh, id.vars=1)
windows(50,50)
m %>% 
  drop_na(value) %>%
  ggplot(aes(x=rating, fill=variable))+
  geom_bar(position='stack') + mytheme+labs(x='word', y=NULL,
       title='Review of Smartphones',
       subtitle='평점 도움/비도움 리뷰 개수',
       caption='Source: Ebay')+scale_x_discrete(limits=c(1,2,3,4,5), breaks=c(1,2,3,4,5),
                 labels=c('1 star', '2 star', '3 star', '4 star', '5 star'))


##아이포
smarth<-iphone.review[iphone.review$helpful >= 3,]
smartuh<-iphone.review[iphone.review$unhelpful >=3, ]

library(reshape2)
smarth$unhelpful<-NA
smartuh$helpful<-NA
smarthuh<-rbind(smarth, smartuh)
smarthuh<-smarthuh[5:7]
m <- melt(smarthuh, id.vars=1)
windows(50,50)
m %>% 
  drop_na(value) %>%
  ggplot(aes(x=rating, fill=variable))+
  geom_bar(position='stack') + mytheme+labs(x='word', y=NULL,
                                            title='Review of iphones',
                                            subtitle='평점 도움/비도움 리뷰 개수',
                                            caption='Source: Ebay')+scale_x_discrete(limits=c(1,2,3,4,5), breaks=c(1,2,3,4,5),
                                                                                     labels=c('1 star', '2 star', '3 star', '4 star', '5 star'))

##갤럭시 
smarth<-galaxy.review[galaxy.review$helpful >= 3,]
smartuh<-galaxy.review[galaxy.review$unhelpful >=3, ]

library(reshape2)
smarth$unhelpful<-NA
smartuh$helpful<-NA
smarthuh<-rbind(smarth, smartuh)
smarthuh<-smarthuh[5:7]
m <- melt(smarthuh, id.vars=1)
windows(50,50)
m %>% 
  drop_na(value) %>%
  ggplot(aes(x=rating, fill=variable))+
  geom_bar(position='stack') + mytheme+labs(x='word', y=NULL,
                                            title='Review of galaxy',
                                            subtitle='평점 도움/비도움 리뷰 개수',
                                            caption='Source: Ebay')+scale_x_discrete(limits=c(1,2,3,4,5), breaks=c(1,2,3,4,5),
                                                                                     labels=c('1 star', '2 star', '3 star', '4 star', '5 star'))
