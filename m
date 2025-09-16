Return-Path: <linux-can+bounces-4716-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 043ABB5A098
	for <lists+linux-can@lfdr.de>; Tue, 16 Sep 2025 20:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86DFD1C04AAC
	for <lists+linux-can@lfdr.de>; Tue, 16 Sep 2025 18:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9282C11F0;
	Tue, 16 Sep 2025 18:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Oiv5S6dK"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-70.smtpout.orange.fr [80.12.242.70])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF94D14E2E2;
	Tue, 16 Sep 2025 18:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758047808; cv=none; b=ULh0skkc/UIfg8JWKXr/jTyA3gPPpz3KnDDhPhtupm+KzCnz98UBzZiqgypZeO/KYMvHyYdUrbwZFZ+6YRCBoYSOORw3NfnJbvB7NwK0vhYfkTkJKF/dfem6neEjk0+Ff0lnXrVAUKq5weEcblbWHODidtuTS9wF4bhbW0OlPRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758047808; c=relaxed/simple;
	bh=T1kePwdeNQXNVSEeE9ckLT57VuktYjKYkdyxWbs1t04=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VB1vYAyCHEETLeBQoA7ExrH7538gtzkXf4Adeu1CHMJurNK31TbLEw+HyINf+nVmUjn2XTYt2VblvvWGZwhyOXs4KhD7KG8QNGGlZ1AvX7xe/W74rSJljkftrxPKbemb5aqDyqyobSDkFKnxlPbEQCZIc3Lwh56hcp7Swyc8gx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Oiv5S6dK; arc=none smtp.client-ip=80.12.242.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
 ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id yaWWu64lLqEwUyaWXuWKCx; Tue, 16 Sep 2025 20:35:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1758047730;
	bh=zv/XOsxsCMorm9VtcC5Pc/3O++i5spJT7NpfLDn0xng=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=Oiv5S6dKfmgpQV8zzdeifbLa1pbHT2OihN6tvDgB5BYtpe74lstadanLVy3YUyuA5
	 s4FGbeP9bXtBde9WNSD/uCpzAFNl2b5xTY4McdZMKL9fjBM7xveO4E9LkxuMo5B/fj
	 Ud2XavwPgQGgYZfI7SOAKWNFA8WzvKGOC0Oz+hKa/NwefkDECvuohmTZ+NbKy+IUhA
	 a8R6ouNYtA4G8vAE0WTRnDEpairy/Gfh38/stHkn4iQgnSMsjLc1ocOlWqraTE9gfx
	 Sq655ek9al7L+YStFOyvxT144kIa4nE/3kiSaBLga9N7rz+i7sU9dVD1OgUTVCpJv0
	 uWjEN0Kh0pcug==
X-ME-Helo: [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Tue, 16 Sep 2025 20:35:30 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
Message-ID: <ed2a1b51-782b-4ee1-be75-06a0a742525c@wanadoo.fr>
Date: Tue, 16 Sep 2025 20:35:27 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] can: raw: use bitfields to store flags in struct
 raw_sock
To: Vincent Mailhol <mailhol@kernel.org>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250915-can-raw-repack-v1-0-5ea293bc6d33@kernel.org>
 <20250915-can-raw-repack-v1-2-5ea293bc6d33@kernel.org>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Content-Language: en-US, fr-FR
