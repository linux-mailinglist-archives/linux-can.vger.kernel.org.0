Return-Path: <linux-can+bounces-2347-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 802239E96B3
	for <lists+linux-can@lfdr.de>; Mon,  9 Dec 2024 14:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 434AD18882DF
	for <lists+linux-can@lfdr.de>; Mon,  9 Dec 2024 13:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083391ACED6;
	Mon,  9 Dec 2024 13:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="cMI0x44f";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="N2NdDhhJ"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B617233158
	for <linux-can@vger.kernel.org>; Mon,  9 Dec 2024 13:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733750212; cv=pass; b=chNYHCpahLg+SusKVKLwG2ocYmucfhtgwOmPUjI1y/rm/KxGyU7QE2nn4EcWGam290eUEE9g4l9iKcE7e7cJOmvlUh9ovkRBoA94JKUNr3a+ws1hdXZJ9YjYBEnlGnelrVnrSUtXSclNKi4N359j4S/+aEeBJRWrNHsVqypcULg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733750212; c=relaxed/simple;
	bh=t9Nx3x2Frvhn1A6cPXnun/tSoKwrWmJJX3IlsPB/4v8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JyoaFEqe257vlqT2Kthh+FtkUEa/Qeu45pHrL2I3TB5DcOxOIeIx/OTl6jwdXf4NHKXC/Ggtbr5SvtXMXNbC8Kc4wkFnuYZw40Q/K6jvs3JyicNFjmU+MZaXx2cHqJIDK7OSdwOHY+ya5g+1YnENlm22DpIspCoIAbTVkWPrAOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=cMI0x44f; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=N2NdDhhJ; arc=pass smtp.client-ip=85.215.255.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1733750015; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Oez4IcLszDu5RD+TDmZYi4LADHsNFoXgAt5sRIO8gN1b3TngVu2p4OX075vGVfgkvc
    JN865PjIcpkvtDVdkN4ntCNjnX7U2r2K7tNTgwU81kV5H2vDKy7xw/nhTna77wkz3KDs
    SG6VS5UrNUh3u2ZvJqMeb7Xt7kfyBvJ164SnGYe7rbftx5N5mC7D26qPOkm9Wijgn83C
    Ojpl+mIGWTsbA3hBc9TTxeAIo7aq336bZftT09faO2ZJsz/4Qaqor5C3tdfI/hulOAuF
    hLTByVciQrUn4nKZ0UGS6i/WLSnJDWiDXSQicei03oPV9KSVVc1xMS+Gwpa3X6TE2LnM
    7X6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1733750015;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=17GQjiCgiTJroWR1qJTL0YxUHyG3zTcMMtkH4qjVCPA=;
    b=m8luE0ANsGSjob6Ha5kxWCheMyj8x8X3FcrE0aDIJQHihadb+22R4oT3c6UXKn3RtS
    IbDVcfhkpPJdXgYd5IrbkmnzEhvtGtpIOTyf1HPrwPvS8lzvcx2s85h8wYF5xEyyXHNm
    LBkzTHiS6S+5uM3lpyR7GdCevi2CSMy2OjVid/FLamOgbur03kUcnhaLAuUTBWwdQml5
    cPNzi9B5CaEhFctKHEbPi1RpQLW6F+kWd77HCxVe2o0Oz32YeTXCqbkjVdj5OF2xyIHN
    2NZQ8dIWbwhUwhk33xELfkrx70VDU29te5JBfPAs+byhQJVYvvCp63U2dcI7+sr0ZlOO
    jl5g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1733750015;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=17GQjiCgiTJroWR1qJTL0YxUHyG3zTcMMtkH4qjVCPA=;
    b=cMI0x44frUc6VFwOvSPJ8ZddX0HPJhwNV12bhG6tCK+rBrhRqKtedk9J+oqZQTrukX
    Oeth8q2May3K2oqt7IEV/kZOHseVk6eqAmGabim0gTUQgwYu8qrgq4/j96gB8kw1rjoX
    IIIh0GW7OxoUi5PQDY22dVue4in0yXGqzCWw7swwfpeWfAnIC2WHQTWsx0aCSBPkSD8p
    M27OC91NDRatgUUP/jnRexSTDAz7hV2lB19SAkqLVb18bSDyEMASuQZcwu4HiT5U7W2a
    xGKQ9fiiq8eOJRu/olaYZ+RxeTTczcA9YGz9LRZlBG+IXkQTjUgglPygOPGEAy90reCc
    ISHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1733750015;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=17GQjiCgiTJroWR1qJTL0YxUHyG3zTcMMtkH4qjVCPA=;
    b=N2NdDhhJ/KTOzo65gO3QKHfKDqDmTXviYq3Fn5GdlLkr1DMdkZYknImLktJy5BXw0l
    YUPlT6S7HknyJO4NFmAw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/vMMcFB+5xtv9aJ67XA=="
