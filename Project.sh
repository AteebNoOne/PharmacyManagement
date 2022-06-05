#!/bin/sh
function logOut(){
echo $username Your LogOut Date and Time is: `date +"%d-%b-%Y %T"`
echo "Logging out..."
userlog=null
passlog=null
NewUsers
echo $username LogOut Date and Time is: `date +"%d-%b-%Y %T"`>> log.txt
sleep 3s
main
}


function admin(){
clear
echo ">>>>>>>>>>>>>>> Welcome $username to My Pharmacy Admin Panel <<<<<<<<<<<<<<<<<<"
echo " "
echo $username Admin Login Date and Time is: `date +"%d-%b-%Y %T"`
echo $username Admin Login Date and Time is: `date +"%d-%b-%Y %T"`>> log.txt
echo "Actions List:"

echo "----------Action Name-------------Actions-------------------------------"
echo "1)	Check Stocks		List amount of present items"
echo "2)	Edit Stocks		Add or remove amount of present items"
echo "3)	List employees		List names of all employees"	
echo "4)	Edit employees		Add or remove new employees"
echo "5)	Check log		List all activities"
echo "6)	LogOut			Go back to login page"
echo "7)	Exit			Close the program"
echo " "

echo "Choose your option(1 - 7)"
echo " "
read choice

if ((choice == 1))
then
checkstock

elif ((choice == 2))
then 
editstock

elif ((choice == 3))
then
listemp

elif ((choice == 4))
then
editemp

elif ((choice == 5))
then
checklog

elif ((choice == 6))
then
logOut

elif ((choice == 7))
then
exit 1

else
echo "Wrong Selection!"
sleep 1s
admin
fi
}  

function checkstock(){
clear
echo ">>>>>>>>>>>>>>>>>>> Welcome $username to My Stocks <<<<<<<<<<<<<<<<<<<<<<"
echo " "
echo $username Checked stocks Date and Time is: `date +"%d-%b-%Y %T"`>> log.txt
echo "Medicine List:"

echo "--------Medicine Name---Strength---------Quantituy----------"
echo "1)	"${myStnames[0]}"		40 mg		 ${myStocks[0]}"
echo "2)	"${myStnames[1]}"		20 mg		 ${myStocks[1]}"
echo "3)	"${myStnames[2]}"		50 mg		 ${myStocks[2]}"
echo "4)	"${myStnames[3]}"		10 mg		 ${myStocks[3]}"
echo "5)	"${myStnames[4]}"		40 mg		 ${myStocks[4]}"
echo "6)	"${myStnames[5]}"	25 mg		 ${myStocks[5]}"
echo " "
printf "Enter to go back..."
read bck
admin
}

function editstock(){
clear
echo ">>>>>>>>>>>>>>> Welcome $username to My Pharmacy Stocks Panel <<<<<<<<<<<<<<<<<<"
echo " "
echo "1)	Add Stocks		Add Stocks"
echo "2)	Remove Stocks		Remove Stocks"
echo "3)	Back			Go back to Admin Panel"
echo " "

echo "Choose your option (1 - 3)"
echo " "
read choice

if ((choice == 1))
then
addstck
elif ((choice == 2))
then
delstck
elif ((choice == 3))
then
admin
else
echo "Wrong choice"
fi
}

