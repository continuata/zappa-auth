users = require('./controllers/users')
$ = require('jquery');
require('zappajs') ->
  @configure =>
    @use 'cookies', 'cookieParser', session: {secret: 'underpants'},
    @use 'bodyParser', 'methodOverride', @app.router, 'static'

  @configure
    development: => @use errorHandler: {dumpExceptions: on, showStack: on}
    production: => @use 'errorHandler'

  @set 'view engine': 'jade' 

  links =
    index:      {permission: 'all',   class: 'home', title: 'Home'}
    profile:    {permission: 'user',  class: 'users', title: 'User'}    
    admin:      {permission: 'admin', class: 'settings', title: 'Admin'}
  
  @get '/login': -> @render 'login', @pageData 'login'
  @get '/logout': ->
    @session.isAuthenticated = false
    @session.username = ''
    @session.role = ''    
    @response.redirect('/page/index')

  @get '/':-> @response.redirect("/page/index") 
  @get '/page/:page':-> @renderPage() #route the permission based pages
  @post '/user/:action/:value': -> @userFn() #route the user actions

  #helpers to keep the scope of all @ variables
  @helper userFn: ->
    action = @request.params.action
    users[action](@request, @response)

  @helper renderPage: ->
    page = @request.params.page
    perm = links[page].permission
    @checkAuth perm, => @render page, @pageData page

  @helper pageData: (page) ->
    data = 
      username: @session.username
      role: @session.role
      page: page
      links: links
    data

  @helper checkAuth: (role, next) ->
    if role is 'all'
      next()
    else
      roles = ['all','user','admin','super']
      reqrole = $.inArray(role, roles)
      sessrole = $.inArray(@session.role, roles)      
      if @session and @session.isAuthenticated is true
        if(sessrole >= reqrole )
          next()
        else
          @response.redirect("/page/index")  
      else
        @response.redirect("/login")  
