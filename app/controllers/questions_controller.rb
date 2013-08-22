class QuestionsController < ApplicationController
  before_filter :login_req, :except => ['main_home']
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
    
    #@question = Question.order("RANDOM()").limit(1)
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
  
#  def home1_original
#    @brands = ['Ray Ban','Balenciaga','Saint Laurent','Miu Miu','Lanvin','MCM','Balmain','Chanel','Maison Martin Margiela','Thom Browne','Common Projects','Azzedine Alaia','Raf Simmons','Cartier','Christian Dior','Phillip Lim','Ghurka','Proenza Schouler','Chloe','Giuseppe Zanotti','Marc Jacobs','Alexander Wang','Kenzo','Gucci','Ann Demeulemeester','Lucien Pellat-Finet','Prada','Burrberry','Fendi']
#
#    @products = []
#
#    while @products.empty? do
#      @selected_brand = @brands.sample(1)
#      @products = Svpply.products(query: @selected_brand[0])
#    end
#    #@products.any?{|p| p.title.include? @selected_brand[0] }
#    @product = @products.sample(1)
#
#    #@products.uniq! {|e| e.store["name"] }
#    #puts @stores.inspect\
#    #@product_store_name = []
#    #@product_store_name << @product[0].store["name"]
#
#    session[:answer] = @selected_brand[0].delete(' ')
#    puts "****************"
#    puts session[:answer]
#    @store_names = @brands - @selected_brand
#    @selected_store_names = @store_names.sample(3)
#    randVal = rand(4)
#    1..rand(10).times do
#      randVal = rand(4)
#    end
#    @selected_store_names.insert(randVal,@selected_brand[0])
#
#    @buy_url = @product[0].url
#  end

   def home1
     session[:score_to_be_added] = 100
     all_brands = Brand.all
    @brands = all_brands.map { |b|
      b.name
    }
    
#    @brands = ['Ray Ban','Balenciaga','Saint Laurent','Miu Miu','Lanvin','MCM','Balmain','Chanel','Maison Martin Margiela','Thom Browne','Common Projects','Azzedine Alaia','Raf Simmons','Cartier','Christian Dior','Phillip Lim','Ghurka','Proenza Schouler','Chloe','Giuseppe Zanotti','Marc Jacobs','Alexander Wang','Kenzo','Gucci','Ann Demeulemeester','Lucien Pellat-Finet','Prada','Burrberry','Fendi']

    @products = []

    while @products.empty? do
      @selected_brand = @brands.sample(1)
      #@products = Svpply.products(query: @selected_brand[0])
      @products = Product.where(:brand => @selected_brand[0])
    end
    @product = @products.sample(1)
    @score = Score.find(session[:score_id])
    session[:answer] = @selected_brand[0].delete(' ')
    session[:score_to_be_added] = 100
    puts "****************"
    puts session[:answer]
    @store_names = @brands - @selected_brand
    @selected_store_names = @store_names.sample(3)
    randVal = rand(4)
    1..rand(10).times do
      randVal = rand(4)
    end
    @selected_store_names.insert(randVal,@selected_brand[0])

    @buy_url = @product[0].buy_url
  end

  def home1_backup
    session[]
    @products = Svpply.categories.first.products("tshirt")
    @product = @products.sample(1)
    @products.uniq! {|e| e.store["name"] }
    #puts @stores.inspect\
    @product_store_name = []
    @product_store_name << @product[0].store["name"]
    
    session[:answer] = @product[0].store["name"].delete(' ')
    puts "****************"
    puts session[:answer]
    @store_names = @products.map{|p| p.store["name"]} - @product_store_name
    @selected_store_names = @store_names.sample(3)
    @selected_store_names.insert(rand(4),@product_store_name[0])
    #@selected_store_names.remove(@product_store_name)
    puts "*******************"
    puts @selected_store_names.inspect

    @similar_url = @product[0].categories[2]["url"]
    @display_name = @product[0].categories[2]["name"]

    @buy_url = @product[0].url
  end
  def check_brand_name
      data = {}
       data["valid"] = false
       @score = Score.find(session[:score_id])
    if session[:answer] == params[:val]
        data["valid"] = true
        @score.points = @score.points + session[:score_to_be_added]
        @score.save!
      else
        session[:mistakes] += 1
        if(session[:mistakes] == 10)
            #redirect_to :action => game_over
            data["valid"] = "completed"
        end
        session[:score_to_be_added] = session[:score_to_be_added] - 25
      end
      data["score"] = @score.points
      render :json => data.to_json
  end

  def main_home
        
  end

  def load_data
    all_brands = Brand.all
    @brands = all_brands.map { |b|
      b.name
    }
#    @brands = ['Ray Ban','Balenciaga','Saint Laurent','Miu Miu','Lanvin','MCM','Balmain','Chanel','Maison Martin Margiela','Thom Browne','Common Projects','Azzedine Alaia','Raf Simmons','Cartier','Christian Dior','Phillip Lim','Ghurka','Proenza Schouler','Chloe','Giuseppe Zanotti','Marc Jacobs','Alexander Wang','Kenzo','Gucci','Ann Demeulemeester','Lucien Pellat-Finet','Prada','Burrberry','Fendi']
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
    @score  = Score.new
    @score.points = 0
    @score.user_id = session[:user_id]
    @score.save!
    session[:score_id] = @score.id
    
    puts "&&&&&&&&&&&&&&&&&&&&&"
    puts "inside start"
    redirect_to :action => 'home1'
    #render :text => session[:access_token].to_s
  end
  
  def game_end
    @score = Score.find(session[:score_id])
    session[:score_id] = nil
    session[:mistakes] = 0
    #render :text => @score.points.to_s
  end


  def getFriendsData
    puts params.inspect
   # @scores = Score.find_by_sql("SELECT DISTINCT(s.user_id), max(s.points) FROM scores s where s.user_id in #{params[:ids]} order by s.points desc")
    #@scores = Score.where(:user_id => params[:ids]).order("points DESC")
    @scores = Score.where(:user_id => params[:ids]).select("user_id,points").order("max(points) DESC").limit(10)
    render :html => "getFriendsData", :layout => false
  end
  def getGlobalData
    

    @scores = Score.limit(10).select("DISTINCT user_id,points").order("max(points) DESC")
    render :html => "getGlobalData", :layout => false
  end

end
