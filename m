Return-Path: <linux-can+bounces-6005-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E1DCF8397
	for <lists+linux-can@lfdr.de>; Tue, 06 Jan 2026 13:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 81D0E3019870
	for <lists+linux-can@lfdr.de>; Tue,  6 Jan 2026 12:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7705C325720;
	Tue,  6 Jan 2026 12:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="FpFPi9mV";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="WkN2GiSP"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BE0327BEC;
	Tue,  6 Jan 2026 12:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767701272; cv=pass; b=kvvLeACOpzBwz9hlLF5uYob+9LxwIlt8bsB72rvhAYb0UeRkMR/cnRbNQfit39sey+trRxilL5YmRKynRHpKFpA3GVJs9z7/Qv+1/rwKhAaCKwncekz3CZ8MsBDbqbd0SArF77jqACNSrc6Ar4tKr208T8y/AvPbkskSK6KazTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767701272; c=relaxed/simple;
	bh=YAXT0O3clrTzMCs5KRYgX+2JTfAcxBl5AzcJ2oFofyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r3K8O+oiyz3+I7qh2iSLS6EVgGqyTb7Dz9VccuDR0fGVqDAfQpN+lV9DC8LQEHWamDskcflR+fJFAINMCxBT48PPvYCwEwRPNz+pkkzHZMOKwIrgWGEXI81PS1yudP/PiorvqCHrnqbFzLvd0EwZGtWHTL2Cu65TWvdq0F+WqaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=FpFPi9mV; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=WkN2GiSP; arc=pass smtp.client-ip=85.215.255.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1767701087; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Jx5crD+8pPxYHcgmxFlCpp4exR4z+37FYaB60Y//8dmu3kQJRmtkB0e2Y9aV+34wPL
    4VgY04oGqWTCllFeVJi04fr18xb6PrDVi5OsR4HTlUZPnJsRJZffhBR/9T378YxQmWoq
    aCbGVi1tlA+dVs5sZgfp5NNY3HEfV8LMd8nCpltIzJhV+dSNyLQAGzm6S4Vca35FTFR6
    bqlqdg6eHUzEz1Hp0QzimVH4W1xcqBpj3q0fJAJhB7YvEEMsvVILr2g9LolzSM39xpg2
    /7ZZjcXWS5RWTTNtinWlxokqgqupPJgnB+wBJtl02krh9Z2oj0bP0vFoSy+33/y9R4xA
    a9sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1767701087;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=deUOjmEYgote1SmyiYc5nEWPGyuAdQ53WBBCYSOu690=;
    b=ciYL58kzsXbw+ilBh1i/TKw3AnDY2h3WzJ185f4eIsQ5go/GGAlDR4cxKhvtsMbqmk
    aI21OOBoflz94pzyQPhvKoT4hcpgcS2gOHMIsNpQk7hVFne2Ozvg/11Cjz7gM+unE41o
    d+PzBuCxc1Gdv/8YH/nxmtHx7ZvXJab3k2vxHxhwGkjPEYNLGILSvJiruHtLda2Wjdlq
    /PlHFc/9d2EaWnMOYgwkXUplVAU5i4lxow9Z1Jl8WXlATl4jewit72OLEUu7cPJnk1db
    4w3JhUaTdr0De3jJYPO0CUI5eNh1ANs8a6R9bIZO0h1/0Zm0fenjGMDnYTXZlKPIJiIP
    0sbw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1767701087;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=deUOjmEYgote1SmyiYc5nEWPGyuAdQ53WBBCYSOu690=;
    b=FpFPi9mVziERiP+pIsxye8bNqoM4TDt04WO+zudcLdhp6AabzDyV8cnb2O4kRJbP73
    CLQpULB3G69BSzIAfHXvhQzvRztU1RdRhjdtK9p3euMwqSktCmdbpplm12tUtR5k5Ezh
    46sGaE0WzalUTks4/TAEzz4WeBUl+sWrLUIA7DJsuBDwJ4rLm6A0u6E7cACDktxKXxVd
    xNQaZXlPvr8tyvmyhOoShbJaplnf/7n06HU/8J8+7jwBlG3OGNfnIs8JCqH0PDw5nFW2
    TbmFU0Z9gRYzND/ulzbkvSXLuChuSOwWjt0Ffn9tPwm9is+CBv1ZODEqmN4sAfvGqBBt
    WtZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1767701087;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=deUOjmEYgote1SmyiYc5nEWPGyuAdQ53WBBCYSOu690=;
    b=WkN2GiSPTY2mqXSRTzV+62iq2V5xV0W7SMtM+MUVz0cFUF2uxgAwHJwav24xyXaiJF
    fGWleNP5apItm19nlOCQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 54.1.0 AUTH)
    with ESMTPSA id K0e68b206C4k4IG
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 6 Jan 2026 13:04:46 +0100 (CET)
Message-ID: <904fa297-b657-4f5b-9999-b8cfcc11bfa9@hartkopp.net>
Date: Tue, 6 Jan 2026 13:04:41 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bpf, xdp] headroom - was: Re: Question about to KMSAN:
 uninit-value in can_receive
