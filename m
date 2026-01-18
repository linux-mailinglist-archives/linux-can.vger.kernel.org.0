Return-Path: <linux-can+bounces-6221-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 84565D3990B
	for <lists+linux-can@lfdr.de>; Sun, 18 Jan 2026 19:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09A783006A4D
	for <lists+linux-can@lfdr.de>; Sun, 18 Jan 2026 18:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7829F234966;
	Sun, 18 Jan 2026 18:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="NiH8oFmk";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="6NYwfTaS"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81271AF0AF;
	Sun, 18 Jan 2026 18:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.165
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768760627; cv=pass; b=cOxUN5or7QXXTIeqY8wriQ02a7gHqXk8q6HmQGOAfImY4/pQ5SToPlX5OibHsfj+XYrr/7LuIX0vmRQgyZEYLPeTMWvTufvyeorBrrtY8Di6DoYB7HeP9GhKMxwgY2SeTbE9+GUOFoIhNUKqqZsCHcwLK0B5bXZMlNhVJrHYJpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768760627; c=relaxed/simple;
	bh=DQ6w9W7+WcZkFrI98+z6jw2a4/NFaaQz0KtoAd8Esck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qjAX8u3Mky/JDMcF0Bm25rdgsoRFZ36Z/jidlweXR9hxzdEDm4QMLPqGGCQo3zA0gDL9h5bHQdeilUjlLceAtL0/1HXae9CvTFxNMc0QHEYB7MhDUsbhRIqkAQEyj/ixTzTk2zB4G3ynUdBTZGmfNJQyBUGL4PCH1MQRaK1sY8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=NiH8oFmk; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=6NYwfTaS; arc=pass smtp.client-ip=81.169.146.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1768760609; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Rdu80M40Qh2XY8N2aLFaa4ziibpvHyqpt+hTTdE3NFtVqECB3lADGFPp4uc2MUsYTj
    /YimTC1m+CYIdcRFVVI9rNhTqOa1nRO3G3f9S5Nugjr2jq/URC0yVrxrUAW5EWl7TMfp
    u+dgqUxsUDuPujePVStqCajzw3QmtVS3S2lNvEaUJQ351beV18l/tCs3w59Nat3C1adC
    AbzcwX4hXYiVsX+7QEvSk2R6P7oznPvgpKfKcWhkzCXaK/SoEpKVw7m6gH8E87caT289
    faKtyxGTWfcdkUQtr0MFG/J3PsGRs3J8hvuO8IEiVkDkXnDtzm5DaUpISKbQWgb6IGFP
    O7Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1768760609;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=QpvWstaJWmcx1e/B2PeFD0v0rEl94agJibzAkV6jqd8=;
    b=R5NKVnGLvxsnp2U7q2XjwFdSHQSwryuBIPhEdRUfdg1t1vyx3llJoftYDNxHa/8R6w
    ROQdwZseWl4XNvodxSxWNxNBLH6jm/r9H7jLmtVcAY0qo5Bl5/PWhFvoojsAEX4Dz23Q
    hAMpIyktuk8qf33DbS0c84yboGPVdQaEaW4OeSpjgxo1RUIV+wWYhAOuLmZm82exsjQE
    MYbmVUQ81ZtHtNG3EcMBEejU3SjnMI5PLEaS5Uh+EhtdrIx5bKA5wVwJdX5rBq53UTE3
    5hEUYxTKVhQVZffBWgyhjXYBEPNe5xIPfKaluMcfuv/sPMBuiM5pafzAx4ddKmiuEKQi
    qV2w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1768760609;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=QpvWstaJWmcx1e/B2PeFD0v0rEl94agJibzAkV6jqd8=;
    b=NiH8oFmkWRm0uw1eBRNWdRzjh+UDwqiq7me2I7OKkCI8KjU9e9rUl4vwdwAGKl9gCz
    iBTT7eLBgXlJQT5PkQhDXM270ZXImEAUZn/zQ4cAqA9vuVKA3xhGTXwvo9vBaWU5GDfi
    J0Su6uBag2zQ1MJ/B8VXO77srK6kPVw4rK2Y5xqPUjDz/EHVuK7EyPj8drUokEoX2b9x
    w7wUPtJ+OIV2zAseyvjCgA5DE6N0T+GeZDIXYbdJGr+ns0RdBuhOZfJ+BpknMM0K2mj+
    +inKTuhWn5QXhCZwI+1h/sgXS73feSMzrkWdrdFV4z+5Gc3BgtfsmJAygVqka3i5/BvB
    sRCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1768760609;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=QpvWstaJWmcx1e/B2PeFD0v0rEl94agJibzAkV6jqd8=;
    b=6NYwfTaS+uS0v2yyH4SAeuy4tVGgEqRpnAc9My5XN0dMv7h7+jFMlu6To2X91TBKJn
    rrjMSr5TiIbwpMuDbKAQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 54.1.0 AUTH)
    with ESMTPSA id K0e68b20IINSQTp
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 18 Jan 2026 19:23:28 +0100 (CET)
Message-ID: <6a99ce41-2200-49d7-9a6c-29e9311b46ab@hartkopp.net>
Date: Sun, 18 Jan 2026 19:23:22 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] docs: can: update SocketCAN documentation for CAN XL
To: Rakuram Eswaran <rakuram.e96@gmail.com>
Cc: corbet@lwn.net, linux-can@vger.kernel.org, linux-doc@vger.kernel.org,
 mailhol@kernel.org, mkl@pengutronix.de, netdev@vger.kernel.org
