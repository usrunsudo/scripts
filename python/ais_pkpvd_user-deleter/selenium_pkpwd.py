# "C:\Program Files\Google\Chrome\Application\chrome.exe" -remote-debugging-port=9014 --user-data-dir="C:\test\Chrome_Test_Profile"
# //div[@id='userGrid-body']/div/table/tbody/tr/td[6]
# //div[@id='userGrid-body']/div/table/tbody/tr/td[7]/div/a
import time
import csv
from selenium import webdriver # type: ignore
from selenium.webdriver.common.by import By # type: ignore

options = webdriver.ChromeOptions()
options.add_experimental_option('debuggerAddress', 'localhost:9014')
driver = webdriver.Chrome(options=options)

def user_delete(family="", name="", otche=""):
    try:
        button = driver.find_element(By.XPATH, "//div[@class='form-group']/div[1]/div/input")
        button.click()
        button.clear()
        button.send_keys(family)
        button = driver.find_element(By.XPATH, "//div[@class='form-group']/div[2]/div/input")
        button.click()
        button.clear()
        button.send_keys(name)
        button = driver.find_element(By.XPATH, "//div[@class='form-group']/div[3]/div/input")
        button.click()
        button.clear()
        button.send_keys(otche)

        button = driver.find_element(By.XPATH, "//span[@id='filterButttons']/div/span[@class='ico ico-search']")
        button.click()
        time.sleep(5)

        try:
            button = driver.find_elements(By.XPATH, "//table[@class='userTable table']/tbody/tr[@class='data_tr']/td[4]/div/span")
            for item in button:
                time.sleep(1)
                if item.get_attribute("class") == "inline pointer ico ico-user-status-active":
                    print("" + family + " " + name + " " + otche + " " + "ACTIVE")
                    item.click()
                if item.get_attribute("class") == "inline pointer ico ico-user-status-archive":
                    print("" + family + " " + name + " " + otche + " " + "DEACTIVATE")
        except TypeError:
            #print("" + family + " " + name + " " + otche + " " + "NOT FOUND")
            pass
        finally:
            #pass
            time.sleep(5)

    finally:
        #driver.quit()
        #print("finally")
        button = driver.find_element(By.XPATH, "//span[@id='filterButttons']/div/span[@class='ico ico-clean']")
        button.click()
        time.sleep(1)
        button = driver.find_element(By.XPATH, "//span[@id='filterButttons']/div/span[@class='ico ico-search']")
        button.click()
        time.sleep(1)


with open("C:/Users/username/Downloads/test.csv", "r", encoding = 'utf-8') as csvfile:
    fieldnames = ['family', 'name', 'otche']
    reader = csv.DictReader(csvfile, fieldnames, delimiter=';')
    for row in reader:
        #results.append(row)
        #print(row['parametr'], row['value'])
        #REGEX_B = row['parametr']
        #SUBST = row['value']
        family = row['family']
        name = row['name']
        otche = row['otche']
        logf = open("C:/Users/username/Downloads/log.txt", 'r', encoding = 'utf-8')
        content = logf.read()
        logf.close()
        logf = open("C:/Users/username/Downloads/log.txt", 'w', encoding = 'utf-8')
        logf.write(content)
        log = "" + family + " " + name + " " + otche + " " + " ПК ПВД\n"
        logf.write(log)
        logf.close()

        user_delete(family, name, otche)

driver.quit()
