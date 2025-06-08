<?php

class DataModel {
    private $id;
    private $name;
    private $faction;
    private $position;

    public function __construct($id, $name, $faction, $position) {
        $this->id = $id;
        $this->name = $name;
        $this->faction = $faction;
        $this->position = $position;
    }

    public function getId() {
        return $this->id;
    }

    public function getName() {
        return $this->name;
    }

    public function getFaction() {
        return $this->faction;
    }

    public function getPosition() {
        return $this->position;
    }

    public function setName($name) {
        $this->name = $name;
    }

    public function setFaction($faction) {
        $this->faction = $faction;
    }

    public function setPosition($position) {
        $this->position = $position;
    }
}