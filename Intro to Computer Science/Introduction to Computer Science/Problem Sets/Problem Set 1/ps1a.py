# Down payment
portion_down_payment = 0.25
# Current Savings
current_savings = 0.0
# Annual return
r = 0.04

# Annual salary
annual_salary = float(input("Enter your annual salary: "))
# Portion of salary saved every paycheck
portion_saved = float(input("Enter the percent of you salary to save, as a decimal: "))
# House cost
total_cost = float(input("Enter the cost of your dream house: "))

# Calculate down payment
total_cost = total_cost * portion_down_payment

# Loop until enough is saved for a down payment
number_of_months = 0
while current_savings < total_cost:
    # Calculate monthly return on investment
    return_on_investment = current_savings * r / 12.0
    # Add return on investment to savings
    current_savings += return_on_investment
    # Add portion saved to savings
    current_savings += portion_saved * annual_salary / 12.0
    # Count months
    number_of_months += 1
print(f"Number of months: {number_of_months}")