for i in range(1, 5):
    for j in range(1, 5):
        for n in range(1, 5):
            print("(declare-const P_" + str(i) + "_" + str(j) + "_" + str(n) + " Bool)")

for i in range(1, 5):
    for n in range(1, 5):
        row = "(assert (or"
        for j in range(1, 5):
            row += " " + "P_" + str(i) + "_" +str(j) + "_" + str(n)
            
        row += "))"
        print(row)
        
for j in range(1, 5):
    for n in range(1, 5):
        column = "(assert (or"
        for i in range(1, 5):
            column += " " + "P_" + str(i) + "_" +str(j) + "_" + str(n)
            
        column += "))"
        print(column)
        
for r in range(0, 2):
    for c in range(0, 2):
        for n in range(1, 5):
            block = "(assert (or"
            for i in range(1, 3):
                for j in range(1, 3):
                    block += " " + "P_" + str(2*r+i) + "_" + str(2*c+j) + "_" + str(n)
            block += "))"
            print(block)
            
for i in range(1, 5):
    for j in range(1, 5):
        for n in range(1, 5):
            cell = "(assert (or (not " + "P_" + str(i) + "_" + str(j) +"_" + str(n) +  ") (not (or"
            for n1 in range(1, 5):
                if n == n1:
                    continue
                cell += " " + "P_" + str(i) + "_" + str(j) +"_" + str(n1)
            cell += "))))"
            print(cell)
            
            
print("(check-sat)")
print("(get-model)")