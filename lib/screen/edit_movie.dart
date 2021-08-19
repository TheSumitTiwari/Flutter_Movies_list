import 'package:flutter/material.dart';
import 'package:movies_list/db/movie_database.dart';
import 'package:movies_list/model/movie.dart';
import 'package:movies_list/widget/movie_form.dart';

class AddEditMoviePage extends StatefulWidget {
  final Movie? movie;

  const AddEditMoviePage({
    Key? key,
    this.movie,
  }) : super(key: key);
  @override
  _AddEditMoviePageState createState() => _AddEditMoviePageState();
}

class _AddEditMoviePageState extends State<AddEditMoviePage> {
  final _formKey = GlobalKey<FormState>();
  late String img;
  late String title;
  late String director;

  @override
  void initState() {
    super.initState();
    img = widget.movie?.img ?? '';
    title = widget.movie?.title ?? '';
    director = widget.movie?.director ?? '';
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: [buildButton()],
        ),
        body: Form(
          key: _formKey,
          child: MovieFormWidget(
            img: img,
            title: title,
            director: director,
            onChangedImg: (img) => setState(() => this.img = img),
            onChangedTitle: (title) => setState(() => this.title = title),
            onChangedDescription: (director) =>
                setState(() => this.director = director),
          ),
        ),
      );

  Widget buildButton() {
    final isFormValid = title.isNotEmpty && director.isNotEmpty;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary: isFormValid ? null : Colors.grey.shade700,
        ),
        onPressed: addOrUpdateMovie,
        child: Text('Save'),
      ),
    );
  }

  void addOrUpdateMovie() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.movie != null;

      if (isUpdating) {
        await updateNote();
      } else {
        await addNote();
      }
      Navigator.of(context).pop();
    }
  }

  Future updateNote() async {
    final note = widget.movie!.copy(
      img: img,
      title: title,
      director: director,
    );
    await MoviesDatabase.instance.update(note);
  }

  Future addNote() async {
    final note = Movie(
      img: img,
      title: title,
      director: director,
      createdTime: DateTime.now(),
    );
    await MoviesDatabase.instance.create(note);
  }
}
