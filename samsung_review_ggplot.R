####단어 빈도 
summary(galaxy.review$rating)
library(ggplot2)
windows(50,50)
ggplot(galaxy.review, aes(x=rating))+
  geom_bar(color='darkblue', fill='cadetblue', width=0.6)+
  scale_x_continuous(breaks=c(1,2,3,4,5),
                     labels=c('1 star', '2 star', '3 star', '4 star', '5 star'))+
  labs(x='Rating', y='Frequency',
       title="Review of galaxy",
       subtitle='Rating distribution',
       caption="Source: Ebay")+
  theme_gray()+
  theme(plot.title=element_text(face='bold'),
        axis.text = element_text(face='bold'))

summary(nchar(galaxy.review$review))
windows(50,50)
ggplot(galaxy.review, aes(x=nchar(review)))+
  geom_histogram(color='brown', fill='coral')+
  labs(x='Review length', y='Frequency',
       title="Review of galaxy",
       subtitle='Distribution of review length',
       caption="Source: Ebay")+
  theme_gray()+
  theme(plot.title=element_text(face='bold'),
        axis.text = element_text(face='bold'))
nrow(galaxy.review[nchar(galaxy.review$review) > 3000,])
windows(50,50)

ggplot(galaxy.review[nchar(galaxy.review$review) <= 3000,],
       aes(x=as.factor(rating), y=nchar(review)))+
  geom_boxplot(fill="goldenrod", color='dimgray')+
  scale_x_discrete(breaks=c(1, 2, 3, 4, 5),
                   labels=c('1 star', '2 star', '3 star', '4 star', '5 star'))+
  labs(x='Rating', y='Review Length',
       title='Review of galaxy',
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
galaxy.review.words<- unnest_tokens(tbl= galaxy.review, output=word, input=review, token='words') %>% 
  anti_join(stop_words, by='word') %>% select(-c(product, date)) %>% as_tibble(.)

galaxy.review.words<- unnest_tokens(tbl= galaxy.review, output=word, input=review, token='words')
galaxy.review.words
left_join(galaxy.review.words, afinn.score, by='word')
galaxy.sent.review <- galaxy.review.words %>% left_join(afinn.score, by='word') %>% group_by(id, rating) %>% summarise(score_avg=mean(score, na.rm=T)) %>% ungroup()
galaxy.sent.review
#리뷰 감정점수 평균과 별점 
windows(50,50)

ggplot(galaxy.sent.review, aes(x=as.factor(rating), y=score_avg))+
  geom_boxplot(fill='lavenderblush', color='black')+
  scale_x_discrete(breaks=c(1, 2, 3, 4, 5),
                   labels=c('1 star', '2 star', '3 star', '4 ster', '5 star'))+
  labs(x='Rating', y='Average sentiment Score of words',
       title='Review of galaxy',
       subtitle='Distribution of average sentiment score by review rating',
       caption="Source: Ebay")+
  theme_gray()+
  theme(plot.title = element_text(face='bold'),
        axis.text = element_text(face='bold'))
galaxy.sent.word<- galaxy.review.words %>% count(id, rating, word) %>% group_by(word) %>%
  summarise(in_review=n(), in_use=sum(n), rating_avg=mean(rating)) %>%
  filter(in_review >=3) %>% arrange(rating_avg) %>% inner_join(get_sentiments(lexicon='afinn'), by='word')%>% ungroup
galaxy.sent.word
#감정사전 
windows(50,50)

ggplot(galaxy.sent.word, aes(x=as.factor(score), y=rating_avg))+
  geom_boxplot(fill='aquamarine', color='black')+
  scale_y_continuous(breaks=c(1, 2, 3, 4, 5),
                     labels=c('1 star', '2 star', '3 star', '4 star', '5 star'))+
  labs(x='Sentiment Score', y='Average Rating of Reviews',
       title='Review of galaxy',
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
galaxy.review$date<-as.Date(galaxy.review$date, format='%B %d, %Y')
galaxy.review$ym<- floor_date(x=galaxy.review$date, unit='month') 
galaxy.review$ym
ebay.agg<- galaxy.review %>% group_by(product, ym) %>% summarise(rating=mean(rating, na.rm=T), n=n())%>% ungroup()
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
       title= 'Review of galaxy',
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
       title= 'Review of galaxy',
       subtitle= 'Rating scores over time',
       caption='Source: ebay')

#비슷한 제품 비교
url2<- 'https://www.ebay.com/urw/Apple-MacBook-Pro-A1278-13-3-Laptop-MD102LL-A-June-2012-/product-reviews/115139414?_itm=153251278603&pgn=1'
url3<- 'https://www.ebay.com/urw/Apple-MacBook-Air-A1466-13-3-Laptop-MD231LL-A-June-2012-/product-reviews/115136931?_itm=163361173182&pgn=1'
ebay.review3<- ebayreview(baseurl = url2, n=7)
galaxy5s.review$product <- regmatches(galaxy5s.review$product,gregexpr(pattern, galaxy5s.review$product))
a$product <-regmatches(a$product,gregexpr(pattern, a$product))

#galaxy6
Sys.setlocale("LC_TIME", "C")
galaxy6.review.last$date<-as.Date(galaxy6.review.last$date, format='%B %d, %Y')
galaxy6.review.last$ym<- floor_date(x=galaxy6.review.last$date, unit='month')
galaxy6.review.last$product <- regmatches(galaxy6.review.last$product,gregexpr(pattern, galaxy6.review.last$product))

#ebay.review4<- ebayreview(baseurl = url3, n=10)

#galaxy6s
Sys.setlocale("LC_TIME", "C")
galaxy6s.review$date<-as.Date(galaxy6s.review$date, format='%B %d, %Y')
galaxy6s.review$ym<- floor_date(x=galaxy6s.review$date, unit='month')
galaxy6s.review$product <- regmatches(galaxy6s.review$product,gregexpr(pattern, galaxy6s.review$product))

#galaxy7
Sys.setlocale("LC_TIME", "C")
galaxy7.review.last2$date<-as.Date(galaxy7.review.last2$date, format='%B %d, %Y')
galaxy7.review.last2$ym<- floor_date(x=galaxy7.review.last2$date, unit='month')
galaxy7.review.last2$product <- regmatches(galaxy7.review.last2$product,gregexpr(pattern, galaxy7.review.last2$product))

#galaxy8
Sys.setlocale("LC_TIME", "C")
galaxy8.review$date<-as.Date(galaxy8.review$date, format='%B %d, %Y')
galaxy8.review$ym<- floor_date(x=galaxy8.review$date, unit='month')
galaxy8.review$product <- regmatches(galaxy8.review$product,gregexpr(pattern, galaxy8.review$product))

#galaxyx
Sys.setlocale("LC_TIME", "C")
galaxyx.review$date<-as.Date(galaxyx.review$date, format='%B %d, %Y')
galaxyx.review$ym<- floor_date(x=galaxyx.review$date, unit='month')
galaxyx.review$product <- regmatches(galaxyx.review$product,gregexpr(pattern, galaxyx.review$product))


ebay.reviewp<-rbind(galaxy6.review.last,galaxy6s.review, galaxy7.review.last2, galaxy8.review, galaxyx.review)
nrow(ebay.reviewp)
stime<- max(min(galaxy6.review.last[galaxy6.review.last$product=="galaxy 6",]$date),
            min(galaxy6s.review[galaxy6s.review$product=="galaxy 6s" ,]$date),
            min(galaxy7.review.last2[galaxy7.review.last2$product=="galaxy 7",]$date),
            min(galaxy8.review[galaxy8.review$product=="galaxy 8",]$date),
            min(galaxyx.review[galaxyx.review$product=="galaxy X",]$date)         )
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
       title='Review of galaxy',
       subtitle='Rating scores of galaxy',
       caption='Source: ebay')
