import { Controller } from "@hotwired/stimulus";
import { post } from "@rails/request.js";

export default class extends Controller {
  static targets = [
    "query",
    "results",
    "name",
    "collection",
    "searchId",
    "fancy",
  ];
  static values = {
    selected: Array,
    field: String,
    source: Number,
    endpoint: String,
    multi: Boolean,
    createTags: Boolean,
  };

  connect() {
    this.resultsList = this.resultsTarget.getElementsByTagName("li");
    this.totalResults = this.resultsList.length;
    this.currentIndex = -1;
    this.tags = new Map();
    this.setHiddenFieldName();
    this.setCollection();
    this.selectedTags();
  }

  update(event) {
    const text = event.target.value;

    this.sendRequest(text);
  }

  filterUpdate(_event) {
    this.sendRequest();
  }

  sendRequest(text) {
    clearTimeout(this.timeout);
    this.timeout = setTimeout(() => {
      this.requestInfo(text);
    }, 400);
  }

  checkInput(_event) {
    this.requestInfo();
  }

  async requestInfo(text) {
    const endpoint = `/main/${this.endpointValue}/search?name=${text}&source=${this.sourceValue}&collection=${this.collection}&search_id=${this.searchIdTarget.value}`;
    const response = await post(endpoint, {
      headers: { Accept: "text/vnd.turbo-stream.html" },
      responseKind: "turbo-stream",
    });
    if (response.ok) {
      const text = await response.text;
      Turbo.renderStreamMessage(text);
      setTimeout(() => {
        this.showResultsIfAny();
      }, 100);
    }
  }

  toggleResults() {
    this.resultsTarget.hidden = !this.resultsTarget.hidden;
    if (!this.resultsTarget.hidden) {
      this.resultsList = this.resultsTarget.getElementsByTagName("li");
      this.totalResults = this.resultsList.length;
      if (this.totalResults == 0) {
        this.requestInfo("");
      }
    }
  }

  upResult() {
    if (this.totalResults < 1) {
      return;
    }

    if (document.activeElement == this.nameTarget) {
      this.focusResults();
    } else {
      if (this.currentIndex > 0) {
        this.currentIndex -= 1;
        this.resultsList[this.currentIndex].focus();
        this.resultsList[this.currentIndex].scrollIntoView({
          behavior: "smooth",
          block: "center",
          inline: "nearest",
        });
      }
    }
  }

  downResult() {
    if (document.activeElement == this.nameTarget) {
      this.focusResults();
    } else {
      if (this.currentIndex < this.totalResults - 1) {
        this.currentIndex += 1;
        this.resultsList[this.currentIndex].focus();
        this.resultsList[this.currentIndex].scrollIntoView({
          behavior: "smooth",
          block: "center",
          inline: "nearest",
        });
      }
    }
  }

  focusResults() {
    this.resultsTarget.hidden = false;
    this.resultsList = this.resultsTarget.getElementsByTagName("li");
    this.totalResults = this.resultsList.length;
    this.currentIndex = 0;
    if (this.totalResults > 0) {
      this.resultsList[this.currentIndex].focus();
      this.resultsList[this.currentIndex].scrollIntoView({
        behavior: "smooth",
        block: "center",
        inline: "nearest",
      });
    }
  }

  showResultsIfAny() {
    this.resultsList = this.resultsTarget.getElementsByTagName("li");
    if (this.resultsList.length > 0) {
      this.resultsTarget.hidden = false;
    }
  }

  selectResult(event) {
    const id = event.target.dataset.id;
    const name = event.target.dataset.name;
    this.addTag(id, name);
    this.resultsTarget.hidden = true;
  }

  clearSelection(_event) {
    this.resultsTarget.hidden = true;
  }

  validateInput(event) {
    if (!this.createTagsValue) return;

    const key = event.target.value;
    if (key && key.at(-1) === ",") {
      const name = key.slice(0, -1);
      this.updateHiddenField(name.toLowerCase(), name);
      this.nameTarget.value = "";
    }
  }

  addTag(id, name) {
    if (!this.multiValue) {
      this.tags.clear();
    }
    const content = name.trim();
    if (content) {
      this.updateHiddenField(id, content);
    }
  }

  updateHiddenField(id, name) {
    this.tags.set(id, name);
    this.createTags(Array.from(this.tags));
  }

  createTags(tags) {
    if (tags.length == 0) {
      this.fancyTarget.innerHTML = "";
      return;
    }
    this.fancyTarget.innerHTML = "";
    tags.forEach((tag) => this.spanTag({ id: tag[0], name: tag[1] }));
    this.nameTarget.value = "";
  }

  removeTag(event) {
    const parent = event.target.parentElement;
    const content = parent.innerText.trim();
    this.removeHiddenField(content);
  }

  removeHiddenField(content) {
    this.tags.forEach((name, key) => {
      if (name == content) {
        this.tags.delete(key);
      }
    });
    this.createTags(Array.from(this.tags));
  }

  spanTag(content) {
    if (!content) return;
    const template = document.getElementById("tag-template");
    const newTemplate = template.content.cloneNode(true);
    const newTag = newTemplate.querySelectorAll("span")[0];
    const name = content.name.replace(/<\/?[^>]+(>|$)/g, "");
    const id = content.id;
    newTag.innerHTML = newTag.innerHTML.replace("{{name}}", name);
    newTag.appendChild(this.hiddenField(id));
    this.fancyTarget.appendChild(newTemplate);
  }

  hiddenField(id) {
    const input = document.createElement("input");
    input.setAttribute("type", "hidden");
    input.setAttribute("name", this.fieldName);
    input.setAttribute("value", id);

    return input;
  }

  setHiddenFieldName() {
    if (this.multiValue) {
      this.fieldName = this.fieldValue + "[]";
    } else {
      this.fieldName = this.fieldValue;
    }
  }

  setCollection() {
    if (this.hasCollectionTarget) {
      this.collection = this.collectionTarget.value;
    } else {
      this.collection = "";
    }
  }

  selectedTags() {
    if (this.selectedValue.length > 0) {
      this.selectedValue.forEach((tag) => {
        console.log(tag);
        if (tag.id) {
          this.tags.set(tag.id, tag.name);
        }
      });
      this.createTags(Array.from(this.tags));
    }
  }
}
