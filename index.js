const express = require('express');
const bodyParser = require('body-parser');
const ip = require('ip');
const hbs = require('express-handlebars');
const { Board, Led } = require("johnny-five");
const board = new Board();



BeforeUnloadEvent.on('ready', () => {
    const led = new new led.RGB({
        pins: {
            red: 27,
            green: 17, 
            blue: 3
        }
    });

    led.color('#FF0000');
    led.blink(1000);
})
const app = express();
const port = 80;

app.set('view engine', 'hbs');

app.engine( 'hbs', hbs({
    extname: 'hbs',
}));

app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

app.get('/', (req, res) => res.render('index', {postURL: '/setColor', button:[
    {
        colorName: 'Red',
        colorData: {
            red: 255,
            green: 0,
            blue: 0
        }
    },
    {
        colorName: 'Green',
        colorData: {
            red: 0,
            green: 255,
            blue: 0
        }
    },
    {
        colorName: 'Blue',
        colorData: {
            red: 0,
            green: 0,
            blue: 255
        }
    }
]}));

app.post('/setColor', (req, res) => {
    res.status(400);
})

app.listen(port, () => console.log(`listening at ${ip.address() + ':' + port}`));