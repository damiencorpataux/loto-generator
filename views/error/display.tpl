<h1><?php echo $d['exception']->getMessage() ?></h1>

<p class="title"><?php echo $d['msg'] ?></p>

<p>
  <?php
printf (
    '<a href="%s">%s</a> %s <a href="%s">%s</a>',
    $d['previous_page'],
    _('Go back'),
    _('or'),
    u(),
    _('return to the homepage')
)
  ?>.
</p>

<hr/>

<pre><?php echo $d['exception'] ?></pre>