Return-Path: <linux-can+bounces-2332-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D91F79E37FB
	for <lists+linux-can@lfdr.de>; Wed,  4 Dec 2024 11:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A725285B62
	for <lists+linux-can@lfdr.de>; Wed,  4 Dec 2024 10:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CA51B0F0A;
	Wed,  4 Dec 2024 10:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="O1YZZzWa";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="RVf/pypE"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDFB19049A
	for <linux-can@vger.kernel.org>; Wed,  4 Dec 2024 10:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.216
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733309782; cv=pass; b=h/2pRQGVPMdQzKq09qTRNDl5oHXAZ8KW8SCMtqa1KzB7XNT4VTXsH4cCW9ZhuZHsAd6ZzNMmqo1He3acpst0p+h7aI9uP1FR7c0oAyRaC3dlCLARUG6NcM1gwD5dzCJTVnp6mRvV520UnhgXXoa92tRGqxmAITkQx9nj08iMfY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733309782; c=relaxed/simple;
	bh=gPilZqZ5r6exUwXI5ZF5aweSbod2DxORlAb7DvM/sTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d9F+gdHiyx5sqq1rz9OptI02xSRvl9Fi0NCPGz3qRzAleRNNfuJJwWniYvobaUmev6eC0Vhhpjv0WXYaPtt6k1PWx2x6ZzGFQjJhfujRaMwbTvVfpNCx7ez3AgWO5sXjl2iq4hXte0sWws1pLX9xNlW7MpZNeuQ2g3gbEeGCARo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=O1YZZzWa; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=RVf/pypE; arc=pass smtp.client-ip=81.169.146.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1733309770; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=agll+Pkold+fOz+bW3hJ0kjJNnxXufpM4FyI4aZ6lw6QyT7pV9JmJCvtv4qZa+NpgS
    B5d4lWX39AKBsC8eTV9WrMdY45cbD3Evvy+ZKr985JZ81EbAR3nSx0A2RTu88SlxC6rq
    Cm50XTOOPaDxYcd/Lr+D9PEMo4XXg9byKMVDYxg9AkP9om1YCGqTnoQYuRQvqa6xZNxT
    ciEcawJhnAl+E4gHcUan92+floKMcEuLbgCgyak98EIYiVn1CO847rwJY+U0kLjKhHhI
    wKDuZSZZEw72BYT39aH+JxVnxy6BxWM+eaiJFyDYaiv7Ia/Qcc69b4lewB453Qwvrafc
    QV0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1733309770;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=1Q7dmbBoYXsug21NnKiScpp6kIMljCCovWSAhv58HG0=;
    b=YUudFsiAIUpK31wzCC+G8xulZsCigPky87px65t/I+kdSEJvw1MTC+1Q1CMutcJM45
    9Q8yv0Y6jKnwOWQkp7+ICRTZCV997c68hVCjH1fsZG/+G3iHVkFenfuP5YmGsPeTb3T2
    d5fkALcqlpTNgKX/NEhi5G/hcsoW35OcZq4XMGlq8SDYkObFtd1tTEQUlZ9qnEIMMBIR
    jFuFVv6jOhJsucBqGEEGxCUFaWDDK+prD99gWBwQ9x18Tuy02aK9d9Pn3PbofXd74Ngn
    qv1Dw0/oXkgW+bKssJnfhJz1opTNFNxWxbmdOnAcpyH1oiRju8rA53mYdj2m2/Vgb14c
    4pJg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1733309770;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=1Q7dmbBoYXsug21NnKiScpp6kIMljCCovWSAhv58HG0=;
    b=O1YZZzWaGrdconihZ3ffRTPALkLnYfrLArZu+ppJk72ne3YAZ91+GW5J1TyzAGWQiP
    cRzIzR6DCcvwEdI0ntyJ/KCYeSfD/DNoD6GWhLUWiseb1iwLlorh8Qv1cE6w/DDnn6Vk
    9d6R1nBq8ukMkLGWp6wpG+pqRBeYx6LdSwsPK0YspV+/PsUfIq7VsHZomNOs8JLKesE1
    G58HTR6MGMH4J4JuylYPvns0W0FVL+pGHypj1ZFGp5TBNhnFdbET/0aesHZpxOAYzrmH
    DRNpu/1gO0ClbgCGwaLJ84tA7IqEuZo6fW/SAXni4v8ImpnbtxVID7KRiH8yVcI7dJhQ
    J2xQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1733309770;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=1Q7dmbBoYXsug21NnKiScpp6kIMljCCovWSAhv58HG0=;
    b=RVf/pypEMlBujadSiP84lZxC6N4bVAoiEOCmE2p71zVvoUomTOBzupGHJ75QEJy2LI
    R1SDNzhCurW0tDbpqLAQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSXVT6pap5"
