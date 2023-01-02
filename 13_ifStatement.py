

"""
    I wake up
            if I'm hungry
                I eat breakfast
"""


"""
    I leave my house
    if it's cloudy
        I bring an umbrella
    otherwise
        I bring sunglasses
"""    


"""
    Im at a restaurant
    if I want meat
        I order a stea
    otherwise if I want pasta
        I order spaghetti & meatballs
    otherwise
        I order a salad

"""


is_male = False
is_tall = True

if (is_male):
    print("You are male")


if (is_male):
    print("You are male")
else:
    print("You not a male")


if is_male or is_tall:
    print("You are a male or tall or both")
else:
    print("You neither mae nor tall")



if is_male and is_tall:
    print("You are tall male")
else:
    print("You are either not male or tall or both")



if is_male and is_tall:
    print("You are tall male")
elif is_male and not(is_tall):
    print("You are a short male")
elif not(is_male) and is_tall:
    print("You are a not a male but are tall")
else:
    print("You are not male and not tall")