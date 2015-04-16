var users = [
    "aandl",
	"groom",
	"bride",
	"jandp",
	"cands",
	"bestman",
	"ganda",
	"greg",
	"brightonelfers",
	"maidofhonour",
	"hamiltons",
	"ohsheila",
	"durants",
	"pinos",
	"mande",
	"randm",
	"brooks",
	"clarks",
	"clarks1",
	"tandk",
	"glovers",
	"aandm",
	"jandr",
	"aandc",
	"randj",
	"jandd",
	"pandm",
	"tuletts",
	"woodwards",
	"canda",
	"vivs",
	"aanda",
	"jandk",
	"hando",
	"jandc",
	"kandl",
	"sarah",
	"andrew",
	"oandl",
	"dominic",
	"nandn",
	"randt",
	"lily",
	"jandt",
	"sarahc",
	"sophie",
	"mark",
	"fran",
	"candm",
	"fandk",
	"gandg",
	"dandn",
	"elizabeth"
]

function follow(user, callback) {
    var page = require('webpage').create();
    page.open('http://development.aliceluke.divshot.io/' + user, function() {
        window.setTimeout(function(){
            page.render('phantom_' + user + '.png');
            page.close();
            callback.apply();
        }, 2000)
    });
}

function process() {
    if (users.length > 0) {
        var user = users[0];
        users.splice(0, 1);
        follow(user, process);
    } else {
        phantom.exit();
    }
}

process();
