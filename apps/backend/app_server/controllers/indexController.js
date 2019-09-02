const indexController = (req, res, next) => {
    res.render('index', {title: 'Daniel\'s Express Backend' });
};

module.exports = indexController;