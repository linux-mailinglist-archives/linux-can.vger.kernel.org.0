Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D12D1445A0
	for <lists+linux-can@lfdr.de>; Tue, 21 Jan 2020 21:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbgAUUEF (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 21 Jan 2020 15:04:05 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.166]:21912 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbgAUUEF (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 21 Jan 2020 15:04:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1579637043;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:Cc:From:References:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=Y0swx7sqZARi8/s6SALQfjTCgL7WqZ3eVWl5EKg4lT8=;
        b=Gvmv1f5N+FCXyIjUEBbdM2tLVVaeBogs45oY8QI14dV7seakGmz0yPn9DsgKo/Ptja
        v3vtc9wN7hwBjJB6pSaTkKa43qmkmtnRcB3tSQ4mohRO/W7v2kg065rbAjP3NzIjUZG1
        IKlGmo/w93ZmTQ+lrq6DqTz4oGJ0WQCW5hxXma/yDeqbuNqN2YoP7Rhc5JsCcjJ9mo4L
        eK5HaaJ/Ukfymz4CIP23mSxBj1fe55O2T16f4jBAzS21zFEXjUkg3YMU/a3tCgsrXU5C
        ow3awrIgg4BJRGLglLPMbfgXjfqebljuR74FN132jgid8g5A75TPfwlwYrN4j8ez9kW9
        YQtg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3PMaViOoLMJV8h5kyA="
X-RZG-CLASS-ID: mo00
Received: from [192.168.40.177]
        by smtp.strato.de (RZmta 46.1.5 DYNA|AUTH)
        with ESMTPSA id t040cew0LK3l5hw
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Tue, 21 Jan 2020 21:03:47 +0100 (CET)
Subject: Re: general protection fault in can_rx_register
To:     Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
References: <00000000000030dddb059c562a3f@google.com>
 <55ad363b-1723-28aa-78b1-8aba5565247e@hartkopp.net>
 <20200120091146.GD11138@x1.vandijck-laurijssen.be>
 <CACT4Y+a+GusEA1Gs+z67uWjtwBRp_s7P4Wd_SMmgpCREnDu3kg@mail.gmail.com>
 <8332ec7f-2235-fdf6-9bda-71f789c57b37@hartkopp.net>
 <2a676c0e-20f2-61b5-c72b-f51947bafc7d@hartkopp.net>
 <20200121192248.GC13462@x1.vandijck-laurijssen.be>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        o.rempel@pengutronix.de,
        syzbot <syzbot+c3ea30e1e2485573f953@syzkaller.appspotmail.com>,
        linux-can@vger.kernel.org
Message-ID: <9a6be054-ac52-761d-83f0-809ec80e7764@hartkopp.net>
Date:   Tue, 21 Jan 2020 21:03:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200121192248.GC13462@x1.vandijck-laurijssen.be>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Kurt,

On 21/01/2020 20.22, Kurt Van Dijck wrote:

> I decreased the CC list a bit, as I'm more like thinking in the wild
> now:

Good choice!

> Since the problems happens only rarely, and with vxcan, I assume not
> vcan, I started to think to locking issues.
> 
> 1. What surprised me a bit is 'rtnl_dereference()' calls, without
> rcu_read_lock() around it? is that supposed to be ok?

Don't know. This code was just copied from veth.c

But veth doesn't fiddle with ml_priv like us.

> 2. is it possible to call vxcan_dellink in between the 2
> rcu_assign_pointer() calls in vxcan_newlink(), resulting in a dead end,
> i.e. one end is referenced, but already deleted?
> I'd expect a kind of rcu_write_lock around the cross-linking at least.

Will look into this too. When there's a comment this might be a 
justification for doing "hacky" things ;-)

> It still puzzles me how this bisected to CAN_REQUIRED_SIZE() macro
> commit.

Yes. That's really weird as is just has an impact on the socket API. But 
it should not have any impact on the CAN_RAW socket they are using.

Hm - in fact is has an impact on the socket API.
Before the patch the user space was able to send 16 bytes to the CAN_RAW 
socket. Now it's only 8 byte as you reduced the required size.

Regards,
Oliver

