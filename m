Return-Path: <linux-can+bounces-4710-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0965EB591DA
	for <lists+linux-can@lfdr.de>; Tue, 16 Sep 2025 11:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9E26520AC8
	for <lists+linux-can@lfdr.de>; Tue, 16 Sep 2025 09:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1834423313E;
	Tue, 16 Sep 2025 09:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="F80k1zZo"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EC81E47B3
	for <linux-can@vger.kernel.org>; Tue, 16 Sep 2025 09:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.218
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758014060; cv=pass; b=LQxiHp8unmwQDiEH8xVl/GlRbJO6SpepEhk5F0PwASozgT953WB3+i30abTKEcCykJKAnkgz3kEFwAgUaqBYqZzvvii6OOoeqDmx6eoybpzyZNWoJdpV+Ty62LoOfjf5FZMUs3E4KXQ0qpOJYbcU6+0hTYl3t11WP9KwYCohSpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758014060; c=relaxed/simple;
	bh=tkje3OA/H9Hb9CUyew8KjM4dECQkU2Y6rowLEy3QZtY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GALL3pQzvOQZikvr/Lr8qps9yZWBTUN00roQXT+GlS+RGWxQc8If9eYeMFECs5ClhXoVOdSQNWCtjxDvud2eu6O8N9YO/KZh14wZBo/PR52Jf+gXr89QwKuhrtMkD0sMy6Fc77uSj1ER5ecPV6VZjHa51KAV0buPru0stG0EE30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=F80k1zZo; arc=pass smtp.client-ip=81.169.146.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1758014047; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=eJYatnioHNXcbhHP29xKSovqtrg/wTVB9+gBcUv6IrTw3ugLAoLafwXxPSMlwIWUOw
    HLwh78FRQMwLSx3PVgp7kgl0z9k/89HJRUJQMZvDoe4UuC5vb7fux9dsG/nGS5VNc85i
    xj9KZ2aw6Cq8ftsgJJnxTCWKSBZLJWeflxId9XVcZ4ePP5drZ3pb9SpNiYZl/JPDjhyf
    n1q3h3ZLBZYedWaba8FXyqhDlf9QXgBorcVzXNHMMGGHF/GNRcPQzKGXudX7t0s0JtuE
    8oz56CgE9QWEq7Y5dsHKNr/BYFsMwCj07tDZFWoO0axwESyNfxKimdmsbhNx9G3zG3CD
    4a9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1758014047;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=bPL8xBZ6d9l6NsBZ6gzBhTl8mZ/LpBhpk+M8YamfAHI=;
    b=SbD8DJZFnJgzut1K0YUgPSBjLdkhofKeJ64F3+h9yDQbcAjuUXYdPxBpuBsWRtPrch
    X1H+KMYHhOm0Ii1JY2HjtiYCjJLm1Fp/ZetR+oqVmh+9Ee4rmEHTugua0WKlz9h7bY1b
    pv99kAN9H7/JCK05Et5arBTNbw/5y+F3bW1CHO5SaauvZrDexnpcHSs34W4TzFIfHPxe
    MPV4MIuWCbjxU2Bp1HHOG5s7+QkjqDJcaVq3O9v3GP7itgfF5us5oOcuqs1BloA5Jx0v
    ArR+weqSu9HvpqWDLThhBlJJgkyZDf08cvJdvKq6pNtAsLBl+WEhbusKBMofJIndTkUq
    7BHA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1758014047;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=bPL8xBZ6d9l6NsBZ6gzBhTl8mZ/LpBhpk+M8YamfAHI=;
    b=F80k1zZoiSw4PucuakyuE064sbW8GSv2NgJYb+qtN8WdcZyUaPL5fbxr/q2hlQnqoa
    dmzjpUpcbSBKqecLSbvrDCWgTWLKJ/EquuWK37To94ZHyCKXlrpxIOSoQ8SfRfkA2b7a
    3pE7O/1204fQDQPErwugtpwFGKU7PzAiwb5v9UetgJNCejGkHqSYNy6caVrdGUcdvoSX
    j5WhY8EQVDbvqyvVMJj9nZ3wbbths2IUOrWaoMPIyfLK/GHLFAS/wk5Pn2QhCm28NZwm
    yo1GjYUzFJf99mehwoE2c3LMGOrYpz1a2LytfwUwVwm5rd7pRIgvSfUUtRH0T/8/ziFK
    YMww==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMr5owMnk64sq9Ul7eqcKOVsu9ML+YEi2e3Mq82YNA050iV974"
Received: from [IPV6:2a02:b98:8a1c:4400:4f6f:6074:73e7:1eee]
    by smtp.strato.de (RZmta 52.1.2 AUTH)
    with ESMTPSA id K2a23218G9E755Q
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 16 Sep 2025 11:14:07 +0200 (CEST)
Message-ID: <034cad19-d04d-4b14-87b2-e8b2b7b14099@hartkopp.net>
Date: Tue, 16 Sep 2025 11:14:01 +0200
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
 <1618e271-e052-4667-9a7f-c6672fe582c4@hartkopp.net>
 <fa15357e-4d08-4192-a0d7-46315cba6610@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <fa15357e-4d08-4192-a0d7-46315cba6610@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15.09.25 20:54, Vincent Mailhol wrote:
