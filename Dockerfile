FROM alpine:3.19.7 AS builder
RUN apk update && apk add --no-cache git
RUN git clone  -b main https://github.com/Coding4Deep/tomcat-tuning.git

FROM tomcat
RUN cp -r /usr/local/tomcat/webapps.dist/* /usr/local/tomcat/webapps/
COPY --from=builder /tomcat-tuning/host-manager/META-INF/context.xml /usr/local/tomcat/webapps/host-manager/META-INF/context.xml
COPY --from=builder /tomcat-tuning/manager/META-INF/context.xml /usr/local/tomcat/webapps/manager/META-INF/context.xml
COPY --from=builder /tomcat-tuning/tomcat-users.xml /usr/local/tomcat/conf/tomcat-users.xml


