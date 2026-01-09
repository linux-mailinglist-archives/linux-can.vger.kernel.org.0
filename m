Return-Path: <linux-can+bounces-6062-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB642D0850C
	for <lists+linux-can@lfdr.de>; Fri, 09 Jan 2026 10:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E3C3E3088352
	for <lists+linux-can@lfdr.de>; Fri,  9 Jan 2026 09:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86513596FA;
	Fri,  9 Jan 2026 09:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="a3WoYgDK";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="XvjdOzvn"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB7435A940
	for <linux-can@vger.kernel.org>; Fri,  9 Jan 2026 09:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767951848; cv=pass; b=aflIfyTJmKt1FZXGHyEGTH/rC1wm4gGiCF/w0v/0akohWtI8zItb09FxU2oJW+bdaWAdAlsAQshuIFKMamDiRaMKoCo7wP3m0OZgWl2NOdzzi4VunwYtw1h+bVGYrBYWTjyhWGbhRCBAs8Yen7y9CwEjy6w/p8Uoni93RKwczoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767951848; c=relaxed/simple;
	bh=mYYguxQeSU5v4fJt5B7E9kHDn6ba81991BAMvPZHsBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KtMU+s6eRA8IzsBC7PUDcEMj5wABmD1HJ1jruhanxC/T2D/CIcvdzCVFBM6D60JQ0jHok2zoeg6XUvOkBOxBrDjJkRtbNIaSnEaPP1ZVdrGY7k6KoiC4/PD/DiVHehonPOrOwVtbSKYIYS3a1FNLHmTos1uAXLCPPHDXS5Xpts8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=a3WoYgDK; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=XvjdOzvn; arc=pass smtp.client-ip=85.215.255.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1767951841; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=c3VlzG+2BkXXtsqZtZzdv7rV85cNwmr/MA+wUFM/PnNgfZDKyovzbwGxoLdjhZaZ8y
    e6kniyFblPzbH3Agv/rHWp0Avesb91iq2Jm3cJIKPEMZ5MZZ9J6ylllO39FnYarlabHz
    jxGW/F67YT4sA19iZ+msRO30EsOAcUHsg/2AGDveEgtq1g80CvyQCL88R+OWyeiyNXiG
    bMTwKYmKW4u9cBkBwYaRkSbf9lw9CGlueeVCTG9M15uh7CosINsrn5S8muDXM/YWX3ar
    aWTEo4uLlK1FtBoH+Gz6zNmcY7Q4V2fT30AyVtLuwZbejfEtZa6cet6t/Wu4oL1ehTDE
    ZweQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1767951841;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Ro6imMG+qNc4s0CeGcVBPwjg9uJcAZNXa5oInXEDpLQ=;
    b=XhSJAL0IKDQQDfbpC322D/puJKfxfGD9t7JuKxOAUT/IYm6Bm8ulTNwOVpK0ucI0zM
    si5g8j9nZYM1/hYpWlxVYt5F3YwEs+lhLKtInm+briK2MGjcyRzF7AGxdH2d96cwzdaZ
    hGe8lk5KLqhMFIzPjFP1kzQQN1V612CKA4d8Pia1qSIlV4fHVRXbmPpWVkg2uXYkpDab
    v6pBOSrWkm0gvYWEWyAs+E1MOTuJWQTz8FCXzRgq7D2FhqC3ev6GeU5H0JyibSdVPu1T
    hbkFqYHKGHp/Ex+G3e321Xu3hFhc3AfGctAG6oIgev9mQbyXfkb5C4FG+l8qR1dIV/wy
    8fSA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1767951841;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Ro6imMG+qNc4s0CeGcVBPwjg9uJcAZNXa5oInXEDpLQ=;
    b=a3WoYgDKFL/HjkSuiMcMyJ7Qz4iDilvUdhugVUL0qb/2p601zcrYnME3VqNipQkPWk
    MlSTaboO0+ZCUxKaj4aehlHoDTAvKZxhBco/wmBWzNiSiOMkie+wJrMeJ7K+OML05gkE
    bZ7VVt3smGm9Xj6Uw05+yeJr4U7EcSPEi6BmWcqxn5avX8/Cc7XcC8J+qJ7/nNJDRfdG
    Rostt4ZPoTs0EeHlBZmaVGuzQ7KeMcGumVpR10dWtd9RHKEwiHR2CyfNdJzxDXDiEE2z
    E49vAOVj4nBQAQ7fOnaSJEfgzutgKn7DgYFYLAy4y22Qhayx7pYFyRlTCzpaF9+uaK6G
    VM7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1767951841;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Ro6imMG+qNc4s0CeGcVBPwjg9uJcAZNXa5oInXEDpLQ=;
    b=XvjdOzvnujihWcsZFV9H0FvJpsDV7vqc08wgW/lut39ySNc7HgoKmC9V7diWStWshh
    HtYc9hj5nqiDiLCnwEAg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 54.1.0 AUTH)
    with ESMTPSA id K0e68b2099i1NL3
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 9 Jan 2026 10:44:01 +0100 (CET)
Message-ID: <528a16f8-1967-4bd5-bd91-6d0eb14c76e0@hartkopp.net>
Date: Fri, 9 Jan 2026 10:43:56 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] can: propagate CAN device capabilities via ml_priv
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>
References: <20260101191330.1836-1-socketcan@hartkopp.net>
 <20260101191330.1836-2-socketcan@hartkopp.net>
 <16a623ec-beb9-4968-bf16-75676d516c0e@hartkopp.net>
 <20260109-precious-bettong-of-courtesy-989324-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260109-precious-bettong-of-courtesy-989324-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 09.01.26 10:23, Marc Kleine-Budde wrote:
> On 06.01.2026 16:40:07, Oliver Hartkopp wrote:
>> On 01.01.26 20:13, Oliver Hartkopp wrote:
>>> Commit 1a620a723853 ("can: raw: instantly reject unsupported CAN frames")
>>> caused a sequence of dependency and linker fixes.
>>>
>>> The entire problem was caused by the requirement that a new network layer
>>> feature needed to know about the protocol capabilities of the CAN devices.
>>> Instead of accessing CAN device internal data structures which caused the
>>> dependency problems this patch introduces capability information into the
>>> CAN specific ml_priv data which is accessible from both sides.
>>>
>>> With this change the CAN network layer can check the required features and
>>> the decoupling of the driver layer and network layer is restored.
>>>
>>> Fixes: 1a620a723853 ("can: raw: instantly reject unsupported CAN frames")
>>
>> Are you fine with this patch set?
>> I've tested it and it works as expected.
> 
> It seems to be OK as an interim solution, that fixes current mess.
> 
> But the main problem is, that we don't have the "struct can_priv can" in
> the netdev_priv of virtual devices. That should be fixed sooner or
> later.

I don't think so. In fact the virtual CAN interfaces vcan/vxcan don't 
need any CAN driver infrastructure to do their work. So why require to 
add lots of code for hardware-less setups?

When you really want to play with a virtual CAN driver that supports the 
entire struct can_priv mechanic and netlink configuration, Vincents new 
dummy_can driver does an excellent work.

Maybe we should improve the v[x]can drivers to reduce code duplications 
in the future.

>> IMO the two patches after the revert should have no problems to be accepted
>> as they restore the functionality we already had in 6.19-rc1.
> 
> Yes, I think so.

Thanks. The three patches are candidates for Jakubs "Current release - 
fix to a fix:" section in his PR description ;-)

Best regards,
Oliver