References: <5d24e045-8ede-4db1-8b0d-a6efd5037704@hartkopp.net>
 <20260118144118.27487-1-rakuram.e96@gmail.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260118144118.27487-1-rakuram.e96@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 18.01.26 15:41, Rakuram Eswaran wrote:
> On Tue, 13 Jan 2026 at 21:45, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>>

>>>    The length of the two CAN(FD) frame structures define the maximum transfer
>>>    unit (MTU) of the CAN(FD) network interface and skbuff data length. Two
>>> -definitions are specified for CAN specific MTUs in include/linux/can.h:
>>> +definitions are specified for CAN specific MTUs in include/uapi/linux/can.h:
>>
>> No.
>>   From the user perspective he has to include include/linux/can.h
>>
>> Better "MTUs in the linux/can.h include file:"
>>
> 
> Can I just incude linux/can.h or include/linux/can.h? As in the current
> document include/linux/can.h is used.
> 

If you look into the code you need e.g.

#include <linux/can.h>
#include <linux/can/raw.h>

So I would name it the linux/can.h include file.

>>
>> What about the PWM settings here?
>> When TMS is "on" the PWM values can be automatically calculated or set
>> manually. There's also no CAN XL TDC when TMS=on as the TDC is a
>> mixed-mode requirement for non-TMS transceivers.
>>
> 
> Can I add the PWM settings under new heading (CAN XL PWM) or is it fine
> to keep the content under the same heading (CAN XL TDC)?
> 

Yes. I would propose a new section

CAN XL TMS (Transceiver Mode Setting / PWM)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The Transceiver Mode Setting (TMS) switches the RX/TX lines between the 
CAN XL controller and the CAN XL transceiver into the "Fast Mode" by 
enabling a PWM protocol.

In the Fast Mode a different sample point is used and the PWM ratio is 
calculated automatically or can be set manually.

>> There's one big difference between CC/FD and XL frames when you
>> read/write it to CAN_RAW sockets:
>>
>> For CAN CC and CAN FD you write struct can(fd)_frame's with CAN_MTU
>> resp. CANFD_MTU lengths - no matter about the data length (cf->len).
>>
>> When you read/write CAN XL frames you are reading and writing the
>> CANXL_HDR_SIZE + the length of the data.
>>
>> So only in the case of writing 2048 byte data, you write 2060 bytes.
>>
>> The minimum size for read/write is CANXL_HDR_SIZE + CANXL_MIN_DLEN == 13
>>
> 
> Good point! I will add this information along with an example. I will go
> through your code and decide what to add. Does the example code should
> focus only on CAN XL frames or also on CC/FD frames?

When the CAN_RAW socket enables the CAN XL support you have to deal with 
all kind of CAN frames. IMO is makes sense to show an example that deals 
with all three types of frames.

>> Here is an example that I've been implemented recently that shows a good
>> example how to handle CC/FD/XL frames, when they are all enabled on the
>> CAN_RAW socket:
>>
>> https://github.com/hartkopp/can-utils/commit/bf0cae218af9b1c1f5eabad7f3704b88ab642e00
>>
>> Feel free to pick the code for some example.
>>
>> But please do not reference the commit as it is in my private repo and
>> not yet integrated in the official can-utils repo.
>>

Best regards,
Oliver