#빨강:i7 3세대 램8g / 초록: i5 3세대 램4g / 파랑: i5 2세대 램2g / 


#wordcloud
library(SnowballC)
library(tm)
trace(utils:::unpackPkgZip, edit=TRUE)

doc <- Corpus(VectorSource(galaxy.review))
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
summary(galaxy.review$rating)
library(ggplot2)
windows(50,50)
ggplot(galaxy.review, aes(x=rating))+
  geom_bar(color='darkblue', fill='gold', width=0.6)+
  scale_x_continuous(breaks=c(1,2,3,4,5),
                     labels=c('1 star', '2 star', '3 star', '4 star', '5 star'))+
  labs(x='Rating', y='Frequency',
       title="Samsung product",
       subtitle='Rating distribution',
       caption="Source: Ebay")+
  mytheme

summary(nchar(galaxy.review$review))
windows(50,50)

ggplot(galaxy.review, aes(x=nchar(review)))+
  geom_histogram(color='brown', fill='chocolate')+
  labs(x='Review length', y='Frequency',
       title="galaxy",
       subtitle='Distribution of review length',
       caption="Source: Ebay")+
  mytheme
nrow(galaxy.review[nchar(galaxy.review$review) > 3000,])

ggplot(galaxy.review[nchar(galaxy.review$review) <= 3000,],
       aes(x=as.factor(rating), y=nchar(review)))+
  geom_boxplot(fill="khaki1", color='indianred')+
  scale_x_discrete(breaks=c(1, 2, 3, 4, 5),
                   labels=c('1 star', '2 star', '3 star', '4 star', '5 star'))+
  labs(x='Rating', y='Review Length',
       title='Review of galaxy',
       subtitle="Distribution of review length by rating",
       caption='Source: Ebay')+
  theme_gray()+
  mytheme

