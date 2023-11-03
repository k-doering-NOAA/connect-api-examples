# change permissions (access_type) on an app.

library(httr)

# The CONNECT_SERVER URL must have a trailing slash.
# instructions to set this up: https://docs.posit.co/connect/cookbook/#getting-started
connectServer <- Sys.getenv("CONNECT_SERVER")
connectAPIKey <- Sys.getenv("CONNECT_API_KEY")




# get GUID (content id) from connect: 
GUID <- "4a006a67-b191-43aa-9fe5-a95d20eb8860" # depends on your content


url_of_content <- paste0(connectServer, "__api__/v1/content/", GUID)

# see the content info (not needed to change the content, but allows you to 
# see the current access type)
# https://docs.posit.co/connect/cookbook/content/#content-listing
result <- GET(url_of_content,
              add_headers(Authorization = paste("Key", connectAPIKey)))
payload <- content(result)
# access type options are all┃logged_in┃acl
payload$access_type


# change a single part of item, in this cass the access type
# we want to change it to all so everyone can see.
# access type options are all┃logged_in┃acl
data <- '{
  "title": "Terra title change"
}'

# make changes to content
result <- PATCH(url_of_content,
                body = data, encode = "raw",
                add_headers(Authorization = paste("Key", connectAPIKey)))
