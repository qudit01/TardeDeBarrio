import {
  Controller
} from "@hotwired/stimulus";
import {
  DirectUpload
} from "@rails/activestorage";

export default class extends Controller {
  static values = {
    url: String
  };

  static targets = ["input"];

  dropUpload(event) {
    event.preventDefault();
    this.uploadFiles(event.dataTransfer.files);
  }

  pasteUpload(event) {
    if (!event.clipboardData.files.length) return;

    event.preventDefault();
    this.uploadFiles(event.clipboardData.files);
  }

  uploadFiles(files) {
    Array.from(files).forEach(file => this.uploadFile(file));
  }

  uploadFile(file) {
    const upload = new DirectUpload(file, this.urlValue);

    upload.create((error, blob) => {
      if (error) {
        console.log("Error");
      } else {
        const text = this.markdownLink(blob);
        const start = this.element.selectionStart;
        const end = this.element.selectionEnd;
        this.element.setRangeText(text, start, end);
      }
    });
  }

  markdownLink(blob) {
    const filename = blob.filename;
    const url = `/rails/active_storage/blobs/${blob.signed_id}/${filename}`;
    const prefix = (this.isImage(blob.content_type) ? '!' : '');

    return `${prefix}[${filename}](${url})\n`;
  }

  isImage(contentType) {
    return ["image/jpeg", "image/gif", "image/png"].includes(contentType);
  }
}