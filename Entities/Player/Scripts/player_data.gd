class_name PlayerData
extends Node2D

const PLAYER_LIFE = 4

static var score = 0

static var player_name : String

static var max_life = PLAYER_LIFE

static var coin = 0
static var life = PLAYER_LIFE
static var normal_attack_damage = 10
static var heavy_attack_damage = 10

static var parry : bool = false

static var alive : bool = true

static var normal_attack_zone : Area2D
static var heavy_attack_zone : Area2D
static var playerBody : CharacterBody2D
static var playerHitbox : Area2D

static var has_doublejump : bool = false
static var has_dash : bool = false 