library(dplyr)

library(tidytext)
affin.score<- get_sentiments(lexicon='afinn')
summary(afinn.score)
library(magrittr)
galaxy.review.words<- unnest_tokens(tbl= galaxy.review, output=word, input=review, token='words') %>% 
  anti_join(stop_words, by='word') %>% select(-c(product, date)) %>% as_tibble(.)

galaxy.review.words<- unnest_tokens(tbl= v.review, output=word, input=review, token='words')
galaxy.review.words
left_join(galaxy.review.words, afinn.score, by='word')
galaxy.sent.review <- galaxy.review.words %>% left_join(afinn.score, by='word') %>% group_by(id, rating) %>% summarise(score_avg=mean(score, na.rm=T)) %>% ungroup()
galaxy.sent.review
#리뷰 감정점수 평균과 별점 
ggplot(galaxy.sent.review, aes(x=as.factor(rating), y=score_avg))+
  geom_boxplot(fill='navyblue', color='aquamarine4', size=0.7)+
  geom_line(size =0.7, color='aquamarine4')+
  scale_x_discrete(breaks=c(1, 2, 3, 4, 5),
                   labels=c('1 star', '2 star', '3 star', '4 ster', '5 star'))+
  labs(x='Rating', y='Average sentiment Score of words',
       title='Review of Samsung product',
       subtitle='Distribution of average sentiment score by review rating',
       caption="Source: Ebay")+
  mytheme
galaxy.sent.word<- galaxy.review.words %>% count(id, rating, word) %>% group_by(word) %>%
  summarise(in_review=n(), in_use=sum(n), rating_avg=mean(rating)) %>%
  filter(in_review >=3) %>% arrange(rating_avg) %>% inner_join(get_sentiments(lexicon='afinn'), by='word')%>% ungroup
galaxy.sent.word
#감정사전 이거 다시 그리기 갤럭시랑 애플 
windows(50,50)
ggplot(galaxy.sent.word, aes(x=as.factor(score), y=rating_avg))+
  geom_boxplot(fill='slateblue3', color='orange', size=0.7)+
  scale_y_continuous(breaks=c(1, 2, 3, 4, 5),
                     labels=c('1 star', '2 star', '3 star', '4 star', '5 star'))+
  labs(x='Sentiment Score', y='Average Rating of Reviews',
       title='Review of Samsung product',
       subtitle='Distribution of average review rating by sentiment score of word',
       caption='Source: Ebay')+  mytheme
review<- xpathSApply(e.parsed, path="//p[@itemprop='reviewBody']", xmlValue)


#신경망
library(RTextTools)
library(tibble)
galaxy.dtm<- create_matrix(textColumns = galaxy.review$review, language = 'english', removeNumbers = T,
                           removePunctuation = T, removeStopwords = T, stemWords = F, stripWhitespace = T, toLower = T, removeSparseTerms = .99)
galaxy.dtm
galaxy.dtm<-as_tibble(as.matrix(galaxy.dtm), row.names=galaxy.review$id)
galaxy.dtm
train.end<- round(nrow(galaxy.dtm)* 0.7, 0)
test.end<- nrow(galaxy.dtm)
train.end; test.end - train.end
my.container<- create_container(matrix=galaxy.dtm, labels=galaxy.review$rating,
                                trainSize = 1:train.end, testSize = (train.end+1):test.end, virgin = F)
my.classifier <- train_models(container = my.container, algorithms = c('RF', 'SVM'))
print_algorithms()
my.predictions<- classify_models(container = my.container, models=my.classifier)
head(my.predictions)
table(galaxy.review$rating[(train.end+1):test.end],
      my.predictions$FORESTS_LABEL, dnn=c("Actual", "Predicted"))
