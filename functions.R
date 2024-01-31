run_cea <- function(sensitivity, specificity, amr_burden_per_abx = NULL) {
  births_per_year <- 25 * 10^6
  sepsis_rate <- 70 / 1000
  births_sepsis <- births_per_year * sepsis_rate
  prop_high_risk_sepsis <- 0.4
  prop_low_risk_sepsis <- 1 - prop_high_risk_sepsis
  births_sepsis_high_risk <- births_sepsis * prop_high_risk_sepsis
  births_sepsis_low_risk <- births_sepsis * prop_low_risk_sepsis
  prop_abx <- 0.2
  births_abx <- births_per_year * prop_abx
  births_abx_sepsis_high_risk <- births_sepsis_high_risk
  births_abx_sepsis_low_risk <- births_abx - births_abx_sepsis_high_risk
  
  total_births_per_year <- 130 * 10^6
  total_births_abx_per_year <- total_births_per_year * prop_abx
  
  # If no AMR burden per prescription provided then calculate one
  if(is.null(amr_burden_per_abx)) {
    total_sepsis_burden <- 24.6 * 10^6
    prop_burden_abx <- 0.31
    total_amr_burden <- total_sepsis_burden * prop_burden_abx
    amr_burden_per_abx <- total_amr_burden / total_births_abx_per_year
  }
  
  cost_culture <- 50
  total_cost_rdt <- 20
  subsidy_rdt <- 10
  cost_rdt <- total_cost_rdt - subsidy_rdt
  cost_treatment <- 5
  
  # Scenario 1
  benefit_correct_sepsis_diagnosis <- 9
  benefit_s1 <- benefit_correct_sepsis_diagnosis * births_sepsis_low_risk - amr_burden_per_abx * (births_abx_sepsis_low_risk - births_sepsis_low_risk)
  cost_s1 <- (cost_culture + cost_treatment) * births_abx_sepsis_low_risk
  cost_per_daly_s1 <- cost_s1 / benefit_s1
  
  # Scenario 2
  sepsis_prev_low_risk <- births_sepsis_low_risk / births_abx_sepsis_low_risk
  true_positive <- births_abx_sepsis_low_risk * sepsis_prev_low_risk * sensitivity
  false_negative <- births_abx_sepsis_low_risk * sepsis_prev_low_risk * (1 - sensitivity)
  true_negative <- births_abx_sepsis_low_risk * (1 - sepsis_prev_low_risk) * specificity
  false_positive <- births_abx_sepsis_low_risk * (1 - sepsis_prev_low_risk) * (1 - specificity)
  stopifnot(true_positive + false_positive + false_negative + true_negative == births_abx_sepsis_low_risk)
  harm_false_negative <- benefit_correct_sepsis_diagnosis * 0.5
  
  benefit_s2 <- (true_positive * benefit_correct_sepsis_diagnosis) + 
    (true_negative * amr_burden_per_abx) - 
    (false_negative * harm_false_negative) - 
    (false_positive * amr_burden_per_abx)
  
  cost_s2 <- (cost_culture + total_cost_rdt) * births_abx_sepsis_low_risk + (true_positive + false_positive) * cost_treatment
  cost_per_daly_s2 <- cost_s2 / benefit_s2
  
  subsidy_test <- subsidy_rdt * births_abx_sepsis_low_risk
  cost_incremental <- cost_s2 - subsidy_test - cost_s1
  benefit_incremental <- benefit_s2 - benefit_s1
  icer <- cost_incremental / benefit_incremental
  return(list(icer = icer, cost_incremental = cost_incremental, benefit_incremental = benefit_incremental))
}