Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE62E18E3E5
	for <lists+linux-can@lfdr.de>; Sat, 21 Mar 2020 20:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbgCUTPb (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 21 Mar 2020 15:15:31 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35723 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbgCUTPb (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 21 Mar 2020 15:15:31 -0400
Received: by mail-lj1-f194.google.com with SMTP id u12so10170348ljo.2
        for <linux-can@vger.kernel.org>; Sat, 21 Mar 2020 12:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pJJ83mfyTCqAJF6csSa3R1PY4jhPT+4ET2XKanu9T4c=;
        b=lS7nC9oTJN9FVrGjbIa34p9+854bj+fba7vDh8x6jIFDm6Lgjl1L3Zz3sAq4/BP7IH
         c7+/40GCYQe/2dxMewfAm+bdQAeJxG/8Cw0PAO5c9sZmDjdB8Fp5tpyN7DGNJ66bsP/u
         IY8io4LuqA2Uk7hh1NKYN9mZmgUWvTAZcWVuKrp82ibBGbpNHTNgyDiVBTXzjQA6u9Jy
         EUW800vt5yzGg8hIe0FiJIlUvuGMmd1/8nt7u1oK27/CCVKwZisWPV31REhZp03EN3FH
         mUsKZikSrdEAnDYaNFdRD8wGjGSA+7keDbMc/RFOyn5ri1p8I1xfzVmGNHE+N4evj/Q/
         H9oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pJJ83mfyTCqAJF6csSa3R1PY4jhPT+4ET2XKanu9T4c=;
        b=IBzO/sChNpJyUvRpvCPiqFv1yR6WDa2RbaB1fdtxv67+z4wI/115hCqbGzk+nC6+TY
         WWcghXi0uQZj4Uowtdstlu3g7FuTh8nk1s2WpZvkjx2xW6E8ejdTVyy4jOMGSMSA2Wyh
         155fglZtca+LQZgZvtLJP8E4C7w6JPnTxAggcSxh/JWg/VG4oV7GwqlUpEcV6FTDjhuA
         CEwfKladT0kq9ttu3RLxlPGm/55HAnezeL76sK7k+wtjNFhnD7A8omUtnbfqJ6CsPygL
         3mRbCxQ1T9iXfIVfTpcvhiXstysRWQYvRM6mYCS/iF8jTQQzFLsfsZ+uhAVMpwCQSxZo
         lTMQ==
X-Gm-Message-State: ANhLgQ0Uc8W5YJ2dac8ZbAQmO0cG9MT+tyYhBXHLmg5kl6XzpmUsy24f
        oPkfYRBr1NVOXZADymjZNv8q9CkR9EB7vRBMiUwfUq8w
X-Google-Smtp-Source: ADFU+vu7WCq/rxgeiGRAcAjnNGIgv1mErzkdA+mIjxPXG2hkxr6vYWC8R9YQ0qgjvAxUERfEYlXxad2E9Q0UkhxbHP4=
X-Received: by 2002:a2e:87c5:: with SMTP id v5mr9166862ljj.166.1584818128887;
 Sat, 21 Mar 2020 12:15:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAOHJ0jSS=g4rQtXGkEFocafEqQAtxEOvq5eSXBC2FY_Esb23OA@mail.gmail.com>
 <2cb68f43-a551-c69d-b43f-3b044b948142@hartkopp.net>
In-Reply-To: <2cb68f43-a551-c69d-b43f-3b044b948142@hartkopp.net>
From:   Robert Barrows <robb.barrows@gmail.com>
Date:   Sat, 21 Mar 2020 14:15:17 -0500
Message-ID: <CAOHJ0jRQx2U1APx92DTGFGzGLY9+tds3R4Sz8Tz8+LToWx_44g@mail.gmail.com>
Subject: Re: How to send a CAN message while in a kernel module?
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

> You don't use sockets from INSIDE the kernel.
> If you want to send CAN frames from inside the kernel you should use the
> can_send() function from af_can.c
Great to know! I Will look at that right away, any example(s) you could point
me towards?

> Is your requirement to send "some content" in a very defined time slot
> OR do you need to send the time as content?
Use case:
I need to send the epoch seconds as close to the zeroth of the second
as possible, there are some legacy cards that use this packet to set their
clocks, and I am attempting a solution to improve their accuracy without
modifying their firmware.
Hence I have a kernel module that can run a function with sub 10uS accuracy,
the function of choice would spit out a CAN packet with the epoch seconds in
it.

> Sending CAN frames in a very precise (hrtimer) manner can be done with
> the broadcast manager (aka CAN_BCM) sockets.
>
> See:
> https://elixir.bootlin.com/linux/latest/source/Documentation/networking/can.rst#L677
>
> 1. You can send fixed CAN frames and also a sequence of up to 256
> (different) CAN frames at a precisely defined time with a CAN_BCM TX job.

struct timeval ival1, ival2;    /* count and subsequent interval */
Unfortunately, this doesn't look like it fits my use case, would have been nice
to do from user space though.  This looks like it can send out evenly spaced
packets. And I need to send one packet at a precise clock time.

> 2. You can generate the timestamp in user space and send it via CAN_RAW
> socket.

This also wont work due to the use case.

> 3. You write your own kernel module o_O :)

Here we are :)
