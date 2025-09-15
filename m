Return-Path: <linux-can+bounces-4708-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB565B58440
	for <lists+linux-can@lfdr.de>; Mon, 15 Sep 2025 20:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7741F3B979E
	for <lists+linux-can@lfdr.de>; Mon, 15 Sep 2025 18:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BB72868B3;
	Mon, 15 Sep 2025 18:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="svTl0AYr"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EAA277CB6
	for <linux-can@vger.kernel.org>; Mon, 15 Sep 2025 18:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757959876; cv=pass; b=Agy2vLDXbQvKe9RsS/YnG8vADxC93hLazKWtO8RjeSVFNVh3Spa0D9k94NHOUm1cOTYpCjLPIG7jFvfqFNeFfN3rHFcbJxF4wouNt+SujMW19IXrc8EhIk3Rvm+Y6RqXwhCbQk6vNxBPjFt4BiyC2/RHgAyiMTKAUYO7T4EFdZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757959876; c=relaxed/simple;
	bh=n2pYR3GOjEtHNYz3IU1tLn+29J1w8HViOuwETQfZeWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TLD5l09ZKgns+vH7h/SBj9yI7PePyQ+Juh5YCjJA4RR7mhBPItTD2TX1FwMoPcnurgOY3N6oU/foU2yRHFGEI+1xdM+WlEj3lvg3rbTWsauSMIKnrWOCAiMuX5Wl+vA5kdOUJqpocUcvRBTV61kkU3RKvryBzI8sc17oeRB9IgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=svTl0AYr; arc=pass smtp.client-ip=85.215.255.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1757959686; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=SPY2O/7LtTm6MVSI3JdhRA/WsXRFNAPwJkJIQJySr5a2uw1vnot0orVNFbfzcQpABJ
    XOd4RSorOFacPnXwtMZGaioEtryksfkA27wpFhUQoSzl4diy3mPZ+6pesPcPu0fSlrxP
    iJUdjkYK8YES7QRXB/GDIOG9uoJXFNBuI199aXTnl89GYRsUrO2R9YUaF00oDeK6O2Rb
    Ew7IQyYoK340wuGwa1fluix/AjcW3LbNJLc0NdEfrXDmKkn2pl3Q7sZq845N57bgBwxT
    XTBCmhpX8Dh8byI2MmJ5aGDO4/zNgIe4+LcIXizZiTd5CN5DXndrZgXCT5897881o0/x
    2xGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1757959686;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=5JD6fbU9RbiuFIac7HpLOU/G13SAbP6LH/S64ni+QNo=;
    b=CXm+zpiwvi5z4SJT+U1r8FNDxAvmBDlq5ylUVv5e0BfCt4XXqztzq9NjZfSAChP7XX
    9RZvx2WO4X6jbXozn5PhbioeAgUZxcKRK+24ak2VTokvytpt847Ia5VAQ/tGsigA+GQ0
    eHvHYbK5KreRCPpXi++CV3lZ99xb4JbsqaWwe4p3eyyLqZNDUPlCFwsCYfmq2zXxUIQk
    +pYRruO92ZZsPulmXq4naLMW3KpxRc7hx7pdM8131poAWFw05cjndL3M/y9bk71D38fw
    +JsBQfHaHhMDM2W7nlPqPOkhpJu8wRqHIe8SBCYGvj3PkzxJuM+a1Y/vLK4TTY+FBDOz
    LONg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1757959686;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=5JD6fbU9RbiuFIac7HpLOU/G13SAbP6LH/S64ni+QNo=;
    b=svTl0AYrn8MjaMtmODJL6IlGHABsB+/IhRt7mQ9E6psQAz4qigY8EZiAvhKx6WKLIw
    na+6U6uY9hHG9Qfxm7+aUTdKVwSU4oVVMGYUI1Y+0moxZeHOcrWaa1pxx/2//plhkOjp
    GQAyITAvymCHXp4jjqHCFUTxPy9LFbX7cWZeBgexhpSWAknCjPJZqgw2q7WFuUVX4tCQ
    KsHUagXUy5G2RBQ33dYLv8EuOu30pZ6Lfzm3/QKIcLtfGYEOMSP8H+m9JiO/6Ww6Mbbh
    NBBM+90HW5GhooZ6PRnHv2vgkJ1BWqxpLk79nfFj6hEhM2lYoUGL1ILXvDdLxbdSd0Io
    WKSw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMr5owMnk64sm8VF6OpcIrgdno+M3mNGEGSIofQp0UJwtSeLY="
