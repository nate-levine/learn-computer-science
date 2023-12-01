# Down payment
portion_down_payment = 0.25
# Current Savings
current_savings = 0.0
# Annual return
r = 0.04
# Semi-annual raise
semi_annual_raise = 0.07
# House cost
total_cost = 1000000.0
# Number of months
number_of_months = 36
# Epsilon
epsilon = 100.0

# Annual salary
annual_salary = float(input("Enter your annual salary: "))

# Calculate down payment
total_cost = total_cost * portion_down_payment

# Set initial lower bound
lower = 0.0
# Set initial upper bound
upper = 1.0
# Set initial guess halfway
guess = (lower + upper) / 2.0

steps = 0
# While current savings guess is not within $100 of the total cost,
# perform the bisection search
while abs(current_savings - total_cost) > epsilon:
    # Calculate amount saved after 36 months
    current_savings = 0
    for _ in range(36):
        # Calculate monthly return on investment
        return_on_investment = current_savings * r / 12.0
        # Add return on investment to savings
        current_savings += return_on_investment
        # Add portion saved to savings
        current_savings += guess * annual_salary / 12.0

    # If not enough is saved after 36 months, take the top interval
    if current_savings < total_cost:
        lower = guess
    # If too much is saved after 36 months, take the bottom interval
    else:
        upper = guess
    # Guess in the middle
    guess = (lower + upper) / 2.0
    # Count a step
    steps += 1
    if steps > 10000:
        break

if steps <= 10000:
    print(f"Best savings rate: {round(guess, 4)}")
    print(f"Steps in bisection search: {steps}")
else:
    print("It is not possible to pay the down payment in three years.")