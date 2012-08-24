authorization do
  
  role :guest do
    has_permission_on :user_sessions, :to => :manage
    has_permission_on :users, :to => [:create, :confirm]

  end


  role :guide do
    includes :guest
    has_permission_on :users, :to => :change_role
    has_permission_on [:users, :fish_species, :fishing_methods, :guide_posts, :angler_posts], :to => :read
    has_permission_on :users, :to => [:create, :update] do
      if_attribute :id => is { user.id }
    end
    has_permission_on [:guide_posts, :angler_posts], :to => :update do
      if_attribute :user_id => is { user.id }
    end
    has_permission_on [:guide_posts, :angler_posts], :to => :create
  end

  role :angler do
    includes :guest
    has_permission_on :users, :to => :change_role
    has_permission_on [:users, :fish_species, :fishing_methods, :guide_posts, :angler_posts], :to => :read
    has_permission_on :users, :to => [:create, :update] do
      if_attribute :id => is { user.id }
    end
    has_permission_on [:guide_posts, :angler_posts], :to => :update do
      if_attribute :user_id => is { user.id }
    end
    has_permission_on [:guide_posts, :angler_posts], :to => :create
  end

  role :property_owner do
    includes :guest
    has_permission_on :users, :to => :change_role
    has_permission_on [:users, :fish_species, :fishing_methods, :guide_posts, :angler_posts], :to => :read
    has_permission_on :users, :to => [:create, :update] do
      if_attribute :id => is { user.id }
    end
  end

  role :admin do
    includes :guest
    includes :guide
    includes :angler
    includes :property_owner
    has_permission_on :users, :to =>  [:manage, :toggle_enabled]
    has_permission_on [:fish_species, :fishing_methods, :guide_posts, :angler_posts, :env_prefs, :locations, :ratings], :to => :manage
  end

end

privileges do
  privilege :manage, :includes => [:create, :read, :update, :delete]
  privilege :read, :includes => [:index, :show]
  privilege :create, :includes => :new
  privilege :update, :includes => [:edit]
  privilege :delete, :includes => :destroy
end 