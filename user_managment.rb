class UserManagment

  attr_accessor :name, :email,:password,:hint, :hintAnswer

  @name
  @email
  @password
  @hint
  @hintAnswer
  #client



  # def initialize(name, email, password, hint,hintAnswer)
  #
  #   @name = name
  #   @email = email
  #   @password = password
  #   @hint = hint
  #   @hintAnswer = hintAnswer
  #
  # end

  # empty Constructor
  def initialize

  end




  def setUserName

    loop do
      puts("Please enter your name")
      userName=gets.chomp()
      if userName.eql?("")
        puts("Please enter a valid name")

      else
        return userName
      end
    end

  end


  def setPassword

    password_validation =  /[a-zA-Z0-9_~!@$%^&*()]{6,}/ # password format

    loop do
      puts("please enter your password")
      password = gets.chomp

      if password_validation.match(password).to_s.chomp.length==0 then puts ("weak password, try again \n")

      else
      puts("confirm your password")
      password2= gets.chomp
      if password.eql?(password2)
        puts("password O.K")
        return password
      else
        puts ("Passwords doesn't match, please try again\n")
      end
    end
  end


end




  def setUserEmail
    email_validation = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    loop do
      puts("please enter your email")
      email = gets.chomp
      #send the email to the isExist function
      isExist = isUserExsist(email)
      if email_validation.match(email).to_s.chomp.length ==0 or  isExist==true
        if isExist==true then puts ("the user is already exists")
          else puts "wrong email input, please try again"
        end

      else
        return email
      end

    end
  end



  def setHintQuestion
    # hint

    userChoiceNumber =0

    #connect to Mysql and to table Students
    @client = Mysql2::Client.new(:host => "localhost", :username => "root",:password => "1212",:database => "students")
    #get table info, the query set into result
    results = @client.query("SELECT * FROM hints")


    puts("Please choose one of the five hints below")
    results.each do |row| #list of hints
      puts row
    end



    loop do
      userChoiceNumber=gets.chomp.to_i
      if userChoiceNumber<0 || userChoiceNumber>6 then puts("Wrong input please try again")
      else break

      end
    end

    return userChoiceNumber

  end



  def setHintAnswer

    puts("Please insert your hint answer")
    hintAnswer = gets.chomp
    return hintAnswer

  end


  def insertToDB(name,email,password,hint,hintAnswer)

    @client.query("INSERT INTO users(name,email,passwd,hintID,hintAnswer) VALUES('#{name}','#{email}','#{password}',#{hint},'#{hintAnswer}');")
  end

  def readUsers
    @client = Mysql2::Client.new(:host => "localhost", :username => "root",:password => "1212",:database => "students")
    read = @client.query("select * from users")
    read.each do |row| #list of hints
      puts row
    end
  end

  #check if there is a user with the same email - email need to be Injective to all the other's email
  def isUserExsist(email)
    @client = Mysql2::Client.new(:host => "localhost", :username => "root",:password => "1212",:database => "students")
    compareEmail = @client.query("SELECT * FROM users WHERE email = '#{email}'")

    #check if there is one row - if it do have, the user is exist
    if compareEmail.count==0
      return false
    else
      return true

    end
  end

  def removeUser(email,password)
    @client = Mysql2::Client.new(:host => "localhost", :username => "root",:password => "1212",:database => "students")
    compareEmail = @client.query("DELETE FROM users WHERE email = '#{email}' AND passwd= '#{password}'")

  end


end