Received: from [IPV6:2a02:b98:8b0e:d800:856:bd03:6d59:abd2]
    by smtp.strato.de (RZmta 52.1.2 AUTH)
    with ESMTPSA id K2a23218FI86309
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 15 Sep 2025 20:08:06 +0200 (CEST)
Message-ID: <1618e271-e052-4667-9a7f-c6672fe582c4@hartkopp.net>
Date: Mon, 15 Sep 2025 20:08:05 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 2/2] can: reject CAN FD content when disabled on
 CAN XL interfaces
To: Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org
Cc: =?UTF-8?Q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>
References: <20250909092433.30546-1-socketcan@hartkopp.net>
 <20250909092433.30546-2-socketcan@hartkopp.net>
 <f7b59c7c-30ad-4cf4-ad0e-bff0e39b3337@hartkopp.net>
 <7578f44d-d85c-473e-8e7a-65d1fc974e68@kernel.org>
 <20c5c885-0bab-4c42-82c6-e98571a5d19d@hartkopp.net>
 <552631f3-15fe-4bb3-a512-1eaca57be5ca@kernel.org>
 <3a963548-faa9-4611-a3cf-e41b425968a8@hartkopp.net>
 <b6637b79-6377-4038-967f-0354a32eb2c3@kernel.org>
 <6afc7e2d-eecf-4c47-bcef-0e2cdd7f4a89@hartkopp.net>
 <67e0351c-b478-4938-a42d-77764b27b9d1@kernel.org>
 <3979cf15-6a08-44e3-a620-fe97d8218713@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <3979cf15-6a08-44e3-a620-fe97d8218713@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Vincent,

