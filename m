Return-Path: <linux-can+bounces-2334-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1CF9E38FE
	for <lists+linux-can@lfdr.de>; Wed,  4 Dec 2024 12:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55595168AC8
	for <lists+linux-can@lfdr.de>; Wed,  4 Dec 2024 11:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC151B3929;
	Wed,  4 Dec 2024 11:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="RhslQj/Y";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="jCyc20Nm"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6111B81B2
	for <linux-can@vger.kernel.org>; Wed,  4 Dec 2024 11:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733312149; cv=pass; b=TBmjMI3qm2SOTz97PYJAQTHMd1TXV6tBwdlLV23F3mKUtXbgYjRqWWDM5LBxnfvLM416SRXS2gPEg2Qi/2iTTajFNBImekspIlVcIqMSta4ddpKfRc5lVYk8zfXhi7vuKZRi/Igup6M3djEg+AYVEUY8C21nXouYkip0SR2vW5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733312149; c=relaxed/simple;
	bh=gzm1FRgjd6dpgHArH3nKRYgQ+ISGKrO2039cff6YzT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BF2NbSURZQBW1n9PPI/JAptbfABdoiQ+jDhn3o1bOOTf0Te49Mb+ckgmwbq+HfVaoCLIwDV3gkfNS3N+mscVkfbYaX7poyu+ipebbrTraHX5YFOCA9myaSwsqXJLUuXEe1uPb6DUtWfh5dQv2pWg9dnUIsOv3zqc3KGEDJu0LJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=RhslQj/Y; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=jCyc20Nm; arc=pass smtp.client-ip=85.215.255.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1733312143; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=AIOjcJ4iR+ci5dlh33Jux0dik0Wflwt3ZM7dYgKaokMPRnu4rzYsr/Eu121wgI+hy7
    kGlGHh2yl9iJPfEd5QrQuc4WJ2v2TEhBjrwrX1gID1+b25ntJG7PUee+qiJfYzDl6CTW
    Xo5hUmqYVykN03k+VSuLFH8PrgJKwd+B0gKruvi63ItHnpxJeXLOKO/nPXtixgDnRSce
    ytPQ3Pdt4IV0GlIUJBJy8fSMdD1ZP33WLUQlvm4GR/gRdKN3vdTj7fnvJuxlRXM59svS
    V4rZgrfV53OYWqnXiLLQW0WCKkPNmNuVtStydnQbuUhm+hUeq/UaTkYQhRcypVCYrhT5
    J2XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1733312143;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=OqR9r1CYnEsGD6XX0FzubM9EZy9prOq4tsVE4M9yacw=;
    b=ADXENV+q4kYV5XuA1V9cqrNtH093oqPc1CEiCGmxSeZGbqwx+HlDv6yCvDfKCAwcwK
    1aJqz52B+HXVbu0JjyrsH7Cyg7xWqXmJ7vtZacwh/bR7PYu1nptA/ZhoF+vA3eGSYaBE
    f23S979vDpRaGP0wOLHslHijDed/UNvaobE+bDXjnx39tGK5Y/2HsmCrjTZzgM+wYLrM
    G/QIu7div1tlOxUeDsjh5zGZrnSuXXIHMWOP4l3tl0NSI7ihqlGU5zEcVHfh9Z3GlQWu
    klRZUtD6v7F4oKj37Ez+TRv+hBO8b5bBswtx7QYQBWo3233/C0nLMPOH+xEuqODMlS6f
    iu2w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1733312143;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=OqR9r1CYnEsGD6XX0FzubM9EZy9prOq4tsVE4M9yacw=;
    b=RhslQj/Y1EjRIGwsp0vLq80RKl/Sk3/5hM0yTh0AidupxdleWFIy34HxXazQOtaIcp
    ZUvZAffvgep2AYypgeQpjb2qpgTuBMlL6euYCsrufCGzWFJ6iFmDjgiqurEAQ8y958hw
    fPkhtQhZROaSFmq5sBY0pD1/epFxfRU+6CLlA7fux33xJHv8brWMNn7eC8002Ep1zFrZ
    9LElNWRM64O2AYflDhpXKyZJiW1JOP5qI1O/R/e+VZTR2ekone6+RzYqWAyRzRMTuznB
    1qq8EYFfahcIWoEFnz1N8P5wB+WnSMGwTnZIUg8oOqXXMqiyoIzrEJN/8e4Lxe+0sS6g
    FdFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1733312143;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=OqR9r1CYnEsGD6XX0FzubM9EZy9prOq4tsVE4M9yacw=;
    b=jCyc20Nm3wp/26nnAoSF9L7N3xG3W8i/6V8WVfi4k9yN0uugQx3v8WKnfG4Dk+xSSh
    n079nIUJGFFnoGEkDTBQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSXVT6pap5"
Received: from [192.168.10.25]
    by smtp.strato.de (RZmta 51.2.11 DYNA|AUTH)
    with ESMTPSA id K63ada0B4BZhu7x
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 4 Dec 2024 12:35:43 +0100 (CET)
Message-ID: <8d1cd5de-ae84-455d-8636-7f269bbfe7db@hartkopp.net>
Date: Wed, 4 Dec 2024 12:35:43 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 12/14] can: netlink: add CAN XL support
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, linux-can@vger.kernel.org,
 Robert Nawrath <mbro1689@gmail.com>
