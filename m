Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D08F830BA95
	for <lists+linux-can@lfdr.de>; Tue,  2 Feb 2021 10:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbhBBJHO (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 2 Feb 2021 04:07:14 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.20]:25077 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232553AbhBBJE7 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 2 Feb 2021 04:04:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1612256460;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:To:Subject:Cc:Date:From:
        Subject:Sender;
        bh=TjVoc4Agx98ht1RSPx0Gi89h00yCrZTM9COiXint2Zc=;
        b=d6sqD7hFqllC6yayWI1qhB00riHMfJY5GEw6LTWwVQbRW9UJMMSXYpGsIaccCZAABn
        ZkMGwnQMXPUedqUVE49DZ1xqLnXusHE/oY4XTcZMz+er67ktJu9iDlA8Djx0pkTsIi9E
        ZtnnGGRu4uvigpVGHxZhGki1mRtBAtYSGlwADqp3fxevoDvrdOzo7scYjwIqKqXaz/Wl
        uXzY/k48cqS5/41wPT29JeXEGnSng/6dPtf6msQhZNck5ZwmQmpKQvN5ez3ACO0FoC+N
        k6be8bBjDytla5RQvuJ6DLHU5sXE2+l2J97gQ5CMSF5VRPiDUA6VJZ/gLo/hRk/epBGX
        3izA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTGVxiOMtqpw=="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.137]
        by smtp.strato.de (RZmta 47.16.0 DYNA|AUTH)
        with ESMTPSA id w076a1x1290vFeA
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Tue, 2 Feb 2021 10:00:57 +0100 (CET)
Subject: Re: [Question] Sending CAN error frames
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        Jimmy Assarsson <extja@kvaser.com>,
        Jimmy Assarsson <jimmyassarsson@gmail.com>,
        linux-can <linux-can@vger.kernel.org>
References: <CAMZ6RqK0rTNg3u3mBpZOoY51jLZ-et-J01tY6-+mWsM4meVw-A@mail.gmail.com>
 <87e3dd54-50ab-1190-efdb-18ddb3b21a02@hartkopp.net>
 <42080d05-7ab3-99be-92e2-73ed262350ba@gmail.com>
 <CAMZ6RqJWrObGZRwyA1kD5cEZRUd_-4zt8rsMR+zZPLpxD6AWAQ@mail.gmail.com>
 <1debcaeb-71c7-6b78-88b3-7f121a33c1c1@kvaser.com>
 <CAMZ6Rq+ObkS2RDFbgbPP7HZH26WbN-eoLeQyiY6+CpDGYjE10w@mail.gmail.com>
 <17b14b11-87bf-9508-0da5-1031c5d5e132@pengutronix.de>
 <20210202082340.GA23043@x1.vandijck-laurijssen.be>
 <8050d433-591c-2d1f-f0c7-ffa92e33032d@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <cac31b51-514d-462b-fe48-4c3bea8b28fd@hartkopp.net>
Date:   Tue, 2 Feb 2021 10:00:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <8050d433-591c-2d1f-f0c7-ffa92e33032d@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 02.02.21 09:41, Marc Kleine-Budde wrote:
> On 2/2/21 9:23 AM, Kurt Van Dijck wrote:
>>>>> Right, it would be nice to sort this out. I prefer to keep the
>>>>> functionality, since we got customers using it.
>>>>
>>>> Basically, I would see this as an expert function: add a
>>>> CAN_CTRLMODE_TX_ERR and have the user explicitly enable the
>>>> feature through netlink when configuring the interface. The
>>>> rationale is to prevent by default an unprivileged application
>>>> from messing with the bus.
>>>
>>> The CAN_CTRLMODE_TX_ERR would be a per device option. Another option might be a
>>> sockopt, where you have to enable the TX_ERR explicitly. I'm not sure, which
>>> option is the best here.
>>
>> a sockopt is only correct if it can detect that the device underneath
>> has CAN_CTRLMODE_TX_ERR capability.
> 
> ACK
> 
> The user space use case would be:
> 
> - fd = socket()
> - bind(fd, "can0")
> - setsockopt(fd, SOCKOPT_TX_ERR)
> 
> The raw_setsockopt() in the kernel can check the CAN devices supported ctrl modes.
> 
>> So I'd think we start with adding the CAN_CTRLMODE_TX_ERR to the driver
>> level.
> 
> ACK
> 
>> It would allow to see if a driver will behave properly with CAN_ERR_FLAG
>> can_frames in the tx path.
> 
> ACK
> 
>>>> If CAN_CTRLMODE_TX_ERR is on the device generates an error
>>>> flag. Else, the CAN_ERR_FLAG is simply ignored (masked out).
>>>> The CAN ID, DLC and payload of the TX error frames are
>>>> ignored (i.e. reserved for future).
>>
>> IMO, can_frames in the tx path with CAN_ERR_FLAG should be dropped
>> if the driver can't handle them. vcan in this regard is capable of
>> handling those, as does the kvaser usb.
> 
> Makes sense. The implementation steps could be:
> - convert can_dropped_invalid_skb() from static inline to
>    regular function
> - add check for CAN_ERR_FLAG and enabled CAN_CTRLMODE_TX_ERR
>    to can_dropped_invalid_skb()
> 

Which means the vcan has to support CAN_CTRLMODE_TX_ERR too.

>> I think it's wrong that CAN_ERR_FLAG messages would appear as regular
>> frame on CAN, as happens today if I understood well.
> 
> ACK

What happens if you send a valid CAN frame with CAN_ERR_FLAG set?

I did not check it but I assume the frame is sent as normal frame and 
the echo'ed CAN frame would *only* go through the error message filter 
bank in af_can.c.

This is probably not what we want for 'real' CAN devices, so we might 
have to take a look at this too.

Regards,
Oliver
