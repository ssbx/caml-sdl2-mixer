
open CamlSDL2

(** Ocaml binding to libsdl2 mixer.  See
    {:https://www.libsdl.org/projects/old/SDL_mixer/docs/SDL_mixer_frame.html}
    for the documentation *)

(** {1:gen General} *)

module InitFlags : sig
  type t =
    [ `MIX_INIT_FLAC
    | `MIX_INIT_MOD
    | `MIX_INIT_MP3
    | `MIX_INIT_OGG
    ]

  val test : unit -> unit
end

(** {2:gen_act Activation} *)

module Default : sig
  val frequency : int
  val audio_format : Sdl.AudioFormat.t
  val chunk_size : int
end

external init : InitFlags.t list -> unit = "caml_Mix_Init"
external quit : unit -> unit = "caml_Mix_Quit"

external open_audio
  :  frequency:int
  -> audio_format:Sdl.AudioFormat.t
  -> channels:int
  -> chunk_size:int
  -> unit
  = "caml_Mix_OpenAudio"

external close_audio : unit -> unit = "caml_Mix_CloseAudio"
external get_error : unit -> string = "caml_Mix_GetError"

(** {1:samples Samples} *)

module Chunk : sig
  type t
end

(** {2:samples_loading Loading} *)

external load_wav : string -> Chunk.t = "caml_Mix_LoadWAV"

(** {2:samples_freeing Freeing} *)

external free_chunk : Chunk.t -> unit = "caml_Mix_FreeChunk"

(** {1:ch Channels} *)

(** {2:ch_playing Playing} *)

external play_channel
  :  channel:int
  -> chunk:Chunk.t
  -> loops:int
  -> unit
  = "caml_Mix_PlayChannel"

(** {1:mus Music} *)

module Music : sig
  type t
end

(** {2:mus_load Loading} *)

external load_mus : string -> Music.t = "caml_Mix_LoadMUS"

(** {2:mus_free Free} *)

external free_music : Music.t -> unit = "caml_Mix_FreeMusic"

(** {2:mus_play Playing} *)

external play_music : Music.t -> loop:int -> unit = "caml_Mix_PlayMusic"

(** {2:mus_stop Stopping} *)

external fade_out_music : ms:int -> unit = "caml_Mix_FadeOutMusic"