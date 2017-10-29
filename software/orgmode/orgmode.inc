<?php

function orgmode_form_upload($form_state) {

  $form['file'] = array(
    '#type' => 'file',
    '#title' => t('Org File'),
    '#description' => t('Upload an org file, allowed extension: org'),
  );

  $form['submit'] = array(
    '#type' => 'submit',
    '#value' => t('Submit'),
  );

  return $form;

}

/**
 * Validate handler for orgmode_form_validate().
 */
function orgmode_form_upload_validate($form, &$form_state) {

  $file = file_save_upload('file', array('file_validate_extensions' => array('org')));
  // If the file passed validation:
  // var_dump($file);
  if ($file) {
    // Move the file, into the Drupal file system
    if ($file = file_move($file, 'public://')) {
      // Save the file for use in the submit handler.
      $form_state['storage']['file'] = $file;
    }
    else {
      form_set_error('file', t('Failed to write the uploaded file to the site\'s file folder.'));
    }
  }
  else {
    form_set_error('file', t('No file was uploaded.'));
  }
}

/**
 * Submit handler for orgmode_form_validate().
 */
function orgmode_form_upload_submit($form, &$form_state) {
  $file = $form_state['storage']['file'];
  // We are done with the file, remove it from storage.
  unset($form_state['storage']['file']);
  // Make the storage of the file permanent
  $file->status = FILE_STATUS_PERMANENT;
  // Save file status.
  file_save($file);

  $lines = file(DRUPAL_ROOT.'/sites/default/files/'.$file->filename);
  $body = "";
  foreach ($lines as $line_num => $line) {
    $title_reg = "/^#\+TITLE:.*/";
    if (preg_match($title_reg, $line, $matches)) {
      $title = preg_replace("/^#\+TITLE:(.*)$/", "$1\n", $matches[0]);
      drupal_set_message(t($title));
    }

    $author_reg = "/^#\+AUTHOR:.*/";
    if (preg_match($author_reg, $line, $matches)) {
      $author = preg_replace("/^#\+AUTHOR:(.*)$/", "$1\n", $matches[0]);
      drupal_set_message(t($author));
    }

    if (!(preg_match("/^#\+/", $line, $matches))) {
      $h1reg = "/^\* .*$/";
      if (preg_match($h1reg, $line, $matches)) {
	$line = preg_replace("/^\* (.*)$/", "<h1>$1</h1>\n", $matches[0]);
      }

      $h2reg = "/^\*\* .*$/";
      if (preg_match($h2reg, $line, $matches)) {
	$line = preg_replace("/^\*\* (.*)$/", "<h2>$1</h2>\n", $matches[0]);
      }

      $h3reg = "/^\*\*\* .*$/";
      if (preg_match($h3reg, $line, $matches)) {
	$line = preg_replace("/^\*\*\* (.*)$/", "<h3>$1</h3>\n", $matches[0]);
      }

      if (preg_match("/\[.*\]/", $line, $matches)) {
	if (preg_match("/\[\[.*\]\[.*\]\]/", $line, $matches)) {
	  $line = preg_replace("/\[\[(.*)\]\[(.*)\]\]/", "<a href='$1'>$2</a>\n", $matches[0]);
	}
	if (preg_match("/\[\[file:(.)*(jpg|png|gif)\]\]/", $line, $matches)) {
	  $line = preg_replace("/\[\[file:(.*)\]\]/", "<img src='$1' alt='text' />", $matches[0]); 
	}
      }

      if (!(preg_match($h1reg, $line, $match1)) && !(preg_match($h2reg, $line, $match2)) && !(preg_match($h3reg, $line, $match3))) {
	$body .= $line;
      }
    }

  }

  $node = new stdClass();
  // Your script will probably pull this information from a database.
  $node->title = $title;
  $node->author = $author;
  //$node->teaser = "If known, the taxonomy TID values can be added as an array.";
  //$node->body = "Your script will probably pull this information from a database.";
  $node->language = 'und';
  $node->body[$node->language][0]['value'] = $body;
  $node->body[$node->language][0]['summary'] = text_summary($body);
  $node->body[$node->language][0]['format'] = 'full_html';
  $node->type = 'article';   // Your specified content type
  $node->created = time();
  $node->changed = $node->created;
  $node->status = 1;
  $node->promote = 1;
  $node->sticky = 0;
  $node->format = 1;       // Filtered HTML
  $node->uid = 1;          // UID of content owner
  // If known, the taxonomy TID values can be added as an array.
  node_save($node);

  // Set a response to the user.
  drupal_set_message(t('The form has been submitted and @filename has been saved.', array('@filename' => $file->filename)));
  //orgmode_process($file)
}

function orgmode_process($file) {


}

?>