import requests
import csv

# http://smartgriddashboard.eirgrid.com/DashboardService.svc/data?area=demandactual&region=ALL&datefrom=01-Apr-2019+00%3A00&dateto=09-Apr-2019+23%3A59&_=1554939751279

days_of_month = {
    "Jan": 31,
    "Feb": 28,
    "Mar": 31,
    "Apr": 30,
    "May": 31,
    "June": 30,
    "July": 31,
    "Aug": 31,
    "Sep": 30,
    "Oct": 31,
    "Nov": 30,
    "Dec": 31
}

def write_csv(rows):
    with open('energy_data.csv', 'a', newline='') as csvfile:
        writer = csv.writer(csvfile)
        for row in rows:
            writer.writerow(row)

def collect_data(start, end):
    url = "http://smartgriddashboard.eirgrid.com/DashboardService.svc/data?area=demandactual&region=ALL&datefrom={start}+00%3A00&dateto={end}+23%3A59&_=1554939751279"
    return requests.get(url.format(start=start, end=end)).json()

def format_data(json_data):
    data = []
    if "Rows" in json_data:
        print(json_data)
        for data_row in json_data["Rows"]:
            data.append([
                data_row["EffectiveTime"],
                data_row["FieldName"],
                data_row["Region"],
                data_row["Value"],
            ])
    return data

for year in range(2010, 2020):
    formatted_data = list()
    print(year)
    for month, last_day in days_of_month.items():
        month_year = "{}-{}".format(month, year)
        from_date = "01-{}".format(month_year)
        to_date = "{}-{}".format(last_day, month_year)
        write_csv(format_data(collect_data(from_date, to_date)))
