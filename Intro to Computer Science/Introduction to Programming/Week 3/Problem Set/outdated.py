months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
]

def main():
    # Get date formatted in YYYY-MM-DD based on input
    try:
        formated_date = get_date("Date: ")
    # Exit program
    except KeyboardInterrupt:
        return
    # Print in YYYY-MM-DD format
    print(formated_date)

def get_date(prompt):
    while True:
        date_string = input(prompt)

        # MM/DD/YY format
        if "/" in date_string:
            try:
                month, day, year = date_string.split("/")    
            # Exception, prompt again
            except ValueError:
                pass
            else:
                # Convert to int
                try: 
                    year = int(year)
                    month = int(month)
                    day = int(day)
                # Exception, prompt again
                except ValueError:
                    pass
                else:
                    # Day is no greater than 31 and month is no greater than 12
                    if (day <= 31) and (month <= 12):
                        try:
                            formated_date =  f"{int(year):04}-{int(month):02}-{int(day):02}"
                    # Exception, prompt again
                        except ValueError:
                            pass
                        else:
                            # Return YYYY-MM-DD format
                            return formated_date
                    else:
                        continue
        # Month DD, YYYY format
        else:
            # If a valid month
            for i in range(len(months)):
                month = i + 1
                date_string = date_string.title()
                if date_string.startswith(months[i]):
                    # Break down
                    try:
                        month_and_day, year = date_string.split(",")
                        day = month_and_day.strip(months[i])
                        day = day.strip(" ")
                    # Exception, prompt again
                    except ValueError:
                        pass
                    else:
                        # Convert to int
                        try:
                            day = int(day)
                            year = int(year)
                        # Exception, prompt again
                        except ValueError:
                            pass
                        else:
                            # Day is no greater than 31
                            if day <= 31:
                                try:
                                    formated_date =  f"{int(year):04}-{int(month):02}-{int(day):02}"
                                # Exception, prompt again
                                except ValueError:
                                    pass
                                else:
                                    # Return YYYY-MM-DD format
                                    return formated_date
                            else:
                                continue

                # Else prompt again
                else:
                    continue

main()