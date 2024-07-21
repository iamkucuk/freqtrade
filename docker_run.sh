docker run -it \
    --name "freqtrade_develop" \
    --publish 8080:8080 \
    --mount type=bind,source="$(pwd)",target=/workspaces/freqtrade,consistency=cached \
    --user "ftuser" \
    ghcr.io/freqtrade/freqtrade-devcontainer:latest \
    /bin/bash -c "pip install --user -e . && freqtrade create-userdir --userdir user_data/ && /bin/bash"