FROM eclipse-temurin:17-alpine 
RUN apk update && apk add --no-cache git curl unzip 
WORKDIR /app
RUN git clone https://github.com/Coding4Deep/SpringBoot-Project.git 
WORKDIR /app/SpringBoot-Project
RUN chmod +x mvnw
CMD ["./mvnw", "spring-boot:run"]
