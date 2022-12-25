########## Orginal File ---- location in disk /mnt/d/Python/sepehr-channels ########### link in git : https://git.mci.dev/r.izadi/sepehr-channels.git
# from browsermobproxy import Server
################3 install pip install -U requests[socks] for Socks
from typing import Dict
import requests
from selenium import webdriver
from selenium.webdriver.chrome import service
from selenium.webdriver.common.keys import Keys
import time
import json
from selenium.webdriver.common.desired_capabilities import DesiredCapabilities
from os import rmdir
from urllib.parse import urlparse
from requests import get
import requests
from selenium.webdriver.chrome.service import Service
# driver_path = Service('1//chromedriver')
driver_path = Service('//Documents//Git//sepehr-channels//chromedriver')
channels = ["https://sepehr.irib.ir/live/play/31" , "https://sepehr.irib.ir/live/play/32" ,  "https://sepehr.irib.ir/live/play/39" ,"https://sepehr.irib.ir/live/play/37" ,"https://sepehr.irib.ir/live/play/38" , "https://sepehr.irib.ir/live/play/42" , "https://sepehr.irib.ir/live/play/72" , "https://sepehr.irib.ir/live/play/46" , "https://sepehr.irib.ir/live/play/44" , "https://sepehr.irib.ir/live/play/45" , "https://sepehr.irib.ir/live/play/53" , "https://sepehr.irib.ir/live/play/51" , "https://sepehr.irib.ir/live/play/50" , "https://sepehr.irib.ir/live/play/15701" , "https://sepehr.irib.ir/live/play/61" , "https://sepehr.irib.ir/live/play/48" , "https://sepehr.irib.ir/live/play/59" , "https://sepehr.irib.ir/live/play/55" , "https://sepehr.irib.ir/live/play/58" , "https://sepehr.irib.ir/live/play/57" ]

opts = webdriver.ChromeOptions()

proxy = '172.16.56.3:1084'

opts.add_argument('--headless')
opts.add_argument('--no-sandbox')
opts.add_argument('--disable-dev-shm-usage')
opts.add_argument('--proxy-server=socks5://' + proxy)
caps = DesiredCapabilities.CHROME
caps['goog:loggingPrefs'] = {'performance': 'ALL'}

mydrive = webdriver.Chrome(
    # executable_path='//Documents//Git//sepehr-channels//chromedriver' ,options=opts, desired_capabilities=caps )
    service=driver_path , options=opts, desired_capabilities=caps )

def get_link(channel):

    flag = True
    mydrive.get(channel)
    while flag:
        try:
            logs_raw = mydrive.get_log("performance")
            logs = [json.loads(lr["message"])["message"] for lr in logs_raw]
            def log_filter(log_):
                return (
                    log_["method"] == "Network.responseReceived"
                    and "json" in log_["params"]["response"]["mimeType"]
                )
            for log in filter(log_filter, logs):
                print(log)
                request_id = log["params"]["requestId"]
                resp_url = log["params"]["response"]["url"]
                print(f"Caught {resp_url}")
                print(mydrive.execute_cdp_cmd("Network.getResponseBody", {
               "requestId": request_id}))
            m3u8 = mydrive.execute_cdp_cmd("Network.getResponseBody", {
                "requestId": request_id})
            print(m3u8)
            flag = False
        except:
            pass




#    print('-----------------------------------------------')
#    print('-----------------------------------------------')

    m3u8_body = m3u8["body"]

    data = json.loads(m3u8_body)

    m3u8_Stream = data['list'][0]['streams']

    m3u8_link = m3u8_Stream[0]["src"]
    print(m3u8_link)
    print("%s%s"%("https://ilive1-cdn.zarebin.ir/https/", m3u8_link[8:]))

#    print('------------------------')

    Secure_link_Zarebin = urlparse("%s%s" % ("https://ilive1-cdn.zarebin.ir/https/", m3u8_link[8:]))

    Secure_link_Zarebin_Path = (Secure_link_Zarebin.path)

    purge = ("%s%s" % ("https://ilive1-cdn.zarebin.ir/purge",Secure_link_Zarebin_Path))


    res = get(purge)
    print(res.status_code)
    flag=True
    while flag:
        res2 =get("%s%s"%("https://ilive1-cdn.zarebin.ir/https/", m3u8_link[8:]))
        print(res2.status_code)
        if (res2.status_code==200):
            flag=False




#    print('------------------------')

    print('-----------------------------------------------')

    print('-----------------------------------------------')

    # mydrive.close()

    # mydrive.quit()

    # time.sleep(3)

for x in channels:
    get_link(x)


mydrive.close()

#mydrive.quit()

#time.sleep(3)