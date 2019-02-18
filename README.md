# kromeajuri

install:

    npm i -g selenium-side-runner@latest

docker-compose up

    selenium-side-runner -c "browserName=chrome chromeOptions.args=[no-sandbox,headless,window-size=1600x1200]" --server http://localhost:8080/wd/hub superside.side

    selenium-side-runner -c "browserName=chrome chromeOptions.args=[no-sandbox,window-size=1600x1200]" --server http://localhost:8080/wd/hub superside.side
