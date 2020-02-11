class MailerWorker
	include Sidekiq::Worker
	sidekiq_options retry: false

	def perform(buyer_email,seller_email)
		UserMailer.buyer_confirmation(buyer_email).deliver
		UserMailer.seller_confirmation(seller_email).deliver
	end
end