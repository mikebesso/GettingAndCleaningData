library(reshape)
setwd('~/Documents/R/Getting and Cleaning/Project')


# a reusable function to get the data
#
# paramters
#   train.or.test:  the word train or test to point to the right folder
#   df.activities:  a data frame of activity codes and names
#   df.features:  the names of the columns (features)

get.data <- function(train.or.test, df.activities, df.features, count = -1){
    
    fn <- paste('data/', train.or.test, '/X_', train.or.test, '.txt', sep='')
    df.x <- read.fwf(fn, widths=rep(16, 561), header=F, colClasses='numeric', n=count)
    names(df.x) <- c(df.features)
    
    df.mean.and.std <- cbind(df.x[,grep("mean", names(df.x))], df.x[,grep("std", names(df.x))])
    
    fn <- paste('data/', train.or.test, '/y_', train.or.test, '.txt', sep='')
    df.y.raw <- read.delim(fn, sep=' ', header=F, nrows=count)
    names(df.y.raw) <- 'activity.code'
    
    df.y <- merge(df.y.raw, df.activities) 
    
    fn <- paste('data/', train.or.test, '/subject_', train.or.test, '.txt', sep='')
    df.subjects <- read.delim(fn, sep=' ', header=F, nrows=count)
    
    
    df <- cbind(df.subjects, df.y$activity, df.mean.and.std)    
    names(df) <- c('subject', 'activity', names(df.mean.and.std))
    
    df
    
}


# encapsulate getting of activities
get.activities <- function() {
    activities <- read.delim('data/activity_labels.txt', sep=' ', header=F)
    names(activities) = c('activity.code', 'activity')
    
    activities
}

# encapsulate the getting and cleansing of features
get.features <- function() {

    features <- read.delim('data/features.txt', sep=' ', header=F)
    features <- features$V2
    
    features <- gsub("\\(", ".", features)
    features <- gsub("\\)", ".", features)
    features <- gsub("\\)", "", features)
    features <- gsub('\\-', '.', features)
    features <- gsub(',', '.', features)
    features <- gsub('\\.\\.', '.', features)
    features <- gsub('\\.\\.', '.', features)
    features <- gsub("\\.$", "", features)
    
    features
}


# determine the axis from the variable (as character)
get.axis <- function(variable){
    
    retval <- ifelse(
        substr(variable, nchar(variable), nchar(variable)) %in% c('X', 'Y', 'Z'),
        substr(variable, nchar(variable), nchar(variable)),
        NA
    )
    
    retval
}

# determine the domain from the variable (as character)
get.domain <- function(variable){

    retval <- ifelse(
        substr(variable, 1, 1) == 't',
        'time',
        ifelse(
            substr(variable, 1, 1) == 'f',
            'frequency',
            NA
            )   
    )
    
}

# encapsulate writing the resulting files
write_files <-function(a){
    write.csv(a$all, 'all.csv', row.names = F)
    write.csv(a$mean.and.std, 'mean and std.csv', row.names = F)
    write.csv(a$tidy, 'tidy.csv', row.names = F)    
}


# due the analysis
run_analysis <- function(count = -1){

    # get the meta data
    df.activities <- get.activities()
    df.features <- get.features()
    
    #get the data
    df.train <- get.data('train', df.activities, df.features, count)
    df.test <- get.data('test', df.activities, df.features, count)
    
    #combine the data
    df.all <- rbind(df.train, df.test)
    
    #create a data set of just means and stds
    mean.and.std <- cbind(df.all[,grep("mean\\.", names(df.all))], df.all[,grep("std\\.", names(df.all))])
        
    #create a data set with subject, activity and the means
    subject.activity.mean <- cbind(df.all[,c(1:3)], df.all[,grep("mean\\.", names(df.all))])
    
    #unpivot
    tidy <- melt(subject.activity.mean, c(1,2))

    #further tidy the axis
    tidy$axis <- get.axis(as.character(tidy$variable))
    tidy$variable <- gsub("\\.[XYZ]", "", tidy$variable)
    tidy$variable <- gsub("\\.mean", "", tidy$variable)
    
    #further tidy the domain
    tidy$domain <- get.domain(as.character(tidy$variable))
    tidy$variable <- gsub("^[ft]", "", tidy$variable)
    
    
    #return the results
    list(features = df.features, all = df.all, mean.and.std = mean.and.std, tidy = tidy)
}


# For testing, pass a number into run_analysis.  10 and 100 work well.
a <- run_analysis()

