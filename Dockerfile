FROM node:10

ENV ADMIN_EMAIL admin@habitica.com
ENV AMAZON_PAYMENTS_CLIENT_ID amzn1.application-oa2-client.68ed9e6904ef438fbc1bf86bf494056e
ENV AMAZON_PAYMENTS_SELLER_ID AMQ3SB4SG5E91
ENV AMPLITUDE_KEY e8d4c24b3d6ef3ee73eeba715023dd43
ENV BASE_URL http://104.197.48.147
ENV FACEBOOK_KEY 128307497299777
ENV GA_ID UA-33510635-1
ENV GOOGLE_CLIENT_ID 1035232791481-32vtplgnjnd1aufv3mcu1lthf31795fq.apps.googleusercontent.com
ENV NODE_ENV production
ENV STRIPE_PUB_KEY pk_85fQ0yMECHNfHTSsZoxZXlPSwSNfA

# Install global packages
RUN npm install -g gulp-cli mocha

# Clone Habitica repo and install dependencies
RUN mkdir -p /usr/src/habitrpg
WORKDIR /usr/src/habitrpg
RUN git clone --branch v4.75.1 https://github.com/HabitRPG/habitica.git /usr/src/habitrpg
RUN npm install
RUN gulp build:prod --force

# Create Build dir
RUN mkdir -p ./website/build

# Start Habitica
EXPOSE 3000
CMD ["node", "./website/transpiled-babel/index.js"]
