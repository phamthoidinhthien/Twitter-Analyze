#These code will export a wordcloud base on input hashtag, simply change the hashtag word and number of Tweets you want to extract
#Require the following library: wordcloud, tm, twitteR, ROAuth
#You need to create application access code and token in Twitter
#Use this command to get authorize: setup_twitter_oauth(api_key,api_secret,access_token,access_token_secret)

#Input
hashtag = "#brexit"
NoTweets = 10000

#Extract tweets
tweets = searchTwitter(searchString = hashtag, n = NoTweets, lang= "en")
tweets = twListToDF(tweets)
text = tweets$text
#Remove link
text = gsub('http.*\\s*|RT|Retweet','',t)
#Convert to utf8
text = iconv(text,to="utf-8-mac")
#To lower case
text = tolower(text)
#remove username
text = gsub("@\\w+","",text)
#remove punctuation
text = gsub("[[:punct:]]","",text)
#remove blank space at the beginning and the end
text = gsub("^ ","",text)
text = gsub(" $","",text)

#convert to corpus
corpus = Corpus(VectorSource(text))

#remove stopword and hastag word
corpus = tm_map(corpus,removeWords,c(substring(hashtag,2),stopwords("english")))

#Output Wordcloud
wordcloud(corpus,min.freq=2,scale=c(7,0.5),colors=brewer.pal(8,"Dark2"), random.order=FALSE, max.words=150)