On 15.09.25 15:59, Vincent Mailhol wrote:
> +cc: Stéphane
> 
> On 15/09/2025 at 19:55, Vincent Mailhol wrote:
>> On 11/09/2025 at 05:12, Oliver Hartkopp wrote:
>>> On 10.09.25 18:19, Vincent Mailhol wrote:
>>>> On 10/09/2025 at 17:48, Oliver Hartkopp wrote:
>>>>> On 10.09.25 09:40, Vincent Mailhol wrote:
>>>>>> On 10/09/2025 at 16:27, Oliver Hartkopp wrote:
>>>>>
>>>>>>>>        /* CAN XL is allowed on virtual interfaces if it fits the MTU */
>>>>>>>>           if (!priv)
>>>>>>>>               return dev->mtu == CANXL_MTU;
>>>>>>>
>>>>>>>            return can_is_canxl_dev_mtu(mtu);
>>>>>>>
>>>>>>> The MTU of CAN XL interfaces might vary.
>>>>>>
>>>>>> Maybe this is something that we discussed before, I do not remember, but how is
>>>>>> it that the MTU can vary?
>>>>>>
>>>>>> MTU is the *Maximum* Transmission Unit. I understand that the size of a CAN XL
>>>>>> frame is variable, but the MTU should be constant, right? Why can it vary?
>>>>>
>>>>> Depending on the realtime requirements the length of the CAN frames (and
>>>>> therefore the time the bus is blocked) the MTU can be reduced. This is (like the
>>>>> bitrate settings) a network architects decision which is enforced by setting the
>>>>> MTU accordingly.
>>>>
>>>> Is this an extension we offer in Socket CAN?
>>>
>>> Yes.
>>>
>>>> The standard says nothing about
>>>> having the MTU configurable.
>>>>
>>>> For CAN FD, we forcefully set the MTU in netlink.c
>>>>
>>>> https://elixir.bootlin.com/linux/v6.16/source/drivers/net/can/dev/netlink.c#L228
>>>
>>> Oh. I did not realize before that we can either modify the MTU with setting fd
>>> on/off and via setting the MTU in can_change_mtu()
>>>
>>> https://elixir.bootlin.com/linux/v6.16/source/drivers/net/can/dev/dev.c#L313
>>>
>>> ?!?
>>>
>>> The two APIs problem for changing the MTU?!?
>>>
>>> I expected the default MTU for CAN FD capable interfaces to be CANFD_MTU which
>>> is obviously not the case.
>>>
>>>> I will have to think of what are the implication for CAN XL.
>>>
>>> I would define a default CANXL MTU (CANXL_MTU 2060) which might be changed with
>>> can_change_mtu().
>>>
>>> And when ever we switch xl on this value is selected as device MTU.
>>>
>>> Or the user can change the MTU as he needs it.
>>> And when xl on is selected and the MTU is a can_is_canxl_dev_mtu() this value is
>>> used. When can_is_canxl_dev_mtu() is not true we take CANXL_MTU.
>>>
>>> Something like this.
>>
>> Yes. I was thinking of something similar. This is what I added locally at the
>> moment:
>>
>> 	if ((priv->ctrlmode & CAN_CTRLMODE_XL) &&
>> 	    !can_is_canxl_dev_mtu(dev->mtu)) {
>>    		/* Set CAN XL MTU to its max unless if already set by user */
>> 		dev->mtu = CANXL_MAX_MTU;
>> 	}
>>
>> But I am still testing it.
> 
> I am looking at the code of can_change_mtu() but I can not understand the intent.
> 
> Back then, commit bc05a8944a34 ("can: allow to change the device mtu for CAN FD
> capable devices") stated that:
> 
>    The configuration can be done either with the 'fd { on | off }' option in the
>    'ip' tool from iproute2 or by setting the CAN netdevice MTU to CAN_MTU (16) or
>    to CANFD_MTU (72).
> 
>    Link: https://git.kernel.org/torvalds/c/bc05a8944a34
> 
> But if I do something like:
> 
>    ip link set can0 mtu 72 type can bitrate 500000
> 
> the command is accepted and I am then left with a device which is in an
> incoherent status (FD on, but no databittiming ?!)
> 
> I tested this on a device and it is just throwing me errors.
> 
> The same goes on when setting the mtu back to 16:
> 
>    ip link set can0 type can bitrate 500000 fd on dbitrate 5000000
>    ip link set can0 mtu 16
> 
> and now I have a device in Classical CAN mode but iproute2 is still reporting me
> the databittiming values (although this time, the device does not send me errors).
> 
> So, whatever I try, can_change_mtu() put the device in some incoherent state
> with some more or less serious impact (either device errors or bad reporting).
> And the only method to remediate is to use the 'fd { on | off }' option.
> 
> Am I missing something? If the feature is just broken, then I would like to
> rewrite it but this time using the net_dev infrastructure by populating
> net_device->min_mtu and net_device->max_mtu. IMHO, this should give us a way
> more robust interface.

I think the interface to set the MTU lacks a clear separation of how to 
set the MTU for real (hardware) CAN interfaces and virtual CAN interfaces.

1. IMO we should be able to set the MTUs on virtual and real interfaces 
when the interface is down (as those MTUs have no effect at this time).

2. When a virtual interface is set to "up" the MTU is used and fixed.

3. When a real interface is set to up the mtu is set to ...
   a. mtu = CAN_MTU when fd off and xl off
   b. mtu = CANFD_MTU when fd on and xl off
   c. mtu = the configured CAN XL MTU (*) when xl on

(*) when the configured mtu is not in the range of CANXL_MIN_MTU and 
CANXL_MAX_MTU the mtu is set to CANXL_MAX_MTU.

By default the initial MTU of virtual CAN interfaces should be set to 
CANXL_MTU.

By default the initial MTU of real CAN interfaces should be set to the 
maximum value which the real CAN interface is capable too:
  a. CAN_CTRLMODE_XL supported -> CANXL_MTU.
  b. CAN_CTRLMODE_FD supported -> CANFD_MTU.
  c. default CAN_MTU

I think this should make it clearer and fix the current inconsistency.

Setting the CANFD_MTU via the ip set mtu feature and expect "fd on" 
being set at the same time is bad.

Best regards,
Oliver


