1.
User.select("*, (select count(*) from posts where posts.user_id=users.id) as post_count")
    .order("post_count desc")

Câu truy vấn bên trên chậm là do:
- Đầu tiên là nó đang sử dụng câu subquery để tính tổng số post cho từng user.
- Thứ hai là nó đang dùng lệnh count(*) - đếm toàn bộ các cột sẽ chậm hơn là đếm chỉ một cột, ta có thể thay bằng count(posts.id) cũng sẽ giảm được số lượng truy vấn vào database.


Cách tối ưu lại là ta sẽ dùng left join để lấy kết quả cho toàn bộ User cho trường hợp này (Lưu ý là từ rails 5 đã hỗ trợ hàm left_joins)
User.select('users.*, COUNT(posts.id) AS post_count').left_joins(:posts).group('users.id').order('post_count DESC')





2.
# migration file:
rails generate migration AddUnSubscriptionFieldsToUsers unsubscribed_at: datetime unsubscribed_token_expires_at:datetime unsubscribed_token:string


---
File model user
# app/models/user.rb
class User < ApplicationRecord
  # ...

  # Tạo mã thông báo hủy đăng ký mới với thời gian hết hạn
  def generate_unsubscribe_token
    update(unsubscribed_token: SecureRandom.urlsafe_base64, unsubscribed_token_expires_at: 3.days.from_now)
  end

  # Hủy đăng ký người dùng khỏi thông báo qua email
  def unsubscribe_from_notifications
    update(subscribed_at: nil, unsubscribed_at: Time.now, unsubscribed_token: nil, unsubscribed_token_expires_at: nil)
  end
end

---
File Services
# app/services/unsubscribe_service.rb
class UnsubscribeService
  def initialize(user, token)
    @user = user
    @token = token
  end

  def call
    if user_can_unsubscribe?
      @user.unsubscribe_from_notifications
      true
    else
      false
    end
  end

  private

  # Chỗ này em giả định là sẽ kiểm tra thêm là user nó đã subcribed chưa qua biến subscribed?
  def user_can_unsubscribe?
    @user.subscribed? &&
      @user.unsubscribed_token == @token &&
      @user.unsubscribed_token_expires_at > Time.now
  end
end


---
File controllers
# app/controllers/notifications_controller.rb
class NotificationsController < ApplicationController
  def unsubscribe
    @user = User.find_by(id: params[:user_id])
    token = params[:token]

    if UnsubscribeService.new(@user, token).call
      flash[:success] = "You have been unsubscribed from email notifications."
    else
      flash[:error] = "Invalid unsubscribe link or you are already unsubscribed."
    end

    redirect_to root_path
  end
end


3.
Tôi giả sử là sẽ bỏ qua vụ thiết lập load balance trên server, mà chỉ tập trung việc cải thiện hệ thống.
- Tôi đang nghĩ đến giải pháp đơn giản nhất là dùng Sidekiq để chạy xử lý chạy nền bên dưới.

Khi mỗi lần user ghé thăm trang post, thì ngoài việc lấy dữ liệu của trang post đó hiển thị, tôi sẽ dùng worker để chạy ngầm xử lý bộ đếm số lượng người viếng thăm.
Như vậy nó sẽ ko ảnh hưởng đến hiệu suất của website chúng ta, do mọi logic cập nhật bộ đếm đều đc đẩy xuống worker để xử lý hết.


4. Gỉa sử cột title và description là bắt buộc nhập
# File migration
rails generate model Job title:string description:text


# File model
class Job < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
end


# File controller
class JobsController < ApplicationController
  before_action :set_job, only: [:show, :edit, :update, :destroy]

  def index
    @jobs = Job.all
  end

  def show
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new(job_params)
    if @job.save
      redirect_to jobs_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @job.update(job_params)
      redirect_to jobs_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @job.destroy
    redirect_to jobs_path
  end

  private

  def set_job
    @job = Job.find_by(id: params[:id])
  end

  def job_params
    params.require(:job).permit(:title, :description)
  end
end


File views
# app/views/jobs/index.html.erb
<%= turbo_frame_tag "new_job", target: "_top" %>
<%= link_to "New job", new_job_path, data: { turbo_frame: "new_job" } %>

<h1>Jobs</h1>

<div id="jobs">
  <%= render @jobs %>
</div>


# app/views/jobs/_form.html.erb
<%= form_with(model: job) do |form| %>
  <% if job.errors.any? %>
    <div style="color: red">
      <h2><%= pluralize(job.errors.count, "error") %> prohibited this job from being saved:</h2>

      <ul>
        <% job.errors.each do |error| %>
          <li><%= error.full_job %></li>
        <% end %>
      </ul>
    </div>
  <% end %>

  <div class="field">
    <%= form.label :title %>
    <%= form.text_field :title %>
  </div>

  <div class="field">
    <%= form.label :description %>
    <%= form.text_area :description %>
  </div>

  <div class="actions">
    <%= form.submit %>
  </div>
<% end %>


# app/views/jobs/_job.html.erb
<%= turbo_frame_tag job do %>
  <div id="<%= dom_id job %>">
    <p>
      <strong>Title:</strong>
      <%= job.title %>
    </p>
    <p>
      <strong>Description:</strong>
      <%= job.description %>
    </p>
    <%= link_to "Edit job", edit_job_path(job) %>
    <%= button_to "Delete job", job, method: :delete, form: { data: { turbo_confirm: "Are you sure?" } } %>
  </div>
<% end %>

# app/views/jobs/new.html.erb
<%= turbo_frame_tag @job do %>
  <%= render "form", job: @job %>
<% end %>


# app/views/jobs/new.turbo_stream.erb
<%= turbo_stream.update @job do %>
  <%= render "form", job: @job %>
<% end %>


# app/views/jobs/edit.html.erb
<%= turbo_frame_tag @job do %>
  <%= render "form", job: @job %>
<% end %>
