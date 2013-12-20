/*
 * Copyright :	reecam
 * URL :		www.reecam.net
 * dev :		gao jun bin[开发者高俊斌]　
 * dev :		deng you hua [开发者邓友华]
 * doucment :	deng you hua
 * bug email:	415137038@qq.com
 * require :	IOS sdk 4.3
 */


#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>


extern NSString * const camera_search_begin_command;
extern NSString * const camera_search_end_command;
extern NSString * const camera_status_changed_command;
extern NSString * const camera_video_status_changed_command;
extern NSString * const camera_audio_status_changed_command;
extern NSString * const camera_talk_status_changed_command;
extern NSString * const camera_alarm_status_changed_command;
extern NSString * const camera_image_command;
extern NSString * const camera_audio_command;
extern NSString * const camera_param_changed_command;

#define D_CAMERA_COMMAND_RESPONSE_BEGIN_WITHOUT_ARG(camera_command)				[[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(d_camera_respone_funtion:) name: camera_command object: nil]
#define D_CAMERA_COMMAND_RESPONSE_BEGIN_WITH_ARG(camera_command,camera_object)	[[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(d_camera_respone_funtion:) name: camera_command object: camera_object]
#define	D_CAMERA_COMMAND_RESPONSE_END()											[[NSNotificationCenter defaultCenter] removeObserver:self]

typedef enum {
	DISCONNECTED,
	CONNECTING,
	VERIFYING,
	CONNECTED,
} camera_status_t;

typedef enum {
	STOPPED,
	REQUESTING,
	PLAYING,
} camera_playing_status_t;

typedef enum {
	NONE,
	MOTION_DETECTING,
	TRIGGER_DETECTING,
	SOUND_DETECTING,
	UNKNOWN_ALARM,
} camera_alarm_status_t;

typedef enum {
	OK,
	BAD_PARAMS,
	BAD_STATUS,
	INTERNAL_ERROR,
	SOCKET_ERROR,
	CANT_CONNECT,
	PEER_CLOSED,
	UNKNOWN_ERROR,
	BAD_ID,
	MAX_SESSION,
	BAD_AUTH,
	TIMEOUT,
	FORBIDDEN,
	UNSUPPORT,
} camera_error_t;

typedef enum {
	T_UP = 0,
	T_DOWN,
	P_LEFT,
	P_RIGHT,
	PT_LEFT_UP,
	PT_RIGHT_UP,
	PT_LEFT_DOWN,
	PT_RIGHT_DOWN,
	PT_CENTER,
	PT_STOP,
	P_PATROL,
	P_PATROL_STOP,
	T_PATROL,
	T_PATROL_STOP,
	ZOOM_WIDE,
	ZOOM_TELE,
	IO_ON,
	IO_OFF,
	PT_SET_RESET1,
	PT_GO_RESET1,
	PT_SET_RESET2,
	PT_GO_RESET2,
	PT_SET_RESET3,
	PT_GO_RESET3,
	PT_SET_RESET4,
	PT_GO_RESET4,
	PT_SET_RESET5,
	PT_GO_RESET5,
	PT_SET_RESET6,
	PT_GO_RESET6,
	PT_SET_RESET7,
	PT_GO_RESET7,
	PT_SET_RESET8,
	PT_GO_RESET8,
	PT_SET_RESET9,
	PT_GO_RESET9,
	PT_SET_RESET10,
	PT_GO_RESET10,
	PT_SET_RESET11,
	PT_GO_RESET11,
	PT_SET_RESET12,
	PT_GO_RESET12,
	PT_SET_RESET13,
	PT_GO_RESET13,
	PT_SET_RESET14,
	PT_GO_RESET14,
	PT_SET_RESET15,
	PT_GO_RESET15,
	PT_SET_RESET16,
	PT_GO_RESET16,
} camera_ptz_command_t;

