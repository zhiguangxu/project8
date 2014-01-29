class OrderNotifier < ActionMailer::Base
  default from: 'Zhiguang Xu<zxu@valdosta.edu>'

  def received(order)
    @order = order
    mail to: order.email, subject: 'Pragmatic Store Order Confirmation' do |format|
      format.html
    end
  end

  def shipped(order)
    @order = order
    mail to: order.email, subject: 'Pragmatic Store Order Shipped'
  end

end
