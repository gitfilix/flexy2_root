// intiState due to asynchron ajax Loading, we must synchronize initiating the app.
// initState is 0
var initState = 0;
// initial active page index: first page is Home from pagesModel
var actPageIdx = 0;
// initial active gallery index
var actAlbumIdx = 0;
// albums are empty
var albums = {};
// teasers are empty
var teasers ={};
// pages are empty
var pages = {};
// is it a touch-device?
var touchdev = false
// is it a apple device?
var iosdev = false;
// Browser Features we require
var featurerequired = ['canvas', 'rgba', 'borderradius', 'cssanimations',  'opacity', 'csstransforms3d' ];
// Browser Feature we get from browserdetection
var featurestest = [];
// test variable for essentials
var essentialfeatures = false;
