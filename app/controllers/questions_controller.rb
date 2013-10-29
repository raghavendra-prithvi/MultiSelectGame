class QuestionsController < ApplicationController
  #before_filter :login_req, :except => ['main_home']
  # GET /questions
  # GET /questions.json
  require 'net/http'
  def index
    @questions = Question.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @questions }
    end
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
    @question = Question.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @question }
    end
  end

  # GET /questions/new
  # GET /questions/new.json
  def new
    @question = Question.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @question }
    end
  end

  # GET /questions/1/edit
  def edit
    @question = Question.find(params[:id])
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(params[:question])

    respond_to do |format|
      if @question.save
        format.html { redirect_to @question, notice: 'Question was successfully created.' }
        format.json { render json: @question, status: :created, location: @question }
      else
        format.html { render action: "new" }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /questions/1
  # PUT /questions/1.json
  def update
    @question = Question.find(params[:id])

    respond_to do |format|
      if @question.update_attributes(params[:question])
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question = Question.find(params[:id])
    @question.destroy

    respond_to do |format|
      format.html { redirect_to questions_url }
      format.json { head :no_content }
    end
  end
  
  def home
    if(!params[:id].nil?)
      @question_before = Question.find(params[:id])
      @question =  @question_before.next
      if @question.nil?
        @question = Question.first
      end
    else
      @question = Question.first
    end
    
  end

  def check_answer
    valid = false
    @ques = Question.find(params[:questionId])
    puts "**************"
    puts @ques.ans.to_s
    puts params[:id].to_s
    puts "#*****************"
    if(@ques.ans.to_s == params[:id])
      valid = true
    end
    render :text => valid.to_s
  end
  


   def home1
     session[:score_to_be_added] = 100
     all_brands = Brand.all
    @brands = all_brands.map { |b|
      b.name
    }
    @products = []
    tot_brands = @brands.length
    while @products.empty? do
      b_rand = rand(tot_brands)
      @selected_brand = []
       @selected_brand << @brands[b_rand]
      @products = Product.where(:brand => @selected_brand[0])
    end
    @product = @products.sample(1)
    @score = Score.find(session[:score_id])

    session[:answer] = @selected_brand[0].gsub(/\W+/, '')
    session[:score_to_be_added] = 100
    @store_names = @brands - @selected_brand
    @selected_store_names = @store_names.sample(3)
    randVal = rand(4)
    1..rand(10).times do
      randVal = rand(4)
    end
    @selected_store_names.insert(randVal,@selected_brand[0])

    @buy_url = @product[0].buy_url
  end

  
  def check_brand_name
      data = {}
       data["valid"] = false
       @score = Score.find(session[:score_id])
       @user = User.find_by_uid(session[:user_id])
        @question = @user
        status = @user.user_status unless session[:user_id].nil?
    if session[:answer] == params[:val]
          if !session[:user_id].nil?
              if status.nil?
                new_status = UserStatus.new
                new_status.user_id = @user.id
                new_status.save!
                status = new_status
              end
              if status.right_answers.nil?
                status.right_answers = 1
              else
                status.right_answers += 1
              end
              status.save!
              resultBadge = check_success_badges(status.right_answers)
              if(resultBadge > 0)
                data["achieved"] = true
                @badge = Merit::Badge.find(resultBadge)
                data["badge_url"] = @badge.image
                data["badge_name"] = @badge.name
              end
              @score.points = @score.points + session[:score_to_be_added]
              @score.save!
          end
        session[:total_score] = session[:total_score] + session[:score_to_be_added]
        data["valid"] = true
      else
          if !session[:user_id].nil?
                if status.nil?
                  new_status = UserStatus.new
                  new_status.user_id = @user.id
                  new_status.save!
                  status = new_status
                end
                if status.wrong_answers.nil?
                  status.wrong_answers = 1
                else
                  status.wrong_answers += 1
                end
                status.save!                
                resultBadge = check_failure_badges(status.wrong_answers)
                if(resultBadge > 0)
                  data["achieved"] = true
                  @badge = Merit::Badge.find(resultBadge)
                  data["badge_url"] = @badge.image
                  data["badge_name"] = @badge.name
                end               
          end
        session[:mistakes] += 1
        if(session[:mistakes] >= 10)
            data["valid"] = "completed"
        end
        session[:score_to_be_added] = session[:score_to_be_added] - 25
        check_merit
      end
      data["score"] = session[:total_score] #@score.points
