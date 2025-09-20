Return-Path: <linux-can+bounces-4769-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C95B8CE0A
	for <lists+linux-can@lfdr.de>; Sat, 20 Sep 2025 19:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF4B0171CC1
	for <lists+linux-can@lfdr.de>; Sat, 20 Sep 2025 17:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1C6205ABA;
	Sat, 20 Sep 2025 17:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Lb1Wp9O3"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A496780C02
	for <linux-can@vger.kernel.org>; Sat, 20 Sep 2025 17:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.218
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758389929; cv=pass; b=KKO+Jx1DgmoKLgg4RGGs8VpNr2DKHN2pgt++k8Mgbp8ri5C1nScKVvil7o4xk4TREjb1BxL82NV7OmdAhRNMy5ZuxE/moTEjEbe9Vfe54i+12hlw/Ch2Z1I7tVXLB1V5KLqKTys9yVVbEF/Rc1z2IiR0qGpGaKox1toFkFrb0To=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758389929; c=relaxed/simple;
	bh=Gb24bFu98iqU2XKXPjBBESVbt4WWowoXZz0qPOj0qYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F+hLucPFmSy6T1TM2dH3dTGTRMnkWALYSRHKrFzvU+GfHgq2kseiCCh6Ih63SlN5zCEXyRnJYoPwORaos17856lZQMOxk0K79/DoAVU5/a6ERyiviPkZZbFlmpvjf3oqNdEsRG4EZShqkpDXAvoM0Dfhc6zzSIpaLSBmE82tMCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Lb1Wp9O3; arc=pass smtp.client-ip=81.169.146.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1758389918; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=IDd6jmsxIcpIgLw2DQkCKdIkAe+7KFMXd4VnB0Uuyig9xFrJGF5hI3maZmGccH3EvX
    8sfsGIqzHaEVDbV6MwRvaq+x3CnrVwecU5yZwzW7YwxdcitFXuoo0awch5vRUuVEcZaz
    YBmigB4ieNhF2HgbqthC0C6GJPuqV+lRWTW4CpZC6HlZuLWFtFP9BJ/6oZ71surf08vt
    KCryqAbWDr6pIBu2lqR21QBJMbHFPbP/+36rzV4s00peHvGgGZCD+gSRo6m0WePDg+UH
    SkraKeMjVe/+ARx6PNrsML1xlcFi5E/QSxh7/NfS86tTAf1jec6nUXt503favklxwxJH
    Vq3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1758389918;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=A50dRTk5BLf3BT1euIHWKwB/lqZu7qBCm6DApELOjeY=;
    b=q2MDz8oaCa1Oecc2Np9/N6XdQc85xaz3iR6m8CMMNMlhtUH5FkTfmU5fwjP8fxwOzd
    nUHp97rdbIeLfsxbE8djlHz9KmN5NUw+BWusBHs8NEFHfVJiXFRK8Zf5wsDSq6tkGl4U
    TTyb3X/7Bu+LaqZMruidxBQFEN4TrxOx30nY8uPYTuE4uTzr9eaFokNLoglPZqoMjHov
    CVwGaMT2ZWTqJB5d3HSuAHtpzybtFuVskbF3Fp/J7owCWEi6FolqOjyjrr2Jz2oS1n0N
    L8ecJ0/mf02jIUS9emECtkOiPCj5fXrcMfxBiUacIZymQlAO54iYJCjpBqR8Ac4yckmT
    XsdA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1758389918;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=A50dRTk5BLf3BT1euIHWKwB/lqZu7qBCm6DApELOjeY=;
    b=Lb1Wp9O3aleju3rpM3jHVoTf2mS/5IS1h94tGAH3EUgBzbq2/1/uzRqKTXL3Za8o6u
    MmRKe6PndzKi5qkrv5PgZFM+wEiApcelTLQSd99dHvTB4I0cff9fXDHk+rmCo01w4WAx
    SA12L3zTcJCcpc5E8TIi7rwNUcnp3DGstqtLvhaDdwufDqz7ljX9HBSuIeHgYqCs7C+E
    b2eQYx9ORn4h761Rl9cWe0Uv9qqNIGGimxxSX8j/JWZ0ebFiE+3wLMOe8oRo2ZlLnWUF
    Wb3QQNREtsDVzuQ2WUSCOYDUAqSlstntxDEmxdmj+m3oSSRRlLf5dTmEkC3m14cCmsem
    YLQg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMr5phO3IzIIYldT81bUUIsmLN7SHydkyMKQvXKPCtWFy/0tzt"
Received: from [IPV6:2a02:3033:268:776a:ab6a:78e4:9901:b595]
    by smtp.strato.de (RZmta 52.1.2 AUTH)
    with ESMTPSA id K2a23218KHcbP54
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 20 Sep 2025 19:38:37 +0200 (CEST)
Message-ID: <e845bb4d-32db-4a73-a4c0-2e43af3bc861@hartkopp.net>
Date: Sat, 20 Sep 2025 19:38:30 +0200
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
 <034cad19-d04d-4b14-87b2-e8b2b7b14099@hartkopp.net>
 <204b2bbf-eeb6-492d-9842-4720ba6c055b@kernel.org>
 <a85dec20-e638-4069-8355-9cbf4d2d278e@hartkopp.net>
 <4430c1a1-5c03-45bb-a687-66e0a41050f6@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <4430c1a1-5c03-45bb-a687-66e0a41050f6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 18.09.25 11:18, Vincent Mailhol wrote:
> On 18/09/2025 at 06:29, Oliver Hartkopp wrote:


>> Will the user defined MTU for CAN XL survive the settings when xl is set to off
>> and then set to on again?
> 
> Unfortunately no. Or at least not without adding one additional field to save
> the old value.
> 
> But after turning FD or XL off, none on the bittiming parameters would survive
> either. So I think it is coherent to say that the user has to set everything
> again each time XL is switched on.
> 

Ok. IMO setting the CAN XL MTU lower than CANXL_MTU_MAX is a power user 
feature anyway. So setting the bitrates and the MTU in one sequence 
should be no problem.


>> To sum it up for myself:
>>
>> 1. Setting the MTU from user space is only relevant for virtual CAN interfaces
>> and CAN XL interfaces for values between CANXL_MIN_MTU and CANXL_MAX_MTU.
> 
> Ack.
> 
>> 2. Usually the MTU is set automatically by the netlink configuration process
>> when fd/xl on/off are set.
> 
> Ack.
> 
> As you will see, I found some bug because a few drivers forgot to set their
> can_change_mtu() and addressed the issue here:
> 
> https://lore.kernel.org/linux-can/20250918-can-fix-mtu-v1-0-0d1cada9393b@kernel.org/
> 
> That series is just to fix things and is meant to be back ported to stable.

Nice cleanup!

> I will send a couple more patches as an RFC which will implement the actual
> logic which we discussed here.

Fine!

I assume we will miss this merge window for the CAN XL support then.
With all the things that need to be looked at carefully the next merge 
window is probably the better choice.

Best regards,
Oliver