function addstck(){
printf "Enter an item name to add:"
read stadd
if [ -z "$stadd" ]
then
echo "Cant be empty"
addstck
fi
len=${#myStnames[@]}
for (( i=0; i<${len}; i++ )); do 
if [[ "$stadd" = "${myStnames[$i]}" ]]
then
printf "How many you want to add??"
read quan
sed -i "`expr ${i} + 1`s/.*/`expr ${myStocks[$i]} + $quan`/" Stocks.txt;
fi;
done
echo "Press Enter to go back"
read bck
NewUsers
editstock
}

function delstck(){
printf "Enter an item name to substract:"
read stdel
if [ -z "$stdel" ]
then
echo "Cant be empty"
delstck
fi
len=${#myStnames[@]}
for (( i=0; i<${len}; i++ )); do 
if [[ "$stdel" = "${myStnames[$i]}" ]]
then
printf "How many you want to Substract???"
read quan
if [ "$quan" -gt "${myStocks[$i]}" ];then
echo "You have "${myStocks[$i]}" available which is less "${myStnames[$i]}" then you're trying to remove"
sleep 1s
delstck
else
echo "Success"
sed -i "`expr ${i} + 1`s/.*/`expr ${myStocks[$i]} - $quan`/" Stocks.txt
fi;
fi
done
echo "Press Enter to go back"
read bck
NewUsers
editstock
}

editemp(){
clear
echo ">>>>>>>>>>>>>>> Welcome $username to My Pharmacy Employee Panel <<<<<<<<<<<<<<<<<<"
echo " "
echo "1)	Add employees		Add new employees"
echo "2)	Remove employees	Remove employees"
echo "3)	Back			Go back to Admin Panel"
echo " "

echo "Choose your option (1 - 3)"
echo " "
read choice

if ((choice == 1))
then
add
elif ((choice == 2))
then
del
elif ((choice == 3))
then
admin
else
echo "Wrong choice"
fi
}

function add(){
printf "Choose Username:"
read user
if [ -z "$user" ]
then
echo "Username cant be empty"
add
fi
for i in ${myUsers[@]};do
    if [ -z "$i" ]; then
    echo $user>Users.txt
    fi
done
for i in "${myUsers[@]}"; do
	if [ "${myUsers[$i]}" == "$user" ];
	then
	echo "Username Already Exist"
	add
	fi
done
echo $user>>Users.txt	
addingpwd
}

function addingpwd(){
printf "Enter password:"
read pwd
if [ -z "$pwd" ]
then
      echo "Password cant be empty"
      addingpwd
fi
for i in ${myPass[@]};do
    if [ -z "$i" ]; then
        echo $pwd>Pass.txt
    fi
done
echo $pwd>>Pass.txt
addingname
}

function addingname(){
printf "Set Full Name:"
read fname
if [ -z "$fname" ]
then
      echo "Name cant be empty"
      addingname
fi
for i in ${myNames[@]};do
    if [ -z "$i" ]; then
        echo $fname>Names.txt
    fi
done
echo $fname>>Names.txt
echo "User added successfully"
sleep 2s
editemp
}
#Delete users function starts from here
function del(){
clear
printf "Enter Username to delete user:"
read todelbu
if [ -z "$todelbu" ]
then
      echo "Cant be empty"
      del
fi
for i in "${!myUsers[@]}";do
if [[ "$todelbu" = "${myUsers[$i]}" ]];then
if (("$todelbu" == 16417 ))
then
echo "Cant delete admin"
sleep 1s
del;
fi;
sed -i /"${myUsers[$i]}"/d Users.txt
sed -i /"${myPass[$i]}"/d Pass.txt
sed -i /"${myNames[$i]}"/d Names.txt
fi
done
echo "Success 1 Row effected"
sleep 1s
editemp
}

function checklog(){
clear
while read line; do echo $line; done < log.txt
echo "Input a to go back Input b to clear log"
read k
if [[ "$k" = "a" ]]
then
admin
elif [[ "$k" = "b" ]]
then
echo ""> log.txt
admin
fi
}

function listemp(){
for z in "${!myUsers[@]}";do
printf "Username: ${myUsers[$z]} First Name:"${myNames[$z]}""
echo " "
done
echo "Press Enter to go back"
read k
admin
}
 
function employee(){ 
NewUsers
clear
nu=5
for p in "${!myStnames[@]}";do
if [[ "${myStocks[$p]}" -lt $nu ]]
then
printf "ALERT ! STOCKS OF "${myStnames[$p]}" ARE LOW OR ZERO PLEASE CONTACT ADMIN!"
echo ""
fi;
done
echo ""
echo ">>>>>>>>>>>>>>>>>>> Welcome $username to My Pharmacy <<<<<<<<<<<<<<<<<<<<<<"
echo " "
echo $username Your Login Date and Time is: `date +"%d-%b-%Y %T"`
echo $username Login Date and Time is: `date +"%d-%b-%Y %T"`>> log.txt
echo "Medicine List:"

echo "----------Medicine Name----------strength----------Price----------"
echo "1)	Rigix			40 mg		 Rs 67 "
echo "2)	Risek			20 mg		 Rs 25 "
echo "3)	Zertech			50 mg		 Rs 150 "
echo "4)	Flagyle			10 mg		 Rs 100 "
echo "5)	Amoxile			40 mg		 Rs 60 "
echo "6)	Brufeene		25 mg		 Rs 20 "
echo "7)	LogOut"
echo " "

echo "Which Medicine Do You Want? (1 - 7)"
echo " "
read choice

if ((choice == 1 ))
then
if [[ "${myStocks[0]}" -gt 0 ]]
then
echo "How Many Packs Of Rigix 40mg Do You Want?"
read Rigix_q
if [[ $Rigix_q -lt "${myStocks[0]}" ]]
then
price=`expr $Rigix_q \* 67`
sed -i "1s/.*/`expr ${myStocks[0]} - $Rigix_q`/" Stocks.txt;
else
echo "Out of stocks!"
sleep 1s
employee
fi
else
echo "Out of stocks!"
fi

elif ((choice == 2))
then
if [[ "${myStocks[1]}" -gt 0 ]]
then
echo "How Many Packs Of Risek 20mg Do You Want?"
read Risek_q
if [[ $Risek_q -lt "${myStocks[1]}" ]]
then
price=`expr $Risek_q \* 25`
sed -i "2s/.*/`expr ${myStocks[1]} - $Risek_q`/" Stocks.txt;
else
echo "Out of stocks!"
sleep 1s
employee
fi
else
echo "Out of stocks!"
fi

elif ((choice == 3))
then
if [[ "${myStocks[2]}" -gt 0 ]]
then
echo "How Many Packs Of Zertech 50mg Do You Want?"
read Zertech_q
if [[ $Zertech_q -lt "${myStocks[2]}" ]]
then
price=`expr $Zertech_q \* 150`
sed -i "3s/.*/`expr ${myStocks[2]} - $Zertech_q`/" Stocks.txt;
else
echo "Out of stocks!"
sleep 1s
employee
fi
else
echo "Out of stocks!"
fi

elif ((choice == 4))
then
if [[ "${myStocks[3]}" -gt 0 ]]
then
echo "How Many Packs Of Flagyle 10mg Do You Want?"
read Flagyle_q
if [[ $Flagyle_q -lt "${myStocks[3]}" ]]
then
price=`expr $Flagyle_q \* 100`
sed -i "4s/.*/`expr ${myStocks[3]} - $Flagyle_q`/" Stocks.txt;
else
echo "Out of stocks!"
sleep 1s
employee
fi
else 
echo "Out of stocks!"
fi

elif ((choice == 5))
then
if [[ "${myStocks[4]}" -gt 0 ]]
then
echo "How Many Packs Of Amoxile 40mg Do You Want?"
read Amoxile_q
if [[ $Amoxile_q -lt "${myStocks[4]}" ]]
then
price=`expr $Amoxile_q \* 60`
sed -i "5s/.*/`expr ${myStocks[4]} - $Amoxile_q`/" Stocks.txt;
else
echo "Out of stocks!"
sleep 1s
employee
fi
else
echo "Out of stocks!"
fi

elif ((choice == 6))
then
if [[ "${myStocks[5]}" -gt 0 ]]
then
echo "How Many Packs Of Brufeene 25mg Do You Want?"
read Brufeene_q
if [[ $Brufeene_q -lt "${myStocks[5]}" ]]
then
price=`expr $Brufeene_q \* 20`
sed -i "6s/.*/`expr ${myStocks[5]} - $Brufeene_q`/" Stocks.txt;
else
echo "Out of stocks!"
sleep 1s
employee
fi
else
echo "Out of stocks!"
fi

elif ((choice == 7))
then
logOut

else
echo "Wrong choice..."
sleep 1s
employee
fi

echo "Thanks For Your Order Printing bill"
echo " "
sleep 1s

printf "Enter Customer Name:"
read c_name
printf "Enter Customer Contact:"
read c_cntn
echo "$c_name Your Contact no: $c_cntn" >bill.txt
echo "Your Total Amount is: "$price "PKR">>bill.txt
echo "Please Pay The Bill and Collect Your medicine From The Counter">>bill.txt
echo "Thanks For Visiting My Pharmacy">>bill.txt
echo "Good Bye">>bill.txt
echo "Get Well Soon <3">>bill.txt
echo "Ref: $username Customer: $c_name with Contact number: $c_cntn bought stuff of worth $price PKR" >> log.txt
employee
}

function userauth(){
len=${#myUsers[@]}
for (( i=0; i<${len}; i++ )); do 
if [[ "$userlog" = "${myUsers[$i]}"&&"$passlog" = "${myPass[$i]}" ]]
then
username="${myNames[$i]}"
if (("$userlog" == 16417&&"$passlog" == ateeb ))
then
admin;
fi;
employee;
fi;
done
echo "Wrong Password or Username!";
sleep 1s
main	
}

function main(){
clear
echo ">>>>>>>>>>>>>>>>>>> Welcome to My Pharmacy Login Page<<<<<<<<<<<<<<<<<<<<<<"
echo " "
printf "Enter Username:"
read userlog
if [ -z "$userlog" ]
then
      echo "Username cant be empty"
      sleep 1s
      main
fi
printf "Enter Password:"
read passlog
if [ -z "$passlog" ]
then
      echo "Username cant be empty"
      sleep 1s
      main
fi
userauth
}
function NewUsers(){
echo Creating files...
sleep 2s
FILE1=/home/liveuser/Users.txt
if test -f "$FILE1"; then
IFS=$'\n' read -d '' -r -a myUsers < /home/liveuser/Users.txt
else
echo 16417 >Users.txt 
echo 18634 >>Users.txt
echo 18953 >>Users.txt   
fi
FILE2=/home/liveuser/Pass.txt
if test -f "$FILE2"; then
IFS=$'\n' read -d '' -r -a myPass < /home/liveuser/Pass.txt
else
echo ateeb>Pass.txt 
echo hammad>>Pass.txt 
echo shiza>>Pass.txt 
   
fi
FILE3=/home/liveuser/Names.txt
if test -f "$FILE3"; then
IFS=$'\n' read -d '' -r -a myNames < /home/liveuser/Names.txt
else
echo "Ateeb Ur Rehman">Names.txt  
echo "Hammad Akhtar">>Names.txt  
echo "Shiza Humayun">>Names.txt    
fi
FILESTOCK=/home/liveuser/Stocks.txt
if test -f "$FILESTOCK"; then
IFS=$'\n' read -d '' -r -a myStocks < /home/liveuser/Stocks.txt
else
echo 0 >Stocks.txt 
echo 0 >>Stocks.txt
echo 0 >>Stocks.txt   
echo 0 >>Stocks.txt
echo 0 >>Stocks.txt  
echo 0 >>Stocks.txt
fi

FILESTCKNAME=/home/liveuser/StocksNames.txt
if test -f "$FILESTCKNAME"; then
IFS=$'\n' read -d '' -r -a myStnames < /home/liveuser/StocksNames.txt
else
echo "Rigix" >StocksNames.txt 
echo "Risek">>StocksNames.txt
echo "Zertech" >>StocksNames.txt   
echo "Flagyle" >>StocksNames.txt
echo "Amoxile" >>StocksNames.txt  
echo "Brufeene" >>StocksNames.txt
fi
}
NewUsers
main
