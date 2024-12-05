Return-Path: <linux-can+bounces-2341-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 238769E4F8A
	for <lists+linux-can@lfdr.de>; Thu,  5 Dec 2024 09:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 925221881C12
	for <lists+linux-can@lfdr.de>; Thu,  5 Dec 2024 08:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24BF92391BC;
	Thu,  5 Dec 2024 08:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="q/0BPWdP";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="r1RKwpuW"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE8A1B2186
	for <linux-can@vger.kernel.org>; Thu,  5 Dec 2024 08:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.221
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733386622; cv=pass; b=XuU8JR3ISCkfz94GT7Y5BvOZpUOo7m2ctUD0oTqMqEdj/heASY/RRKb7lpL7UzaZz2nLFciVqnc3Z23JLSJxKgzp0DokZz6WsKeumYCS8tRQqmGSPMZ5GAm1zAz5VJ+VyjQYJvhai9ZkligtMHHa2mCUUSu54TiZcFDaRwTj/JM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733386622; c=relaxed/simple;
	bh=DdnuKFHL+SZcnXxBlM2aQehBiZm6w6xlZFhZaXitTJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DR5mFQq3WvRIf4n0dc1rMQCoUFfPjSWtMVnYbVWje1HH+yIWF5I2rW11bX5SRd9ySJwNszSHzNgr+53UQ0zr4/zl6jU2Rr8VICKpKSiIJ/hyWi37DxX79nXRT/bO6Y1nV5crwzkCYcJPXLMweRGGTNnDdo4GqYlA4/bnwudQPx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=q/0BPWdP; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=r1RKwpuW; arc=pass smtp.client-ip=81.169.146.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1733386611; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=MHBN3Tabne37e2785FrxRFd1PRqC2hm9DjdSaoJQ7HLQkIjXxeuQrOAzFRJkz/p29M
    tMH73YKAYKz+x1dY2IB7xp/0DC1AwwoK12POieqByXIZ8azJSvShHhXmyX7Is3LIhamY
    IDwdCn3MD8gsoUz72EZ4p1zBI4foAUaZHrRjTMienNwjZqD7PIp+X5sPYkQ9I1Tvx55y
    yrFJDq1RFTnjdFykPDNxY+z6DX1660vgcfYHMgWWXtxtX9mTeBmrwasb/MXnEwlWsrPh
    A4O7ASTnHF/9p5CUW1jHHcX5f3tF9TlCpVW+XpZ/4ylkT8K0j32x4atPXfka58dihq88
    XKHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1733386611;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Pch6UGJoNbap375OhxsVAEfcuE6Q8AOu2G8pteUlELc=;
    b=Jlt55KFnuQWUn4AJxYvzpQNUe0gwN1kFSih8R6wCa8+r1LNigJz5JAIhuZuDnxYwyr
    CcEkQ1feWENyDAMituNWipyOxILsxy5a4AkuJWusQRa35jcYqXP0C8lrfTmV7sGy4FS4
    +uJlHnNqkrdjSztNwNo7P05bk9AZ/hFdJziqTcjV8HHqILlQEHs5dpqhKBn5c5nC7bLY
    2lL2sKXqsGic9pnFBZOQKIt+OiZzzg1CKAsaZJrKSxcdyhiefKhhzzpvQTAyaGkhQ0GQ
    jbAZ0By3T2Ypj6KOx5RA5NDBZtqvMf7UnLztTRVn8YnfdShjGVOVtwNLQ/vm3YXib0vf
    XS1g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1733386611;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Pch6UGJoNbap375OhxsVAEfcuE6Q8AOu2G8pteUlELc=;
    b=q/0BPWdPNURK0yGUUv/aWDw5DesiEcm60y7qNlECqqshn3Crbw/twV0yOFnYdRv/Hs
    BMBKTiD91R5WEZ+A1q90Tpo2Gv4l9HaCfIvDjzmpnBVnWzYO+9avcvoOC1SwwQHe3DiG
    wgDb7UnaOirE2B9ZZK2ZDSHwDKxx7dp6C/pSfe/nbp/nb2tUAz1/GbjD7zSuphd3tkYv
    /6OVgyj2fnoi7NulUtjtXXlkn0tYVhTA1rxMMYVLKv/GmyuvaVgX+USHuDQuW+fIM37n
    7szz5DYbC8SCp8B0CE11Y6D//l89F8IQiNdh6HGBw7VvfBQO6dqajx/a74dg2Pu5ZhZh
    vNow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1733386611;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Pch6UGJoNbap375OhxsVAEfcuE6Q8AOu2G8pteUlELc=;
    b=r1RKwpuWRe37mbUEybcCfM8/59U/9FAhRGB042KIEOnZj6X5Wy60AciopEYd0IQbO6
    4oi38DWRsoNa1AAg+LAQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSXVT6pap5"
