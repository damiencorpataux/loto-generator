<style>
hr {
    margin: 5px 0;
}
.headline {
    margin: 10px 0;
}
.headline .inner {
    font-family: "OFL Sorts Mill Goudy TT";
    font-style: italic;
    font-size: 20px;
    text-align: center;
    background-color: #fafafa;
    margin: 0 15px;
    padding: 15px 0 3px 0;
}

.steps h2 {
    margin-bottom: 20px;
}

.uploader {
    border: 8px dashed #ddd;
    background-color: #ffd;
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

form table th {
    text-align: right;
}
</style>

<script>
$(function() {
    new uploader('drop', null, '<?php echo u("upload") ?>', 'list');
});
</script>

<h1>Lotery card generator</h1>

<?php echo xView::load('layout/messages') ?>

<?php if ($d['1st-time']): ?>
<?php echo xView::load('home/1st-time') ?>
<?php endif ?>

<div class="headline">
    <hr>
    <div class="inner">
        <p>Create graphical loto cards in a blink.</p>
    </div>
    <hr>
</div>

<ul class="thumbnails steps">
    <li class="span8">
        <div class="thumbnail">
            <div class="caption">
                <h2>1. Upload your images</h2>
                <p>Drag and drop your images into the box below.</p>
                <p>Your images sizes must be minimum: 300x300 pixels. They should be all the same size.</p>
                <div class="btn-group pull-right" style="margin: -8px 0 5px 0">
                    <a class="btn btn-mini dropdown-toggle" data-toggle="dropdown" href="#">
                        Actions
                        <span class="caret"></span>
                    </a>
                    <ul class="dropdown-menu">
                        <li><a href="<?php echo u('upload/reset') ?>" class="btn-danger">Remove all images</a></li>
                    </ul>
                </div>
                <div class="thumbnails">
                    <div id="drop" class="uploader thumbnail span7">
                        <h3>Drop here</h3>
                        <div id="list">
            <?php foreach (xController::load('upload')->urls() as $url): ?>
                            <img src="<?php echo $url ?>"/>
            <?php endforeach ?>
                        </div>
                    </div>
                </div>
            </div>
            <br>
        </div>
    </li>

    <li class="span4">
        <div class="thumbnail">
            <div class="caption">
                <h2>2. Generate your cards</h2>
                <p>Fill the form &amp; click the <b style="color:#51A351">green</b> button.</p>
                <br><br>
                <form action="<?php echo u('home/cards') ?>">
                    <input type="hidden" name="html">
                    <table>
                        <tr>
                            <th>
                                <label for="form-field-cards">Number of cards:</label>
                            </th>
                            <td>
                                <input type="text" id="form-field-cards" name="cards" value="<?php echo $d['cards'] ?>">
                            </td>
                        </tr>
                        <tr>
                            <th>
                                <label for="form-field-header">Card header text:</label>
                            </th>
                            <td>
                                <input type="text" id="form-field-header" name="header" value="<?php echo $d['header'] ?>">
                            </td>
                        </tr>
                        <tr>
                            <th colspan="2">
                                <input type="submit" class="btn btn-large btn-success" value="Create cards !>">
                            </th>
                        </tr>
                    </table>
                </form>
        </div>
    </li>
</ul>
