# clear
print('\033c')
print('\x1bc')
# values=["a","b","c"]
# values_2=range(100)

# for i , v in enumerate(values_2 , start=45):
#     print (i,v)   

# ##################################################

# x=[1,2,4,6,8,10]
# x2=[n*n for n in x]
# print (x2)

# ##################################################
# #f string
# name="MohammadReza"
# age="24"
# print(f"name is {name} and age is {age}")
####################################################
age = 41
print("old" if age>40 else "young")
count=11
found= True if count>10 else False
print (found)
####################################################
# import pathlib
# pathlib.



###################################################
#decorators

###################################################
print("------")
print("Map - Filter - Zip")
print("------")
print("-----Map-----")
for i in map(lambda x: x+5 , [1,2,4]):
    print(i)
print("------Filter-----")
for i in filter(lambda x: True if x>10 else False, [1,213,3,342,4,3,32,43]):
    print(i)
print("-----Zip-----")

for name , age , sex in zip(['mohammad' , 'fatemeh' , 'efun' , 'darya'], [25,24,25,24],['male' , 'female' , 'male' , 'felmale']):
    print(name,age,sex)