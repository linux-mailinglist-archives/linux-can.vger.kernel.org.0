Return-Path: <linux-can+bounces-6020-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC5DCFEADC
	for <lists+linux-can@lfdr.de>; Wed, 07 Jan 2026 16:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A4DC730A8646
	for <lists+linux-can@lfdr.de>; Wed,  7 Jan 2026 15:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C80395DB8;
	Wed,  7 Jan 2026 15:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="eQ7TJO44";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="LSQQ2Z5j"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE82395D90;
	Wed,  7 Jan 2026 15:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767800071; cv=pass; b=l0R/xKYpQgeuRQ0UHeyO6M3ifbbWdoQnGPx9ZFbWsWVgCkOyqRhrPEy/3R362wNGO2TFO2szHcdyKFZEm8RlWKWbM5FfoD9yDLvv7olVgZFtFZdGMo/oAiEM8QWQ33XZ3VVNPd8qPiWTBxk6Ta1IFJ9v9cyTvJKZO6kRioQu3Xc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767800071; c=relaxed/simple;
	bh=UZZarDGIHnVTIoQ8enN9Zph0GfAT5H+xlYSwfaS7/b4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JuX3Z8oUjsDXpbHfAz3VqzmKBUyG86UCToK52HxcGBiCH26Yf61ALP8+l7ccsT0XSEDk9DxeWRwtRlyIDQLK6Dr9ZBbt+EkQhwpD3D3sHgzZx0tP84ayiu0Ba87zU3IWVnKSs1Zv8ZwmblgvM+VkMZNRzQHj3MDXKYJyGSRy6yA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=eQ7TJO44; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=LSQQ2Z5j; arc=pass smtp.client-ip=85.215.255.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1767800059; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Y8AqzZECsUtKXD47IaJyz6CUOMhsEeJ2E7JoIdJFvlyNY1UeyMq6GgKvgrE5CLetxA
    SUdQqWz31eQlqXhxzlQPWoOP08eVUFqhPb70uTGNckwGUvsaYHLo6VzsCcgZ75g6pBTb
    n3Reh5VFmdDfzBvYU3yJpdjzC0Ld6u7S731RTSW84M7wEWmtSiS/hSzhwJLxn+ORJQvQ
    AQBWde5p2DgY9QXZhlzR2fQO6nf/KEsuScsnkYIxzNWLN7J6gnpfjV72qTIxjzULOzvk
    mcEwvBKukPX4uaisENRVIweQD56po/fODN1r+hydZOhmwrzKW/+LBCWlpiBL0cqJsXSm
    j9Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1767800059;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=9NgbAeqzyHQXGFfVjBUF3lSa3PSH4LNlvLsaHRyC/Ro=;
    b=YWP9OQI1zSmmJP2ITyacR0ZakUnMVU0t+BGVaXtJ8SJLPLVgiVDXyHJA6DWcHL0Z4o
    zm29yFOtcY4CYQ8S6GxlCa6DJTbzvDfWZusWZA8lToJ6z8lrFjKayfWysWbPQx1jLljP
    m7EJIf3aTNJY66xmSo1UG02F2IdQZ2LBcNqpdQnxmkjlEZIn9B/NbEND+37omU+Pz6lf
    bRJAbQXaiWugWSGiRsI6kf4C1knEZN4EVfBcP1ciS+Yj7VJdkBme3vsk8Ak+z2gQ4aV5
    gcm4dXoHRMBN7dO9IcU9IBMyzq/ityw7xQczMsd/Jj0EPg03SheO/BlHDLlc6U13DksI
    3lrA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1767800059;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=9NgbAeqzyHQXGFfVjBUF3lSa3PSH4LNlvLsaHRyC/Ro=;
    b=eQ7TJO44rUjF23D9lQY1Lna/TzxzECfBfaB6cED4gcnQDlxYWLnk+8DA6fDUUUPPfK
    j1fmN7f978eJ6LAUTZLOBqsWhjKSIds/9QBDz21ZhLsJ6gDAmYQ/76MLd3oF2zsu6U8V
    2YPcjxRquEv7Pwq1MeKw6BKqtIuJTiwEgSlELwZokCRuI5x3453hjE6UwgcwY0EdM+js
    UaTuje/YsIEIgWyFGAt0+86ojGkZ+yNpSwmx+6mDMhvucgyzSY1DGsbAVOljPGItfIRf
    sQyVCVk3oKZCfALboZzH9UGqOpKmVdP3eVAZQS+lV9NMAkj3Dgn3V3gWyIVM/nn+yaTD
    Oz8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1767800059;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=9NgbAeqzyHQXGFfVjBUF3lSa3PSH4LNlvLsaHRyC/Ro=;
    b=LSQQ2Z5jZVIUPlGGD3ht5/t24eB9Cxae7AFDLH2XkKZLBAjhvsMGE/Nv/WummSvYVX
    TmKA2xfY71cTF/2A80AQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeFQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6800::9f3]
    by smtp.strato.de (RZmta 54.1.0 AUTH)
    with ESMTPSA id K0e68b207FYJD0i
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 7 Jan 2026 16:34:19 +0100 (CET)
Message-ID: <8b55ae26-daba-4b2e-a10b-4be367fb42d0@hartkopp.net>
Date: Wed, 7 Jan 2026 16:34:13 +0100
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
 <904fa297-b657-4f5b-9999-b8cfcc11bfa9@hartkopp.net>
 <20260106162306.0649424c@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260106162306.0649424c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Jakub,