#      if @user.nil?
        render :json => data.to_json
#      else
#        redirect_to :action => 'check_merit', :data => data
#      end
  end



  def check_merit
    return true
  end

  def main_home
        
  end

  def load_data
    all_brands = Brand.all
    @brands = all_brands.map { |b|
      b.name
    }
    @brands.each do |b|
      @products = Svpply.products(query: b)
      @products.each do |p|
        Product.find_by_product_id(p.id.to_s) || Product.create_product(p,b)
      end
    end
  end


  def high_scores
      @scores = Score.limit(10).where(:user_id => session[:user_id]).order("points DESC")
  end
  
  def game_start
    session[:wrong_answer_count] = 0
    session[:score_now] = 0
    session[:mistakes] = 0
    session[:total_score] = 0
    unless session[:user_id].nil?
        @score  = Score.new
        @score.points = 0
        @score.user_id = session[:user_id]
        @score.save!
        session[:score_id] = @score.id
    end
    redirect_to :action => 'home1'
  end
  
  def game_end
    @score = Score.find(session[:score_id])
    session[:score_id] = nil
    session[:mistakes] = 0
  end


  def getFriendsData
    @scores = Score.where(:user_id => params[:ids]).limit(10).maximum(:points,group: 'user_id')
    @scores = @scores.sort_by { |k| k[1] }.reverse
    render :html => "getFriendsData", :layout => false
  end
  def getGlobalData
    @scores = Score.where("user_id is not null").limit(10).maximum(:points,group: 'user_id')
    @scores = @scores.sort_by { |k| k[1] }.reverse
    render :html => "getGlobalData", :layout => false
  end

  def invite_friend
      @user = User.find_by_uid(session[:user_id])
      status = @user.user_status
      if status.nil?
        new_status = UserStatus.new
        new_status.user_id = @user.id
        new_status.save!
        status = new_status
      end
      if status.invited.nil?
        status.invited = 1
      else
        status.invited += 1
      end
      status.save!
  end

  def fbshare
      @user = User.find_by_uid(session[:user_id])
      status = @user.user_status
      if status.nil?
        new_status = UserStatus.new
        new_status.user_id = @user.id
        new_status.save!
        status = new_status
      end
      status.shared_on_fb = true   
      status.save
  end

  def buyed
      @user = User.find_by_uid(session[:user_id])
      status = @user.user_status
      if status.nil?
        new_status = UserStatus.new
        new_status.user_id = @user.id
        new_status.save!
        status = new_status
      end
      status.buyed = true
      status.save
  end

  def check_success_badges(rightAns)

    if(rightAns == 10)
      badge_id = 1
    elsif(rightAns == 25)
      badge_id = 2
    elsif(rightAns == 50)
      badge_id = 3
    elsif(rightAns == 100)
      badge_id = 4
    elsif(rightAns == 500)
      badge_id = 5
    elsif(rightAns == 1000)
      badge_id = 6
    elsif(rightAns == 10000)
      badge_id = 7
    else
      badge_id = 0
    end
    return badge_id
  end

  def check_failure_badges(rngAns)
      if(rngAns == 10)
        badge_id = 8
      elsif(rngAns == 25)
        badge_id = 9
      elsif(rngAns == 50)
        badge_id = 10
      elsif(rngAns == 100)
        badge_id = 11
      else
        badge_id = 0
      end
      return badge_id
  end

  def badges
    @badges = current_user.badges
  end

end
