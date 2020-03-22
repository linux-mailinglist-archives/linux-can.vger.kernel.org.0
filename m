Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59EAC18EBB6
	for <lists+linux-can@lfdr.de>; Sun, 22 Mar 2020 19:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbgCVSzI (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 22 Mar 2020 14:55:08 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.20]:9192 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgCVSzI (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 22 Mar 2020 14:55:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1584903306;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=fT/v7LS9gPuTr9kvoACvIcxMonHR0ZsVE7XP/GvRyxA=;
        b=WoxY3NbLBGrbJ1tswGBS3pYzlYc2JlBth5HOwwy9mCfzn2ga0vjKRwftawGANr42XM
        ACl6jKe9DVQNDc3NvJtfYRuy26tUg+1eEK+2KiASQC4ugYoZIVWD+FVcR2pXmWSzBh8w
        57QEdfwma6A2J1I+oegwQKHXEykyos4TPaBRrC03ambul1rUqOBxgN797sk3FvjoP8aU
        6WYwhpCP9h+Af4WplQY+SGDxj5hTtHZ5ahsXf89LA6oARpRSYpw0TxKw5EyokVU3jZen
        wEJ0bUMhoWJ+qMOSFS5LtgsgmbYLoND+4qiMGVw2Ot1mbqwI8wBU5LSnMjlIJ9VWXSjz
        WRlA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3HMbEWKNNeTQdI="
X-RZG-CLASS-ID: mo00
Received: from [192.168.50.177]
        by smtp.strato.de (RZmta 46.2.1 DYNA|AUTH)
        with ESMTPSA id R0105bw2MIt58AJ
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Sun, 22 Mar 2020 19:55:05 +0100 (CET)
Subject: Re: How to send a CAN message while in a kernel module?
To:     Robert Barrows <robb.barrows@gmail.com>
Cc:     linux-can@vger.kernel.org
References: <CAOHJ0jSS=g4rQtXGkEFocafEqQAtxEOvq5eSXBC2FY_Esb23OA@mail.gmail.com>
 <2cb68f43-a551-c69d-b43f-3b044b948142@hartkopp.net>
 <CAOHJ0jRQx2U1APx92DTGFGzGLY9+tds3R4Sz8Tz8+LToWx_44g@mail.gmail.com>
 <ead77f42-f0f9-9b5a-ce5a-5e7f641d8a14@hartkopp.net>
 <CAOHJ0jQq80B64O6nG-aNSUhUrczVL0r4GZj-AUWcs4coiERG+Q@mail.gmail.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <a152f1b1-f9e4-cae2-4dc4-d651f84eb11b@hartkopp.net>
Date:   Sun, 22 Mar 2020 19:55:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAOHJ0jQq80B64O6nG-aNSUhUrczVL0r4GZj-AUWcs4coiERG+Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 22/03/2020 19.03, Robert Barrows wrote:
> Thank you for all the direction Oliver,  I think I am on the correct path,
> but now have can_send returning with a "-1" (ERESTART). I used raw_sendmsg
> as a template for this and cut out (hopefully) unneeded code, but I am
> concerned I cut out something I needed.  Would you mind taking another look?
> 
> Thanks.
> 
> int SendCanTime(struct timespec *tsCurrentTime) {
> 
>    struct sk_buff *skb;
>    struct can_frame *frame = kmalloc(sizeof (struct can_frame), GFP_KERNEL);
>    struct net_device *dev;
>    int err = 0;
>    int thetime = tsCurrentTime->tv_sec;
> 
>    // Set up can frame
>    frame->can_id = 0x00050F93 | CAN_EFF_FLAG;
>    frame->can_dlc = 6;
>    frame->data[0] = 0x00;
>    frame->data[1] = 0x02;
>    memcpy(frame->data+2, &thetime, sizeof(int));
> 
>    // Find the netdevice named can0
>    read_lock(&dev_base_lock);
>    dev = first_net_device(&init_net);
>    while (!strcmp(dev->name, "can0")) {
>      printk(KERN_INFO "found [%s]\n", dev->name);
>      dev = next_net_device(dev);
>    }
>    read_unlock(&dev_base_lock);

What does this return when you don't have can0 in the system??

You should use
  __dev_get_by_name()
here.
https://elixir.bootlin.com/linux/latest/source/net/core/dev.c#L762

And check for success :-)


> 
>    if (!dev)
>      return -ENXIO;
> 
>    // Create skb
>    skb = alloc_can_skb(dev, &frame);
>    if (!skb)
>      goto put_dev;
> 
>    skb->dev = dev;
> 
>    err = can_send(skb, 0);
> 
>    dev_put(dev);
> 
>    if (err)
>      goto send_failed;
> 
>    return 0;
> 
> //kfree_skb(skb);
> put_dev:
>    dev_put(dev);
> send_failed:
>    return err;
> 
> }
>                                                                                 ^
> 
