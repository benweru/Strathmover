import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_dashboard_template/models/route_model.dart';

class EditRoutePage extends StatefulWidget {
  final RouteModel route;

  const EditRoutePage({super.key, required this.route});

  @override
  EditRoutePageState createState() => EditRoutePageState();
}

class EditRoutePageState extends State<EditRoutePage> {
  late TextEditingController _nameController;
  late List<RoutePoint> _points;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.route.name);
    _points = List<RoutePoint>.from(widget.route.points);
  }

  Future<void> _saveRoute() async {
    final route = widget.route.copyWith(
      name: _nameController.text,
      points: _points,
    );

    if (route.id != null) {
      await FirebaseFirestore.instance
          .collection('Routes')
          .doc(route.id)
          .update(route.toJson());
    } else {
      await FirebaseFirestore.instance.collection('Routes').add(route.toJson());
    }

    if (!mounted) return;
    Navigator.pop(context);
  }

  void _addPoint() {
    setState(() {
      _points.add(RoutePoint(name: 'New Point', location: GeoPoint(0, 0)));
    });
  }

  void _removePoint(int index) {
    setState(() {
      _points.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Route'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveRoute,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Route Name',
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Points',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: _points.length,
                itemBuilder: (context, index) {
                  final point = _points[index];
                  return ListTile(
                    title: Text(point.name),
                    subtitle: Text(
                        'Lat: ${point.location.latitude}, Lng: ${point.location.longitude}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _removePoint(index),
                    ),
                    onTap: () async {
                      final updatedPoint = await Navigator.push<RoutePoint>(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditPointPage(point: point),
                        ),
                      );
                      if (updatedPoint != null) {
                        setState(() {
                          _points[index] = updatedPoint;
                        });
                      }
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _addPoint,
              child: const Text('Add Point'),
            ),
          ],
        ),
      ),
    );
  }
}

class EditPointPage extends StatefulWidget {
  final RoutePoint point;

  const EditPointPage({super.key, required this.point});

  @override
  _EditPointPageState createState() => _EditPointPageState();
}

class _EditPointPageState extends State<EditPointPage> {
  late TextEditingController _nameController;
  late TextEditingController _latController;
  late TextEditingController _lngController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.point.name);
    _latController = TextEditingController(
        text: widget.point.location.latitude.toString());
    _lngController = TextEditingController(
        text: widget.point.location.longitude.toString());
  }

  void _savePoint() {
    final updatedPoint = RoutePoint(
      name: _nameController.text,
      location: GeoPoint(
        double.tryParse(_latController.text) ?? 0,
        double.tryParse(_lngController.text) ?? 0,
      ),
    );
    Navigator.pop(context, updatedPoint);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Point'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _savePoint,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Point Name',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _latController,
              decoration: const InputDecoration(
                labelText: 'Latitude',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _lngController,
              decoration: const InputDecoration(
                labelText: 'Longitude',
              ),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
    );
  }
}