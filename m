Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1EF72DD54C
	for <lists+linux-can@lfdr.de>; Thu, 17 Dec 2020 17:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbgLQQeX (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 17 Dec 2020 11:34:23 -0500
Received: from smtp.cubyte.cloud ([62.113.199.100]:44056 "EHLO
        smtp.cubyte.cloud" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbgLQQeX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 17 Dec 2020 11:34:23 -0500
Received: from [192.168.1.10] (i59f4b54f.versanet.de [89.244.181.79])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp.cubyte.cloud (Postfix) with ESMTPSA id 0B28E44522;
        Thu, 17 Dec 2020 16:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=schich.tel; s=mail;
        t=1608222814;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=it1ivbQvqrEc1hijtJsu3Tsb7ppTupPLat99cVcBx9M=;
        b=twNGvOVWr/70Puxulm51uncEUpZMJv9T34S/kDbabxZjxzvM3nfZW7+kNEKZCsueMCj3Vv
        aNDv/sdx+vXQi3lJgzdTnLLfWn2TLtNqiAILUuvdtmzUqtH+VeHfFpE2ThucFpNztHaSnT
        ynwt2wGfohd1aTVqDHhdPGqCQWA0B8MZmHgOe4nDxN5ejbp0E7p1fxUKa+outAZISQ9R+o
        U3Cdxx312rlDmbcbSru4ckwfs0v5IYjWInduWEGeZoa3aMhQoP6LBgSTXfLMtGnT1PraMK
        rnB8Zbct7X8qlrf2yg2PIywaL9xLvD1znN4hJqpVvjbMcK7abphhhvZAqozwlg==
Message-ID: <3b2b260621a09d9abe14f92b32d54b38faf0b7c7.camel@schich.tel>
Subject: Re: get entire CAN_RAW_FILTER value without knowing its size
From:   Phillip Schichtel <phillip@schich.tel>
To:     Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Date:   Thu, 17 Dec 2020 17:33:33 +0100
In-Reply-To: <6fde14ea-12e0-aea7-a61c-b59303513637@hartkopp.net>
References: <ac75d44f61007ece402aca50f49ee57138000d27.camel@schich.tel>
         <d717b4d0-4678-c528-9581-dcc8f97b189e@hartkopp.net>
         <151eee51da7f618e2691ff1af32debc730168feb.camel@schich.tel>
         <9feebe63-2dbd-bce3-c1aa-bec3b4d03a03@hartkopp.net>
         <6fde14ea-12e0-aea7-a61c-b59303513637@hartkopp.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Oliver,

I also adjusted my java binding to handle the ERANGE error and
everything works as expected with your patch applied. I'm using a
buffer of 10 * sizeof(struct can_filter) now and realloc in case of
ERANGE using the optlen. So with an unpatched kernel the API is
currently restricted to the first 10 filters, but that's probably fine.

~ Phillip

On Thu, 2020-12-17 at 13:19 +0100, Oliver Hartkopp wrote:
> Hello Phillip,
> 
> On 16.12.20 19:31, Oliver Hartkopp wrote:
> > On 16.12.20 18:55, Phillip Schichtel wrote:
> > 
> > > I also assumed that this might not be the most used of the
> > > SocketCAN
> > > APIs. I actually did use it a few times for some verification
> > > purposes.
> > > 
> > > I very much agree with the -ERANGE approach, so you can initially
> > > try
> > > with a sensible default size and try again in case the buffer was
> > > not
> > > sufficient, while not really breaking existing code.
> > 
> > I posted a RFC patch for testing.
> > 
> > https://lore.kernel.org/linux-can/20201216174928.21663-1-socketcan@hartkopp.net/T/#u
> >  
> > 
> > 
> > An I will create some test for the can-tests repo now.
> 
> Done!
> 
> https://github.com/linux-can/can-tests/commit/a129d9f3f583add9282d408a8fa591dbb61caa51
> 
> The code has extensive tests but in the end you can see that the
> optlen 
> value which is provided in the -ERANGE case can directly be used for
> the 
> second getsockopt() syscall.
> 
> Given your buffer has enough space, of course ;-)
> 
> Best,
> Oliver
> 
> > 
> > > On Wed, 2020-12-16 at 17:35 +0100, Oliver Hartkopp wrote:
> > > > Hi Phillip,
> > > > 
> > > > On 16.12.20 05:33, Phillip Schichtel wrote:
> > > > > Hi everyone!
> > > > > 
> > > > > This is my first post to this mailing list (or any kernel
> > > > > mailing
> > > > > list), so please tell me if this is the wrong place for this
> > > > > kind
> > > > > of
> > > > > topic.
> > > > 
> > > > Welcome :-)
> > > > 
> > > > You are perfectly right here.
> > > > 
> > > > > I'm developing a Java binding library to SocketCAN using JNI
> > > > > [1],
> > > > > where
> > > > > I try to provide a reasonably "Java-like" yet efficient and
> > > > > safe
> > > > > API.
> > > > 
> > > > Great idea!
> > > > 
> > > > > Part of this are setters and getters for the SOL_CAN_* socket
> > > > > options,
> > > > > which is straight forward for all options except
> > > > > CAN_RAW_FILTER,
> > > > > since
> > > > > it is the only option with a dynamically sized value (struct
> > > > > can_filter*). Setting the value is simple, since all the
> > > > > information is
> > > > > available in user space, but when using getsockopt I'm
> > > > > expected to
> > > > > provide a buffer and a size, but I don't know how many
> > > > > filters
> > > > > there
> > > > > are without keeping that state in the library or application,
> > > > > risking
> > > > > it going out of sync with the kernel. Is this correct thus
> > > > > far or
> > > > > am I
> > > > > missing something? Relevant source on the kernel side is at
> > > > > [2].
> > > > > 
> > > > > On the user space side using getsockopt() I see three ways
> > > > > around
> > > > > this
> > > > > issue:
> > > > > 
> > > > > 1. Track the amount of filters in user space. I feel like
> > > > > this
> > > > > might be
> > > > > problematic if e.g. sockets get shared between threads and
> > > > > processes.
> > > > > Other bindings usually take this approach as far as I could
> > > > > tell,
> > > > > if
> > > > > they support getting filters at all.
> > > > 
> > > > IMO the filters are intended as write-only as it is very common
> > > > to
> > > > set
> > > > the filters once at process start and live with them until the
> > > > process
> > > > terminates.
> > > > 
> > > > The getsockopt for CAN_RAW_FILTER was only for completion sake
> > > > - but
> > > > in
> > > > fact I did not really think about the expected buffer length in
> > > > userspace when reading back a 'bigger' filter list :-/
> > > > 
> > > > > 2. Allocate a buffer large enough that the filters will most
> > > > > likely
> > > > > all
> > > > > fit, the optlen will be corrected to the actual size. This is
> > > > > the
> > > > > approach I currently take (see [3]), but it feels very wrong.
> > > > > 
> > > > > 3. Search for the right size by trying increasingly larger
> > > > > buffers
> > > > > until the buffer is big enough to fit all. This would be kind
> > > > > of an
> > > > > improvement to 2. for the common case.
> > > > > 
> > > > > Neither of these feel good to me, but maybe that is just me?
> > > > 
> > > > No. As we provide the getsockopt() for CAN_RAW_FILTER this way
> > > > of
> > > > 'testing out' the filter size is no fun for the programmer.
> > > > 
> > > > And using SocketCAN should be fun :-)
> > > > 
> > > > > On the
> > > > > kernel side ([2]), I could imagine the option taking a void**
> > > > > for
> > > > > optval and the kernel allocating a new buffer for the caller
> > > > > and
> > > > > writing its address to the given pointer and the real length
> > > > > to
> > > > > optlen,
> > > > > kind of like this (without knowing the appropriate
> > > > > functions):
> > > > > 
> > > > > 
> > > > > case CAN_RAW_FILTER:
> > > > >          lock_sock(sk);
> > > > >          void* filters = NULL;
> > > > >          if (ro->count > 0) {
> > > > >                  int fsize = ro->count * sizeof(struct
> > > > > can_filter);
> > > > >                  filters = allocate_to_user(fsize);
> > > > >                   if (!optval)
> > > > >                          err = -EFAULT;
> > > > >                  if (copy_to_user(optval, ro->filter, fsize))
> > > > >                          err = -EFAULT;
> > > > >          } else {
> > > > >                  len = 0;
> > > > >          }
> > > > >          release_sock(sk);
> > > > > 
> > > > > 
> > > > >          if (!err)
> > > > >                  err = put_user(len, optlen);
> > > > >          if (!err)
> > > > >                  err = put_user(filters, optval);
> > > > >          return err;
> > > > > 
> > > > > The setsockopt implementation of the option could also be
> > > > > adapted
> > > > > to
> > > > > take the same void**.
> > > > > 
> > > > > Alternatively the implementation could always write back the
> > > > > full
> > > > > size
> > > > > to optlen instead of the "written size" (put_user(fsize,
> > > > > optlen)
> > > > > instead of put_user(len, optlen) in code). Since the caller
> > > > > knows
> > > > > how
> > > > > big its buffer is, the size necessary would be the more
> > > > > valuable
> > > > > information.
> > > > > 
> > > > > Did I completely misunderstand something or is this really a
> > > > > limitation
> > > > > of the current implementation of this option? And if the
> > > > > latter is
> > > > > true, are we in the position to change anything about this
> > > > > without
> > > > > breaking user space?
> > > > 
> > > > Yes, you hit the point. We have a limitation in the current
> > > > implementation; and no, we must not break user space.
> > > > 
> > > > > I also haven't really looked into how other protocols handle
> > > > > dynamically sized option values or if that is even a thing
> > > > > else
> > > > > where.
> > > > 
> > > > Yes. I also had to google and read some kernel code.
> > > > 
> > > > When we take a look into the can/raw.c code
> > > > https://elixir.bootlin.com/linux/v5.10.1/source/net/can/raw.c#L663
> > > > 
> > > >           case CAN_RAW_FILTER:
> > > >                   lock_sock(sk);
> > > >                   if (ro->count > 0) {
> > > >                           int fsize = ro->count * sizeof(struct
> > > > can_filter);
> > > > 
> > > >                           if (len > fsize)
> > > >                                   len = fsize;
> > > > 
> > > >                           if (copy_to_user(optval, ro->filter,
> > > > len))
> > > > 
> > > > 
> > > > At this point we silently truncate the filters to the given
> > > > length of
> > > > the userspace buffer. That's safe but not really good ...
> > > > 
> > > >                                   err = -EFAULT;
> > > >                   } else {
> > > >                           len = 0;
> > > >                   }
> > > >                   release_sock(sk);
> > > > 
> > > >                   if (!err)
> > > >                           err = put_user(len, optlen);
> > > >                   return err;
> > > > 
> > > > The only interesting code that handles this kind of variable
> > > > data
> > > > vector
> > > > read was in net/core/sock.c in sock_getsockopt() for
> > > > SO_PEERGROUPS:
> > > > 
> > > > https://elixir.bootlin.com/linux/v5.10.1/source/net/core/sock.c#L1429
> > > > 
> > > > It was introduced in commit 28b5ba2aa0f55:
> > > > 
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=28b5ba2aa0f55
> > > >  
> > > > 
> > > > 
> > > > "That is, if the provided buffer is too small, ERANGE is
> > > > returned and
> > > > @optlen is updated. Otherwise, the  information is copied,
> > > > @optlen is
> > > > set to the actual size, and 0 is returned."
> > > > 
> > > > This sounds like an interesting approach.
> > > > 
> > > > What do you think about integrating this kind of -ERANGE
> > > > functionality
> > > > into can/raw.c ?
> > > > 
> > > > In fact I never saw someone to use the getsockopt() for
> > > > CAN_RAW_FILTER
> > > > until now. That's probably the reason why you hit this issue
> > > > just
> > > > now.
> > > > 
> > > > IMO introducing the -ERANGE error number does not make the
> > > > current
> > > > situation worse and when a programmer properly checks the
> > > > return
> > > > value
> > > > this -ERANGE would lead to some error handling as -EFAULT does
> > > > today.
> > > > So
> > > > I would not see that we are breaking user space here, right?
> > > > 
> > > > Regards,
> > > > Oliver
> > > 
> > > 


