Return-Path: <linux-can+bounces-4527-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BCC4B49645
	for <lists+linux-can@lfdr.de>; Mon,  8 Sep 2025 18:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C6244C0B6B
	for <lists+linux-can@lfdr.de>; Mon,  8 Sep 2025 16:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B8C53A7;
	Mon,  8 Sep 2025 16:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Fxwp/j1g";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="JoxNieQs"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54E61E51FB
	for <linux-can@vger.kernel.org>; Mon,  8 Sep 2025 16:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.221
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757350560; cv=pass; b=UJVjqTn6FpKzYEmXqFHQ5UWiGvt3tkmTgLUVAVbvz0VRujhgapY/9M50RlMFMPtZxGOZjQRtTUBuFiiKMB1/MfbRYoS23WZwNmngzgZ9EqFu8up5eSfNFVqV0gnPDh78y8riRnW0uUUPTeV9E7AtrbN7AsUxgqwyhh5rcC9KSaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757350560; c=relaxed/simple;
	bh=bk2Puxj543jujNUivUxGPgWA7n/TWHrupgAdAa79x2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F5JFmUWqEax5MhawMCArkV9UEsur6wmdfhp+tOh3B7jH97xiALU5wqpfcGFQLhZXhYW9H1qch76VPiT2DqrgBRtkrfMfm+Q5rBGViEr1NHCuU9TZRdyBJQg0hr4r5jrwdl6K7W3rK2mnj7v8pM4mrcdWl/jaAn26h0xDHh8Lslo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Fxwp/j1g; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=JoxNieQs; arc=pass smtp.client-ip=81.169.146.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1757350555; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=HXi0uZ8LbOay7uhPVDGNNb4sA9RS9brN/W2gMd+L2EAYjbaEwyCROC6TSR+o6f+HH/
    0xvXpJD+dZ+qvekl/kx++T/AB8+Wl9Yxz9hxQiT09jvrJYFgUFYHSTMNCMgdpOQCea38
    8xFccnq8mYH7Ug7FpL+rxYc0sNwX3QJPPhDoQ2gkSnuGNpdT3i5c2o57Tg+6xAMCYLEn
    kV21NnOyCeRug74G/g9pWNRrw5698WIuR+ltElECgUsbuK4xPXCHNPtVtm8lY/BIuBFz
    0dRb87HiR+EMlFo+nMfKo0GpFFcd+sUOZK7X8Um40y6PFHPHjOir77WtZwX3h10CmEH0
    z0OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1757350555;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=+WhA2Acwx2pXlOLgnv//q3sIF5UUnLbwLYz5LvwumSI=;
    b=fGCA/ZvR1pn/FUhnFDhLfbTdqTYz3y2ClwSUghWZyxdBMPosDHuQ/ceSRlQ8URJX3S
    mOe7lvwy9y//WaEu/QwO6VnQvUSZzDMf2PkOP0n9rnfbqMWDSt5YVBJAfVpXs+VxL44T
    16s8BC7wlF7uBtm45U02PW/k+MOAzB2GpmWtHvTHWuWTTNQbhbsE73q9PDQx7yms1Nbc
    C1U38/QT6VovuWTFacyk6/dFSl3cj9cXRsJEe3vgoQSIG9ZODT1tJuhdlyMupZzW5eDO
    S7L+VtWxBNJKu8+Y8uuyiMr/aozWpJhgkLxZvAe4i8n2Cmks+6V5Fh02i/I5Ci13Nz3G
    gz5A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1757350555;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=+WhA2Acwx2pXlOLgnv//q3sIF5UUnLbwLYz5LvwumSI=;
    b=Fxwp/j1gEZYhUnkz7QE/zQvKh4ORbGmPSJdKls5ts3CgeC0/NtiAV3fDh44RXIuxPB
    qOWjDo9sauAeVpnynf1FPhfskbKvOANp/cJvnKO9GRJ+da/L/6ifF0GWCznXh2OrX0L3
    /3AjEADsbnneOjdOSF1zN/bBQTlHYGCxQIJhdNCvOrq+I6JfRCR7z3/uiSnP13OJkbtc
    +R77/oLaziNTQ2cNSESPUG8inhpbjZcaY85UjxaASiIM8KUzQ6+EAtfLUoSjku/yIcej
    3dI7xRScZB1mGZy8Vr8PkChKOYqm57btTWiutxx8Dc4uLI1728UkHkkOLUrg5hnBvHlE
    C0+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1757350555;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=+WhA2Acwx2pXlOLgnv//q3sIF5UUnLbwLYz5LvwumSI=;
    b=JoxNieQsePsOdD7Yu//hhvtWKUt1w2Bq+IyrWDUc4dgX0s+1oimxPrFSBkU4Z21bb/
    rDt30DLy4yUxmDcaUTBw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 52.1.2 AUTH)
    with ESMTPSA id K5d361188Gttb5r
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 8 Sep 2025 18:55:55 +0200 (CEST)
Message-ID: <2f9fdf70-856c-4b4b-ac69-5e22f4d9e014@hartkopp.net>
Date: Mon, 8 Sep 2025 18:55:54 +0200
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
 <fc1dfbf6-33e1-47a1-943d-806f146c5be6@hartkopp.net>
 <891c738e-f807-46a7-8e03-4223969c9002@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <891c738e-f807-46a7-8e03-4223969c9002@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 08.09.25 18:31, Vincent Mailhol wrote:
