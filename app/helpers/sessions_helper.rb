module SessionsHelper


   def sign_in(user)

      # Note: cookies utility supplied by rails. Used like a hash,
      # with value and optional expires date. Using permanent causes
      # Rails to set expiration to 20 years from now.
      cookies.permanent[:remember_token] = user.remember_token

      # Purpose is to create current_user accessible in both
      # controllers and views. Remember all helpers available
      # to views and this SessionsHelper was added to the
      # Applications controller to make available to all controllers.
      self.current_user=user

   end

   def sign_out
     self.current_user=nil
     cookies.delete(:remember_token)
   end

   # This defines a method 'current_user=' whose one argument
   # is the righthand side of the assignment.
   def current_user=(user)

     # Defines instance variable @current_user
     #
     @current_user = user

   end

   def current_user

     # '||=' (or equals) Set the @current_user instance variable
     # to the user corresponding to the remember token, but only if 
     # @current_user is undefined.
      @current_user ||= 
        User.find_by_remember_token(cookies[:remember_token]) 
      return @current_user

   end

   def signed_in?
     !current_user.nil?
   end

end

