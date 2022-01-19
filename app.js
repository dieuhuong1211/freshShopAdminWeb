const createError = require('http-errors');
const express = require('express');
const bodyParser = require("body-parser");
const path = require('path');
const cookieParser = require('cookie-parser');
const logger = require('morgan');
const session = require("express-session");
const hbs = require('hbs');
const exphbs  = require('express-handlebars');
const handlebar = require('handlebars');
const moment = require('moment');
const handlebars = require('./public/assets/js/handlebars-helper')(handlebar);


const indexRouter = require('./components/index');
const loginRouter = require('./components/auth/loginRouter');
const accountsRouter = require('./components/accounts/accountsRouter');
const clientsRouter = require('./components/clients/clientsRouter');
const productsRouter = require('./components/products/productsRouter');
const categoriesRouter = require('./components/categories/categoriesRouter');
const ordersRouter = require('./components/orders/ordersRouter');
const chartsRouter = require('./components/charts/chartsRouter');
const passport = require('./components/auth/passport');
const flash = require('connect-flash');

const app = express();


// view engine  setup
app.set('views', path.join(__dirname, 'views'));

app.engine('.hbs',exphbs.engine({
  defaultLayout:'layout',
  layoutsDir: path.join(__dirname,'views'),
  partialsDir:path.join(__dirname,'views'),
  extname:'.hbs',
  helpers: {
    format: val => {
      return moment(val).format('L');
    },
    formattime: val => {
      return moment(val).format('YYYY-MM-DDTHH:mm');
    },
  }

}));

app.set('view engine', 'hbs');


//Here we are configuring express to use body-parser as middle-ware.
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));
app.use(session({secret:process.env.SESSION_SECRET}));
app.use(passport.initialize());
app.use(passport.session());
app.use(flash());

app.use('/logout', loginRouter);
app.use('/login', loginRouter);

app.use(function(req,res,next){
  res.locals.user = req.user;
  console.log(req.user);
  next();
});


app.use(function(req, res, next){
	if(req.user){
		next();
	}else{
		res.redirect('/login');
	}
})

app.use('/', indexRouter);
app.use('/account', accountsRouter);
app.use('/client', clientsRouter);
app.use('/product', productsRouter);
app.use('/category', categoriesRouter);
app.use('/order', ordersRouter);
app.use('/chart', chartsRouter);

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  next(createError(404));
});

// error handler
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('error');
});

module.exports = app;
