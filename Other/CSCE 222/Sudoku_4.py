for i in range(1, 10):
    for j in range(1, 10):
        for n in range(1, 10):
            print("(declare-const P_" + str(i) + "_" + str(j) + "_" + str(n) + " Bool)")

print("(assert P_1_1_8)")
print("(assert P_1_8_9)")

print("(assert P_2_7_6)")
print("(assert P_2_8_7)")

print("(assert P_3_3_3)")
print("(assert P_3_4_5)")
print("(assert P_3_5_8)")
print("(assert P_3_9_1)")

print("(assert P_4_4_8)")

print("(assert P_5_2_5)")
print("(assert P_5_5_4)")
print("(assert P_5_8_6)")
print("(assert P_5_9_3)")

print("(assert P_6_5_2)")
print("(assert P_6_9_9)")

print("(assert P_7_1_9)")
print("(assert P_7_2_4)")
print("(assert P_7_6_7)")

print("(assert P_8_1_2)")

print("(assert P_9_4_1)")
print("(assert P_9_6_3)")

for i in range(1, 10):
    for n in range(1, 10):
        row = "(assert (or"
        for j in range(1, 10):
            row += " " + "P_" + str(i) + "_" +str(j) + "_" + str(n)
            
        row += "))"
        print(row)
        
for j in range(1, 10):
    for n in range(1, 10):
        column = "(assert (or"
        for i in range(1, 10):
            column += " " + "P_" + str(i) + "_" +str(j) + "_" + str(n)
            
        column += "))"
        print(column)
        
for r in range(0, 3):
    for c in range(0, 3):
        for n in range(1, 10):
            block = "(assert (or"
            for i in range(1, 4):
                for j in range(1, 4):
                    block += " " + "P_" + str(3*r+i) + "_" + str(3*c+j) + "_" + str(n)
            block += "))"
            print(block)
            
for i in range(1, 10):
    for j in range(1, 10):
        for n in range(1, 10):
            cell = "(assert (or (not " + "P_" + str(i) + "_" + str(j) +"_" + str(n) +  ") (not (or"
            for n1 in range(1, 10):
                if n == n1:
                    continue
                cell += " " + "P_" + str(i) + "_" + str(j) +"_" + str(n1)
            cell += "))))"
            print(cell)
            
            
print("(check-sat)")
print("(get-model)")