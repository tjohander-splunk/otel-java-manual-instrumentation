FROM openjdk:11 as builder
RUN apt-get update
RUN apt-get -y install curl maven
WORKDIR /home/app
COPY pom.xml .
COPY src ./src
RUN curl -L https://github.com/signalfx/splunk-otel-java/releases/latest/download/splunk-otel-javaagent-all.jar -o splunk-otel-javaagent.jar
RUN mvn -f /home/app/pom.xml clean package

FROM openjdk:11
COPY --from=builder /home/app/target/otel-java-manual-instrumentation-1.0-SNAPSHOT.jar /usr/local/lib/app.jar
COPY --from=builder /home/app/splunk-otel-javaagent.jar /usr/local/lib/splunk-otel-javaagent.jar
ENTRYPOINT ["java","-javaagent:/usr/local/lib/splunk-otel-javaagent.jar","-jar","/usr/local/lib/app.jar"]