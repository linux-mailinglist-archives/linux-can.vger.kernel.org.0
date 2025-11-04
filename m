Return-Path: <linux-can+bounces-5312-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 00731C2FBFE
	for <lists+linux-can@lfdr.de>; Tue, 04 Nov 2025 09:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A0C3D34D412
	for <lists+linux-can@lfdr.de>; Tue,  4 Nov 2025 08:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A822874E4;
	Tue,  4 Nov 2025 08:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="CVgg5FbJ"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1134A29B224
	for <linux-can@vger.kernel.org>; Tue,  4 Nov 2025 08:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.165
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762243272; cv=pass; b=qbvjKo2JeEzkmc0RR8T0k7imv1oGcjOT2lk1A0HKYFORN+Hhd35Q5ZGf08oWOfVoAkUrqEdGx32rKkFj2mS35TpUWRRxcSkHRwnr2hMwVoZlzLBB984rlHm2nAm4gFYpiyNGamGWIo0esetAgzHwIJlv19G0jX5gkAtIka1FLjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762243272; c=relaxed/simple;
	bh=PCN5baTHesATaIYzC0QBmNOYMOtBPngKAwnXUVDPIzA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kmGIRRpv2IT3FAXNirNTcgxA8WI6TagcMyJGD0yIEjl1s55NO7cSJ5EhMUhw0fpwil+B8oJKnpi2+J3NWCpi2p4UzHg9OCvLDdllHSeBlXEWW8CuGCcT+Pvj5uxfoxDUtbwMcbR+maXykqc9fISsNacbYIdOEh7SjpInrMnrpH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=CVgg5FbJ; arc=pass smtp.client-ip=81.169.146.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1762243261; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=FPgdNrXGCGSWlgfXX7R/pEOMTlkqOF1bMxFxYYu4esihkjZhEw3TXP7eBVjprfCMLg
    StzRKhxFNqhDlVnOtCCF8b90eDGM8CCLl9ounFw5tbjwYorM/caq223DmsMaxkZt9d8j
    5roVChfyhsuu+ROLu17ydD0oUvq364NjZRFiGs4yh/5g13jQjh9MAC3l/oysi5K4I8sV
    ILMsT1IdP905LNMrhClkI1+plnxqTTcm4seud8litLbrcD9WaauGQyewE+RGqr4Wg3pa
    Oy7Xd45mhWTlSHDvSpuKNiM9TecXItQR0GXGfFwVlkwec0JGDEKdxZOgE3jWxfG3WI6x
    ULIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1762243261;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=+q/Qq9/p1m/IXlfwo3H5YWviOgUNau2CDVmeH6Tuqgw=;
    b=FTxAQcPtUfXh/+Mu4/9xu4jJU+dgODg+RmrtYOLnB79H++6cu+RQJRkz/JjiQG1VI9
    pDS261guJXNnRi1hN6yZ7paBq50sy0Dtw0/Ac2k52jt2BwxjK1JB85E7XAimMfoZ8LxV
    fW1h+WGHw1Yzaa5b6RPNrZo1om2aLUK/cvNqemxc+mHLjjbKFNLNFENRXUBl/43pLMk8
    aymiqopWsy/Tof2g9Occ3A1GzrsPbyZ3yGWy3r3GRpDrB1fu39Qm2uIMg9opO0fmHxTL
    puG3kBPaIFheYmzhymV062BHvMVDzaEMq89ieSZVxzhd7Uy7j7kI9AAIouHu3weHeygA
    qhtw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1762243261;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=+q/Qq9/p1m/IXlfwo3H5YWviOgUNau2CDVmeH6Tuqgw=;
    b=CVgg5FbJDA1UTr/VNBH0EPet4vLkfW1UULcgSrM8PeYdsgzT/5j2BhqjTlB/+AqBzs
    lNFj6MC666d9Fb/Izy2YFzqEmGufOgIJshO4pvmp1Sihhv1XFMDWiSwqCIaZGUBv9XAV
    E3IQFlcYEWGusCod9apxu5R47ETbya9Y5i/CU6VZucpo+bKOH/0eImzuaaedDKFo6O/a
    50UpCe2U/gzMNKVsKx0vTBFmYnms3ANP4Se+xp+7VGkSiabiKzN1mUgjlmo96uLo61Sk
    02jwABa9Xs2ik6IckoU6+I2ufrcMdIQT77URsDRwh0W7AgI7qdfm4EnDT5YxuYQMRPBh
    LffQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 53.4.2 AUTH)
    with ESMTPSA id Kf23d01A48117AN
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 4 Nov 2025 09:01:01 +0100 (CET)
Message-ID: <570e0ca6-97ea-42d5-8604-4bc04c2fa1af@hartkopp.net>
Date: Tue, 4 Nov 2025 09:01:00 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/10] can: netlink: add CAN XL
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent Mailhol <mailhol@kernel.org>, Robert Nawrath
 <mbro1689@gmail.com>, Minh Le <minh.le.aj@renesas.com>,
 Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org,
 =?UTF-8?Q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>
References: <20251021-canxl-netlink-v2-0-8b8f58257ab6@kernel.org>
 <743ba133-3735-48fd-994a-9727cfe8c114@hartkopp.net>
 <69303466-a9ed-44cb-a1a9-30ac1451e7cb@kernel.org>
 <3d7521ba-bd71-46b0-9642-728a5222f2d6@hartkopp.net>
 <20251104-refined-winged-mamba-fd8cc1-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20251104-refined-winged-mamba-fd8cc1-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 04.11.25 08:28, Marc Kleine-Budde wrote:
> On 03.11.2025 20:15:59, Oliver Hartkopp wrote:
>>> I just sent
>>>
>>> https://lore.kernel.org/linux-can/20251102-pwm_sample_point-v1-0-3bbea180f59e@kernel.org/
>>>
>>> to address the problem. Let me know if this works in your test environment and I
>>> will merge it to the main series.
>>
>> Very elegant solution. I started some coding into this direction too.
>> Good that I didn't post it ;-)
>>
>> Tested-by: Oliver Hartkopp <socketcan@hartkopp.net>
>> Reviewed-by: Oliver Hartkopp <socketcan@hartkopp.net>
>>
>> For the series. The 'nominal' left over was also a good improvement.
> 
> Can you post your tags under the cover letter, so that b4 will pick it
> up automatically?
> 

Done!

Didn't know that there is an automatism for that.

Best regards,
Oliver