Received: from [192.168.20.116]
    by smtp.strato.de (RZmta 51.2.11 DYNA|AUTH)
    with ESMTPSA id K63ada0B58GpWjS
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 5 Dec 2024 09:16:51 +0100 (CET)
Message-ID: <aeb667e7-9a5b-4d6f-8220-ac06dbdcfe80@hartkopp.net>
Date: Thu, 5 Dec 2024 09:16:44 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 12/14] can: netlink: add CAN XL support
To: Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: linux-can@vger.kernel.org, Robert Nawrath <mbro1689@gmail.com>
References: <20241110155902.72807-16-mailhol.vincent@wanadoo.fr>
 <20241110155902.72807-28-mailhol.vincent@wanadoo.fr>
 <20241112-flashy-straight-poodle-9a796d-mkl@pengutronix.de>
 <CAMZ6RqKQLaEtgoLOAa3NHJotyHcAo=7ObXf=7tLh_DJ_QTCKOg@mail.gmail.com>
 <36b1f1cb-c431-43ad-be49-5093a3534b9d@hartkopp.net>
 <20241204-nippy-vivid-mantis-ee1725-mkl@pengutronix.de>
 <8d1cd5de-ae84-455d-8636-7f269bbfe7db@hartkopp.net>
 <20241204-mauve-asp-of-fortitude-e75174-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20241204-mauve-asp-of-fortitude-e75174-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.12.24 12:44, Marc Kleine-Budde wrote:
> On 04.12.2024 12:35:43, Oliver Hartkopp wrote:
>>>>> Also, the main reason for not creating the nest was that I thought
>>>>> that the current bittiming API was stable. I was not aware of the
>>>>> current flaw on how to divide tseg1_min. Maybe we should first discuss
>>>>> how to solve this issue for CAN FD?
>>>>
>>>> I like the current way how you added the CAN XL support.
>>>> It maintains the known usage pattern - and the way how CAN XL bit timings
>>>> are defined is identical to CAN FD (including TDC).
>>>>
>>>> Is the separation of propseg and tseg1 that relevant?
>>>> Does it really need to be exposed to the user?
>>>
>>> There are IIRC at least 2 CAN-FD cores where the prop segment and phase
>>> segment 1 for the data bit timing have not the same width. This means we
>>> have to change the bittiming_const in the kernel.

Sure?

In the end (almost) every CAN controller has the tseg1 register which 
contains prop_seg + phase_seg1 as a sum of these.

The relevant point is behind prop_seg + phase_seg1 and I'm pretty sure 
these "2 CAN-FD cores" will add the values internally too.

I'm a bit concerned that after 40 years someone shows up with the idea 
to spend two registers for the tseg1 value instead of one.

As a both values rely on the same tq can't we just split the tseg1 into 
prop_seg + phase_seg1 values with some common e.g. 70:30 pattern?

IMO changing the bittiming API has no value for the user just to satisfy 
the "2 CAN-FD cores" that came late to the party.

>>> A struct in netlink means we cannot change it.
>>
>> But are we not already in this situation with CAN FD that we can not change
>> the bittiming (const) in the userspace API?
> 
> Yes, we have to support it. But we can add a new nested type that
> serializes the individual members of an improved struct bittiming_const.
> The old user space tools will just keep working, iproute2 can be updated
> to use the new bittiming_const if it's available and fall back to the
> existing one.

Ok. Nice - but maybe obsolete due to my question above ;-)

Best regards,
Oliver


