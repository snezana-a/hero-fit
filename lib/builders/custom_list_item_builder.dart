import '../shared/custom_list_item.dart';

class CustomListItemBuilder {
  String text = 'Default Text';
  Function? onPressed;
  String imagePath = '';

  CustomListItem build() {
    return CustomListItem(
      text: text,
      onPressed: onPressed ?? () {},
      imagePath: imagePath,
    );
  }

  CustomListItemBuilder setText(String text) {
    this.text = text;
    return this;
  }

  CustomListItemBuilder setImagePath(String imagePath) {
    this.imagePath = imagePath;
    return this;
  }

  CustomListItemBuilder setOnPressed(Function onPressed) {
    this.onPressed = onPressed;
    return this;
  }
}