﻿package com.eliz.photobooth {	import flash.display.Sprite;	import flash.media.Video;	import flash.events.SampleDataEvent;	import flash.media.Microphone;	import flash.media.Sound;	import flash.utils.ByteArray;	import com.zeropointnine.SimpleFlvWriter;	import flash.filesystem.*;	import com.adobe.audio.format.WAVWriter;	import flash.utils.*;		public class VideoScreen extends Sprite {		private var videoRecorder:VideoRecorder;		private var audioRecorder:AudioRecorder;				public function VideoScreen(vid:Video) {			videoRecorder = new VideoRecorder(vid);			audioRecorder = new AudioRecorder();		}				public function capture():void {			videoRecorder.recordVideoClip();			audioRecorder.recordAudioClip();		}			}}