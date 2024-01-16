#!/bin/bash
echo Prüfe vorhandensein der Dateien
./checkfiles.sh
echo Generiere Spring Boot stub.
sleep 3
./generator.sh

