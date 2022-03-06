# Import libraries used in the script
import requests
import openpyxl
from bs4 import BeautifulSoup

# Setup the Excel workbook that we will save the data collected into
excel = openpyxl.Workbook()
sheet = excel.active
sheet.title = 'imdb_top_250_movies'
sheet.append(['IMDB Rank', 'Movie Name', 'Year of Release', 'IMDB Rating'])

# Assign variables needed for scraping
URL = "https://www.imdb.com/chart/top/"
source = requests.get(URL)
soup = BeautifulSoup(source.text, 'html.parser')

movies = soup.find('tbody', class_='lister-list').find_all('tr')

# Collect specific data in the scrape and save it to individual rows in the
# workbook
for movie in movies:
    rank = movie.find('td', class_='titleColumn').get_text(
        strip=True).split('.')[0]
    name = movie.find('td', class_='titleColumn').a.text
    year = movie.find('td', class_='titleColumn').span.text.strip('()')
    rating = movie.find('td', class_='ratingColumn').strong.text

    sheet.append([rank, name, year, rating])


excel.save('movie_data.csv')
