Return-Path: <linux-can+bounces-4525-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95571B49232
	for <lists+linux-can@lfdr.de>; Mon,  8 Sep 2025 16:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37DB518946DC
	for <lists+linux-can@lfdr.de>; Mon,  8 Sep 2025 14:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7117630C633;
	Mon,  8 Sep 2025 14:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="hmg9VXIk";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="7Ki6fehZ"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E5712DDA1
	for <linux-can@vger.kernel.org>; Mon,  8 Sep 2025 14:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.163
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757343560; cv=pass; b=Xa60E+P6sbmcCjdwuUDRsVOKiJj44ZFXt6P5VXHzM23iLN9srTxvvVh0hyPHxVJmpH15UMUT5bfHZfOUwCVW3jiBUi8OIWW/JlrQ3nfCnTSMuWq7CoNlQ+qeEOBDd9Cda5cX2lrDehCuat4bDQn117a8DSGeAF/du5SlOBPVLV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757343560; c=relaxed/simple;
	bh=qTcnIZurWKvIRoWzyM26ts6E+mQAon9lZAO+q+whOpY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RVuEptxn8ftri15eMdDUjPyX0Tg7fZIpTqm3HCiB197byxCF7q5cVeDLWdZPIRkeMjSjGfnLWIPIRiK+nGgJBRSpKGwV/oq9N3VBWyXXR5DLiD1xvgr4KC8dB9IZR5cKIfwybz+mrOB/D32ZTC8KRo00J+VdR2JwKU1re5DOzAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=hmg9VXIk; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=7Ki6fehZ; arc=pass smtp.client-ip=81.169.146.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1757343554; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Es5jCMwa5o/vbbKlP8coN8J7pIahz7Sv0+jjsusUUCmZ70ziebgItTm+AspKBfsTFt
    ewGJ2ILc+KPXJVZV3AWXu9DJxcyk1qkgFoWtk7Scg3lc9CsE1An3aankKAv/1uh3JR1b
    Ifp8elHNGio5nJr2va23w2YBSGu9nIVXfh1I5b5ngj95shxEmPBoMw/rg4DbCKOVDYaz
    Id/3vC317rEzsOv9o/TiXcHIRoUnKi0QxbczNyHN2frgEGHVxpDrjpGgnINIaBsibsLQ
    lVFSa3+knw+EK+TBrbB0Qp6rH9Dp/JrdAv2+0F/cfcn888rpLMsQNQvA/Rq27b0E4v53
    GxyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1757343554;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=rxQDlDd36328QmDHpuA8rU42xLoZDW54ov0I8tElm4c=;
    b=ii55eT3TeLtwZRTtfP+X4040CuvdkBVFIQpiPv0YLExmZPLpmZKEzrwOIEZGKdiACF
    OIIf9NAjb5ad8e7Cgux/IGyZNPtcdnh453EVhaNbl9ShBv2WC396fqmnHi+5yiPl3qAZ
    vWbjk8E88SLTmEQ1MrxQmSmH16WUvXAjxNVbj5xbsMK8fXp9K0X5nBLDNtn3x1BaswKY
    AIFzesF5zKZhuDueRO5434+YccloV8GLC6PlpiivuvxHp8RQDfFFFWbfLOorx7C9RcsC
    iwhtyw8reKWmiHXN4HhP3wCkKIijfETkLwalnobAr0jct6pmEeGUNfwyG4UT0X/XmoQU
    emSg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1757343554;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=rxQDlDd36328QmDHpuA8rU42xLoZDW54ov0I8tElm4c=;
    b=hmg9VXIkid8uGgWi4SSjptFUXrLP8CSaqzTbW74zsN2abgtMGIiMmZD2BMB/NrQcQH
    KJaQ//KaunMVpiQuIJcbyE5CO+0x1CLuG41MU93CykxpaMHzl8tMJqXxgtp6zB70CYiR
    q3HcczuGI80hCK6s3+xw0yFZE2TvicQvT88IvO2fXlvXhsjSlEsBnIBhqJzt9Pt5b6RL
    aq6GS5aEH3urU3/+sSBW6UIzS/kDdO9Kx7bXurifJy/aDwnoYa7ev2818W/o3Nw1eJlh
    R8OLKRA9V8R8PIN41bgvTpdxq2cWtShhxQvixRmhMDY8svkvi3wJ8sLdYOjm+hX1M2ju
    Kj5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1757343554;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=rxQDlDd36328QmDHpuA8rU42xLoZDW54ov0I8tElm4c=;
    b=7Ki6fehZDwXZ2DixBiCRmnaAzzCMjTO0EEF4aRXV3jbXgCDWICxW18b3wpZ/outGmL
    clpkXDlhbl2EscNrOLCw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 52.1.2 AUTH)
    with ESMTPSA id K5d361188ExEafZ
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 8 Sep 2025 16:59:14 +0200 (CEST)
Message-ID: <fc1dfbf6-33e1-47a1-943d-806f146c5be6@hartkopp.net>
Date: Mon, 8 Sep 2025 16:59:08 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] can: dev: can_dev_dropped_skb: drop CAN FD skbs if FD
 is off
