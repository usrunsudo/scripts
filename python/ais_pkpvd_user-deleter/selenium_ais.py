# "C:\Program Files\Google\Chrome\Application\chrome.exe" -remote-debugging-port=9014 --user-data-dir="C:\test\Chrome_Test_Profile"
# XPath Helper by Adam Sadovsky https://chromewebstore.google.com/detail/xpath-helper/hgimnogjllphhhkhlmebbmlgjoejdpjl
# //div[@id='userGrid-body']/div/table/tbody/tr/td[6]
# //div[@id='userGrid-body']/div/table/tbody/tr/td[7]/div/a
import time
import csv
from selenium import webdriver # type: ignore
from selenium.webdriver.common.by import By # type: ignore

options = webdriver.ChromeOptions()
options.add_experimental_option('debuggerAddress', 'localhost:9014')
driver = webdriver.Chrome(options=options)

def user_delete(snils=""):
    try:
        button = driver.find_element(By.XPATH, "//div[@id='cpguAdminFormPage-body']/div[@id='userGrid']/div/div/div/div/div/table/tbody/tr/td/div/div/div/div/table")
        button.click()
        time.sleep(5)
        button = driver.find_element(By.XPATH, "//div[@id='cpguAdminFormPage-body']/div[@id='userGrid']/div/div/div/div/div/table/tbody/tr/td/div/div/div/div/table/tbody/tr/td/table/tbody/tr/td/div[2]/input")
        button.clear()
        button.send_keys(snils)
        time.sleep(5)
        button = driver.find_element(By.XPATH, "//div[@id='cpguAdminFormPage-body']/div[@id='userGrid']/div/div/div/div/div/table/tbody/tr/td/div/div/div/div/div/em/button")
        button.click()
        time.sleep(5)
        #button = driver.find_elements(By.XPATH, "//div[a]")
        #button[1].click()

        table = driver.find_elements(By.XPATH, "//div[@id='userGrid-body']/div/table/tbody/tr")
        for tr in table:
            if tr != table[0]:
                item = driver.find_element(By.XPATH, "//td[6]")
                if item.text != "Нет ролей":
                    button = driver.find_element(By.XPATH, "//td[7]/div/a[1]")
                    button.click()
                    print("!= Нет ролей")
                    time.sleep(5)
                    button = driver.find_element(By.XPATH, "//div/table[24]/tbody/tr/td/input")
                    button.click()
                    time.sleep(5)
                    try:
                        button = driver.find_element(By.XPATH, "//div[@id='formId-body']/div/div/div/div/div[1]")
                        button.click()
                        print("button click")
                    finally:
                        time.sleep(5)
                    #for item in button:
                    #    if item.text == "Сохранить":
                    #        item.click()
                else:
                    print("исключение")

    finally:
        #driver.quit()
        print("finally")

with open("C:/Users/username/Downloads/test.csv", "r", encoding = 'utf-8') as csvfile:
    fieldnames = ['fio', 'snils']
    reader = csv.DictReader(csvfile, fieldnames, delimiter=';')
    for row in reader:
        #results.append(row)
        #print(row['parametr'], row['value'])
        #REGEX_B = row['parametr']
        #SUBST = row['value']
        fio = row['fio']
        snils = row['snils']
        logf = open("C:/Users/username/Downloads/log.txt", 'r', encoding = 'utf-8')
        content = logf.read()
        logf.close()
        logf = open("C:/Users/username/Downloads/log.txt", 'w', encoding = 'utf-8')
        logf.write(content)
        log = "" + snils + " " + fio + " ОБРАБОТАНО\n"
        logf.write(log)
        logf.close()

        user_delete(snils)

driver.quit()
