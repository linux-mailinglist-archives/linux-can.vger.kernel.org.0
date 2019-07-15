Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E82B768F9E
	for <lists+linux-can@lfdr.de>; Mon, 15 Jul 2019 16:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389592AbfGOOPn (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 15 Jul 2019 10:15:43 -0400
Received: from mail.iot.bzh ([51.75.236.24]:27556 "EHLO mail.iot.bzh"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389575AbfGOOPm (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 15 Jul 2019 10:15:42 -0400
Received: from [10.18.127.29] (unknown [10.18.127.29])
        by mail.iot.bzh (Postfix) with ESMTPSA id 1128740071;
        Mon, 15 Jul 2019 16:15:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iot.bzh; s=20180822;
        t=1563200136; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IvNSmllU0xxxJF7GMftVaoJkWjN1yepss3N5jSC6YTQ=;
        b=P5LvXG/fNu2XjtUE81vDIpfw+QV6Kz39nAMgmsnIxYVOKZBat+iUpm4qznya7IiPI7scdE
        mLudhvyp4QRUYbML+m7A7LJPi2+4PN2HjnDAnyRdaVS7CTcOv9mamuGNsEJjlDayO3A5I/
        dfpzBTdt3ZUfmAZ9639MJtVbabz1/Ms5IqawAixBygVnbhk2IfoKk8mWh3kVjqJz1/H5IG
        ckEhIa/DJyen4kaNILt68s+hTzeqjCyWsYi2DLsuQhSWXP80ZdbxCVWTbQkMASNlEb+n/K
        9yXkTB/074uE3B2YvMS5iWFln/R0KcB53uTyeBMjegsjLwSP/+/iK4i59Lz9Dg==
Subject: Re: J1939 : Address Claiming
From:   Arthur Guyader <arthur.guyader@iot.bzh>
To:     linux-can@vger.kernel.org, dev.kurt@vandijck-laurijssen.be
References: <43c0a773-ec06-5288-9fcc-9cdf68e72879@iot.bzh>
 <20190706050020.GE22538@x1.vandijck-laurijssen.be>
 <f95b8200-31fa-e2f5-49a2-f576fae3cc9c@iot.bzh>
 <20190708084934.GA24954@x1.vandijck-laurijssen.be>
 <81056b49-a0c7-8b2d-d2d2-785b6107fd9d@iot.bzh>
Message-ID: <a0d48616-86ac-a2f3-8d07-e0209e6f2021@iot.bzh>
Date:   Mon, 15 Jul 2019 16:15:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <81056b49-a0c7-8b2d-d2d2-785b6107fd9d@iot.bzh>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello,

I encountered a problem when using the claiming address.
When an ECU1 with a low name requests an address, it is saved in the 
kernel cache.
If this ECU1 is cut, and we launch our ECU2 which will ask for the same 
address.
He will have no answer from ECU1 and has no trace of him in his cache, 
so he can consider that the address is free.
However, the kernel will consider that the address is busy and generate 
an error when sending a message. (99 : cannot assign requested address)

How would you handle this situation?

I thought about sending a test message and handling the error case and 
choosing another address.

Is there any way to clear the kernel cache?

Best regards

-- 
Arthur Guyader - Embedded Engineer - IoT.bzh

On 08/07/2019 13:46, Arthur Guyader wrote:
> OK great !
>
> Thank you !
>
> Best regards
>
> -- 
> Arthur Guyader - Embedded Engineer - IoT.bzh
>
> On 08/07/2019 10:49, Kurt Van Dijck wrote:
>>>     Each time a new address is assigned I rebind the other sockets 
>>> with it.
>> This administration is inherently racy.
>> That's why you better bind the other sockets by name,
>> so you don't have to rebind each time the address changes.
>> The kernel will, based on the address claims passing in & out,
>> apply the correct address, if any is available.
>>
>> As such, you can push the address claiming socket in another process,
>> and my re-use jacd.
>>
>> Kind regards,
>> Kurt
>>
>>
>> On ma, 08 jul 2019 10:22:21 +0200, Arthur Guyader wrote:
>>>     Thank you for your answer !
>>>
>>>     Let me get this straight :
>>>     I create a socket dedicated to the claiming address.
>>>     Each time a new address is assigned I rebind the other sockets 
>>> with it.
>>>     If I use the wrong address, the message will not be sent.
>>>
>>>     Best regards
>>> -- 
>>> Arthur Guyader - Embedded Engineer - IoT.bzh
>>>
>>>
>>>     On 06/07/2019 07:00, Kurt Van Dijck wrote:
>>>
>>> Hey,
>>>
>>> On vr, 05 jul 2019 17:52:16 +0200, Arthur Guyader wrote:
>>>
>>> Hello all,
>>>
>>> I looked at the code of can-utils and more precisely jacd.c.
>>>
>>> In the way it is implemented, the deamon's only objective is to 
>>> change its
>>> address according to the different requests it receives.
>>>
>>> That is indeed the only thing jacd does. It helps other programs that
>>> use the same 64bit NAME so that they don't have to implement the same
>>> thing.
>>>
>>>
>>> More precisely, the socket is blocked until the next received claiming
>>> address request (recvfrom).
>>>
>>> yes.
>>> Since it's the only thing it does, there is no need to use non-blocking
>>> calls.
>>>
>>>
>>> In a real implementation, do you need two sockets?
>>>      - one to receive and write messages
>>>      - another dedicated only to the claiming address
>>> Or did you have another solution?
>>>
>>> The objective is to have multiple programs or sockets open that
>>> each implement a little functionality, and that share the same NAME and
>>> address. To the outer world howevers, they must cooperate and use the
>>> same address at all times.
>>>
>>> This is not technically enforced, you could combine all logic
>>> in one program. In my experience, it's hard to get that one program
>>> correct and stable, and it's easier when you divide it in pieces.
>>>
>>>
>>> In the documentation, it says: "If another ECU claims the address, the
>>> kernel will mark the NAME-SA expired", how can this be checked?
>>>
>>> This is implemented in the kernel-part of j1939, which is not yet
>>> mainline.
>>> That part does interprete address claim traffic.
>>>
>>> You cannot check that from userspace, other than finding yourself
>>> blocked when using that SA. The kernel will enforce the address
>>> claiming.
>>>
>>>
>>> Do you plan to integrate the management of the claiming address 
>>> (jacd.c)
>>> into the kernel or leave it to the user?
>>>
>>> The kernel part of address claiming already exists, but is not
>>> mainlined. It enforces correct operation on the bus.
>>>
>>> The userspace part is jacd, whose only job is to choose an address.
>>>
>>> kind regards,
>>> Kurt
