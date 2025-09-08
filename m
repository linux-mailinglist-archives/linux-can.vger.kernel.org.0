Return-Path: <linux-can+bounces-4514-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D76B48C1F
	for <lists+linux-can@lfdr.de>; Mon,  8 Sep 2025 13:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 881A93B1986
	for <lists+linux-can@lfdr.de>; Mon,  8 Sep 2025 11:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1476918C2C;
	Mon,  8 Sep 2025 11:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="tIXDy8Nz";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="AbVhXlc4"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBFA213236
	for <linux-can@vger.kernel.org>; Mon,  8 Sep 2025 11:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.220
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757330871; cv=pass; b=naGht78F1p/HDps6/mJtF3mpUODzjQa08xNUSvg01uwt8nWp9AXXgZLvysUqLu3kO65Jf1MBmYI1U993BoQ6I4hBRsUNVWXlp8XhrbmEUjXE+d/yzQDdchCgq4uGvRurxloERWVRz/lBky6BEZxWj4zFLYLVBybTsbYFTTIcspY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757330871; c=relaxed/simple;
	bh=42e94fVWOWJ/h6ezh1E/PyZ/Pld30Pe5eEFQn9NlOQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tTyVpXjvZBZcm9bXK6ovUqaQR4JNf0y1otm13xYh0tF7PcyJEe2vRQ3tKT6SLS3yM5mdLE2suQ1xWINHi3SkyO7P4r/4KTyC/VjLG2BeGhL+fKf5Njx94axAnT/oG+IYgvuCIYy210iRHcjK6YX3KHh+FV8KIWPd+/0YJrqOc4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=tIXDy8Nz; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=AbVhXlc4; arc=pass smtp.client-ip=81.169.146.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1757330867; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=F8xF1l+KreyMpzqWPGcI1dd/wRLwbVYfchq10Wb8+/6tYSl3mDQt8StacxKoWFW3E0
    M8YZ7RWTfO+8J3wfpzksYDxettQzgIzJsaZEhlY4QUWjoYt7Im85ltUd0L/EYXiq0yUs
    zXYeirDVOzHb7biVXxf3U+gVbmybTfm2Rdkkbb7o7TRzy1KXtKvoT3hd1i4ry0iI4yqc
    uC93YYBW2LfxG2v1P9ZfcPivE5/2U0L4tICZUvf0GhHCWcJ6Mv6s9j5prDOp5obdKZpr
    dam3iHe8vvL3Y1b9ftbeyZuZL1Lp4l6hjVwOnZ4YKsqzpr2mzi0AKqlzz2BZNjojPC/f
    ZM7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1757330867;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=yK7nIzk7aVNTqXHQVvUE1JwE7HHh3DRn7et3EVI/WGY=;
    b=QLRIQnhqZOJV4qGjlSaCxuYHiqRSnKfJm8sye01Z+HkSEjo4KkuNumLlJfnEA9fEWb
    MDd+zxwCTroQ0U/aQ6MnrZiwUPF7l5kfHmJa9abYrlkM+kBj4ehYIX8QVO2LuVMEODsp
    AzXk2IbL3aCR2ti97LLVOOZon7gXLRHgFRA3wpRm1bcFBGF/32NgTckr3L0/8we7s34T
    sOlx6MaIgaQPoiAS3iwbmm9448QC8dNUms3cKKsPowlgncvg52Naol96/AWa/Fzcaot7
    JrVqumYkd13tnFWKYyGTq23lopko3FNS5cKGEb1XiI+dBU39+wqmB07DaxgZO2R0rqWZ
    6eKw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1757330867;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=yK7nIzk7aVNTqXHQVvUE1JwE7HHh3DRn7et3EVI/WGY=;
    b=tIXDy8NzNZ9mMWv0NXhS0Q+qmdU49ii2KO2w37z5Mx8vsY2kCJJwmj4ioMgCnp4GNZ
    YOcvmVIYI6q2XnYbqZPPaJy2XKccqycDPiM5t/1Ny5eqGnm4SrjepXYgY1dIBtVGrECw
    ST872XA0Xf/cMrcq4gSvre/tEmxSOW8BlqkBrFYzzGiUQCj1mbWLnQsnArMy1duz+TOI
    cBE+QqPVcKJFJCAOzi3rMXRwRDXTlHmWFlcTUUJcLsmTSozsNLCeDBUUSmfkN/NzqK55
    nmKE00NgMq07uK3e1Inf+K/RAD4xU8/1q7+3TpldGZGnPaiDmfyx7E6fqlKEv/cX5bm0
    OxYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1757330867;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=yK7nIzk7aVNTqXHQVvUE1JwE7HHh3DRn7et3EVI/WGY=;
    b=AbVhXlc4BohAHw8vZzu/6VOxV56y3+blPRgkD6OiPD+U1aURNqFANVzBb5RaJLqtzm
    m349Go5BGG50kpFhI3BQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 52.1.2 AUTH)
    with ESMTPSA id K5d361188BRlZNd
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 8 Sep 2025 13:27:47 +0200 (CEST)
Message-ID: <4242f299-64c2-47f1-90d5-6381752bc1f3@hartkopp.net>
Date: Mon, 8 Sep 2025 13:27:46 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH can-utils] cangen: allow to use -m on classical CAN
 interfaces
To: Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org
References: <20250907060330.441165-1-mailhol@kernel.org>
 <20250908-hilarious-myna-of-relaxation-f26357-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20250908-hilarious-myna-of-relaxation-f26357-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Me too :-D

https://github.com/linux-can/can-utils/pull/600

The former concept mixed the actual frame format (canfd canxl) with the 
switch whether FD/XL is enabled and operable.

So I reworked the idea from Vincent.

Best regards,
Oliver

On 08.09.25 13:10, Marc Kleine-Budde wrote:
> On 07.09.2025 15:03:30, Vincent Mailhol wrote:
>> The -m option currently only works on CAN FD or CAN XL interfaces.
>> There is a logic to add CAN XL to the mix only if supported but CAN FD
>> is always forced.
>>
>> Modify the -m logic so that only the options supported by the
>> interface are added to the mix. This way:
>>
>>    - a Classical CAN interface only mixes -e and -R
>>    - a CAN FD interface mixes -e, -R, -f, -b and -E
>>    - a CAN XL interface mixes -e, -R, -f, -b, -E and -X
>>
>> This provides a better user experience and also makes -m a good
>> default option for fuzzing any type of CAN interface.
> 
> I've created a PR on GH:
> https://github.com/linux-can/can-utils/pull/599
> 
> Marc
> 


