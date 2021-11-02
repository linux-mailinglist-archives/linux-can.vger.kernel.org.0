Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 548264431CE
	for <lists+linux-can@lfdr.de>; Tue,  2 Nov 2021 16:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbhKBPiq (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 2 Nov 2021 11:38:46 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.160]:15398 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbhKBPim (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 2 Nov 2021 11:38:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1635867366;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:Date:Message-ID:From:References:To:Subject:Cc:Date:From:
    Subject:Sender;
    bh=neJBGp/5r9ouc1s+FaG3NPLAPYoUkE1w41C/csDB288=;
    b=lYAIPov3UZXxC9YWW1IqYegshdcDEbZeU4MED7Dnuemdepxpm9GjgCeRmXPAtRXSS0
    iGLvJvtwmRV6d+Ut839ejpE3oekToT5cD/qRZbbgNI6xilEv8wmBeMEHJTQ/4RiPKQTn
    5cxdxByyTf0ZprO2ko1Vlrrgp8SOnG1Q7ZLdD0/vnzP/NT4gMt2UtcZp0I8dRQcaaeXM
    2j6wgb5zybH74ZNbv+vIR3vbw1+NdtK39QXNoMpWTKCqbGnBFhoFM66Tb+gDQGfO35Wn
    McYRPDbbZanl3AMu3YE9kD1tbDHvs5pArgjrlo+bu+j6BVTOyLPgIhAfo60R2G7St1ou
    5Q2g==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdd0DIgVuBOfXW6v7w=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a00:6020:1cfa:f900::b82]
    by smtp.strato.de (RZmta 47.33.8 AUTH)
    with ESMTPSA id 900f80xA2Fa518y
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 2 Nov 2021 16:36:05 +0100 (CET)
Subject: Re: sjw in can_calc_bittiming
To:     =?UTF-8?Q?Matthias_Wei=c3=9fer?= <m.weisser.m@gmail.com>,
        linux-can@vger.kernel.org
References: <CAO8h3eEcK7c6M5T88K0MO6eQk64DY+85Mzsi5zdT9tV9mxiMfw@mail.gmail.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <0a539c49-b92e-892e-5848-613ff745c283@hartkopp.net>
Date:   Tue, 2 Nov 2021 16:36:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAO8h3eEcK7c6M5T88K0MO6eQk64DY+85Mzsi5zdT9tV9mxiMfw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Matthias,

On 02.11.21 16:03, Matthias Weißer wrote:

> we recently had a case here where one member of a CAN bus couldn't receive
> frames with data content of only zeros:
> 
> $ cansend can0 123#0000000000000000
> 
> After some investigation we found the root cause to be a slight difference
> (about 1%) in actual bitrates of the two members. The one with showed the
> RX errors had a sjw value of 1 and a lot of time quanta (40) due to the 40MHz
> CAN clock.
> 
> This leads to a build up of phase error (as sjw is not able to compensate for
> enough of the bitrate difference) which at some point leads to a framing
> error due to missing a stuff bit. Playing around with the sample point can
> improve or worsen the behavior.
> 
> We can fix this quite easily by specifying a higher sjw value.

You can specify the sjw value with the ip command (for CAN FD there is 
also a dsjw). And IIRC you can set it to the max. value for your CAN 
controller if you define sjw to be 4.

Best regards,
Oliver

$ ip link help can
Usage: ip link set DEVICE type can
	[ bitrate BITRATE [ sample-point SAMPLE-POINT] ] |
	[ tq TQ prop-seg PROP_SEG phase-seg1 PHASE-SEG1
  	  phase-seg2 PHASE-SEG2 [ sjw SJW ] ]

	[ dbitrate BITRATE [ dsample-point SAMPLE-POINT] ] |
	[ dtq TQ dprop-seg PROP_SEG dphase-seg1 PHASE-SEG1
  	  dphase-seg2 PHASE-SEG2 [ dsjw SJW ] ]

	[ loopback { on | off } ]
	[ listen-only { on | off } ]
	[ triple-sampling { on | off } ]
	[ one-shot { on | off } ]
	[ berr-reporting { on | off } ]
	[ fd { on | off } ]
	[ fd-non-iso { on | off } ]
	[ presume-ack { on | off } ]

	[ restart-ms TIME-MS ]
	[ restart ]

	[ termination { 0..65535 } ]

	Where: BITRATE	:= { 1..1000000 }
		  SAMPLE-POINT	:= { 0.000..0.999 }
		  TQ		:= { NUMBER }
		  PROP-SEG	:= { 1..8 }
		  PHASE-SEG1	:= { 1..8 }
		  PHASE-SEG2	:= { 1..8 }
		  SJW		:= { 1..4 }
		  RESTART-MS	:= { 0 | NUMBER }

> 
> Question is now:
> Wouldn't it make sense to increase sjw in can_calc_bittiming() to something
> like 5% of the total time quanta? This may increase the reliability of the CAN
> network when there are differences in the bitrates of the single members. Are
> there any arguments against such an arbitrary selection of sjw?
> 
> If you agree with such a change I can come up with a proper patch. If I wrote
> totally nonsense please tell me :-)
> 
> Regards
> 
> Matthias
> 
