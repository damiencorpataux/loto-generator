<?php foreach (xWebFront::messages() as $message): ?>
<?php $css_class = "alert alert-{$message['type']}" ?>
<div class="<?php echo $css_class ?>">
    <button type="button" class="close" data-dismiss="alert">×</button>
    <strong><?php echo $message['text'] ?></strong>
</div>
<?php endforeach ?>
