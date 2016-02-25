User.transaction do
  User.create( :name => 'dave', :password => 'dave', :password_confirmation => 'dave', :address => "Dallas, TX")
  User.create( :name => 'mary', :password => 'mary', :password_confirmation => 'mary', :address => "San Jose, CA")
end

Product.transaction do    
# Products owned by dave
  Product.create!(title: 'Agile Web Development with Rails 4',
    description: 
      %{<p>
        Rails just keeps on changing. Both Rails 3 and 4, as well as Ruby 1.9 and 2.0, 
        bring hundreds of improvements, including new APIs and substantial performance 
        enhancements. The fourth edition of this award-winning classic has been reorganized 
        and refocused so it's more useful than ever before for developers new to Ruby and Rails.
      </p>},
    image_url:   open('app/assets/images/agile.jpg'),    
   user_id: User.find_by_name("dave").id,
   price: 26.46)
   
   Product.create!(title: 'jQuery Mobile, Up and Running',
    description: 
      %{<p>
        By the time you finish this book, you'll know how to create responsive, 
        Ajax-based interfaces that work on a variety of smartphones and tablets, 
        using jQuery Mobile and semantic HTML5 code.
      </p>},
    image_url:   open('app/assets/images/jQuery-Mobile.jpg'),    
   user_id: User.find_by_name("dave").id,
   price: 19.21)
   
# Products owned by Mary
  Product.create!(title: 'Pragmatic Version Control Using Git',
    description: 
      %{<p>
        There's a change in the air. High-profile projects such as the Linux Kernel, 
        Mozilla, Gnome, and Ruby on Rails are now using Distributed Version Control Systems (DVCS) 
        instead of the old stand-bys of CVS or Subversion.
      </p>},
    image_url:   open('app/assets/images/git.jpg'),    
   user_id: User.find_by_name("mary").id,
   price: 18.03)
   
   Product.create!(title: 'CoffeeScript Programming with jQuery, Rails, and Node.js',
    description: 
      %{<p>
        Learn CoffeeScript programming with the three most popular web technologies around.
      </p>},
    image_url:   open('app/assets/images/coffeescript.jpg'),    
   user_id: User.find_by_name("mary").id,
   price: 26.99)
   
   Product.create!(title: 'CoffeeScript: Accelerated JavaScript Development',
    description: 
      %{<p>
        For 15 years, dynamic web content has been written in a single language: 
        JavaScript. Now, for the first time, programmers have an alternative that doesn't
         add an extra layer of abstraction or require plugins. CoffeeScript provides all
          of JavaScript's functionality wrapped in a cleaner, more succinct syntax that 
          encourages use of "the good parts" of the language.
      </p>},
    image_url:   open('app/assets/images/coffee-ajd.jpg'),    
   user_id: User.find_by_name("mary").id,
   price: 26.10)
   
end