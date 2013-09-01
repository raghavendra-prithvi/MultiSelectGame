# Use this hook to configure merit parameters
Merit.setup do |config|
  # Check rules on each request or in background
  # config.checks_on_each_request = true

  # Define ORM. Could be :active_record (default) and :mongo_mapper and :mongoid
  # config.orm = :active_record

  # Define :user_model_name. This model will be used to grand badge if no :to option is given. Default is "User".
  # config.user_model_name = "User"

  # Define :current_user_method. Similar to previous option. It will be used to retrieve :user_model_name object if no :to option is given. Default is "current_#{user_model_name.downcase}".
  # config.current_user_method = "current_user"
  Merit::Badge.create! ({
    id: 1,
    name: "Intern",
    image: "/assets/badge.png",
    description: "Reached 10 correct questions",
    custom_fields: { difficulty: :low }
  })

   Merit::Badge.create! ({
    id: 2,
    name: "Lable Whore",
    image: "/assets/lablewhore.png",
    description: "Reached 25 correct questions",
    custom_fields: { difficulty: :low }
  })

  Merit::Badge.create! ({
    id: 3,
    name: "Addict",
    image: "/assets/badge.png",
    description: "Reached 50 correct questions",
    custom_fields: { difficulty: :medium }
  })

  Merit::Badge.create! ({
    id: 4,
    name: "Stylist",
    image: "/assets/badge.png",
    description: "Reached 100 correct questions",
    custom_fields: { difficulty: :high }
  })



  Merit::Badge.create! ({
    id: 5,
    name: "Fashion Killa",
    image: "/assets/fashionkilla.png",
    description: "Get 500 correct questions",
    custom_fields: { difficulty: :high }
  })

   Merit::Badge.create! ({
    id: 6,
    name: "Fashionista",
    image: "/assets/fashionista.png",
    description: "Reached 1000 correct questions",
    custom_fields: { difficulty: :high }
  })

  Merit::Badge.create! ({
    id: 7,
    name: "Editor at Large",
    image: "/assets/editoratlarge.png",
    description: "10000 correct questions",
    custom_fields: { difficulty: :medium }
  })

  ###### BADGETS for fail  ###########
  Merit::Badge.create! ({
    id: 8,
    name: "Knockoff",
    image: "/assets/knockoff.png",
    description: "Loose 10 games",
    custom_fields: { difficulty: :low }
  })



  Merit::Badge.create! ({
    id: 9,
    name: "Poser",
    image: "/assets/poser.png",
    description: "Get 25 questions wrong",
    custom_fields: { difficulty: :low }
  })

   Merit::Badge.create! ({
    id: 10,
    name: "Diva",
    image: "/assets/diva.png",
    description: "Get 50 questions wrong",
    custom_fields: { difficulty: :low }
  })

  Merit::Badge.create! ({
    id: 11,
    name: "Trainwreck",
    image: "/assets/trainwreck.png",
    description: "Get 100 questions wrong",
    custom_fields: { difficulty: :medium }
  })


  #########inviteesssss###########
  Merit::Badge.create! ({
    id: 12,
    name: "Namedropper",
    image: "/assets/badge.png",
    description: "Invited a friend",
    custom_fields: { difficulty: :high }
  })


   Merit::Badge.create! ({
    id: 14,
    name: "Entourage",
    image: "/assets/entourage.png",
    description: "Invited 5 friends",
    custom_fields: { difficulty: :high }
  })

  Merit::Badge.create! ({
    id: 15,
    name: "Trendsetter",
    image: "/assets/badge.png",
    description: "Invited 10 friends",
    custom_fields: { difficulty: :medium }
  })



 # sharing on facebook
  Merit::Badge.create! ({
    id: 16,
    name: "Bragging Rights",
    image: "/assets/badge.png",
    description: "Shared high score on Facebook",
    custom_fields: { difficulty: :low }
  })

# need categories to achieve this.
  Merit::Badge.create! ({
    id: 17,
    name: "Wardrobe",
    image: "/assets/badge.png",
    description: "Correctly answered 10 shoes, 10, shirts, 10 pants, 10 dresses...",
    custom_fields: { difficulty: :low }
  })

  Merit::Badge.create! ({
    id: 18,
    name: "Buyer",
    image: "/assets/buyer.png",
    description: "Buy Item from a store",
    custom_fields: { difficulty: :low }
  })



end

# Create application badges (uses https://github.com/norman/ambry)
# Merit::Badge.create!({
#   id: 1,
#   name: 'just-registered'
# }, {
#   id: 2,
#   name: 'best-unicorn',
#   custom_fields: { category: 'fantasy' }
# })
