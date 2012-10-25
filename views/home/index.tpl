<style>
.uploader {
    border: 8px dashed #ddd;
    _height: 100px;
    text-align: center;
    display: table-cell;
    vertical-align: middle;
}
.uploader:hover {
    border-color: #9f9;
    background-color: #dfd;
}
.uploader h3 {
    padding: 10px;
}

#list div {
    display: none;
}
#list img {
    height: 75px;
    border: 1px solid #ddd;
    padding: 2px;
    margin: 2px;
}
</style>

<script>
$(function() {
    new uploader('drop', null, '<?php echo u("upload") ?>', 'list');
});
</script>

<h1>Home</h1>

<section>
    <h2>1. Upload your images</h2>
    <p>Drag and drop your images into the box below.</p>
    <div class="thumbnails">
        <div id="drop" class="uploader thumbnail span10">
            <h3>Drop here</h3>
            <div id="list">
<?php foreach (xController::load('upload')->urls() as $url): ?>
                <img src="<?php echo $url ?>"/>
<?php endforeach ?>
            </div>
        </div>
    </div>
</section>

<section>
    <h2>2. Generate your cards</h2>
    <p>Simply click the button below.</p>
    <a class="btn btn-large btn-success" href="<?php echo u('home/cards?html') ?>">
        Download
    </a>
</section>
