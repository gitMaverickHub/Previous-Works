for i in range(1, 10):
    for j in range(1, 10):
        for n in range(1, 10):
            print("(declare-const P_" + str(i) + "_" + str(j) + "_" + str(n) + " Bool)")

print("(assert P_1_6_3)")
print("(assert P_1_8_8)")

print("(assert P_2_3_6)")
print("(assert P_2_5_7)")
print("(assert P_2_8_5)")

print("(assert P_3_2_1)")
print("(assert P_3_5_2)")
print("(assert P_3_7_9)")

print("(assert P_4_9_1)")

print("(assert P_5_1_5)")
print("(assert P_5_2_2)")

print("(assert P_6_1_7)")
print("(assert P_6_3_9)")
print("(assert P_6_4_4)")
print("(assert P_6_6_6)")
print("(assert P_6_7_3)")

print("(assert P_7_4_2)")
print("(assert P_7_9_7)")

print("(assert P_8_3_5)")
print("(assert P_8_5_4)")

print("(assert P_9_1_3)")
print("(assert P_9_4_8)")

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