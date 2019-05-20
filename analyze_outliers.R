'''

@fanlizhou

Statistic tests of outlier data


'''

lnames <- load(file = "GCN2-TLS-1000-dataInput.RData")
datExpr <- data.frame(datExpr)
datExpr <- datExpr[c(1:6)]
par(mfrow=c(2,3))

hist(datExpr$R1_wtC, breaks = 10)
hist(datExpr$R2_wtC, breaks = 10)
hist(datExpr$R3_wtC, breaks = 10)
hist(datExpr$R1_wtH, breaks = 10)
hist(datExpr$R2_wtH, breaks = 10)
hist(datExpr$R3_wtH, breaks = 10)

geneName = as.vector(rownames(datExpr))

# WTC ANOVA
WTC_R1 <- as.vector(datExpr$R1_wtC)
WTC_R2 <- as.vector(datExpr$R2_wtC)
WTC_R3 <- as.vector(datExpr$R3_wtC)
WTC <- c(WTC_R1,WTC_R2,WTC_R3)
group_WTC <- rep(1:3, c(length(WTC_R1), length(WTC_R2), length(WTC_R3)))
WTC_data <- data.frame(y=WTC, group=factor(group_WTC))
results_WTC<-aov(y~group, WTC_data)
summary(results_WTC)

# WTC Chi-squared Test
M_WTC <- as.table(rbind(WTC_R1,WTC_R2,WTC_R3))
dimnames(M_WTC) <- list(round = c("WTC_R1","WTC_R2","WTC_R3"), gene = geneName)
WTC_chi_results <- chisq.test(M_WTC)
summary(WTC_chi_results)
WTC_chi_results$p.value

# WTC ttest
t.test(datExpr$R1_wtC,datExpr$R2_wtC)
t.test(datExpr$R1_wtC,datExpr$R3_wtC)
t.test(datExpr$R2_wtC,datExpr$R3_wtC)

# WTH ANOVA
WTH_R1 <- as.vector(datExpr$R1_wtH)
WTH_R2 <- as.vector(datExpr$R2_wtH)
WTH_R3 <- as.vector(datExpr$R3_wtH)
WTH <- c(WTH_R1,WTH_R2,WTH_R3)
group_WTH <- rep(1:3, c(length(WTH_R1), length(WTH_R2), length(WTH_R3)))
WTH_data <- data.frame(y=WTH, group=factor(group_WTH))
results_WTH<-aov(y~group, WTH_data)
summary(results_WTH)

# WTH Chi-squared Test
M_WTH <- as.table(rbind(WTH_R1,WTH_R2,WTH_R3))
dimnames(M_WTH) <- list(round = c("WTH_R1","WTH_R2","WTH_R3"), gene = geneName)
WTH_chi_results <- chisq.test(M_WTH)
summary(WTH_chi_results)
WTH_chi_results$p.value

# WTH ttest
t.test(datExpr$R1_wtH,datExpr$R2_wtH)
t.test(datExpr$R1_wtH,datExpr$R3_wtH)
t.test(datExpr$R2_wtH,datExpr$R3_wtH)
