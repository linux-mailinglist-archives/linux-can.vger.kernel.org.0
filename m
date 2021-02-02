Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCAB30CB77
	for <lists+linux-can@lfdr.de>; Tue,  2 Feb 2021 20:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234431AbhBBTZl (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 2 Feb 2021 14:25:41 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.23]:12838 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239638AbhBBTXh (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 2 Feb 2021 14:23:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1612293580;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
        From:Subject:Sender;
        bh=kSKFjX+cqOUWSYhegONUgn6GZafMqk/+Aa4G3qLhxGo=;
        b=cHxn2IyXslsGP1Gi9B9xEggwY8P1FiMQKO+wjXBM261n4kmrKGVyZiZq2rAnkoKAXL
        /0ZRuQsR+4Ur4/OKfT2pscwXTRadRw/BBqjf6ByXIF1fkcocq2gKPpkiGsE+xBs5deVG
        Dcd/cmeDQQa/MuxK95mZspVOJP3KaC9vyqIbzaOuIIjz+SJSXofwn3RZxk08Ir4oOh1I
        J/bTTDCryjeHFnYRX5Yu5/xNTsb443UByjzBE1Zf2DYfHBmQ49wDOhizA7Fb7BRXy/W3
        SjoeXbaD2SMtmTqe5VzCX3JJcoO1FQL2ujFwIAZIepcbcL8iaykf3UTkm8f+g75wJsa2
        s5OQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3PMaViOoLMJV8h6kk/I"
X-RZG-CLASS-ID: mo00
Received: from [192.168.50.177]
        by smtp.strato.de (RZmta 47.16.0 DYNA|AUTH)
        with ESMTPSA id w076a1x12JJaIHE
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Tue, 2 Feb 2021 20:19:36 +0100 (CET)
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
 <ac8c4d3c-4261-8909-3481-abcd1d3bf43e@hartkopp.net>
 <CAMZ6RqKkeV6WRtfh65mDsYthuG1S+LD=kexAdcx=DeShf0T0YQ@mail.gmail.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <d7584992-78a0-4be7-6b31-0bc1e4adfeca@hartkopp.net>
Date:   Tue, 2 Feb 2021 20:19:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAMZ6RqKkeV6WRtfh65mDsYthuG1S+LD=kexAdcx=DeShf0T0YQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 02.02.21 12:12, Vincent MAILHOL wrote:

>> The CAN_ERR_FLAG has been renamed in the documentation to indicate
>> "error messages" from the CAN controller, as an error frame is something
>> completely different.
>>
>> Now as we are talking about having CAN_ERR_FLAG in the TX path besides
>> the vcan testing stuff, we should think about an API for the really
>> outgoing frames.
>>
>> We could not only think about "create an error frame right now" but also
>> think about a more intelligent CAN node, which also offers to destroy
>> one or more specific CAN ID(s) at a specific bit position after
>> detecting that CAN ID.
> 
> My original idea was to leave it unspecified until a device was
> actually capable of doing such a thing. But I am not against
> defining the API now :) We might just have to wait a long time
> for someone to actually implement it.
> 
>> We could use the CAN_RTR_FLAG and the data[] section of the outgoing
>> error CAN frames for such an API.
> 
> We are not limited to the CAN_RTR_FLAG and the data[]
> 
> First, we have to list the use cases.
> 
> As I wrote before, there are only two forms for the error flag:
>    - The active error flag: 6 consecutive dominant bits
>    - The passive error flag: 6 consecutive recessive bits

IMO this passive error flag stuff is pointless.
The passive error does not have any effect on the bus. Nobody sees it. 
It's just a measure to continue counting error counters inside the CAN 
controller. IMO it's a read-only feature about the controller internal 
status.

> The device can either inject the flag either during:
>    - bus idle

Is an error flag defined at bus idle?

Error flags are intended to destroy *other CAN controllers* 
transmissions when detecting protocol violations. There can not be a 
protocol violation at idle time, right?

>    - while it is transmitting a frame

What's the use-case for destroying your own transmission?

>    - while it is receiving a frame

This makes sense, especially when you can destroy specific CAN ID frames 
at a specific bit position.
Or for any CAN ID at a specific bit position.
Or for any CAN ID at an undefined bit position.

> The error flag can occur at any time.

Sure? (see above)

Of course we might also provide some pump gun mode which just sends an 
error flag at some (any) time.

But for what reason?

Therefore I would massively reduce the following list:

> My first proposal would be:
> 
>   1/ One flag to specify the error flag form (active or
>      passive). Passive error flags can not be used when receiving
>      a frame.

NO

> 
>   2/ One flag to specify if we inject during bus idle or not.

NO

> 
>   3/ One flag to specify if we inject while transmitting or
>      receiving a frame.

NO - receiving only

> 
>   4/ If injecting while receiving, have the ability to specify
>      the CAN ID, DLC and flag filters (EFF, SFF, RTR, BRS...) of
>      the frame on which we want to inject the error flag. I do not
>      see the need for a complex filter. I would propose to either
>      have an exact match or no match (e.g. inject on next frame
>      whatever this frame is).

Yes. Additionally to a bit position after detecting the CAN ID, we could 
also provide these symbolic defines like 'BRS' from which position we 
want to start the error flag transmission.

But we should be careful not to make the job too complex for the sending 
CAN controller.

> 
>   5/ One flag to specify if injection while transmitting is done
>      on exact match or on any frames (if done on any frames,
>      the filters 4/ are ignored). This flag is ignore for bus idle or
>      while receiving.

NO - receiving only

> 
>   6/ If we inject while receiving, do it on the next normal frame
>      we transmit (no filter). The userland have to send two frame:
>      one with CAN_ERR_FLAG and one normal one on which we
>      will inject the error flag in order to use the feature.

Maybe the 'pump gun' could always hit the 'next' frame as default.

> 
>   7/ Have an offset: the bit index on which we want to inject the
>      error flag. I am not yet sure if we should ignore bitstuffing
>      or not. If the bus is idle, wait offset bit times before
>      injecting. Else, start counting the bits from the Start of
>      Frame.

See 4/

> 
> The flags 1/, 2/, 3/, 5/ and the offset 7/ goes into the data[]
> payload, the filters 3/ goes into their respective field (CAN ID,
> DLC, FF, SFF, RTR, BRS flags).
> 
> 

Regards,
Oliver
