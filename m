Return-Path: <linux-can+bounces-6162-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BF13FD23663
	for <lists+linux-can@lfdr.de>; Thu, 15 Jan 2026 10:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3EE9A3015474
	for <lists+linux-can@lfdr.de>; Thu, 15 Jan 2026 09:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116DF346792;
	Thu, 15 Jan 2026 09:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="GXH1yX73";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="g775CgO1"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44943054D0;
	Thu, 15 Jan 2026 09:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768468728; cv=pass; b=WARMtYjYbhrZqhiN9i18bw3jHKbTgSORgiGcDOotC8EZ7rxmMeWCD7JIueERwWkAk3oNYEl0Fakqm/L18NZFDEFH7i5M+gUx4Vft/VA4Cc5RqcqA5na9zicy2gefn6ggFqPbdhHV5dlT6/JJ8tbPurkFug/G/16GJAes9dlJ8ek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768468728; c=relaxed/simple;
	bh=M+pNp3LL/kN3rYrjcaGmOFQZ85UIrojKoSHO9Xaecmk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eF+K6zAvgPiXeaVSTkdjGfPwHaZRTcmpePanfMSLOvhXUiyc2XdFc8pVuz7TN8YXVsQN2eGBioLmt95DBXsa9YSCfx8G6Dqjjg7h3Sd+C4IL056gde8wqiOQCJ3hKg73EjIZT7peOd9TMX4PMsHilqRI+iqi0ZsU9l8DsWAkVqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=GXH1yX73; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=g775CgO1; arc=pass smtp.client-ip=85.215.255.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1768468705; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=O/WE1E2yBV/hKhYks0OvAIjnVcreLGvnsuOhQRFM9q9mWCSYZYNwfqYAk7c24tmBlI
    wonv4eDrk975GLbzmoIswpd9J3YB7MB16Qyg8WmozoiV1ErPbUfY/+jQIbl6woDmu5mp
    /a/cGiwwAv7Es54D6s2x9isSLuP8ar4blwDgsyca+/gYYAxZkBo5J9V7JQ8YmO7Dcb1B
    RJvxgiNxTuncprVjF2EJ5s4Pxzs+xNm80svwnUXaJ+qK15+P4FJ08rCirtNjTObWsYB9
    088gEi3Pg/39yCj/ixJA6e1RNmFVzFztMxXPm15SgBRBuyPhqf9lIrySJV4CZZx2XWOi
    /TUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1768468705;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=kov1ppaYr3cRWPRmOGZgrqZKh5WnMrlVWI+g1qVTpTY=;
    b=iB+QxLwXWSiRJtBnb7qCMNl9QcVklY0vlLq2yLTVaWedu3iZ9brZChKg8Nk+QJfvO3
    iGrhBg1B/YQI5A10q3e0X2n5EOWlMB0AiiJfi+TlQt7sEqQjNj2e1L7on3RCRnZ02YSP
    RdGPcQ4TcyTEM5QZ1Kf41Qz5OYqrXH3ZsLIhrkRurK7DpSeEU506Y5APAaDDVmgdY+pR
    4ugHXdlgj83iRV60g9/gQiQEddxmk/34loRtdCBvMWsnCMiWXoSr6CRZgxMoyQ7p33py
    4AtZNRXcYMFvvNzsAxxfospTMJ5P8fefRQnTRkQE68nLwWoHkVR5tyJN6NNrodstKtzY
    WIfQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1768468705;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=kov1ppaYr3cRWPRmOGZgrqZKh5WnMrlVWI+g1qVTpTY=;
    b=GXH1yX73Ic1sGghPRRRkhvqyhZY9VtOWYsf8+7eIwY6ozXwsNO9YHb/chH9RtlVNm3
    mFIhlHha+yHIGwgeNr0OIbRIsj6hfoxF8fxUeeZgHEf70AE93LCPBqOnA1BpepbcbfU6
    +QaRb95hv3DMZBPz4VXVhiKMoAUH89z8WwPlaFNdqHzJ7NxrjDKv6hoCBO56UBWBMQDJ
    DKJYXGcUx01U8AiMrs5TByUpQbeiDKKOjuuDmlPURfM+e5fEaml81N38ifUli57j14MV
    2S1DqTQQOSHvSooXsWFE3fzCkKx1dj3+beLZXW9BBb1PbeQXAQJaxqZHayEC+8mGAUz8
    AHXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1768468705;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=kov1ppaYr3cRWPRmOGZgrqZKh5WnMrlVWI+g1qVTpTY=;
    b=g775CgO1mow/o9IElOpmftLUlHacj08QWKC1s55qhIkL7tjxrSk8FTBOzv9PjDFE2W
    kSaoyrmC0yZlr28UBNAQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 54.1.0 AUTH)
    with ESMTPSA id K0e68b20F9IPxT3
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 15 Jan 2026 10:18:25 +0100 (CET)
Message-ID: <2b2b2049-644d-4088-812d-6a9d6f1b0fcc@hartkopp.net>
Date: Thu, 15 Jan 2026 10:18:19 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/4] can: raw: instantly reject disabled CAN frames
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de,
 Arnd Bergmann <arnd@arndb.de>, Vincent Mailhol <mailhol@kernel.org>
References: <20260114105212.1034554-1-mkl@pengutronix.de>
 <20260114105212.1034554-4-mkl@pengutronix.de>
 <0636c732-2e71-4633-8005-dfa85e1da445@hartkopp.net>
 <20260115-cordial-conscious-warthog-aa8079-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260115-cordial-conscious-warthog-aa8079-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 15.01.26 09:59, Marc Kleine-Budde wrote:
> On 15.01.2026 08:55:33, Oliver Hartkopp wrote:
>> Hello Marc,
>>
>> On 14.01.26 11:45, Marc Kleine-Budde wrote:
>>> From: Oliver Hartkopp <socketcan@hartkopp.net>
>>
>>> @@ -944,6 +945,10 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
>>>    	if (!dev)
>>>    		return -ENXIO;
>>> +	/* no sending on a CAN device in read-only mode */
>>> +	if (can_cap_enabled(dev, CAN_CAP_RO))
>>> +		return -EACCES;
>>> +
>>>    	skb = sock_alloc_send_skb(sk, size + sizeof(struct can_skb_priv),
>>>    				  msg->msg_flags & MSG_DONTWAIT, &err);
>>>    	if (!skb)
>>
>> At midnight the AI review from the netdev patchwork correctly identified a
>> problem with the above code:
>>
>> https://netdev-ai.bots.linux.dev/ai-review.html?id=fb201338-eed0-488f-bb32-5240af254cf4
> 
> Is the review sent exclusively in a direct email or available in a
> mailing list?

No. I have checked the status of our PR in patchwork yesterday:

https://patchwork.kernel.org/project/netdevbpf/list/?series=1042268

And I was wondering why my patch was marked "yellow"

https://patchwork.kernel.org/project/netdevbpf/patch/20260114105212.1034554-4-mkl@pengutronix.de/

The AI review marked the patch as "yellow" but the review result was not 
accessible until midnight.

A direct feedback to the authors would be helpful.

>> Can you please change it in your tree and send an updated PR?
> 
> yes

Many thanks!

Best regards,
Oliver


