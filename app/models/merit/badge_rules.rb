# Be sure to restart your server when you modify this file.
#
# +grant_on+ accepts:
# * Nothing (always grants)
# * A block which evaluates to boolean (recieves the object as parameter)
# * A block with a hash composed of methods to run on the target object with
#   expected values (+:votes => 5+ for instance).
#
# +grant_on+ can have a +:to+ method name, which called over the target object
# should retrieve the object to badge (could be +:user+, +:self+, +:follower+,
# etc). If it's not defined merit will apply the badge to the user who
# triggered the action (:action_user by default). If it's :itself, it badges
# the created object (new user for instance).
#
# The :temporary option indicates that if the condition doesn't hold but the
# badge is granted, then it's removed. It's false by default (badges are kept
# forever).

module Merit
  class BadgeRules
    include Merit::BadgeRulesMethods

    def initialize
      grant_on 'questions#check_brand_name', :badge => 'Label Whore', :model_name => 'User' do |u|
        u.user_status.right_answers == 10
      end
      grant_on 'questions#check_brand_name', :badge => 'Intern', :model_name => 'User' do |user|
        user.user_status.right_answers == 10
      end

      grant_on 'questions#check_brand_name', :badge => 'Label Whore', :model_name => 'User' do |user|
        user.user_status.right_answers == 25
      end
#
      grant_on 'questions#check_brand_name', :badge => 'Addict', :model_name => 'User' do |user|
        user.user_status.right_answers == 50
      end
#
      grant_on 'questions#check_brand_name', :badge => 'Stylist', :model_name => 'User' do |user|
        user.user_status.right_answers == 100
      end
#
      grant_on 'questions#check_brand_name', :badge => 'Fashion Killa', :model_name => 'User' do |user|
        user.user_status.right_answers == 500
      end
#
      grant_on 'questions#check_brand_name', :badge => 'Fashionista', :model_name => 'User' do |user|
        user.user_status.right_answers == 1000
      end
#
      grant_on 'questions#check_brand_name', :badge => 'Editor at Large', :model_name => 'User' do |user|
        user.user_status.right_answers == 10000
      end
#
#
#      #### Losts ############
      grant_on 'questions#check_brand_name', :badge => 'Knockoff', :model_name => 'User' do |user|
        user.user_status.wrong_answers == 10
      end

     grant_on 'questions#check_brand_name', :badge => 'Poser', :model_name => 'User' do |user|
        user.user_status.wrong_answers == 25
      end
#
      grant_on 'questions#check_brand_name', :badge => 'Diva', :model_name => 'User' do |user|
        user.user_status.wrong_answers == 50
      end
#
      grant_on 'questions#check_brand_name', :badge => 'Trainwreck', :model_name => 'User' do |user|
        user.user_status.wrong_answers == 100
      end
#
#
#      #invitations
      grant_on 'questions#invite_friend', :badge => 'Namedropper', :model_name => 'User' do |user|
        user.user_status.invited == 1
      end
#
      grant_on 'questions#invite_friend', :badge => 'Entourage', :model_name => 'User' do |user|
        user.user_status.invited == 5
      end
#
      grant_on 'questions#invite_friend', :badge => 'Trendsetter', :model_name => 'User' do |user|
        user.user_status.invited == 10
      end
#
#      #share highscore on facebook
      grant_on 'questions#fbshare', :badge => 'Bragging Rights', :model_name => 'User' do |user|
        user.user_status.shared_on_fb == true
      end
#
      grant_on 'questions#buyed', :badge => 'Buyer', :model_name => 'User' do |user|
        user.user_status.buyer == true
      end

      # If it creates user, grant badge
      # Should be "current_user" after registration for badge to be granted.
      # grant_on 'users#create', :badge => 'just-registered', :to => :itself

      # If it has 10 comments, grant commenter-10 badge
      # grant_on 'comments#create', :badge => 'commenter', :level => 10 do |comment|
      #   comment.user.comments.count == 10
      # end

      # If it has 5 votes, grant relevant-commenter badge
      # grant_on 'comments#vote', :badge => 'relevant-commenter', :to => :user do |comment|
      #   comment.votes.count == 5
      # end

      # Changes his name by one wider than 4 chars (arbitrary ruby code case)
      # grant_on 'registrations#update', :badge => 'autobiographer', :temporary => true, :model_name => 'User' do |user|
      #   user.name.length > 4
      # end
    end
  end
end
