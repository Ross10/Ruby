


require 'rubygems'
require 'mysql2'
require_relative "user_managment"




def login
  puts("login - Wellcom ")


  hash = {}
  user= UserManagment.new
  user.readUsers # print all the DB of users
  # File.open("Students.txt") do |fp| #check if the file is not empty
  #   fp.each do |line|
  #     key, value = line.chomp.split(" ")
  #     hash[key] = value
  #   end
  # end



  puts("please enter youre email")
  userMail = gets.chomp
  puts("please enter youre password")

  i=2
  while i>=0 do

    userPass = gets.chomp
    if userPass!= hash[userMail]
      if i==0
        puts("sorry - wrong password. goodBye")
        break
      end
      puts("wrong password try again - you left #{i} times")


      i-=1

    else
      puts("wellcom")
      break
    end

  end




end


def register
#  user = UserManagment.new("fdf","fdf",1,"fdf","fdf")

  @hints = []
  userChoiceNumber=0

  puts("register\n\n")


  # call to setters methods
  namea= @user.setUserName()
  emaila=@user.setUserEmail()
  # userExisit = user.isUserExsist(emaila)
  # puts userExisit
  passworda =@user.setPassword()
  hinta = @user.setHintQuestion()
  puts hinta
  hintAnswera = @user.setHintAnswer()



  @user.insertToDB(namea,emaila,passworda,hinta,hintAnswera)



       # studentFile.puts("#{email} #{password} #{userChoiceNumber} #{userChoiceHint}")

end




def recoverPassword
  puts("recoverPassword")
end



def removeMe
  puts "please enter your email"
  email = gets.chomp
  puts "please enter your password"
  password = gets.chomp

  @user.removeUser(email,password)
  # loop do
  #   if isUserExsist email == false
  #     puts "you are not in the list please try again"
  #   else

    # end
  # end


end



def showAll
  @user.readUsers
end



def quit
  puts("quit")
end



####################################################################################################################
####################################################################################################################


                                  # M A I N     A R E A

####################################################################################################################
####################################################################################################################
@user= UserManagment.new
choice = ""
loop do
  puts ("Please enter your choice\n

  1. Login\n

  2. Register new\n

  3. Recover Password\n

  4. Remove me\n

  5. Show all\n

  6. Quit" )

  choice=gets.chomp.to_i
  break if choice >=1 and choice <= 6

end

case choice
  when 1 then login
  when 2 then register
  when 3 then recoverPassword
  when 4 then removeMe
  when 5 then showAll
  when 6 then quit
end