> On 16/09/2025 at 03:08, Oliver Hartkopp wrote:

>> I think the interface to set the MTU lacks a clear separation of how to set the
>> MTU for real (hardware) CAN interfaces and virtual CAN interfaces.
> 
> Ack.
> 
>> 1. IMO we should be able to set the MTUs on virtual and real interfaces when the
>> interface is down (as those MTUs have no effect at this time).
> 
> Mostly agreed. It should not be possible to switch between the Classical CAN,
> CAN FD or CAN XL MTUs. But I do not yet see an issue to change the MTU to
> something in between CANXL_MIN_MTU and CANXL_MAX_MTU while a CAN XL node is running.

No, not while it is running (== up).
My point was that you can set the MTU as long as the interface is not 
"up". Together with the default initial values (see below) this makes 
perfect sense to me.

> I want to first study the other interfaces (e.g. ethernet) and the core net
> infrastructure in order to make my mind. For the moment, I am just undecided.

I'm not sure if ethernet is a good example for our use-case with 
different CAN protocols types (CC/FD/XL) which is more than having 
ethernet frames of different length.

>> 2. When a virtual interface is set to "up" the MTU is used and fixed.
> 
> Same as above, mostly agreed aside from the CAN XL on which I do not yet have my
> final opinion.
> 
>> 3. When a real interface is set to up the mtu is set to ...
>>    a. mtu = CAN_MTU when fd off and xl off
>>    b. mtu = CANFD_MTU when fd on and xl off
>>    c. mtu = the configured CAN XL MTU (*) when xl on
>>
>> (*) when the configured mtu is not in the range of CANXL_MIN_MTU and
>> CANXL_MAX_MTU the mtu is set to CANXL_MAX_MTU.
>>
>> By default the initial MTU of virtual CAN interfaces should be set to CANXL_MTU.
>>
>> By default the initial MTU of real CAN interfaces should be set to the maximum
>> value which the real CAN interface is capable too:
>>   a. CAN_CTRLMODE_XL supported -> CANXL_MTU.
>>   b. CAN_CTRLMODE_FD supported -> CANFD_MTU.
>>   c. default CAN_MTU
> 
> I was thinking of the opposite:
> 
>    a. if the device is CAN FD static it is CANFD_MTU
>    b. if the device is CAN XL static it is CANXL_MTU
>    c. otherwise, it is the CAN_MTU by default
> 
> which, if you remove point b., happens to be the current logic. I do not see a
> need to change this.

I like that approach of having the supported MTUs as default and later 
reduce the MTU based on fd=off and xl=off, because it would be similar 
with the virtual CAN configuration then.

I assume the initial MTU isn't looked at by the users anyway.

> If we set CANXL_MTU by default on XL capable devices, it means that at a moment
> in time, we have a device with the CAN_CTRLMODE_XL off but with a CAN XL MTU.

???

Maybe I was not clear enough:

You intitialize the MTU to CANXL_MTU when CAN_CTRLMODE_XL is a 
"supported mode". The interface is not "up" at this time and therefore 
the MTU is not on active service.

Then you configure the interface with bitrates and xl/fd on/off.

And then you set the interface to "up" and in this process the MTU is 
set as a valid and activated value with a MTU based on the xl/fd on/off 
settings. This was my idea.

> And this is inconsistent. For me, the MTU should always match the control mode
> flags. Because all control modes are off at the beginning, the MTU is thus the
> Classical CAN one.
> 
>> I think this should make it clearer and fix the current inconsistency.
>>
>> Setting the CANFD_MTU via the ip set mtu feature and expect "fd on" being set at
>> the same time is bad.
> 
> OK. Aside of a few details, I think we agree on the big lines. The good thing is
> that the current can_change_mtu() only targets the real interfaces. The virtual
> ones already have their own functions and so will not get impacted.

Right. The virtual CAN stuff can stay as-is.

> So I am just thinking of doing a full rewrite of can_change_mtu(). The old logic
> of being able to implicitly set the fd flag by providing an MTU will go to the
> trash can.

Yes. That was not consistent and clear in the usage.

With my suggestion the can_change_mtu() will be just a simple setting of 
values which is the same for real and virtual interfaces.
For real interfaces we might make some additional checks against the 
"supported modes" for FD and XL.

And when the real interface is set to "up" the MTU is adjusted to the 
real cc/fd/xl configuration values. I hope this makes it clear now.

> The new logic will try to follow as much as possible the intended MTU
> logic of the core net framework (which I am still studying).

Don't expect too much for our use-case there ;-)

Best regards,
Oliver