mean(galaxy.review$rating[(train.end+1):test.end]==my.predictions$FORESTS_LABEL)
mean(galaxy.review$rating[(train.end+1):test.end]==my.predictions$SVM_LABEL)
train.end
test.end
View(galaxy.dtm)
#시계열
windowsFonts(
  Arial   = windowsFont("Arial"),
  Calibri = windowsFont("Calibri"),
  Cambria = windowsFont("Cambria")
)
windowsFonts()
library(lubridate)
library(dplyr)
galaxy.agg<- galaxy.review %>% group_by(product, date) %>% summarise(rating=mean(rating, na.rm=T), n=n())%>% ungroup()
galaxy.agg
library(ggplot2)
windows(50,50)
ggplot(galaxy.agg, aes(x=date, y=rating))+
  geom_line(color='khaki4', size=1)+
  geom_smooth(method='loess', color='firebrick4', size=1.5)+
  scale_x_date(date_labels="%Y", date_breaks='1 years')+
  scale_y_continuous(limits=c(1, 5), breaks=c(1, 2, 3, 4, 5),
                     labels=c('1 star', '2 star', '3 star', '4 star', '5 star'))+
  labs(x=NULL, y='Rating',
       title= 'Review of Samsung',
       subtitle= 'Rating scores over time',
       caption='Source: ebay')+ mytheme

windows(50,50)
ggplot(galaxy.agg, aes(x=date, y=n))+
  geom_line(color='khaki4', size=1)+
  geom_smooth(method='loess', color='firebrick4', size=1.5)+
  scale_x_date(date_labels="%Y", date_breaks='1 years')+
  labs(x=NULL, y='Numbers of Reviews',
       title= 'Review of galaxy catergory product',
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
galaxy.review.words <-
  unnest_tokens(tbl=galaxy.review, output=word, input=review, token="words")%>%
  anti_join(stop_words, by="word")%>%
  as_tibble(.)

galaxy.review.words

galaxy.sent.review <- galaxy.review.words %>%
  inner_join(bing, by="word") %>%
  count(id, word, sentiment)%>%
  spread(sentiment, n, fill=0) %>%
  mutate(sentiments=positive - negative) %>%
  ungroup()

galaxy.sent.review

summary(galaxy.sent.review$sentiments)

galaxy.sent.review <- galaxy.review.words %>%
  inner_join(bing, by="word")%>%
  count(sentiment, word)%>%
  ungroup() %>%
  filter(n >10)%>%
  mutate(nsign=ifelse(sentiment=="negative",-n,n))

windows(width = 50.0, height = 50)
ggplot(galaxy.sent.review,
       aes(x=reorder(word,nsign), y=nsign,
           fill=factor(sentiment,levels = c("positive","negative"))))+
  geom_bar(stat = "identity", color="lightslategray", width=0.8)+
  geom_text(aes(label=n),size=3, color="black",
            hjust=ifelse(galaxy.sent.review$nsign <0, 1.1, -0.1))+
  scale_fill_manual(values=c("cornflowerblue","tomato"))+
  coord_flip()+
  labs(x="Word",y="Count",
       title="Review of galaxy",
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
windows(20,20)
ggplot(galaxy.sent.word, aes(x=as.factor(score), y=rating_avg))+
  geom_boxplot(fill='slateblue3', color='orange', size=0.7)+
  scale_y_continuous(breaks=c(1, 2, 3, 4, 5),
                     labels=c('1 star', '2 star', '3 star', '4 star', '5 star'))+
  labs(x='Sentiment Score', y='Average Rating of Reviews',
       title='Review of galaxy',
       subtitle='Distribution of average review rating by sentiment score of word',
       caption='Source: Ebay')+
  mytheme

##비교  
stime<- max(min(galaxy5.review$date),
            min(galaxy6.review$date),
            min(galaxy7.review$date),
            min(galaxy8.review$date),
            min(galaxy9.review$date))
stime
galaxy.review$review<-gsub("[^[:alnum:]///' ]", "",galaxy.review$review)
galaxy.review$date
Sys.setlocale("LC_ALL", "C")
i.review<- filter(galaxy.review, date>= stime)

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
  scale_colour_discrete(labels=c("Galaxy S5", "Galaxy S6", "Galaxy S7","Galaxy S8","Galaxy S9"))+
  theme_bw()+
  theme(text=element_text(family='sans'),
        plot.title=element_text(face='bold'),
        axis.text=element_text(size=8),
        legend.position= c(.8, .32),
        legend.title=element_blank(),
        legend.background = element_rect(color = 'red', size = 2,linetype = 'dashed'),
        legend.key.size = unit(12, 'mm'))+
  
  
  labs(x='2018', y='Rating',
       title='Review of galaxys',
       subtitle='Rating scores of galaxy s5/ s6/ s7/ s8/ s9 ver',
       caption='Source: Ebay')
#빨강:i7 3세대 램8g / 초록: i5 3세대 램4g / 파랑: i5 2세대 램2g / 
