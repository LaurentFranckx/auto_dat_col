# load packages
library(stringr)
library(XML)
library(RCurl)
library(tau)

# A difficult example
raw.data <- "555-1239Moe Szyslak(636) 555-0113Burns, C. Montgomery555-6542Rev. Timothy Lovejoy555 8904Ned Flanders636-555-3226Simpson, Homer5543642Dr. Julius Hibbert"

# Extract information
name <- unlist(str_extract_all(raw.data, "[[:alpha:]., ]{2,}"))
name
phone <- unlist(str_extract_all(raw.data, "\\(?(\\d{3})?\\)?(-| )?\\d{3}(-| )?\\d{4}"))
phone
data.frame(name = name, phone = phone)

names_inter<- str_extract_all(raw.data, "[[:alpha:]., ]{2,}")[[1]]
names_split <- sapply(names_inter, function(x) str_split(x, " "))
str_locate_all(name, "[a-zA-Z]{2,}\\. ")
str_detect(name, "[a-zA-Z]{2,}\\. ")

reverse_names_pos <- str_detect(name, "[a-zA-Z]{2,}, ")
reverse_names <- name[reverse_names_pos]
reverse_names_split <- str_split(reverse_names, ", ")
reverse_names_correct <- sapply(reverse_names_split, function(x) str_c(x[2],x[1], sep = " "))
name[reverse_names_pos] <- reverse_names_correct


test_string1 <- c("afhff2566","eedf25446eeer","ezzff4557$")
str_detect(test_string1,"[0-9]+\\$")

test_string2 <- c("ag66","eed", " ed ", "ezzfffgfg")
str_detect(test_string2,"\\b[a-z]{1,4}\\b")

test_string3 <- c("122file.txt","file34.txt", "file.txt ", "   file.txt", ".txt")
str_detect(test_string3,".*?\\.txt$")


test_string4 <- c("3222/32/4567","1234/45/4555555", "12/23354/2455")
str_detect(test_string4,"\\d{2}/\\d{2}/\\d{4}")

test_string5 <- c("<(112)>444451125667</>","<112>44445</<>","<(abc)>44445</<>","<()>44445</5446112>", "<(abc)>44445</54abc12>","<(112)>44445</5446abc>")
str_detect(test_string5,"<(.+?)>.+?</\\1>")
str_extract("<(112)>445667</445112>","<(.+?)>.+?</\\1>")
str_extract("<(112)>4456671127789","<(.+?)>.+?\\1")
str_extract("<\\(112\\)>4456671127789\\(","<(.+?)>.+?\\1")

str_extract("<(112)>4456671127789","<(.+?)>.+?")

str_extract("<(112)>445667<","<(.+?)>.+?<")
str_extract("<(112)>445667</","<(.+?)>.+?</")
str_extract("<(112)>445667112</","<(.+?)>.+?</\\1")
str_extract("<(112)>dfffg112</","<(.+?)>.+?</\\1")
str_extract("<(112)>dfffg(112)</","<(.+?)>.+?\\1")

str_extract("<(112)>dfffg(112)</","<(.+?)>.+?</\\1")

#solutions
str_extract("<(112)>dff</(112)","<(.+?)>.+?</\\1")
str_extract("<(112)>dff1225   44555</(112)","<(.+?)>.+?</\\1")
str_extract("<(112)>dff1225</44555</(112)","<(.+?)>.+?</\\1")
str_extract("<(112)>dff1225</44555</aahdddcg(112)","<(.+?)>.+?</\\1")
str_extract("<(112)>dff1225</44555</aahdddcg(112)/(112)","<(.+?)>.+?</\\1")
str_extract("<(112)>dff1225</44555</(112)/(112)","<(.+?)>.+?</\\1")















