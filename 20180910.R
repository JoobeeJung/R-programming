search()
plot(faithful)
str(mtcars)

library(ggplot2) 
windows(width = 7.0, height = 5.5) ##aesthetic 그래프의 외관 담당
ggplot(data = mtcars, aes(x = wt, y=mpg)) +  ##그래프를 만들기 위한 기초 다지기 - 
  ##사용할 데이터 지정과 그래프요소간의 매핑
  geom_point() + ##산점도를 그려주는 함수 인수가 아무것도 지정 안되어있음 
  ##이 줄부터 그래프 그리기 시작 geometric object : 기하학적인 객체 geom함수 
  labs(x = "weight(1,100 1bs)", y="Fuel Consumption(miles per gallon)",
       title = "Fuel Consumption vs. weight",
       subtitle = "Negative relationship between fuel efficiency and car weight",
       caption="Source : mpg dataset") ##각 요소가 어디에 위치하는지 잘 알
data("mtcars")
mtcars$gear <- factor(mtcars$gear, levels=c(3,4,5),
                      labels=c("3 gears","4 gears", "5 gears"))
mtcars$cyl <- factor(mtcars$cyl, levels = c(4,6,8),
                     labels = c("4 cylinders", "6 cylinders", "8 cylinders"))
ggplot(data= mtcars, aes(x=mpg)) + geom_histogram()+facet_grid(cyl ~.)+
  labs(title="geom_histogram()", x="Miles per Gallon")
ggplot(data = mtcars, aes(x= cyl, y=mpg)) + geom_boxplot()+
  labs(title="geom_boxplot()", x = "Number of Cylinders", y ="miles per Gallon")
ggplot(data=mtcars, aes(x=mpg, fill=cyl)) + geom_density()+ ##밀도함수 채워달라 
  labs(title="geom_destiny()", x="miles per Gallon")
ggplot(data = mtcars, aes(x=wt, y=mpg, col=cyl))+geom_point()+
  labs(title="geom_point()", x="weight(1,000 lbs)", y="Miles per Gallon")
ggplot(data=mtcars, aes(x=wt, y=mpg)) + geom_smooth()

##
ggplot(data = mtcars, aes(x = wt, y=mpg)) +  ##그래프를 만들기 위한 기초 다지기 
  ##- 사용할 데이터 지정과 그래프요소간의 매핑
  geom_point() +##산점도를 그려주는 함수 인수가 아무것도 지정 안되어있음 
  ##이 줄부터 그래프 그리기 시작 geometric object : 기하학적인 객체 geom함수 
  geom_smooth()+
  labs(x = "weight(1,100 lbs)", y="Fuel Consumption(miles per gallon)",
       title = "Fuel Consumption vs. weight",
       subtitle = "Negative relationship between fuel efficiency and car weight",
       caption="Source : mpg dataset")

ggplot(data = mtcars, aes(x = wt, y=mpg)) +  ##그래프를 만들기 위한 기초 다지기 - 사용할 데이터 지정과 그래프요소간의 매핑
  geom_point(pch=17, color="blue",size=2) +##산점도를 그려주는 함수 인수가 아무것도 지정 안되어있음 ##이 줄부터 그래프 그리기 시작 geometric object : 기하학적인 객체 geom함수 
  geom_smooth(method="lm", color="red", linetype=2 , size=1)+##lty
  labs(x = "weight(1,100 lbs)", y="Fuel Consumption(miles per gallon)",
       title = "Fuel Consumption vs. weight",
       subtitle = "Negative relationship between fuel efficiency and car weight",
       caption="Source : mpg dataset")
?points
help(points)
?geom_smoth
?par
install.packages(help)


ggplot(data = mtcars, aes(x = wt, y=mpg)) +  ##그래프를 만들기 위한 기초 다지기 - 사용할 데이터 지정과 그래프요소간의 매핑
  geom_point(pch=17, color="blue",size=2) +##산점도를 그려주는 함수 인수가 아무것도 지정 안되어있음 ##이 줄부터 그래프 그리기 시작 geometric object : 기하학적인 객체 geom함수 
  geom_smooth(method="lm", color="red", linetype=2 , size=1)+##lty
  geom_text(label=rownames(mtcars), hjust=0, vjust=1, nudge_y = 0.7, size=2)+
  labs(x = "weight(1,100 lbs)", y="Fuel Consumption(miles per gallon)",
       title = "Fuel Consumption vs. weight",
       subtitle = "Negative relationship between fuel efficiency and car weight",
       caption="Source : mpg dataset")