Received: from [192.168.10.25]
    by smtp.strato.de (RZmta 51.2.11 DYNA|AUTH)
    with ESMTPSA id K63ada0B4AuAtta
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 4 Dec 2024 11:56:10 +0100 (CET)
Message-ID: <36b1f1cb-c431-43ad-be49-5093a3534b9d@hartkopp.net>
Date: Wed, 4 Dec 2024 11:56:02 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 12/14] can: netlink: add CAN XL support
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, Robert Nawrath <mbro1689@gmail.com>
References: <20241110155902.72807-16-mailhol.vincent@wanadoo.fr>
 <20241110155902.72807-28-mailhol.vincent@wanadoo.fr>
 <20241112-flashy-straight-poodle-9a796d-mkl@pengutronix.de>
 <CAMZ6RqKQLaEtgoLOAa3NHJotyHcAo=7ObXf=7tLh_DJ_QTCKOg@mail.gmail.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <CAMZ6RqKQLaEtgoLOAa3NHJotyHcAo=7ObXf=7tLh_DJ_QTCKOg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12.11.24 09:31, Vincent Mailhol wrote:
> On Tue. 12 Nov. 2024 at 17:09, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>> On 11.11.2024 00:56:01, Vincent Mailhol wrote:
>>> Add the netlink interface for CAN XL.
>>>
>>> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>>> ---
>>>   drivers/net/can/dev/netlink.c    | 78 +++++++++++++++++++++++++++++---
>>>   include/linux/can/bittiming.h    |  2 +
>>>   include/linux/can/dev.h          | 13 ++++--
>>>   include/uapi/linux/can/netlink.h |  7 +++
>>>   4 files changed, 90 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
>>> index 6c3fa5aa22cf..3c89b304c5b8 100644
>>> --- a/drivers/net/can/dev/netlink.c
>>> +++ b/drivers/net/can/dev/netlink.c
>>> @@ -22,6 +22,9 @@ static const struct nla_policy can_policy[IFLA_CAN_MAX + 1] = {
>>>        [IFLA_CAN_TERMINATION] = { .type = NLA_U16 },
>>>        [IFLA_CAN_TDC] = { .type = NLA_NESTED },
>>>        [IFLA_CAN_CTRLMODE_EXT] = { .type = NLA_NESTED },
>>> +     [IFLA_CAN_XL_DATA_BITTIMING] = { .len = sizeof(struct can_bittiming) },
>>> +     [IFLA_CAN_XL_DATA_BITTIMING_CONST] = { .len = sizeof(struct can_bittiming_const) },
>>> +     [IFLA_CAN_XL_TDC] = { .type = NLA_NESTED },
>>
>> I haven't looked at the can_xl IP-core docs yet.
>>
>> I don't want to pass "struct can_bittiming_const" via netlink to user
>> space. It's not sufficient to fully describe the CAN-FD controllers, as
>> tseg1_min cannot equally divided into prop_seg and phase_seg1.
>>
>> Better make it a NLA_NESTED, as you did for the TDC.
> 
> I considered this point. The fact is that the code to handle the "struct
> can_bittiming_const" already exists. And so here, I am left with two
> choices:
> 
>    - small code refactor and reuse the existing
> 
>    - rewrite the full thing just for CAN XL and have two different ways
>      to handle the constant bittiming: one for Classical CAN and CAN FD
>      and the other for CAN XL.
> 
> For consistency, I chose the former approach which is the least
> disruptive. If you want this nested, what about an in-between
> solution:
> 
>    IFLA_CAN_XL /* NLA_NESTED */
>      + IFLA_CAN_DATA_BITTIMING /* struct can_bittiming */
>      + IFLA_CAN_DATA_BITTIMING_CONST /* struct can_bittiming */
>      + IFLA_CAN_TDC /* NLA_NESTED */
>          + IFLA_CAN_TDC_TDCV_MIN
>          + IFLA_CAN_TDC_TDCV_MAX
>          + (all other TDC nested values)...
> 
> This way, we can still keep most of the current CAN(-FD) logic, and if
> we want to add one value, we can add it as a standalone within the
> IFLA_CAN_XL nest.
> 
> Also, the main reason for not creating the nest was that I thought
> that the current bittiming API was stable. I was not aware of the
> current flaw on how to divide tseg1_min. Maybe we should first discuss
> how to solve this issue for CAN FD?

I like the current way how you added the CAN XL support.
It maintains the known usage pattern - and the way how CAN XL bit 
timings are defined is identical to CAN FD (including TDC).

Is the separation of propseg and tseg1 that relevant?
Does it really need to be exposed to the user?

Best regards,
Oliver