#define AUDIO_RECORD_BUFFERS_NUMBER						10
#define AUDIO_PLAY_BUFFERS_NUMBER						10

@interface IPCamera : NSObject <NSCoding> {
	@public
	NSString * identity;
	NSString * name;
	NSString * host;
	NSNumber * port;
	NSString * user;
	NSString * pwd;
	NSNumber * audio_buffer_time;
	
	
	camera_status_t			camera_status;
	camera_playing_status_t video_status;
	camera_playing_status_t audio_status;
	camera_playing_status_t talk_status;
	camera_alarm_status_t	alarm_status;
	camera_error_t			error;

	@private
	CFReadStreamRef		op_r_stream;
	CFWriteStreamRef	op_w_stream;
	CFReadStreamRef		av_r_stream;
	CFWriteStreamRef	av_w_stream;
	
	NSMutableData * op_r_data;
	NSMutableData * op_w_data;
	NSMutableData * av_r_data;
	NSMutableData * av_w_data;
	
	int op_t;
	int op_r_t;
	int op_w_t;
	
	NSTimer * timer;

	int		resolution;
	int		brightness;
	int		contrast;
	int		mode;
	int		flip;
	
	float	volume;
	
	int adpcm_decode_sample;
	int	adpcm_decode_index;
	int	adpcm_encode_sample;
	int	adpcm_encode_index;
	
	
	AudioQueueRef		audio_record_queue;
	AudioQueueBufferRef audio_record_buffers[AUDIO_RECORD_BUFFERS_NUMBER];
	
	AudioQueueRef		audio_play_queue;
	AudioQueueBufferRef audio_play_buffers[AUDIO_PLAY_BUFFERS_NUMBER];
	
	unsigned long		talk_seq;
	unsigned long		talk_tick;
	unsigned long		local_start_tick;
	unsigned long		camera_start_tick;
}


@property (nonatomic, retain)	NSString * identity;
@property (nonatomic, retain)	NSString * name;
@property (nonatomic, retain)	NSString * host;
@property (nonatomic, retain)	NSNumber * port;
@property (nonatomic, retain)	NSString * user;
@property (nonatomic, retain)	NSString * pwd;
@property (nonatomic, retain)	NSNumber * audio_buffer_time;

@property (nonatomic, readonly)	camera_status_t camera_status;
@property (nonatomic, readonly)	camera_playing_status_t video_status;
@property (nonatomic, readonly)	camera_playing_status_t audio_status;
@property (nonatomic, readonly)	camera_playing_status_t talk_status;
@property (nonatomic, readonly)	camera_alarm_status_t alarm_status;
@property (nonatomic, readonly)	camera_error_t error;

@property (nonatomic, readonly)	BOOL started;
@property (nonatomic, readonly)	NSMutableArray * video_queue;
@property (nonatomic, readonly)	NSMutableArray * audio_queue;


+(int) search;

+ (void) camera_audio_runtime_init;
+ (void) camera_audio_runtime_start;
+ (void) camera_audio_runtime_stop;

-(camera_error_t) start;
-(camera_error_t) play_video;
-(camera_error_t) play_audio;
-(camera_error_t) start_talk;

-(camera_error_t) ptz_control: (camera_ptz_command_t) command;

-(void) stop;
-(void) stop_video;
-(void) stop_audio;
-(void) stop_talk;

-(camera_error_t) set_resolution: (int) value;
-(camera_error_t) set_brightness: (int) value;
-(camera_error_t) set_contrast: (int) value;
-(camera_error_t) set_mode: (int) value;
-(camera_error_t) set_flip: (int) value;

-(int) get_resolution;
-(int) get_brightness;
-(int) get_contrast;
-(int) get_mode;
-(int) get_flip;

-(void) set_volume: (float) value;
-(float) get_volume;

-(void) start_audio_record;
-(void) stop_audio_record;

-(void) start_audio_play;
-(void) stop_audio_play;



@end
