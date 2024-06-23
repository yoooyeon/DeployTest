APP_PORT=8081
cd /var/lib/docker/volumes/a0c6b3b7e5bc15b6463cdd488dc04c299ee963041eedda701e311621a54a63ad/_data/workspace/DeployTest/build/libs/
JAR_NAME=$(ls | grep '0.0.1' | tail -n 1)
echo ">> jar name: $JAR_NAME"

# 현재 사용 중인 8081 포트 확인
echo ">> Checking if port $APP_PORT is in use..."
if sudo lsof -i :$APP_PORT | grep LISTEN; then
    echo ">> Port $APP_PORT is in use, shutting down current application..."
    # 현재 실행 중인 서버 프로세스 종료
    sudo kill $(sudo lsof -t -i :$APP_PORT)
    sleep 1  # 종료 완료를 기다림 (필요에 따라 조정)

    # 종료 후 확인
    if sudo lsof -i :$APP_PORT | grep LISTEN; then
        echo ">> Failed to shut down application on port $APP_PORT, exiting..."
        exit 1
    else
        echo ">> Application on port $APP_PORT shutdown successfully."
    fi
fi


# JAR 파일 실행
echo ">> Starting application with JAR file"
nohup java -jar $JAR_NAME > app.log 2>&1 &

# 실행 상태 확인
echo ">> Waiting for application to start on port $APP_PORT..."
sleep 3  # 애플리케이션이 시작되는 동안 기다림 (필요에 따라 조정)

if sudo lsof -i :$APP_PORT | grep LISTEN; then
    echo ">> Application started successfully on port $APP_PORT."
else
    echo ">> Failed to start application on port $APP_PORT. Check logs for details."
    exit 1
fi

exit 0