Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9562430BBE8
	for <lists+linux-can@lfdr.de>; Tue,  2 Feb 2021 11:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbhBBKR3 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 2 Feb 2021 05:17:29 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.167]:32487 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbhBBKR2 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 2 Feb 2021 05:17:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1612260876;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
        From:Subject:Sender;
        bh=qDOi0hXSjBqnavrfN868Xj6/fqoBRWS97C75b2d7tdo=;
        b=XhIjlF9U1lZMcFFByVx287Ud3RFqooWY+Xi6ZPT+EVf+akXwn0+F/H9U8tgneIJwFq
        CUxqueHT2Ggp92F7yHaSTwQneZAhC9Pm5MVBL+f9G+m4XBMcM1HNAfU4WaawYic1OIM2
        KwTMsdX8M5XsVCvcC9ED+LW42I3iKnlLpRZodrDCkEHT133dtUf9fKYsR2MLfD0uPvs/
        BY9B2OX/eSj3dzbOHM8XtHgrxlffqf4HZEzJkiMHgq7wuetqNPOJysAp4mq02kUibh8Q
        WXpvWJgw2LCg7l2EgINdpDHJ0b4oKiO+/i4Mn8UJhab5qgMWscRJpDNfw6l+HE5gvs5g
        WdYA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTGVxiOMtqpw=="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.137]
        by smtp.strato.de (RZmta 47.16.0 DYNA|AUTH)
        with ESMTPSA id w076a1x12AEUG52
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Tue, 2 Feb 2021 11:14:30 +0100 (CET)
Subject: Re: [Question] Sending CAN error frames
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
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
 <abc8923c-8cf6-c0d5-ec67-73afe183b9b3@hartkopp.net>
 <CAMZ6RqKx5NCFKiahb8AbUx=LC5xS6oYCdVZk8WGSAzZeAVs9Qg@mail.gmail.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <ac8c4d3c-4261-8909-3481-abcd1d3bf43e@hartkopp.net>
Date:   Tue, 2 Feb 2021 11:14:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAMZ6RqKx5NCFKiahb8AbUx=LC5xS6oYCdVZk8WGSAzZeAVs9Qg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 02.02.21 11:00, Vincent MAILHOL wrote:

>>> If CAN_CTRLMODE_TX_ERR has been added to the kernel and
>>> can_dropped_invalid_skb() is updated, then a CAN frame with CAN_ERR_FLAG set
>>> would be either send as an error frame or dropped by can_dropped_invalid_skb().
>>>
>>> So it would be echoed only if the driver supports CAN_CTRLMODE_TX_ERR and it's
>>> enabled.
>>
>> ACK.
> 
> The echo would be special here.  We have to remember that the
> payload of the CAN_ERR_FLAG frames is an arbitrary design. This
> payload has no meaning for the data link.
> 
> When we echo back the frame, only the DLC, CAN ID and payload of
> the TX frame are irrelevant (except for vcan).
> 
> My current idea would be to follow what Kvaser did: they send the
> frame and the device reports the error flag (c.f. the example
> given by Jimmy above). So the echo feature would not be used
> for error flags.

In fact I would suggest to think a about a proper API (aka CAN frame 
content definition) for outgoing CAN frames with the CAN_ERR_FLAG set.

The CAN_ERR_FLAG has been renamed in the documentation to indicate 
"error messages" from the CAN controller, as an error frame is something 
completely different.

Now as we are talking about having CAN_ERR_FLAG in the TX path besides 
the vcan testing stuff, we should think about an API for the really 
outgoing frames.

We could not only think about "create an error frame right now" but also 
think about a more intelligent CAN node, which also offers to destroy 
one or more specific CAN ID(s) at a specific bit position after 
detecting that CAN ID.

We could use the CAN_RTR_FLAG and the data[] section of the outgoing 
error CAN frames for such an API.

Regards,
Oliver
