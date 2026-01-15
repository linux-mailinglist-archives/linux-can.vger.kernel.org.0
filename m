Return-Path: <linux-can+bounces-6168-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6371D24BA2
	for <lists+linux-can@lfdr.de>; Thu, 15 Jan 2026 14:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6466630131F1
	for <lists+linux-can@lfdr.de>; Thu, 15 Jan 2026 13:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648EF36B04E;
	Thu, 15 Jan 2026 13:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="QBWTWCl4";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="OaRVXjJh"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64D627877D;
	Thu, 15 Jan 2026 13:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.165
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768483674; cv=pass; b=OJPUseOgkbHZr0AmCCKT3jyLajomGSKigtUExr0zuGgabzQ7mwY5kK94A73sR1lwOGArmPKACxlxMpvFKIPwKHQ4EbByFPgOzSYWqZsHluUFdgZOb8t7lphnhvYo52qiwV4wRJB6AJrSy70oSTp1NsJB7Iq+X8d2j5smwG4yU9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768483674; c=relaxed/simple;
	bh=fAl4hndFAzrYKviBxx8HduRVdvLrZaTIm5KpgIZDzSs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VK8tKML8dTm/z/2EbpMdvn09w8JMq2S9GJpSKGg7mxJb8zLPQWZB0kyPIER+AQVk6YqIraVNfD/3INcZurHZxwqOy6IlISIxXw3mafpCPxGc1qTeO+XPeJuaf39xM+q3TtdPhWNVHzm1EI7d+tfRa6dhfnqJ7g2sXy3uiqQniZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=QBWTWCl4; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=OaRVXjJh; arc=pass smtp.client-ip=81.169.146.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1768483647; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=lSUi8eeGTWzux517B6Q7H5TkthGS7y4K7alSRqqLg1//rcVpmaLRKK5PGjIYAa/VNP
    SDItnWk2yn2mRV12zbM9WdKh4HKcX5EX8Vw5l6LLXu7FHwVE4w7VSDGgqsLpwD/UqiqM
    XaV3iU1EMBzknFsMa2cnsd/xKWRhFiC56Uc1eLkl6PeU9G/S219vFr60PNAltHHvsOo4
    g1pE99bSD6XndMrbslAMSFeh7XjZOkz6ggSsl2tAvuBdKsqemsUL+ModchXhwQ+5Ph2Z
    oLd9ADW5jQItyKvp52zsoHakoohftflMkDCcdmXCrUMVuPEzEyqGL5lhxMmy6TEe85Ei
    ECqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1768483647;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=RxfL4Cr0VGYbmZRq1UjsK/K50UwqACOT8E3pWl+igYg=;
    b=kg4WM+nXO9ZSAN7pPJkE947/Ti/nq8jxh5klb3IQMHROQ5rpSwEqlUu4ETM0ncHGyg
    w3ZJh+TOi4F8BT/LP995Hz2N4gs4NJKINMS/uZv1aFdNQ4CnXZOe0DJWSkrp8Mdz9U0r
    2cAQ6gQ1b052wDM5Yfbyw3UtVABteS//kpWkwNFPffXmKLV6mZkkOvEVxvFoUsY2PInU
    Y7XEYr0izDUjsxnF1/R230eVK8JEO8I7Z9pniqywsTc09RvxNnOBJaFpZF4kZ/CnYX1Z
    6wOEekiSNvStvBfbQy1jCV+vtEQW+72qC/h4s1tMqLB975/pZqns//y7A8rL3gwqBeYq
    1hIw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1768483647;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=RxfL4Cr0VGYbmZRq1UjsK/K50UwqACOT8E3pWl+igYg=;
    b=QBWTWCl4FgNmfzAkaOkoV+yVeWBDTqqGSiFSvfw3U65PvyRYMWYbz8Z0jAVDZ+K5sG
    Wl/BrthUngoAbW9vgrcCHcY4+1V8uA20rQO5m1nPC6zJElUFQ4Z1eIgGm3kerbzVTTvJ
    PlevpQpGCO+5s53P9515z4N8NCHFGIvKPaljTMUX6keBO7zrLOvwla9+NrADQZjMmu7I
    lbZ+9QfvjavKGzEfW7NVXt4Jxf+DUCiirNUexUgA5ENsy1hBoYP+mLkjl6Sd4fAPgwpT
    MEz77frFRTTP0iB2AEVPrkdDmMVqig6qY2VJM1T+fne+wdCLUFF4rAwFX9pXmcX8OlTP
    9R/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1768483647;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=RxfL4Cr0VGYbmZRq1UjsK/K50UwqACOT8E3pWl+igYg=;
    b=OaRVXjJhWEJi/HSN+9feeIKFrC4gyr3fx3vtqJUXcDG000ZeN7jkDsYhwRX/6XUTbL
    MwvyHG/vjC9b5DmoYqDw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 54.1.0 AUTH)
    with ESMTPSA id K0e68b20FDRQzRv
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 15 Jan 2026 14:27:26 +0100 (CET)
Message-ID: <a8a6eb54-fbc3-4468-bc16-df0ed8eddf6d@hartkopp.net>
Date: Thu, 15 Jan 2026 14:27:26 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/4] can: raw: instantly reject disabled CAN frames
To: Paolo Abeni <pabeni@redhat.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de,
 Arnd Bergmann <arnd@arndb.de>, Vincent Mailhol <mailhol@kernel.org>
References: <20260114105212.1034554-1-mkl@pengutronix.de>
 <20260114105212.1034554-4-mkl@pengutronix.de>
 <0636c732-2e71-4633-8005-dfa85e1da445@hartkopp.net>
 <20260115-cordial-conscious-warthog-aa8079-mkl@pengutronix.de>
 <2b2b2049-644d-4088-812d-6a9d6f1b0fcc@hartkopp.net>
 <a315b18b-a9d5-4925-9e59-1b1596c28625@redhat.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <a315b18b-a9d5-4925-9e59-1b1596c28625@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 15.01.26 13:26, Paolo Abeni wrote:
> On 1/15/26 10:18 AM, Oliver Hartkopp wrote:

>> And I was wondering why my patch was marked "yellow"
>>
>> https://patchwork.kernel.org/project/netdevbpf/patch/20260114105212.1034554-4-mkl@pengutronix.de/
>>
>> The AI review marked the patch as "yellow" but the review result was not
>> accessible until midnight.
>>
>> A direct feedback to the authors would be helpful.
> 
> The AI review is intentionally "revealed" in PW after a grace period to
> avoid random people sending unreviewed/half-finished patches to the ML
> just to get the AI review.
> 
> I insisted to raise such grace period to 24h to align with the maximum
> re-submit rate, but I did not consider carefully the trusted PR cases.

Thanks for the explanation!

IMO the grace period is generally fine to control the re-submit rate.

Btw. automatically informing only the author (who's very likely in 
charge to provide a fix) would be helpful. E.g. when a PR/patchset is 
processed completely.

That would at least avoid patches from random people but would give more 
time to the author to think about his faults ;-)

Best regards,
Oliver

