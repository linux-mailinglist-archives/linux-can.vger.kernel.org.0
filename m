Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7372DC46B
	for <lists+linux-can@lfdr.de>; Wed, 16 Dec 2020 17:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgLPQjX (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 16 Dec 2020 11:39:23 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.21]:15454 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbgLPQjX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 16 Dec 2020 11:39:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1608136527;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:To:Subject:From:Subject:
        Sender;
        bh=P58Q1B6Y3i9m72D8duhwdNXBTuNFIG/Vp3XP3bU7cds=;
        b=hQvAYsiep6P1mESQX7upwUo3k0VuYzpwj1QQ9hJAWWxzCOLhRvA31glhSNsxxDrGRR
        6q0w/vzGlB9Ts7OfQuGrWTkSk6GR9WhrlqbbyqhqY3sYWUDJqDN5EFtTMD+qKQo5pbDA
        UKYA3sc0QDxXC+ETB+HtqNZqite2DtL4APZ10uF/MyzlPtU+4S5MnHQ5mW+Zu2VefwYN
        GIIzV+9zzAsk6H9YQp+D1xDVAb7UaiGialg/R8DtcoaIr4QaX1sJ+eAXUwywuyZF+804
        t02sZyqN12mFYkah60GyEdlBUqVU8Nw5qRgmwx5Cph6iMmjxJs80ubGLva8MFEMq8gm5
        2pvg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3HMbEWKNNeTQbwO"
X-RZG-CLASS-ID: mo00
Received: from [192.168.50.177]
        by smtp.strato.de (RZmta 47.8.6 DYNA|AUTH)
        with ESMTPSA id h04d32wBGGZO0vA
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Wed, 16 Dec 2020 17:35:24 +0100 (CET)
Subject: Re: get entire CAN_RAW_FILTER value without knowing its size
To:     Phillip Schichtel <phillip@schich.tel>, linux-can@vger.kernel.org
References: <ac75d44f61007ece402aca50f49ee57138000d27.camel@schich.tel>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <d717b4d0-4678-c528-9581-dcc8f97b189e@hartkopp.net>
Date:   Wed, 16 Dec 2020 17:35:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <ac75d44f61007ece402aca50f49ee57138000d27.camel@schich.tel>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Philip,

On 16.12.20 05:33, Phillip Schichtel wrote:
> Hi everyone!
> 
> This is my first post to this mailing list (or any kernel mailing
> list), so please tell me if this is the wrong place for this kind of
> topic.

Welcome :-)

You are perfectly right here.

> I'm developing a Java binding library to SocketCAN using JNI [1], where
> I try to provide a reasonably "Java-like" yet efficient and safe API.

Great idea!

> Part of this are setters and getters for the SOL_CAN_* socket options,
> which is straight forward for all options except CAN_RAW_FILTER, since
> it is the only option with a dynamically sized value (struct
> can_filter*). Setting the value is simple, since all the information is
> available in user space, but when using getsockopt I'm expected to
> provide a buffer and a size, but I don't know how many filters there
> are without keeping that state in the library or application, risking
> it going out of sync with the kernel. Is this correct thus far or am I
> missing something? Relevant source on the kernel side is at [2].
> 
> On the user space side using getsockopt() I see three ways around this
> issue:
> 
> 1. Track the amount of filters in user space. I feel like this might be
> problematic if e.g. sockets get shared between threads and processes.
> Other bindings usually take this approach as far as I could tell, if
> they support getting filters at all.

IMO the filters are intended as write-only as it is very common to set 
the filters once at process start and live with them until the process 
terminates.

The getsockopt for CAN_RAW_FILTER was only for completion sake - but in 
fact I did not really think about the expected buffer length in 
userspace when reading back a 'bigger' filter list :-/

> 2. Allocate a buffer large enough that the filters will most likely all
> fit, the optlen will be corrected to the actual size. This is the
> approach I currently take (see [3]), but it feels very wrong.
> 
> 3. Search for the right size by trying increasingly larger buffers
> until the buffer is big enough to fit all. This would be kind of an
> improvement to 2. for the common case.
> 
> Neither of these feel good to me, but maybe that is just me?

No. As we provide the getsockopt() for CAN_RAW_FILTER this way of 
'testing out' the filter size is no fun for the programmer.

And using SocketCAN should be fun :-)

> On the
> kernel side ([2]), I could imagine the option taking a void** for
> optval and the kernel allocating a new buffer for the caller and
> writing its address to the given pointer and the real length to optlen,
> kind of like this (without knowing the appropriate functions):
> 
> 
> case CAN_RAW_FILTER:
> 	lock_sock(sk);
> 	void* filters = NULL;
> 	if (ro->count > 0) {
> 		int fsize = ro->count * sizeof(struct can_filter);
> 		filters = allocate_to_user(fsize);
>                  if (!optval)
> 			err = -EFAULT;
> 		if (copy_to_user(optval, ro->filter, fsize))
> 			err = -EFAULT;
> 	} else {
> 		len = 0;
> 	}
> 	release_sock(sk);
> 
> 
> 	if (!err)
> 		err = put_user(len, optlen);
> 	if (!err)
> 		err = put_user(filters, optval);
> 	return err;
> 
> The setsockopt implementation of the option could also be adapted to
> take the same void**.
> 
> Alternatively the implementation could always write back the full size
> to optlen instead of the "written size" (put_user(fsize, optlen)
> instead of put_user(len, optlen) in code). Since the caller knows how
> big its buffer is, the size necessary would be the more valuable
> information.
> 
> Did I completely misunderstand something or is this really a limitation
> of the current implementation of this option? And if the latter is
> true, are we in the position to change anything about this without
> breaking user space?

Yes, you hit the point. We have a limitation in the current 
implementation; and no, we must not break user space.

> I also haven't really looked into how other protocols handle
> dynamically sized option values or if that is even a thing else where.

Yes. I also had to google and read some kernel code.

When we take a look into the can/raw.c code
https://elixir.bootlin.com/linux/v5.10.1/source/net/can/raw.c#L663

         case CAN_RAW_FILTER:
                 lock_sock(sk);
                 if (ro->count > 0) {
                         int fsize = ro->count * sizeof(struct can_filter);

                         if (len > fsize)
                                 len = fsize;

                         if (copy_to_user(optval, ro->filter, len))


At this point we silently truncate the filters to the given length of 
the userspace buffer. That's safe but not really good ...

                                 err = -EFAULT;
                 } else {
                         len = 0;
                 }
                 release_sock(sk);

                 if (!err)
                         err = put_user(len, optlen);
                 return err;

The only interesting code that handles this kind of variable data vector 
read was in net/core/sock.c in sock_getsockopt() for SO_PEERGROUPS:

https://elixir.bootlin.com/linux/v5.10.1/source/net/core/sock.c#L1429

It was introduced in commit 28b5ba2aa0f55:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=28b5ba2aa0f55

"That is, if the provided buffer is too small, ERANGE is returned and 
@optlen is updated. Otherwise, the  information is copied, @optlen is 
set to the actual size, and 0 is returned."

This sounds like an interesting approach.

What do you think about integrating this kind of -ERANGE functionality 
into can/raw.c ?

In fact I never saw someone to use the getsockopt() for CAN_RAW_FILTER 
until now. That's probably the reason why you hit this issue just now.

IMO introducing the -ERANGE error number does not make the current 
situation worse and when a programmer properly checks the return value 
this -ERANGE would lead to some error handling as -EFAULT does today. So 
I would not see that we are breaking user space here, right?

Regards,
Oliver