On 07.01.26 01:23, Jakub Kicinski wrote:
> On Tue, 6 Jan 2026 13:04:41 +0100 Oliver Hartkopp wrote:
>> When such skb is echo'ed back after successful transmission via
>> netif_rx() this leads to skb->skb_iif = skb->dev->ifindex;
>>
>> To prevent a loopback the CAN frame must not be sent back to the
>> originating interface - even when it has been routed to different CAN
>> interfaces in the meantime (which always overwrites skb_iif).
>>
>> Therefore we need to maintain the "real original" incoming interface.
> 
> Alternatively perhaps for this particular use case you could use
> something like metadata_dst to mark the frame as forwarded / annotate
> with the originating ifindex?

I looked into it and the way how skb_dst is shared in the union behind 
cb[] does not look very promising for skbs that wander up and down in 
the network layer. And it is pretty complex to just store a single 
interface index integer value.

While looking into _sk_redir to see how the _skb_refdst union is used, 
I've seen that the _sk_redir function was removed from struct tcp_skb_cb 
(commit e3526bb92a208).

Today we use skb->cb only for passing (address) information from the 
network layer to the socket layer and user space. But the space in cb[] 
could also hold the content we currently store in the problematic skb 
headroom.

Would using skb->cb be a good approach for CAN skbs (that do not have 
any of the Ethernet/TCP/IP requirements/features) or will there still be 
networking code (besides CAN drivers and CAN network layer) that writes 
into cb[] when passing the CAN skb up and down in the stack?

/**
  * struct can_skb_cb - private data inside CAN skb->cb
  * cb[] is 64 bit aligned which is also recommended for struct sockaddr_can
  * @magic:	to check if someone wrote to our CAN skb->cb space
  * @flags:	extra flags for CAN_RAW and CAN_BCM sockets
  * @can_addr:	socket address information to userspace
  * @can_iif:	ifindex of the first interface the CAN frame appeared on
  * @skbcnt:	atomic counter to have an unique id together with skb pointer
  * @frame_len:	bql length cache of CAN frame in data link layer
  */
struct can_skb_cb {
	u32 magic;
	u32 flags;
	struct sockaddr_can can_addr;
	int can_iif;
	int skbcnt;
	unsigned int frame_len;
};

If not: We also don't have vlans nor inner[protocol|headers] in CAN 
where we might store the 4 byte can_iif integer ...

Many thanks and best regards,
Oliver

