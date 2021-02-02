Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 090BB30BACD
	for <lists+linux-can@lfdr.de>; Tue,  2 Feb 2021 10:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbhBBJUH (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 2 Feb 2021 04:20:07 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.167]:23735 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232524AbhBBJTa (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 2 Feb 2021 04:19:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1612257395;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:To:Subject:Cc:Date:From:
        Subject:Sender;
        bh=OG7gN8//7M2tIchNsxd7Psy4F8VRmRpUDGrruTOl7Lw=;
        b=PuVIB2pON7bZTXyzucRkgMUbFRNBNyQOIz6bQaNWwuCmSAgsSahZ1WLNwrXqN+lVLp
        oDW+DK9d9wk/AxayUPx2K3u0LOIkdMXOl4KlpNMqhDFUsk6Cy56Cxee9/B7FTPKxgdrI
        ekysJHcY64g5U12FZechHENBS1XWUqEKujmPRiTaqrCL46PWM/xKN7QFy5SMDAZQa5o9
        4ABKa3f2q51F4leAEEfgn0NN8NAOGEpJY4Uf0p94tUSwdCsXA9pTVgKX5PIwrpaTQMvM
        Bu3703kyygy7xygo7moICgp+WBS2Q8IczGZM+nFgrDfchzGPAaxk50z0IjsnPn7ccEMg
        45pQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTGVxiOMtqpw=="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.137]
        by smtp.strato.de (RZmta 47.16.0 DYNA|AUTH)
        with ESMTPSA id w076a1x129GVFks
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Tue, 2 Feb 2021 10:16:31 +0100 (CET)
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
 <cac31b51-514d-462b-fe48-4c3bea8b28fd@hartkopp.net>
 <1b82f875-5884-3bf6-7891-2e4461d2a72a@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <abc8923c-8cf6-c0d5-ec67-73afe183b9b3@hartkopp.net>
Date:   Tue, 2 Feb 2021 10:16:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <1b82f875-5884-3bf6-7891-2e4461d2a72a@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 02.02.21 10:05, Marc Kleine-Budde wrote:
> On 2/2/21 10:00 AM, Oliver Hartkopp wrote:
>>>> IMO, can_frames in the tx path with CAN_ERR_FLAG should be dropped
>>>> if the driver can't handle them. vcan in this regard is capable of
>>>> handling those, as does the kvaser usb.
>>>
>>> Makes sense. The implementation steps could be:
>>> - convert can_dropped_invalid_skb() from static inline to
>>>     regular function
>>> - add check for CAN_ERR_FLAG and enabled CAN_CTRLMODE_TX_ERR
>>>     to can_dropped_invalid_skb()
>>>
>>
>> Which means the vcan has to support CAN_CTRLMODE_TX_ERR too.
>>
>>>> I think it's wrong that CAN_ERR_FLAG messages would appear as regular
>>>> frame on CAN, as happens today if I understood well.
>>>
>>> ACK
>>
>> What happens if you send a valid CAN frame with CAN_ERR_FLAG set?
>>
>> I did not check it but I assume the frame is sent as normal frame and
>> the echo'ed CAN frame would *only* go through the error message filter
>> bank in af_can.c.
> 
> If CAN_CTRLMODE_TX_ERR has been added to the kernel and
> can_dropped_invalid_skb() is updated, then a CAN frame with CAN_ERR_FLAG set
> would be either send as an error frame or dropped by can_dropped_invalid_skb().
> 
> So it would be echoed only if the driver supports CAN_CTRLMODE_TX_ERR and it's
> enabled.

ACK.

So a second time Vincent found a mismatch nobody cared about so far. 
Congrats, Vincent!
(no irony here)

;-)

Best,
Oliver

>> This is probably not what we want for 'real' CAN devices, so we might
>> have to take a look at this too.
> 
> Marc
> 
