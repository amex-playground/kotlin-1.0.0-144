FROM gradle:5.6.2-jdk8

MAINTAINER Franco Meloni

LABEL "com.github.actions.name"="Danger Kotlin"
LABEL "com.github.actions.description"="Runs Kotlin Dangerfiles"
LABEL "com.github.actions.icon"="zap"
LABEL "com.github.actions.color"="blue"

# Install dependencies
RUN curl -sL https://deb.nodesource.com/setup_10.x |  bash - && \
    apt-get install -y nodejs make zip danger

RUN cd /usr/lib && \
    wget -q https://github.com/JetBrains/kotlin/releases/download/v1.4.0/kotlin-compiler-1.4.0.zip && \
    unzip kotlin-compiler-*.zip && \
    cd _danger-kotlin && \
    make install && \
    rm kotlin-compiler-*.zip && \
    rm -rf _danger-kotlin

ENV PATH $PATH:/usr/lib/kotlinc/bin

# Install danger-kotlin globally
COPY . _danger-kotlin

# Run Danger Kotlin via Danger JS, allowing for custom args
ENTRYPOINT ["danger-kotlin", "ci"]
