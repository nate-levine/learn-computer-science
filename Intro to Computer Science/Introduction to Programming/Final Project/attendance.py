"""
    Summary:
        This is my final project for the online course "CS50's Introduction to Programming with Python".

    Background:
        I use a software called Notion to track my attendance at OSSU, keep track of my hours in attendance, and take notes on lectures.
        I keep track by inputting my hours spent on OSSU in a table. My goal when enrolling in OSSU was to do 20 hours of work per week, or roughly 3 hours every day.
        Of course, life gets in the way and my progress is much more sporatic. Sometimes I will miss a day or several days in a row.
        Sometimes I will have a whole weekend with no responsibilities and spend my whole day learning computer science.

    Goal:
        Graph my hours attending OSSU over time. I want to see how my hours spent over time
        compare to a perfect model where I spent three hours attending OSSU every day.
    
    Method:
        My goal can be broken down into 3 objectives:
            1. Extract the table data from Notion using the Notion API.
                - Documentation: https://developers.notion.com/
                    - Authorization: https://developers.notion.com/docs/authorization
                - "Getting Started with the Notion API using Python": https://www.pynotion.com/getting-started-with-python
            2. Process the data into a .csv file using the Python's built in csv library.
                - Documentation: https://docs.python.org/3/library/csv.html
            3. Read that data from the .csv, and graph it using matplotlib.
                - Documentation: https://pypi.org/project/matplotlib/
"""


import requests
import csv
import matplotlib.pyplot as plt
import numpy


def main():
    """
    See above.
    """
    # 1. Extract the table data from Notion using the Notion API.
    attendance = get_attendance_data()
    # 2. Process the data into a .csv file using the Python's built in csv library.
    write_csv_file(attendance)
    # 3. Read that data from the .csv, and graph it using matplotlib.
    plot_attendance()


def plot_attendance():
    """
    Creates a plot of attendance over time using matplotlib and numpy

    :param data: None
    :type: None
    :return: None
    :type: None
    """
    # Goal number of hours spent per day
    GOAL = 3
    # Create empty lists
    dates = []
    hours = []
    goal = []
    # Read .csv data to lists
    with open("attendance.csv", "r") as file:
        reader = csv.DictReader(file)
        for row in reader:
            # Convert to a date format readable by numpy
            dates.append(row["date"])
            # Add time spent to hours list
            try:
                hours.append(float(row["time_spent"]))
            except ValueError:
                raise ValueError(f"Value '{row["time_spent"]}' in column 'time_spent' cannot be converted to a float.")
            # Add goal for each day to the list
            goal.append(GOAL)

    # Create a figure containing a single axes.
    fig, axes = plt.subplots(figsize=(24, 12), layout="tight")
    # Sum the hours over time
    hours = numpy.cumsum(hours)
    # Sum the goal for each day over time
    goal = numpy.cumsum(goal)
    # Plot the actual time spent over time
    axes.plot(dates, hours, color="#6666ff", linewidth=3)
    # Plot the goal over time
    axes.plot(dates, goal, color="#ff6666", linewidth=3, linestyle=(0, (5, 5)))

    # Visuals
    # Set plot margins
    plt.margins(x=0, y=0)
    # Set figure background color
    fig.set_facecolor("#000000")
    # Set plot background color
    axes.set_facecolor("#1e1e1e")
    # Set plot border color
    for axis in ["top", "bottom", "left", "right"]:
        axes.spines[axis].set_color("#dddddd")
    # Set tick parameters
    plt.tick_params(axis="both", colors="#dddddd")
    # Set title parameters
    axes.set_title("Hours Worked on OSSU vs. Time", color="#ffffff", fontsize="64")
    # Set axis parameters
    axes.set_xlabel("Date", color="#ffffff", fontsize="20")
    plt.xticks(color="#ffffff", fontsize=12, rotation=315)
    axes.set_ylabel("Time Spent [hrs]", color="#ffffff", fontsize="20")
    plt.yticks(color="#ffffff", fontsize=15)

    # Save the figure
    plt.savefig("attendance.png")


def write_csv_file(data):
    """
    Write attendance data into .csv file.

    :param data: Dictionary containing attendance data
    :type: dict
    :return: None
    :type: None
    """
    # Open attendance .csv
    with open("attendance.csv", "w") as file:
        writer = csv.DictWriter(file, fieldnames=["date", "time_spent"], lineterminator = '\n')
        # Headers
        writer.writeheader()
        # Iterate through dictionary to write rows to .csv file
        for date, time_spent in data.items():
            writer.writerow({"date": date, "time_spent": time_spent})


def get_attendance_data():
    """
    Get Notion database information using the Notion API.

    :param: None
    :type: None
    :return attendance: Return a dictionary of key-value pairs
    :rtype: dict
    """
    # Initialize empty dictionary list
    attendance = {}

    # Notion integration key HIDE THIS WHEN UPLOADING TO GITHUB
    NOTION_KEY = "KEY GOES HERE"
    # Headers
    headers = {
        "Authorization": f"Bearer {NOTION_KEY}",
        "Content-Type": "application/json",
        "Notion-Version": "2022-06-28",
    }
    # Post request search parameters
    search_params = {
        "filter": {
            "value": "page",
            "property": "object",
        },
    }
    # Retrieve attendance page with a POST request
    search_response = requests.post("https://api.notion.com/v1/search", json=search_params, headers=headers)
    # Results
    o = search_response.json()
    # Get data from results in chronological order
    for results in reversed(o["results"]):
        date = results["properties"]["Date"]["date"]["start"]
        time_spent = results["properties"]["Time Spent (hrs)"]["number"]
        attendance[date] = time_spent
    # Return data
    return attendance


if __name__ == "__main__":
    main()