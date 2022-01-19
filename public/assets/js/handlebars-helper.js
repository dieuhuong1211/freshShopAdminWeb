function hbsHelpers(hbs) {
    // hbs.create({
    //     helpers: { 
    //       ifEquals: function(arg1, arg2, options) {
    //            return (arg1 == arg2) ? options.fn(this) : options.inverse(this);
    //       }}});
    

   hbs.registerHelper('ifEquals', function(arg1, arg2, options) {
       return (arg1 == arg2) ? options.fn(this) : options.inverse(this);
   });
}
module.exports = hbsHelpers;