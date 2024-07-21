docker rm -f freqtrade_develop

docker run -it \
    --name "freqtrade_develop" \
    --publish 8080:8080 \
    --mount type=bind,source="$(pwd)",target=/freqtrade,consistency=cached \
    --user "ftuser" \
    ghcr.io/freqtrade/freqtrade-devcontainer:latest \
    /bin/bash -c "pip install --user -e . && freqtrade create-userdir --userdir user_data/ && pip install -r tuneta/requirements.txt && /bin/bash"