In-Reply-To: <20250915-can-raw-repack-v1-2-5ea293bc6d33@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 15/09/2025 à 11:23, Vincent Mailhol a écrit :
> The loopback, recv_own_msgs, fd_frames and xl_frames fields of struct
> raw_sock just need to store one bit of information.
> 
> Declare all those members as a bitfields of type unsigned int and
> width one bit.
> 
> Add a temporary variable to raw_setsockopt() and raw_getsockopt() to
> make the conversion between the stored bits and the socket interface.
> 
> This reduces struct raw_sock by eight bytes.
> 
> Statistics before:
> 
>    $ pahole --class_name=raw_sock net/can/raw.o
>    struct raw_sock {
>    	struct sock                sk __attribute__((__aligned__(8))); /*     0   776 */
> 
>    	/* XXX last struct has 1 bit hole */
> 
>    	/* --- cacheline 12 boundary (768 bytes) was 8 bytes ago --- */
>    	int                        bound;                /*   776     4 */
>    	int                        ifindex;              /*   780     4 */
>    	struct net_device *        dev;                  /*   784     8 */
>    	netdevice_tracker          dev_tracker;          /*   792     0 */
>    	struct list_head           notifier;             /*   792    16 */
>    	int                        loopback;             /*   808     4 */
>    	int                        recv_own_msgs;        /*   812     4 */
>    	int                        fd_frames;            /*   816     4 */
>    	int                        xl_frames;            /*   820     4 */
>    	struct can_raw_vcid_options raw_vcid_opts;       /*   824     4 */
>    	canid_t                    tx_vcid_shifted;      /*   828     4 */
>    	/* --- cacheline 13 boundary (832 bytes) --- */
>    	canid_t                    rx_vcid_shifted;      /*   832     4 */
>    	canid_t                    rx_vcid_mask_shifted; /*   836     4 */
>    	int                        join_filters;         /*   840     4 */
>    	int                        count;                /*   844     4 */
>    	struct can_filter          dfilter;              /*   848     8 */
>    	struct can_filter *        filter;               /*   856     8 */
>    	can_err_mask_t             err_mask;             /*   864     4 */
> 
>    	/* XXX 4 bytes hole, try to pack */
> 
>    	struct uniqframe *         uniq;                 /*   872     8 */
> 
>    	/* size: 880, cachelines: 14, members: 20 */
>    	/* sum members: 876, holes: 1, sum holes: 4 */
>    	/* member types with bit holes: 1, total: 1 */
>    	/* forced alignments: 1 */
>    	/* last cacheline: 48 bytes */
>    } __attribute__((__aligned__(8)));
> 
> ...and after:
> 
>    $ pahole --class_name=raw_sock net/can/raw.o
>    struct raw_sock {
>    	struct sock                sk __attribute__((__aligned__(8))); /*     0   776 */
> 
>    	/* XXX last struct has 1 bit hole */
> 
>    	/* --- cacheline 12 boundary (768 bytes) was 8 bytes ago --- */
>    	int                        bound;                /*   776     4 */
>    	int                        ifindex;              /*   780     4 */
>    	struct net_device *        dev;                  /*   784     8 */
>    	netdevice_tracker          dev_tracker;          /*   792     0 */
>    	struct list_head           notifier;             /*   792    16 */
>    	unsigned int               loopback:1;           /*   808: 0  4 */
>    	unsigned int               recv_own_msgs:1;      /*   808: 1  4 */
>    	unsigned int               fd_frames:1;          /*   808: 2  4 */
>    	unsigned int               xl_frames:1;          /*   808: 3  4 */
> 
>    	/* XXX 4 bits hole, try to pack */
>    	/* Bitfield combined with next fields */
> 
>    	struct can_raw_vcid_options raw_vcid_opts;       /*   809     4 */
> 
>    	/* XXX 3 bytes hole, try to pack */
> 
>    	canid_t                    tx_vcid_shifted;      /*   816     4 */
>    	canid_t                    rx_vcid_shifted;      /*   820     4 */
>    	canid_t                    rx_vcid_mask_shifted; /*   824     4 */
>    	int                        join_filters;         /*   828     4 */
>    	/* --- cacheline 13 boundary (832 bytes) --- */
>    	int                        count;                /*   832     4 */
>    	struct can_filter          dfilter;              /*   836     8 */
> 
>    	/* XXX 4 bytes hole, try to pack */
> 
>    	struct can_filter *        filter;               /*   848     8 */
>    	can_err_mask_t             err_mask;             /*   856     4 */
> 
>    	/* XXX 4 bytes hole, try to pack */
> 
>    	struct uniqframe *         uniq;                 /*   864     8 */
> 
>    	/* size: 872, cachelines: 14, members: 20 */
>    	/* sum members: 860, holes: 3, sum holes: 11 */
>    	/* sum bitfield members: 4 bits, bit holes: 1, sum bit holes: 4 bits */
>    	/* member types with bit holes: 1, total: 1 */
>    	/* forced alignments: 1 */
>    	/* last cacheline: 40 bytes */
>    } __attribute__((__aligned__(8)));
> 
> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
> ---
>   net/can/raw.c | 47 ++++++++++++++++++++++++++++-------------------
>   1 file changed, 28 insertions(+), 19 deletions(-)
> 
> diff --git a/net/can/raw.c b/net/can/raw.c
> index db21d8a8c54d1b6a25a72c7a9d11d5c94f3187b5..cec580ecd58e36931d1be05716e6beb9c93aa271 100644
> --- a/net/can/raw.c
> +++ b/net/can/raw.c
> @@ -87,10 +87,10 @@ struct raw_sock {
>   	struct net_device *dev;
>   	netdevice_tracker dev_tracker;
>   	struct list_head notifier;
> -	int loopback;
> -	int recv_own_msgs;
> -	int fd_frames;
> -	int xl_frames;
> +	unsigned int loopback:1;
> +	unsigned int recv_own_msgs:1;
> +	unsigned int fd_frames:1;
> +	unsigned int xl_frames:1;
>   	struct can_raw_vcid_options raw_vcid_opts;
>   	canid_t tx_vcid_shifted;
>   	canid_t rx_vcid_shifted;

[...]

Hi,

just in case, it looks like bound and join_filters could also be defined 
in the bitfield.

just my 2c.

CJ