library(car)
str(Salaries)
ggplot(Salaries, aes(x=rank, y=salary))+
  geom_boxplot(fill="coral3", color="black", notch = TRUE)+ ##fill 내부색 color 경계선 색 notch- 홈이 파진 상자도표 중위수 강조한
  geom_point(position="jitter", color="blue", alpha=0.5)+
  geom_rug(sides="l", color="black")
colors()


library(car)
str(Salaries)
ggplot(Salaries, aes(x=rank, y=salary))+
  geom_boxplot(fill="coral3", color="black", notch = TRUE)+ ##fill 내부색 color 경계선 색 notch- 홈이 파진 상자도표 중위수 강조한
  geom_point(color="blue", alpha=0.5)+ ## alpha인수는 색의 투명도 0-1 사이 1은 투명도 엑스 0은 하나도 안보
  geom_rug(sides="l", color="black")
colors()

library(car)
str(Salaries)
ggplot(Salaries, aes(x=rank, y=salary))+
  geom_boxplot(fill="coral3", color="black", notch = TRUE)+ ##fill 내부색 color 경계선 색 notch- 홈이 파진 상자도표 중위수 강조한
  geom_point(position="jitter", color="blue", alpha=0.5)+
  geom_rug(sides="l", color="black") ##left = l  연속형 변수여야지 rug도표 의미 있음 줄자의 간격들은 밀도를 나타냄 까만ㅈ것은 점들이 모여있는 것 
colors()

ggplot(Salaries, aes(x=salary, fill=rank))+ ##rank데이터를 필링을 다르게 해서 표시해줘 
  geom_density(alpha=0.5)

ggplot(Salaries, aes(x=yrs.since.phd, y=salary, color=rank, shape=sex))+
  geom_point()

p1 <- ggplot(Salaries, aes(x=rank, fill=sex))+
  geom_bar(position="dodge") + labs(title='postion="dodge"')
p2 <- ggplot(Salaries, aes(x=rank, fill=sex))+
  geom_bar(position="stack") + labs(title='postion="stack"')
p3 <- ggplot(Salaries, aes(x=rank, fill=sex))+
  geom_bar(position="fill") + labs(title='postion="fill"', y="proportion")
library(gridExtra)
install.packages("gridExtra")
grid.arrange(p1,p2,p3, nrow=3)
library(lattice)
ggplot(data=singer, aes(x=height))+
  geom_histogram(fill="tomato")+
  facet_wrap(~ voice.part, nrow=4) ##4개의 행을 생성해라 열의 갯수는 자동으로 2개 
str(singer)

ggplot(data = singer, aes(x=height, fill=voice.part))+
  geom_density(alpha=0.5)+
  facet_grid(voice.part ~ .)

ggplot(Salaries, aes(x=yrs.since.phd, y=salary))+
  geom_point(color="cornflowerblue")+
  facet_grid(sex ~ rank)

ggplot(Salaries, aes(x=rank, y=salary, fill=sex))+
  geom_boxplot()+
  scale_x_discrete(breaks=c("AsstProf", "AssocProf", "Prof"),
                   labels = c("Assistant\nProfessor",
                              "Associate\nProfessor", "Full\nProfessor"))+
  scale_y_continuous(breaks=c(50000,100000,150000,200000),
                     labels = c("$50k","$100k","$150k","$200k"))+
  labs(title="Faculty Salary by Rank and Sex",x=NULL, y=NULL, fill="Gender")+#fill=gender하면 범례 바꿀 수 있음 
theme(legend.position = c(0.1,0.85)) ##범례 안쪽으로 넣기 

ggplot(data=mtcars, aes(x=wt, y=mpg, size=disp))+
  geom_point(shape=21, color="black", fill="wheat")+
  labs(size="Engine\nDisplacement\n(cubic inch)")

ggplot(Salaries, aes(x=rank, fill=sex))+
  geom_bar()+
  scale_fill_manual(values=c("coral","cornflowerblue"))

ggplot(Salaries,aes(x=yrs.since.phd, y=salary, color=rank))+
  geom_point(site=2)+
  scale_color_brewer(palette="Accent")
install.packages("RColorBrewer")
library(RColorBrewer)
display.brewer.all()
display.brewer.pal(3, "Accent")

library(car)
ggplot(Salaries, aes(x=yrs.since.phd, y=salary, color=rank, shape=rank))+
  scale_shape_manual(values=c(15,17,19))+
  geom_point(size=2)

?theme_gray
?theme_bw

mytheme <- theme(plot.title = element_text(face="bold.italic",
                                           size="14", color="brown"),
                 axis.title=element_text(face="bold.italic",
                                         size="10", color="tomato"),
                 axis.title=element_text(face="bold",
                                         size="9", color = "royalblue"),
                 panel.background=element_rect(fill="snow", color = ""))
