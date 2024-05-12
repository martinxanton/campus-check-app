import 'package:campus_check_app/models/student_model.dart';
import 'package:flutter/material.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtener el argumento pasado desde la ruta anterior
    final userModel =
        ModalRoute.of(context)?.settings.arguments as StudentModel?;

    String enrollmentText = '';
    Color enrollmentColor = Colors.red;

    if (userModel?.stateEnrollment == 1) {
      enrollmentText = 'Matriculado';
      enrollmentColor = Colors.green; // Color para el estado 1
    } else if (userModel?.stateEnrollment == 2) {
      enrollmentText = 'Suspendido';
      enrollmentColor = Colors.grey; // Color para el estado 2
    } else if (userModel?.stateEnrollment == 3) {
      enrollmentText = 'Egresado';
      enrollmentColor = Colors.orange; // Color para el estado 3
    } else {
      enrollmentText = 'No disponible';
      enrollmentColor = Colors.red; // Color predeterminado para otros estados
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Perfil',
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: Theme.of(context).colorScheme.background,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color.fromARGB(10, 0, 0, 0),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image(
                              image: NetworkImage(userModel?.photoURL ??
                                  'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png'),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 8, right: 8, top: 5, bottom: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: enrollmentColor,
                            ),
                            child: Text(
                              enrollmentText,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userModel?.name ?? 'Nombre',
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 3),
                        const Text(
                          'Estudiante',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      _buildUserInfoTile(const Icon(Icons.qr_code_outlined),
                          'Código de alumno', userModel?.code),
                      const SizedBox(height: 10),
                      _buildUserInfoTile(
                          const Icon(Icons.perm_identity_outlined),
                          'DNI',
                          userModel?.docID),
                      const SizedBox(height: 10),
                      _buildUserInfoTile(const Icon(Icons.school_outlined),
                          'Facultad', userModel?.faculty),
                      const SizedBox(height: 10),
                      _buildUserInfoTile(const Icon(Icons.book_outlined),
                          'Carrera', userModel?.career),
                    ],
                  ),
                  SizedBox(
                    height: 56,
                    width: double.infinity,
                    child: FilledButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFF831216)),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Regristrar entrada',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfoTile(Icon icon, String title, String? subtitle) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black26),
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: icon,
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(180, 0, 0, 0),
          ),
        ),
        subtitle: Text(subtitle ?? 'No disponible'),
      ),
    );
  }
}
