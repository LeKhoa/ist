class TransactionWorker
  include Sidekiq::Worker
  sidekiq_options retry: false
  PATH = Rails.root.join("storage").freeze

  def perform(from, to, amount)
    from_amount = File.read("#{PATH}/user#{from}.txt").to_f
    File.open("#{PATH}/user#{from}.txt", "w") do |f|
      from_amount -= amount
      f.write(from_amount.to_s)
    end

    to_amount = File.read("#{PATH}/user#{to}.txt").to_f
    File.open("#{PATH}/user#{to}.txt", "w") do |f|
      to_amount += amount
      f.write(to_amount.to_s)
    end
  end
end