To: Vincent Mailhol <mailhol@kernel.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org
References: <20250907080504.598419-2-mailhol@kernel.org>
 <49e0970f-1a10-438f-b9ae-afcc75edaccd@hartkopp.net>
 <5edbe004-767f-4a41-9454-f4bbf8f5b590@kernel.org>
 <4e380c2b-f48d-4bd5-bc8d-3bfd85fc0d2f@hartkopp.net>
 <cc56cf68-49d4-4c94-844c-ec413307dedf@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <cc56cf68-49d4-4c94-844c-ec413307dedf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 08.09.25 15:30, Vincent Mailhol wrote:
> On 08/09/2025 at 18:00, Oliver Hartkopp wrote:
>> On 08.09.25 06:07, Vincent Mailhol wrote:
>>> On 08/09/2025 at 04:03, Oliver Hartkopp wrote:
>>>> Hi Vincent,
>>>>
>>>> can_dev_dropped_skb() is not what you are looking for.
>>>>
>>>> Whether a CAN frame fits to the CAN device is checked in raw_check_txframe()
>>>> here:
>>>>
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net/can/
>>>> raw.c#n884
>>>>
>>>> Or do I miss anything?
>>>
>>> My point is not if it fits or not. Of course, if CAN XL is activated, CAN FD
>>> frames would fit.
>>>
>>> My point is that activating CAN XL should not imply that CAN FD is also
>>> activated. Having CAN FD off and CAN XL on is a valid configuration.
>>>
>>> Let me take an example, imagine that I configure my device with CAN FD off and
>>> CAN XL on, for example:
>>>
>>>     ip link set can0 up type can bitrate 500000 \
>>>        fd off \
>>>        xl on xbitrate 10000000 tms on
>>>
>>
>> Ah, ok.
>>
>>> Where is the check that, with this configuration, the device is not CAN FD
>>> capable and that the FD frames should be dropped? When I try this under my dummy
>>> driver, the FD frames pass the raw_check_txframe() check, reach the driver's
>>> xmit function and pass the can_dev_dropped_skb() checks. And that is the problem.
>>>
>>> So, yes, the frame "fits" in above configuration and no buffer overflows nor any
>>> other security problems occurred. But CAN FD is off so the frame should have
>>> been discarded at some point.
>>
>> Yes. I think your original patch with
>>
>>> +    if (!(priv->ctrlmode & CAN_CTRLMODE_FD) && can_is_canfd_skb(skb))
>>> +        goto invalid_skb;
>>
>> should do that job. Btw. I would also add a netdev_info_once() here too, so that
>> we can give a heads up to the user.
> 
> Ack. This patch will now go to my CAN XL WIP with the netdev_info_once() added
> to it ;)
> 
>>> The same issue goes for probing. How do you detect if an interface is CAN FD
>>> capable? By checking that its MTU is at least CANFD_MTU? For example like this
>>> in cangen?
>>>
>>>     https://github.com/linux-can/can-utils/blob/master/cangen.c#L802-L805
>>>
>>> If I do this check, it would wrongly detect that my interface is CAN FD capable
>>> when in fact, it is turned off in the configuration. So, under my previous
>>> example, cangen is also fooled into believing that it can send CAN FD frames
>>> when in reality the option is turned off.
>>>
>>> So, these are my point:
>>>
>>>     - how do you configure a vcan so that CAN FD is off and CAN XL is on?
>>
>> This is not possible due to the missing flags (netlink) infrastructure known
>> from the real hardware drivers. And IMHO this is also not needed to be
>> implemented for a virtual CAN interface which does not have those restrictions.
> 
> I would say that it is not strictly needed but would have been a nice to have.
> If you want to proxy between a virtual interface and a real hardware, I can see
> how this can become annoying.
> 
> But I concede that there is not much that we can do and that it is probably
> better to just say that having a virtual interface with CAN FD off and CAN XL on
> is just impossible.
> 
>>>     - when CAN FD is off and CAN XL is on, how do you drop CAN FD frames in the
>>>       kernel TX path ?
>>
>> As you proposed in your extension for can_dev_dropped_skb() - with some more
>> comments and a netdev_info_once(), of course ;-)
>>
>> We might also try to access the CAN flags from the device in the network layer
>> but this will become very ugly for a comparably unimportant use-case IMO. And it
>> won't help for PF_PACKET users creating their own SKB content either.
>>
>>>     - in the userland, how do you probe that an interface is CAN FD capable or
>>>       not?
>>
>> Test ifr.ifr_mtu for
>>
>> == CAN_MTU -> CC IF -> CAN CC
>> == CANFD_MTU -> FD IF -> CAN CC & CAN FD
>>> = CANXL_MIN_MTU -> XL IF -> CAN CC & CAN FD & CAN XL
>>
>> There is no way to have CAN CC with CAN XL without CAN FD right now as we can
>> not detect this without accessing the netlink configuration.
> 
> This brings us to the next point I wanted to discuss. As you say, the only
> solution is to access the ctlrmode flags which, at the moment, are only exposed
> through the netlink interface.
> 
> But using the netlink interface directly in your program is a bit troublesome,
> to say the least, because of all the boilerplate code needed as illustrated in
> the libsocketcan:
> 
>    https://github.com/linux-can/libsocketcan/blob/master/src/libsocketcan.c
> 
> So, my other idea would be to add a new socket option that would act as a
> shortcut to priv->ctrlmode.
> 
>    getsockopt(s, SOL_CAN_RAW, CAN_RAW_CTRLMODE, &ctrlmode, sizeof(ctrlmode));
> 
> The interface would return an error if the interface is a virtual interface.
> Otherwise, it would return the flags, allowing for an easier way to probe. As a
> bonus, all the flags become easily accessible.
> 
> It means that we would have two different ways to do the same thing (netlink and
> getsockopt) but I do not see this as an issue.
> 
> What do you think?

You are right with having two APIs for the same thing ...

If we would have such a getsockopt() I would suggest to provide the 
ctrlmode and the ctrlmode_supported to the user space.

And the bits are only valid when the interface is up. So additional to 
e.g. -EOPNOTSUPP for vcan's we should also be able to return -ENETDOWN.

My biggest concern is whether such a getsockopt() is really needed.

Today you can enable CANFD and CANXL with setsockopt() and when you send 
frames that can not be sent to the interface you get an error.

The only thing that is "not that nice" is the CANXL-only (without FD) 
possibility.

Best regards,
Oliver


