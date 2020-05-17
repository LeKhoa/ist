class TransactionController < ApplicationController
  skip_before_action :verify_authenticity_token
  PATH = TransactionWorker::PATH

  def reset
    File.open("#{PATH}/user1.txt", "w") do |f|
      f.write("1000")
    end
    File.open("#{PATH}/user2.txt", "w") do |f|
      f.write("1000")
    end

    render json: {
      "user1_amount" => 1000,
      "user2_amount" => 1000,
    }
  end

  def transfer
    from = params[:transfer_from].to_i
    to = params[:transfer_to].to_i
    amount = params[:amount].to_f
    TransactionWorker.perform_async(from, to, amount)
  end

  def amounts
    amount1 = File.read("#{PATH}/user1.txt").to_s
    amount2 = File.read("#{PATH}/user2.txt").to_s
    render json: {
      "user1_amount" => amount1,
      "user2_amount" => amount2,
    }
  end
end
