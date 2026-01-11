#!/bin/sh
set -e

echo "Authorizing $SHINY_USERNAME"

Rscript -e "rsconnect::setAccountInfo(name='$SHINY_USERNAME', token='$SHINY_TOKEN', secret='$SHINY_SECRET')"

echo "Deploying $APP_NAME from $SHINY_PATH to shinyapp.io"

APP_PATH="$GITHUB_WORKSPACE/$APP_DIR"

Rscript -e 'install.packages(c("shiny", "DT", "readr", "dplyr", "tidyr", "forcats"), repos="https://cloud.r-project.org")'
Rscript -e "rsconnect::deployApp(appDir='$APP_PATH', appName='$APP_NAME', appTitle='$APP_TITLE', launch.browser=FALSE, forceUpdate=TRUE)"

url="https://$SHINY_USERNAME.shinyapps.io/$APP_NAME/"
echo "::set-output name=url::$url"

exit 0