References: <20241110155902.72807-16-mailhol.vincent@wanadoo.fr>
 <20241110155902.72807-28-mailhol.vincent@wanadoo.fr>
 <20241112-flashy-straight-poodle-9a796d-mkl@pengutronix.de>
 <CAMZ6RqKQLaEtgoLOAa3NHJotyHcAo=7ObXf=7tLh_DJ_QTCKOg@mail.gmail.com>
 <36b1f1cb-c431-43ad-be49-5093a3534b9d@hartkopp.net>
 <20241204-nippy-vivid-mantis-ee1725-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20241204-nippy-vivid-mantis-ee1725-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 04.12.24 12:15, Marc Kleine-Budde wrote:
> On 04.12.2024 11:56:02, Oliver Hartkopp wrote:
>>
>>
>> On 12.11.24 09:31, Vincent Mailhol wrote:
>>> On Tue. 12 Nov. 2024 at 17:09, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>>>> On 11.11.2024 00:56:01, Vincent Mailhol wrote:
>>>>> Add the netlink interface for CAN XL.
>>>>>
>>>>> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>>>>> ---
>>>>>    drivers/net/can/dev/netlink.c    | 78 +++++++++++++++++++++++++++++---
>>>>>    include/linux/can/bittiming.h    |  2 +
>>>>>    include/linux/can/dev.h          | 13 ++++--
>>>>>    include/uapi/linux/can/netlink.h |  7 +++
>>>>>    4 files changed, 90 insertions(+), 10 deletions(-)
>>>>>
>>>>> diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
>>>>> index 6c3fa5aa22cf..3c89b304c5b8 100644
>>>>> --- a/drivers/net/can/dev/netlink.c
>>>>> +++ b/drivers/net/can/dev/netlink.c
>>>>> @@ -22,6 +22,9 @@ static const struct nla_policy can_policy[IFLA_CAN_MAX + 1] = {
>>>>>         [IFLA_CAN_TERMINATION] = { .type = NLA_U16 },
>>>>>         [IFLA_CAN_TDC] = { .type = NLA_NESTED },
>>>>>         [IFLA_CAN_CTRLMODE_EXT] = { .type = NLA_NESTED },
>>>>> +     [IFLA_CAN_XL_DATA_BITTIMING] = { .len = sizeof(struct can_bittiming) },
>>>>> +     [IFLA_CAN_XL_DATA_BITTIMING_CONST] = { .len = sizeof(struct can_bittiming_const) },
>>>>> +     [IFLA_CAN_XL_TDC] = { .type = NLA_NESTED },
>>>>
>>>> I haven't looked at the can_xl IP-core docs yet.
>>>>
>>>> I don't want to pass "struct can_bittiming_const" via netlink to user
>>>> space. It's not sufficient to fully describe the CAN-FD controllers, as
>>>> tseg1_min cannot equally divided into prop_seg and phase_seg1.
>>>>
>>>> Better make it a NLA_NESTED, as you did for the TDC.
>>>
>>> I considered this point. The fact is that the code to handle the "struct
>>> can_bittiming_const" already exists. And so here, I am left with two
>>> choices:
>>>
>>>     - small code refactor and reuse the existing
>>>
>>>     - rewrite the full thing just for CAN XL and have two different ways
>>>       to handle the constant bittiming: one for Classical CAN and CAN FD
>>>       and the other for CAN XL.
>>>
>>> For consistency, I chose the former approach which is the least
>>> disruptive. If you want this nested, what about an in-between
>>> solution:
>>>
>>>     IFLA_CAN_XL /* NLA_NESTED */
>>>       + IFLA_CAN_DATA_BITTIMING /* struct can_bittiming */
>>>       + IFLA_CAN_DATA_BITTIMING_CONST /* struct can_bittiming */
>>>       + IFLA_CAN_TDC /* NLA_NESTED */
>>>           + IFLA_CAN_TDC_TDCV_MIN
>>>           + IFLA_CAN_TDC_TDCV_MAX
>>>           + (all other TDC nested values)...
>>>
>>> This way, we can still keep most of the current CAN(-FD) logic, and if
>>> we want to add one value, we can add it as a standalone within the
>>> IFLA_CAN_XL nest.
>>>
>>> Also, the main reason for not creating the nest was that I thought
>>> that the current bittiming API was stable. I was not aware of the
>>> current flaw on how to divide tseg1_min. Maybe we should first discuss
>>> how to solve this issue for CAN FD?
>>
>> I like the current way how you added the CAN XL support.
>> It maintains the known usage pattern - and the way how CAN XL bit timings
>> are defined is identical to CAN FD (including TDC).
>>
>> Is the separation of propseg and tseg1 that relevant?
>> Does it really need to be exposed to the user?
> 
> There are IIRC at least 2 CAN-FD cores where the prop segment and phase
> segment 1 for the data bit timing have not the same width. This means we
> have to change the bittiming_const in the kernel.
> 
> A struct in netlink means we cannot change it.

But are we not already in this situation with CAN FD that we can not 
change the bittiming (const) in the userspace API?

Best regards,
Oliver


> It makes IMHO no sense to
> me to add any new structs into netlink, especially if we know the
> bittiming struct is going to change.
> 
> regards,
> Marc
> 


