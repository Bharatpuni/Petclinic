FROM alpine as stage1
WORKDIR /app
RUN apk add git
RUN git clone https://github.com/artisantek/docker-multistagebuild-java.git

FROM maven:3.8.4-openjdk-11 as stage2
WORKDIR /multiapp2
COPY --from=stage1 /app/docker-multistagebuild-java .
RUN mvn clean install

FROM adhig93/tomcat-conf
COPY --from=stage2 /multiapp2/target/*.jar /app/

