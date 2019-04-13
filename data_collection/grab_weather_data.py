import bs4
import requests

weather_stations = ["Athenry","Ballyhaise","Belmullet","Casement Aerodrome","Claremorris","Cork Airport","Dublin Airport","Dunsany (Grange)","Finner Camp","Gurteen","Johnstown Castle","Knock Airport","Mace Head","Malin Head","Markree Castle","Moore Park","Mount Dillon","Mullingar","Newport Furnace","Oak Park","Phoenix Park","Roches point SWS.","Shannon Airport","Sherkin Island","Valentia Observatory"]

# https://www.met.ie/api/stations/Athenry/monthly
weather_data_url = "https://www.met.ie/api/stations/{}/monthly"


def get_station_data(station_name):
    response = requests.get(weather_data_url.format("Athenry")).json()
    return response["report"]


def parse_table(table_string):
    soup = bs4.BeautifulSoup(table_string, features="html.parser")

    tables = soup.find_all('table')
    headers = soup.find_all('h3')
    print(len(tables))
    print(len(headers))


parse_table(get_station_data(""))