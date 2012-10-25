<style>
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

<ul class="thumbnails">
    <li class="span6">
        <div class="thumbnail">
            <div class="caption">
                <h2>1. Upload your images</h2>
                <p>Drag and drop your images into the box below.</p>
                <p>Your images sizes must be minimum: 300x300 pixels. They should be all the same size.</p>
                <div class="thumbnails">
                    <div id="drop" class="uploader thumbnail span5">
                        <h3>Drop here</h3>
                        <div id="list">
            <?php foreach (xController::load('upload')->urls() as $url): ?>
                            <img src="<?php echo $url ?>"/>
            <?php endforeach ?>
                        </div>
                    </div>
                </div>
                <br>
                <div class="btn-group">
                <a class="btn dropdown-toggle" data-toggle="dropdown" href="#">
                    Actions
                    <span class="caret"></span>
                </a>
                <ul class="dropdown-menu">
                    <li><a href="<?php echo u('upload/reset') ?>" class="btn-danger">Remove all images</a></li>
                </ul>
                </div>
            </div>
        </div>
    </li>

    <li class="span6">
        <div class="thumbnail">
            <div class="caption">
                <h2>2. Generate your cards</h2>
                <p>Simply fill the form and click the button below.</p>
                <form action="<?php echo u('home/cards') ?>">
                    <input type="hidden" name="html">
                    <table>
                        <tr>
                            <th>
                                <label for="form-field-cards">Number of cards to create:</label>
                            </th>
                            <td>
                                <input type="text" id="form-field-cards" name="cards" value="<?php echo $d['cards'] ?>">
                            </td>
                        </tr>
                        <tr>
                            <th>
                                <label for="form-field-header">Hard header text:</label>
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
