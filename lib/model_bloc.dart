import 'dart:async';

import 'package:ChaMaxAdr/model_event.dart';
import 'package:ChaMaxAdr/strings.dart' as strings;

class ModelBloc {
  String _prefab = strings.statuePrefab;

  final _modelStateController = StreamController<String>();
  StreamSink<String> get _inModel => _modelStateController.sink;
  Stream<String> get selectedModel => _modelStateController.stream;

  final _modelEventController = StreamController<ModelEvent>();
  StreamSink<ModelEvent> get modelSink => _modelEventController.sink;

  ModelBloc() {
    void _mapEventToState(ModelEvent event) {
      if (event is StatueModelSelectEvent) {
        _prefab = strings.statuePrefab;
      } else if (event is CubeModelSelectEvent) {
        _prefab = strings.cubePrefab;
      } else if (event is BrainModelSelectEvent){
        _prefab = strings.brainPrefab;
      }

      _inModel.add(_prefab);
    }

    _modelEventController.stream.listen(_mapEventToState);
  }

  void dispose() {
    _modelStateController.close();
    _modelEventController.close();
  }
}