Received: from [IPV6:2a00:6020:4a8e:5000::9f3]
    by smtp.strato.de (RZmta 51.2.11 AUTH)
    with ESMTPSA id K63ada0B9DDZBf5
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 9 Dec 2024 14:13:35 +0100 (CET)
Message-ID: <572d0fa8-e9df-4047-951f-2747571086db@hartkopp.net>
Date: Mon, 9 Dec 2024 14:13:29 +0100
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
 <8d1cd5de-ae84-455d-8636-7f269bbfe7db@hartkopp.net>
 <20241204-mauve-asp-of-fortitude-e75174-mkl@pengutronix.de>
 <aeb667e7-9a5b-4d6f-8220-ac06dbdcfe80@hartkopp.net>
 <20241205-archetypal-stirring-kakapo-407537-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20241205-archetypal-stirring-kakapo-407537-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 05.12.24 10:15, Marc Kleine-Budde wrote:
> On 05.12.2024 09:16:44, Oliver Hartkopp wrote:
>> On 04.12.24 12:44, Marc Kleine-Budde wrote:
>>> On 04.12.2024 12:35:43, Oliver Hartkopp wrote:
>>>>>>> Also, the main reason for not creating the nest was that I thought
>>>>>>> that the current bittiming API was stable. I was not aware of the
>>>>>>> current flaw on how to divide tseg1_min. Maybe we should first discuss
>>>>>>> how to solve this issue for CAN FD?
>>>>>>
>>>>>> I like the current way how you added the CAN XL support.
>>>>>> It maintains the known usage pattern - and the way how CAN XL bit timings
>>>>>> are defined is identical to CAN FD (including TDC).
>>>>>>
>>>>>> Is the separation of propseg and tseg1 that relevant?
>>>>>> Does it really need to be exposed to the user?
>>>>>
>>>>> There are IIRC at least 2 CAN-FD cores where the prop segment and phase
>>>>> segment 1 for the data bit timing have not the same width. This means we
>>>>> have to change the bittiming_const in the kernel.
>>
>> Sure?
> 
> I'm sure the registers don't have the same width. And I'm sure about my
> conclusion, but that's up for discussion :)
> 
> https://elixir.bootlin.com/linux/v6.12.1/source/drivers/net/can/ctucanfd/ctucanfd_base.c#L197
> https://elixir.bootlin.com/linux/v6.12.1/source/drivers/net/can/flexcan/flexcan-core.c#L1210
> 
>> In the end (almost) every CAN controller has the tseg1 register which
>> contains prop_seg + phase_seg1 as a sum of these.
> 
> Some do (just a short grep): bxcan, esdacc, rcar_can, softing, hi311x,
> ti_hecc. More controllers haven evenly divided prop_seg + phase_seg1.
> 
>> The relevant point is behind prop_seg + phase_seg1 and I'm pretty sure these
>> "2 CAN-FD cores" will add the values internally too.
> 
> As the ctucanfd is open you can have a look :)
> 
>> I'm a bit concerned that after 40 years someone shows up with the idea to
>> spend two registers for the tseg1 value instead of one.
> 
> It doesn't matter if prop_seg and phase_seg1 are in the same register or
> not, what matters is:
> a) 1. does the IP core want separate prop_seg and phase_seg1 values
>     - or -
>     2. does the IP core want a single "prop_seg + phase_seg1", a.k.a.
>        tseg1 value?
> b) 1. what's the width of the prop_seg and phase_seg1?
>     2. what's the width of tseg1?
> 
> Currently the CAN infrastructure allows the driver to specify tseg1 only
> and assumes the width of prop_seg and phase_seg1 to be the same, as it
> distributes tseg1 evenly between prop_seg and phase_seg1:
> 
> https://elixir.bootlin.com/linux/v6.12.1/source/drivers/net/can/dev/calc_bittiming.c#L155
> 
> This leads to the workarounds in the CAN drivers, see above for links.

Yes. But why don't we just let this as-is then?

Even if prop_seg phase_seg1 registers have a different size, this split 
up can be done easily without changing the current bittiming API.

Maybe a common helper function to split up the values based on given 
register sizes could simplify the handling for those CAN drivers.

I'm still not convinced that it brings some benefits for the user to 
extend the bittiming API. IMHO it just complicates the bitrate settings.

Best regards,
Oliver

>> As a both values rely on the same tq can't we just split the tseg1 into
>> prop_seg + phase_seg1 values with some common e.g. 70:30 pattern?
> 
> We currently split 50:50 (hard-coded).
> 
>> IMO changing the bittiming API has no value for the user just to satisfy the
>> "2 CAN-FD cores" that came late to the party.
>>
>>>>> A struct in netlink means we cannot change it.
>>>>
>>>> But are we not already in this situation with CAN FD that we can not change
>>>> the bittiming (const) in the userspace API?
>>>
>>> Yes, we have to support it. But we can add a new nested type that
>>> serializes the individual members of an improved struct bittiming_const.
>>> The old user space tools will just keep working, iproute2 can be updated
>>> to use the new bittiming_const if it's available and fall back to the
>>> existing one.
>>
>> Ok. Nice - but maybe obsolete due to my question above ;-)
> 
> regards,
> Marc
> 


