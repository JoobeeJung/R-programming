help.start()
.libPaths()

help.start()

help(Syntax)
help(cars)
help(median)
?median #물음표랑 help 랑같ㅇ

args(median) #인수가 뭔지 궁금할떄 쓰는 함수

example(median)

help(xyplot)#exact 매칭 무조건 똑같은ㄱ 
help.search("xyplot") #부분 매칭하기
??plot #위의거랑 똑같은거 !! #
help(xyplot, package="lattice") #lattice에 포함된 패키지에서 도움말 불러와줘

hero.vector <-c("Superman","Spiderman","Bathman")
apropos("vector") #정규표현식 a로 시작하는 단어, 숫자로 끝나는 단어로 찾아줘 이런거 #

?regex #정규표현식 ㅅㄹ명

apropos("q$") #Q로 끝나는 단어
apropos("[7-9]") #7,8,9포함된 단어
apropos("xy+")

RSiteSearch("topicmodels") #외부사이트에 연결

install.packages("sos")
library(sos)
search()
findFn("social network analysis") #함수를 찾아주는, 키워드를 해결할 수 있는 함수별 리스트 줌

demo(graphics)
demo(image)


