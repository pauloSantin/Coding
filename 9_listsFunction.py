lucky_number = [4, 8, 15, 16, 16, 23, 42]
friends = ["Kevin","Karen", "Jim", "Oscar", "Toby"]

print(friends)

friends.extend(lucky_number)

print(friends)

friends.append("Paulo")

print(friends)

friends.insert(1, "Keely")

print(friends)

friends.remove("Paulo")

print(friends)

friends.clear()

print(friends)

friends = ["Kevin","Karen", "Jim", "Oscar", "Toby"]

friends.pop()

print(friends)

print(friends.index("Kevin"))
friends.insert(2, "Kevin")
friends.append("Paulo")
print(friends.count("Kevin"))


friends.sort()
print(friends)


lucky_number.reverse()

print(lucky_number)


friends2 = friends.copy()

print(friends2)