> On 08/09/2025 at 23:59, Oliver Hartkopp wrote:
>> On 08.09.25 15:30, Vincent Mailhol wrote:
>>> On 08/09/2025 at 18:00, Oliver Hartkopp wrote:
> 
> (...)
> 
>>>> There is no way to have CAN CC with CAN XL without CAN FD right now as we can
>>>> not detect this without accessing the netlink configuration.
>>>
>>> This brings us to the next point I wanted to discuss. As you say, the only
>>> solution is to access the ctlrmode flags which, at the moment, are only exposed
>>> through the netlink interface.
>>>
>>> But using the netlink interface directly in your program is a bit troublesome,
>>> to say the least, because of all the boilerplate code needed as illustrated in
>>> the libsocketcan:
>>>
>>>     https://github.com/linux-can/libsocketcan/blob/master/src/libsocketcan.c
>>>
>>> So, my other idea would be to add a new socket option that would act as a
>>> shortcut to priv->ctrlmode.
>>>
>>>     getsockopt(s, SOL_CAN_RAW, CAN_RAW_CTRLMODE, &ctrlmode, sizeof(ctrlmode));
>>>
>>> The interface would return an error if the interface is a virtual interface.
>>> Otherwise, it would return the flags, allowing for an easier way to probe. As a
>>> bonus, all the flags become easily accessible.
>>>
>>> It means that we would have two different ways to do the same thing (netlink and
>>> getsockopt) but I do not see this as an issue.
>>>
>>> What do you think?
>>
>> You are right with having two APIs for the same thing ...
>>
>> If we would have such a getsockopt() I would suggest to provide the ctrlmode and
>> the ctrlmode_supported to the user space.
> 
> Yes, and probably also the CAN_RAW_CTRLMODE_STATIC. I do not often use that one,
> but for completeness, better to expose all three.
> 
>> And the bits are only valid when the interface is up. So additional to e.g. -
>> EOPNOTSUPP for vcan's we should also be able to return -ENETDOWN.
> 
> Ack for the vcan.
> 
> For the real hardware, I think that the CAN_RAW_CTRLMODE_SUPPORTED and
> CAN_RAW_CTRLMODE_STATIC should be always available. Only the CAN_RAW_CTRLMODE
> would return -ENETDOWN if the interface is down.
> 
>> My biggest concern is whether such a getsockopt() is really needed.
>>
>> Today you can enable CANFD and CANXL with setsockopt() and when you send frames
>> that can not be sent to the interface you get an error.
>>
>> The only thing that is "not that nice" is the CANXL-only (without FD) possibility.
> 
> The fact that vcan can not be configured with FD off and XL on is what I would
> call a "not that nice".
> 
> But the impossibility to reliably probe the FD state is worse than "not that
> nice". When I see cangen sending CAN FD frames when it shouldn't, I call this a
> bug. The impossibility to probe is a no-go to me.
> 
> An alternative would be to revive the libsocketcan to make it easier to use the
> netlink interface but this is lot of effort and it means adding one userland
> dependency. The getsockopt() seems a better alternative.

I think the best way is to properly split up the FD/XL capabilities for 
CAN XL interfaces. Right now CAN FD is implicitly enabled on CAN XL 
interfaces when CAN XL is enabled.

I would tend to change the code in raw.c in a way that you have to 
switch on FD/XL explicitly. And then the problem would directly show up 
in write() and FD frames would not be silently dropped in 
can_dev_dropped_skb().

Best regards,
Oliver


