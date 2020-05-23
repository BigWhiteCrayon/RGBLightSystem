const express = require('express');
const bodyParser = require('body-parser');
const ip = require('ip');
const hbs = require('express-handlebars');
const Gpio = require('pigpio').Gpio;

let red = new Gpio(27, {mode:Gpio.OUTPUT});
let green = new Gpio(17, {mode:Gpio.OUTPUT});
let blue = new Gpio(22, {mode:Gpio.OUTPUT});

const app = express();
const port = 80;

app.set('view engine', 'hbs');

app.engine( 'hbs', hbs({
    extname: 'hbs',
}));

app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

app.get('/', (req, res) => res.render('index', {postURL: '/setColor'}));

app.post('/setColor', (req, res) => {
    res.status(400);
    red.pwmWrite(parseInt(req.body.newColor.substring(1,3), 16));
    green.pwmWrite(parseInt(req.body.newColor.substring(3,5), 16));
    blue.pwmWrite(parseInt(req.body.newColor.substring(5), 16));
})

app.listen(port, () => console.log(`listening at ${ip.address() + ':' + port}`));