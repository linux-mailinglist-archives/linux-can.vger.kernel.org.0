Return-Path: <linux-can+bounces-5464-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D9CDAC63CA5
	for <lists+linux-can@lfdr.de>; Mon, 17 Nov 2025 12:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 988BC4E11FE
	for <lists+linux-can@lfdr.de>; Mon, 17 Nov 2025 11:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C24C27280F;
	Mon, 17 Nov 2025 11:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="FPdRGToF";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="/+GatdgA"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C7424503B
	for <linux-can@vger.kernel.org>; Mon, 17 Nov 2025 11:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763378739; cv=pass; b=Iv/Xpv8MYdNwOv+ZoXsM0ULyD98/6uASQ/UQdjiFNh8djRW2QmCiv3mzfYuA+t1Vohuz9/BaFEUIsuu1qnN9C1e7Xodc0nBApkPITocPQXKu8D0xguW1UsHGh8GVo4gPs5+oExvIrpr06LNvEBMz8/2k/+qZ98KJ4eB6bmRsmx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763378739; c=relaxed/simple;
	bh=r+0JvBIT/TlAhMrKVx9m0cOPNI1xMi9WqRfuqUxY22I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nGrT5FOBxVTlM31DKdVGfEKT0nnEScVOpskTu4OaTjyBKPgx4B5NRfAi2hZaJ5MJW21WRi3loiWnxNLDcFiAcAVt410Eo6c7N/8GQPI2hyDvKEyOf/I8XksQNQwYsFLeD1ffaHFGNX7zjZJsrpsDpdjkbMYDyEv8sbdPa8NFjk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=FPdRGToF; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=/+GatdgA; arc=pass smtp.client-ip=85.215.255.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763378728; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=aiiUPBHe/mxBxIlOUKQPVS86W0j5577JxzmDSybjMHMoVbem2NaBAMBq+Vt8x31VlW
    oKuxWoxsXBEqY6c7Qu6+SWxyOcPi51etQyMdE5+bErl2qkPP5JW7J8OTdpu7dzvY6RMt
    LXNwty+MKPaujHFS6zWDi15K4Gsj+aD+4Xue1bAtejmDADLVcuZDojWMDXCWFNk8J1Lp
    hjJ3pOkYPNbs7F/8Kv+LhbEbJ5Nv/unaYjFaD6H0PwzgatkdmVVz0C6BhefZjfHXBiYw
    eXUP67pw+CKN3+osu2dL4uYE2AdiyYrQbw2Ppk63nb1fCVFMxvJXWci4pMxiJfuLOnb9
    bKiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763378728;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=akeZzU5a6HVgmHW9oInDZxzxo/3ppuT8PIz0OadA2oI=;
    b=FjI4A1MnOmusPfHMCW7WUxjirEA0/SJywKBiCMkjIPHUcxFnO/jjMqHo4sf8Utc9DR
    RCnowTvfGm+J5I3whxfuvz60Xm3esTog5c26meSDHzMocBher5xVi+uOow7TB4CkMe39
    auYzZcLt9JNm/OZd0Lf/heCg7JZnt+1IHHtiClTtww7pEvQ3oX4oUcDr+LvG7yblQn+R
    OdY+rF3Vo++G8QF9UHzWVw8FkyiQ++Hvmbb59QLi+4MKaTGDfNcUqWUgcuFkUCprSKZj
    OsbA8Sfkshendrgeq8CcQCqjL3kXhQDFph+CCLz43ejbdjMjMMLS/R//u8vcVdMQz3hl
    nMtQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763378728;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=akeZzU5a6HVgmHW9oInDZxzxo/3ppuT8PIz0OadA2oI=;
    b=FPdRGToFtEP9VeJaOdcEwgAjqz+R42RFN8FxRzhiKCX4Of7w/7XAZYdCDH/XIQBYPI
    rjq+/cTmN/xYAW1FW9px8PTiWu165Ruy4xHQBLT4PM2SrNeww2SqdrMUgeR9A02jkLad
    O14visyNq9Kh2rZOoikRuXF737hp4nBjLBatlOA7J7QGkMFfKpLyDXcf5qXDxN9SxJtc
    +FB9x99HYHb65z7d+AdZ4vdlS6mVBVjpiMVu3scT7+KmetE0Hj+UobCzoP1ZpSY7mXtn
    vFKdZgcsmUEu6bLcNpGzJnE39QZ10KjZB9y101nTs6D/Gs5XFTcSVee8mYyu8Uf0yHDK
    d4Gw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763378728;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=akeZzU5a6HVgmHW9oInDZxzxo/3ppuT8PIz0OadA2oI=;
    b=/+GatdgAs7PUHzXm6bIrxKJnZoJnI/7AWUlrniwNUxrPLYuAsz6GVOgNR9zYf/XkUw
    cWg1ieP7dkQ05Pt4c1Cg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AHBPSlec
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 17 Nov 2025 12:25:28 +0100 (CET)
Message-ID: <f720f2fc-b224-46ab-89b1-24cff40a4927@hartkopp.net>
Date: Mon, 17 Nov 2025 12:25:28 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RFC remove CAN_CTRLMODE_XL_ERR_SIGNAL
To: Vincent Mailhol <mailhol@kernel.org>,
 =?UTF-8?Q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>
Cc: linux-can@vger.kernel.org
References: <84cb473f-be5b-464b-a5d9-10c6f643f145@hartkopp.net>
 <ee2ecbeb-eb88-45a5-b13d-0616383e0987@kernel.org>
 <13906d6a-34be-47ff-bedf-c25a2d755aba@hartkopp.net>
 <67564299-c929-4eed-991c-90c311d6b90d@kernel.org>
 <61f731ac-3876-45e8-a5dc-6cfa24f2739d@hartkopp.net>
 <48fae6ee-94cf-444a-a6f1-53dc6fb44c34@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <48fae6ee-94cf-444a-a6f1-53dc6fb44c34@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Vincent,

