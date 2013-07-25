class NewsletterWorker
  include Sidekiq::Worker

  def perform(*args)
    User.find_each do |user|
      @user = user
      @posts = Post.joins(:communities).where("posts.created_at >= ?", DateTime.now - 1.week).where(approved: true, communities: {id: @user.community_ids}).select('posts.*, COUNT(distinct communities.id) AS community_count').having('COUNT(distinct communities.id) >= 2').group('posts.id').order('community_count DESC')
      begin
        UserMailer.newsletter(@user, @posts).deliver! unless @posts.blank?
      rescue
        puts "Mailing error caused by User #{user.id} - check workers/newsletter_worker.rb"
      end
    end
  end
end