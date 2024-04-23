## This scripts generates the synthetic data for the MSM tutorial on labor supply responses to income taxes (Lecture 8.2)

using JuMP, Optim, Ipopt # For optimization
using Random, Distributions # For random draws
using CSV, DataFrames  # For data manipulation

Random.seed!(652)

N = 100 # Set number of agents in economy
γ = .5  # Set Cobb-Douglas relative preference for consumption
τ = .12 # Set tax rate
 
# We assume max hours worked per year is 2x1800, the average US annual hours worked 
# Then, 72K is the average at a $20/h wage rate
wage_income = rand(LogNormal(log(72.0), log(1.3)), N)

# Mean zero, SE of 3 shock
epsilon = rand(Normal(0, 1.0), N)

# Cobb-Douglas demand for c
consump = γ*(1-τ) .* wage_income + (γ .*epsilon)

# Cobb-Douglas demand for l
leisure = (1.0-γ) .+ ( (1.0-γ)*epsilon)./ ((1.0-τ) .* wage_income)  

## Prepare the data to export

# Wage rate is in $/hour
wage_rate = round.(wage_income ./ 3.6, digits=2)

# Consumption in 1000 USD
consump_1000 = round.(consump*1000, digits=2)

# Convert to hours of labor (thousands of hours)
labor = convert(Array{Int64}, (round.((1.0 .- leisure) .* 3600)))

# Create a DataFrame
df = DataFrame(
    ID = 1:N,
    wage_rate = wage_rate,
    consump = consump_1000,
    labor_hours = labor
)

# Write to CSV
CSV.write("labor_supply.csv", df)