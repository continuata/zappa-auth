model = require '../models/mysql'

@auth = (req, res) -> 
  url = req.params.value
  model.user.find 'first',req.body, (err, doc) -> 
    if(!err)
      console.log doc
      if(doc and doc.username)
        req.session.isAuthenticated = true
        req.session.username = doc.username         
        req.session.email = doc.email
        req.session.role = doc.role
        console.log("Authenticated #{doc.email}")
        res.redirect("/page/#{url}")
      else
        req.session.isAuthenticated = false 
        req.session.username = ''       
        req.session.email = ''
        req.session.role = ''      
        console.log("login failed")        
        res.redirect('/login')
    else
      req.session.isAuthenticated = false 
      req.session.username = ''        
      req.session.email = ''
      req.session.role = ''          
      console.log("login failed")        
      res.redirect('/login')    
