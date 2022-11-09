apt update
apt install virtualenv -y
## راه اندازی و نام گذاری محیط
virtualenv venv --python

ls venv
## ورود به محیط مجازی
source venv/bin/activate

pip install django==2

django-admin startproject simpledjango

pip freeze

pip freezee > requirements.txt
cat requirements.txt

cd simpledjango

nano settings.py