On 16.11.25 22:34, Vincent Mailhol wrote:

>>> Did you try those?
>>>
>>
>> For what reason? This is a detail of how Bosch creates their filtering but has
>> nothing to do with what makes sense on the bus.
> 
> The reason is that we are discussing how to deactivate CAN FD on your device
> when it is in mixed mode and it appears that your device has a CAN XL specific
> feature to filter out CAN FD frames.
> 
> Why does your device have a CAN FD filter which can be used only under CAN XL
> then? If it is not to disable CAN FD under mixed mode, what is it for?

You are mixing layers what can be sent on the bus and what the 
applications needs can filter for. If you don't want to 'see' FD 
traffic, you can set such a filter like blinding sunglasses. See details 
below.

>>>> This setup covers all Bosch use-case slides and Bosch CAN XL IP core
>>>> documentations (e.g. with the 1.5.5.3 Operating Mode table).
>>>
>>> You are referring to those slides, right?
>>>
>>> https://www.bosch-semiconductors.com/media/ip_modules/pdf_2/
>>> can_xl_1/20230717_can_xl_overview.pdf
>>>
>>> I see in slide 16:
>>>
>>>     Error Signaling: Software Configurable: ON/OFF
>>
>> Yes. Of course! As CAN XL can be used in mixed-mode together with CAN FD and in
>> CANXL-only mode. And for those two cases you need to set that bit in the
>> controller accordingly.
>>
>> But you are mixing different thing here:
>>
>> 1. The API to configure CAN FD and CAN XL in Linux
>> 2. The API of the CAN XL controller
>>
>> Item 1 is on a different level.
> No, 1. and 2. are on the same layer. It is just that 1. is an abstraction of 2.

No. And this is the problem in our discussion, why you think you must 
modify the err-signal configuration bit from the user-space.

The netlink API is not transparent. It is designed to configure various 
CAN controllers with multiple features. And it is an abstraction, 
because different CAN controller specifications use different wordings, 
have different restrictions, initialization sequences and features.

The task is to design an interface, that is not CAN controller specific 
but supports the CAN standards requirements and communication modes.

So when a Bosch IP core provides CAN standard features that are also 
provided by a PEAK IP core and both are officially ISO 11898-1:2024 
certified, then this is the intersection of features we need to provide 
and control.

The tests performed through the certification process are the real 
benchmark for our netlink API.

> Also TMS and error signaling are at the same layer so if error signaling is only
> at 2., where does TMS configuration go?

With the error-signalling bit you permanently insist on the direct 
manipulation of the bit in the CAN controller (from user-space). But if 
there would be a direct manipulation of Bosch's FDOE bit with our 
CAN_CTRLMODE_FD flag the CAN XL-only mode (and TMS) would never work.

That's the proof that there *is* an abstraction and the netlink API is 
definitely different to the Bosch controller API. Therefore the items 1. 
and 2. are *not* on the same layer.

Agreed?

So let's see what the intersection of ISO 11898-1:2024, the Bosch X_CAN 
IP core and the PEAK CANXL IP core looks like. Then this is what we need 
to support. Happily I have both of them on my table.

The required CAN protocol modes are built as follows:

FD=0 XL=0 CC-only mode         (ES=1)
FD=1 XL=0 FD/CC mixed-mode     (ES=1)
FD=1 XL=1 XL/FD/CC mixed-mode  (ES=1)
FD=0 XL=1 XL-only mode         (ES=0, TMS optional)

The XL-only mode is the only mode which has ES=0. In this mode no CC/FD 
frames can be sent or received. Ignoring this restriction leads to an 
"invalid frame format evt" in the Bosch X_CAN controller.

If you want to use the CAN XL protocol with error-signalling you need to 
select the XL/FD/CC mixed-mode. This mixed-mode is intended to have 
(XL-tolerant) CAN FD nodes and CAN XL nodes on one CAN segment, where 
the FD-controllers can talk CC/FD and the XL-controllers can talk CC/FD/XL.

As the intention of this mode is a hybrid FD/XL network, the CAN FD 
option is always enabled in the Bosch X_CAN and the bitrate 
configuration register for FD is used and therefore has to be valid.

If you don't want to 'see' specific CAN protocols you might filter them 
away. But on the CAN bus all three XL/FD/CC protocol frames are allowed. 
You might misconfigure the FD bitrate if you enjoy it.

The above "required CAN protocol modes" table is the intersection of ISO 
11898-1:2024, the Bosch X_CAN IP core and the PEAK CANXL IP, what we 
need to support with the netlink API:

We only need

- CAN_CTRLMODE_FD
- CAN_CTRLMODE_XL
- CAN_CTRLMODE_XL_TMS
- CAN_CTRLMODE_RESTRICTED

to configure/control the new CAN XL support. The error-signalling bit in 
the CAN controller API level can be derived from the XL-only mode.

Back to your last question:

> And one more time, why do you want to send FD frames when FD is off? It is
> *normal* to get errors when receiving FD frames while FD is turned off. If FD is
> off, there should be no FD nodes on the bus, period. Everything else is bogus.
> 
> This is really what I can not understand in your reasoning.
The answer is: There is no "FD is off" in the XL/FD/CC mixed-mode. And 
if you want CAN XL with error-signalling you have to take FD as a bundle.

Best regards,
Oliver


