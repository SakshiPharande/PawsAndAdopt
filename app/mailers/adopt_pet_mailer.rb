class AdoptPetMailer < ApplicationMailer
  default from: ENV["EMAIL_USERNAME"] # Change as per your requirement

  def status_update_email(adopt_pet, previous_status)
    @adopt_pet = adopt_pet
    @user = @adopt_pet.user
    @previous_status = previous_status.capitalize
    @new_status = @adopt_pet.status.capitalize

    mail(to: @user.email, subject: "Your Adoption Request Status Changed to #{@new_status}")
  end
end
