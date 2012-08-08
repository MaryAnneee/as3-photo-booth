﻿package com.eliz.photobooth.screenrecording {		import de.benz.exec.screenrecording.AudioRecorder;	import de.benz.exec.screenrecording.ScreenRecorder;	import de.benz.exec.screenrecording.VideoSoundMerger;		//import mx.collections.ArrayCollection;		import flash.events.Event;	import flash.filesystem.File;	import flash.utils.setInterval;	import flash.utils.clearInterval;	import flash.media.Microphone;		public class Screenrecording_VideoSound {				private var screenRecorder:ScreenRecorder;		private var microphoneRecorder:AudioRecorder;		private var videoSoundMerger:VideoSoundMerger;				private var vlcFile:File;		private var ffmpegFile:File;				private var tempAudioFile:File;		private var tempVideoFile:File;		private var finalRecordingFile:File;				private var intervalId:Number;				public function Screenrecording_VideoSound() {			init();			startRecording();		}				private function init():void {			vlcFile = new File("/Applications/VLC.app/Contents/MacOS/VLC");			ffmpegFile = File.desktopDirectory.resolvePath("trash"+File.separator+"bin"+File.separator+"ffmpeg");			tempAudioFile = File.desktopDirectory.resolvePath("temp.raw");			tempVideoFile = File.desktopDirectory.resolvePath("temp.mp4");			finalRecordingFile = File.desktopDirectory.resolvePath("finalScreen.mp4")		}				private function startRecording():void {			trace("start recording");			screenRecorder = new ScreenRecorder(vlcFile);			screenRecorder.addEventListener(Event.COMPLETE,onComplete);			screenRecorder.startRecording(tempVideoFile);						var mic:Microphone = Microphone.getMicrophone();			microphoneRecorder = new AudioRecorder();			microphoneRecorder.startRecording(mic.index,tempAudioFile);						intervalId = setInterval(stopRecording, 10000);		}				private function stopRecording():void {			trace("stop recording");			clearInterval(intervalId);						screenRecorder.stopRecording();			microphoneRecorder.stopRecording();		}				private function onComplete(evt:Event):void {			try {				videoSoundMerger = new VideoSoundMerger(ffmpegFile);				videoSoundMerger.addEventListener(Event.COMPLETE,onRecordingDone);				videoSoundMerger.run(tempAudioFile,tempVideoFile,finalRecordingFile);			} catch (e:Error) {			}		}				private function onRecordingDone(evt:Event):void {			//vPlayer.source = finalRecordingFile.url;		}	}}