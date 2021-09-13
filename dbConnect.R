library(DBI)
library(RPostgres)
library(RPostgresSQL)
#before work run *** ssh -f dawid232323@s31.mydevil.net -L 8543:pgsql31.mydevil.net:5432 -N *** in terminal

con <-DBI::dbConnect(RPostgres::Postgres(), dbname='p1495_regon_base', host='localhost', port='8543', user='p1495_regon_base', password='R!(gR(A2pEyOj(8N5iZN') # make connection with dataBase

df <- dbGetQuery(con, 'SELECT * FROM F_CDEIG_rest_view') # returns data frame with joined common f with cdeig/rest with pkd (and states, counties etc.)

df <- dbGetQuery(con, 'SELECT * FROM F_agriculture_view') # returns data frame with joined common f with f_agriculture, pkd, states, counties etc.

df <- dbGetQuery(con, 'SELECT * FROM F_deleted_View') # returns data frame with joined common f with deleted, states, countires etc. (without pkds)

df <- dbGetQuery(con, 'SELECT * FROM common_P_view') # returns data frame with joined common p with pkds, states, streets, founding bodies etc. 

df <- dbGetQuery(con, 'SELECT * FROM local_P_view') # returns data frame with joined common local p with pkds, states, streets, founding bodies etc. 

df <- dbGetQuery(con, 'SELECT * FROM local_F_view') # returns data frame with joined common local p with pkds, states, streets, founding bodies etc. 

df <- dbGetQuery(con, 'SELECT * FROM local_P_view lpv JOIN common_P_view cpv ON cpv.praw_regon = lpv.lokpraw_parentregon') # returns data frame with common p items, joined with pkd and their local units 

df <- dbGetQuery(con, 'SELECT * FROM local_F_view lfv JOIN F_CDEIG_rest_view FCrv on lfv.lokfiz_parentregon = FCrv.fiz_regon') # returns data frame with common f items, joined with pkd, cdeig/rest raports and their local units 

df <- dbGetQuery(con, 'SELECT * FROM local_F_view lfv JOIN F_agriculture_view fav ON lfv.lokfiz_parentregon = fav.fiz_regon') # returns data frame with common f items, joined with pkd, agr raports and their local units 

df <- dbGetQuery(con, 'SELECT * FROM local_F_view lfv JOIN F_deleted_View fdv ON lfv.lokfiz_parentregon = fdv.fiz_regon') # returns data frame with common f items, joined with pkd, deleted raports and their local units 