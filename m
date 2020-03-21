Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C078D18E2F4
	for <lists+linux-can@lfdr.de>; Sat, 21 Mar 2020 17:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgCUQqM (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 21 Mar 2020 12:46:12 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.24]:18509 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbgCUQqM (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 21 Mar 2020 12:46:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1584809170;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=KY5vmllp7yDf0z0vYNkEVpbZ4I65ZWjLeU2K+wWeaUM=;
        b=T3hjwQPJGE9p9LmtCMO1BKrFyQGnfBCyGv4UpZl7Rz90xkqm+7OhIjanbyN4H2jTUy
        WGGGV9tOkiwmyESXhosXq7nz2lpXm41mnqeM51vjvQXCMmdvfq5CsCnqfxWPBeQsD7Zd
        eItb/D/symPY6do8e0gRZh1G5YehPL6ZgiAnBHwHDY2lTUEsc+/thrby7TQyg6KQCpbG
        reFmHD7Xp3JgFF3HkQpHJjGeq08gE+/4h+SYnjxdfBfmY0Rzp561Ar0Brdqqh+wCh3d6
        Dvue+aZpxSr6IY1vsw3u9i9G73vnt7oJTqRNA9zHp0ZuAf1r2wCv+qCuxnqXmZTx/JcP
        evlw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3PMaViOoLMGXsh6kk/L"
X-RZG-CLASS-ID: mo00
Received: from [192.168.50.177]
        by smtp.strato.de (RZmta 46.2.1 DYNA|AUTH)
        with ESMTPSA id R0105bw2LGk96sP
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Sat, 21 Mar 2020 17:46:09 +0100 (CET)
Subject: Re: How to send a CAN message while in a kernel module?
To:     Robert Barrows <robb.barrows@gmail.com>, linux-can@vger.kernel.org
References: <CAOHJ0jSS=g4rQtXGkEFocafEqQAtxEOvq5eSXBC2FY_Esb23OA@mail.gmail.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <2cb68f43-a551-c69d-b43f-3b044b948142@hartkopp.net>
Date:   Sat, 21 Mar 2020 17:46:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAOHJ0jSS=g4rQtXGkEFocafEqQAtxEOvq5eSXBC2FY_Esb23OA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Robert,

On 21/03/2020 15.50, Robert Barrows wrote:
> I have attempted to write a kernel module that sends a message via CAN but I am
> having trouble understanding which level of the socket api I should be using,
> and where there may be some documentation or examples of how to use it?
> 
> I am on a much older embedded 2.6.31 imx arm kernel, and eventually I
> would like to
> send this message from within a high res timer triggered ISR.

You can probably use the CAN_BCM sockets for your use-case which uses 
high-res timers too - even in the 2.6.31 kernel. But I'll come to that 
later ...

> This is my code, which is hobbled together from internet examples, and kernel
> oops is during sock_sendmsg, for now I am just trying to get it do run as part
> of the init of the module:
> 
> int SendCanTime(struct timespec *tsCurrentTime) {
>    int s;
>    struct sockaddr_can addr;
>    struct can_frame frame;
>    struct socket *sock;
>    int thetime = tsCurrentTime->tv_sec;
>    mm_segment_t oldfs;
> 
>    oldfs = get_fs();
>    set_fs(KERNEL_DS);
> 
>    printk("cantime.ko: Socket 10\n");
>    if ((s = sock_create(PF_CAN, SOCK_RAW, CAN_RAW, &sock)) < 0) {
>      printk("cantime.ko: Socket failure\n");
>      return 1;
>    }

Argh - No!

You don't use sockets from INSIDE the kernel.
If you want to send CAN frames from inside the kernel you should use the 
can_send() function from af_can.c

> 
>    printk("cantime.ko: Socket 20\n");
>    memset(&addr, 0, sizeof(addr));
>    addr.can_family = PF_CAN;
>    addr.can_ifindex = 2; // This is bad how do I dynamically find it?
> 
>    printk("cantime.ko: Socket 30");
>    if (sock->ops->bind(sock, (struct sockaddr *)&addr, sizeof(struct
> sockaddr) ) < 0) {
>      printk("cantime.ko: Bind failure\n");
>      return 1;
>    }
> 
>    printk("cantime.ko: Socket 40\n");
>    frame.can_id = 0x00050F93 | CAN_EFF_FLAG;
>    frame.can_dlc = 6;
>    frame.data[0] = 0x00;
>    frame.data[1] = 0x02;
> 
>    memcpy(frame.data+2, &thetime, sizeof(int));

Is your requirement to send "some content" in a very defined time slot 
OR do you need to send the time as content?

> 
>    printk("cantime.ko: Socket 50\n");
>    if (sock_sendmsg(sock,(struct msghdr*)&frame,sizeof(struct
> can_frame)) !=  sizeof(struct can_frame)) {
>      printk("cantime.ko: Write failure");
>      return 1;
>    }
> 
>    sock_release(sock);
>    set_fs(oldfs);
> 
>    return 0;
> 
> }
> 
> Output:
> cantime.ko: Socket 10
> cantime.ko: Socket 20
> cantime.ko: Socket 30cantime.ko: Socket 40
> cantime.ko: Socket 50
> Unable to handle kernel paging request at virtual address 80050f93
> pgd = d14c8000
> [80050f93] *pgd=00000000
> Internal error: Oops: 1 [#1] PREEMPT
> Modules linked in: cantime(+) g_ether arcotg_udc

Funny thing :-)

> I also have the user space code that works perfectly that I was trying to model
> my kernel module code after:

Ok - but we need to check your use-case.

Sending CAN frames in a very precise (hrtimer) manner can be done with 
the broadcast manager (aka CAN_BCM) sockets.

See:
https://elixir.bootlin.com/linux/latest/source/Documentation/networking/can.rst#L677

1. You can send fixed CAN frames and also a sequence of up to 256 
(different) CAN frames at a precisely defined time with a CAN_BCM TX job.

2. You can generate the timestamp in user space and send it via CAN_RAW 
socket.

3. You write your own kernel module o_O :)

Regards,
Oliver

