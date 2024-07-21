if docker ps -a | grep -q freqtrade_develop; then
    echo "Container freqtrade_develop exists, starting it..."
    docker start freqtrade_develop
    docker exec -it freqtrade_develop /bin/bash
else
    echo "Container freqtrade_develop does not exist, creating and starting a new one..."
    docker run -it \
        --name "freqtrade_develop" \
        --publish 8080:8080 \
        --publish 8888:8888 \
        --mount type=bind,source="$(pwd)",target=/freqtrade,consistency=cached \
        --user "ftuser" \
        ghcr.io/freqtrade/freqtrade-devcontainer:latest \
        /bin/bash -c "pip install --user -e . && freqtrade create-userdir --userdir user_data/ && pip install -r tuneta/requirements.txt && /bin/bash"
fi