To: Jakub Kicinski <kuba@kernel.org>
Cc: mkl@pengutronix.de, Prithvi <activprithvi@gmail.com>, andrii@kernel.org,
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, netdev@vger.kernel.org
References: <20251117173012.230731-1-activprithvi@gmail.com>
 <0c98b1c4-3975-4bf5-9049-9d7f10d22a6d@hartkopp.net>
 <c2cead0a-06ed-4da4-a4e4-8498908aae3e@hartkopp.net>
 <aSx++4VrGOm8zHDb@inspiron>
 <d6077d36-93ed-4a6d-9eed-42b1b22cdffb@hartkopp.net>
 <20251220173338.w7n3n4lkvxwaq6ae@inspiron>
 <01190c40-d348-4521-a2ab-3e9139cc832e@hartkopp.net>
 <20260102153611.63wipdy2meh3ovel@inspiron>
 <20260102120405.34613b68@kernel.org>
 <63c20aae-e014-44f9-a201-99e0e7abadcb@hartkopp.net>
 <20260104074222.29e660ac@kernel.org>
 <fac5da75-2fc0-464c-be90-34220313af64@hartkopp.net>
 <20260105152638.74cfea6c@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260105152638.74cfea6c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06.01.26 00:26, Jakub Kicinski wrote:
> On Mon, 5 Jan 2026 14:47:08 +0100 Oliver Hartkopp wrote:
>> For the ifindex I would propose to store it in struct skb_shared_info:
>>
>> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
>> index 86737076101d..f7233b8f461c 100644
>> --- a/include/linux/skbuff.h
>> +++ b/include/linux/skbuff.h
>> @@ -604,10 +604,15 @@ struct skb_shared_info {
>>                   struct xsk_tx_metadata_compl xsk_meta;
>>           };
>>           unsigned int    gso_type;
>>           u32             tskey;
>>
>> +#if IS_ENABLED(CONFIG_CAN)
>> +       /* initial CAN iif to avoid routing back to it (can-gw) */
>> +       int can_iif;
>> +#endif
>> +
>>           /*
>>            * Warning : all fields before dataref are cleared in __alloc_skb()
>>            */
>>           atomic_t        dataref;
>>
>> Would this be a suitable approach to get rid of struct can_skb_priv in
>> your opinion?
> 
> Possibly a naive question but why is skb_iif not working here?

With the CAN gateway (net/can/gw.c) incoming CAN frames can be modified 
and forwarded to other CAN interfaces via dev_queue_xmit(skb).

When such skb is echo'ed back after successful transmission via 
netif_rx() this leads to skb->skb_iif = skb->dev->ifindex;

To prevent a loopback the CAN frame must not be sent back to the 
originating interface - even when it has been routed to different CAN 
interfaces in the meantime (which always overwrites skb_iif).

Therefore we need to maintain the "real original" incoming interface.

can_iif could also be named skb_initial_iif when someone else would need 
such an information too.

Best regards,
Oliver



