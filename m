Return-Path: <linux-can+bounces-6367-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNQhF7lAemmr4wEAu9opvQ
	(envelope-from <linux-can+bounces-6367-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 18:00:41 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4346A6765
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 18:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BB6130B1BE2
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 16:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3874431354D;
	Wed, 28 Jan 2026 16:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Wg0I/iMU";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="smAO8uqi"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED1728C2BF;
	Wed, 28 Jan 2026 16:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769617680; cv=pass; b=FYtZRd8ADbH7OcOfoDFmPlGQOlCqAN/nQtrTyZ2gqBTRAStx3hCUFsy9icYhSoqVr4zlSRlS9TntA+gVgpeZ6ZlX6MWKAgYQUrREqVj/U8+n/JRDWKCJpG2noDyHTTInPFeJObdHdrfkU/kQWXbYhQx4vCs4DHTgbz8PLG5oX8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769617680; c=relaxed/simple;
	bh=9NQhKrM07UxdnY6Nk+xaohP6SDmIBNYkltqED26I0vM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j9IxY6tLjDqX2TSvnHSiCHg3YKU/11xlnITUTBvjVwWW9H8b/+Zjgt18i78OVRTFtITilez4EwH/sgPRSlCRav020olOa+zANNOfeUG7uvr2yUJzFM7U4O7CPqxlKOhMv4ZPxt+WdKXEOkIyz/TCkJ+39GnuRT6TWxhsbaetiqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Wg0I/iMU; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=smAO8uqi; arc=pass smtp.client-ip=85.215.255.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1769617493; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=hNnujXp5Zx0p13EUNj3NnFTQcKUhNWCI/4EePvSaqKh48NjfhiSD4w+49T2f2IZOKE
    Xpvsvxi1aJYQCcQ2D6O4+TXKXSKwS+JPpM9xHejQR+bw2zhqGSgffJ4PUgOr5jmusDRc
    d9OmRSoAtVZkeaoY9hs5BRFqmZUZkRoi/3a0K6tSaM2xp6ae63QFaCaLwWY2mA4f4h28
    tknpowzq06xetEugYBwx/Mft/xutrIlTYjc/uQXG8DE0f13A63WUNrRU8YWTHAf2glR9
    mvesO3cKGWC2xqkQ6TlJrAQuyKe8a/KPfLbeaNCa+8fJ7BPYVdtr+DDn6KGVC5oioxJQ
    ZnAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1769617493;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ola9VCkQpAE85q7pA6oJgli7ByxYQZNZDz9woeMQWng=;
    b=VVCZLclPSEZkD7Uz4EbFWaLONvUr0qHaDszj9SX4FWet7u6jQ4cd6QjPeV5muViL1V
    GZqX20W6IPShlpvs7iH6xPJxKNaR6ytlzhPJJGDFGI1JLco9ZW7+jLWoxCb697VwjQa2
    Pjqireugk1ZR6jCnCCykLZcNmtMgV0hM3ISbOvXDA0rXdpNsaFII+XSmf8NPlZvZeOW0
    AQjnGG788zkb9Pn2LG92AKGsAH5swyiMv8D9kr5xGY92wRK7fYicVYtpAT0Frd86boka
    CUHfmohmGHliWO2Qa4LtDkKTXJ0elnvMWF/jsMkKlqXS/wnAEvnpGDWyybLUPFmU7Qlz
    5C+w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1769617493;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ola9VCkQpAE85q7pA6oJgli7ByxYQZNZDz9woeMQWng=;
    b=Wg0I/iMUdpXqxSg5CpVtb+029QQKvCKf51cVR8MAaiKOApmJ2xvyOWSPpzJqfQ1xVf
    uTCIY33cQX4kg8aiBTBzKguibucvRcvIdy09U7eaHGud7nmKFu7SngRSRTRBVq8tYAXI
    J3G/+q3PB1of8Cii7R0raodAp+qYUD2yP7COqOeRH1caQQP9uMBH4S2b/H1Nu4FPHgXL
    n9On0AUYXr5OGjw3Jue1k8f8bYb7TELTWCgf1SMSwlG40y7Lp+sbRkWp4YEq+2okpB9W
    QJbZpZTR4roW/z8x+mmeCr35P8QMPoye8AoT0JHR2L9uYY4f1UNF/Mr7DgzuCshSXj3F
    Vl6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1769617493;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ola9VCkQpAE85q7pA6oJgli7ByxYQZNZDz9woeMQWng=;
    b=smAO8uqifriuz6fKjTa1agjdRS75RWYVt1U2LHu3ytmtfisxXwSxuSqCfCClTAQa7/
    sm48qv1s5Dr2j1nR96Cw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8YjX10Q=="
Received: from [IPV6:2a00:6020:4a38:6810::76e]
    by smtp.strato.de (RZmta 54.1.0 AUTH)
    with ESMTPSA id K0e68b20SGOro7V
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 28 Jan 2026 17:24:53 +0100 (CET)
Message-ID: <4ae24c74-0f72-4565-9468-6fa43fa872a3@hartkopp.net>
Date: Wed, 28 Jan 2026 17:24:52 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [can-next,v2,6/6] can: gw: use can_gw_hops instead of
 sk_buff::csum_start
To: Jakub Kicinski <kuba@kernel.org>, mkl@pengutronix.de
Cc: pabeni@redhat.com, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, kernel@pengutronix.de, mailhol@kernel.org,
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, robin@protonic.nl, o.rempel@pengutronix.de
References: <20260128-can-skb-ext-v2-6-fe64aa152c8a@pengutronix.de>
 <20260128161248.40799-1-kuba@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260128161248.40799-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6367-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hartkopp.net:mid,hartkopp.net:dkim]
X-Rspamd-Queue-Id: B4346A6765
X-Rspamd-Action: no action



On 28.01.26 17:12, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> 
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---
> can: gw: use can_gw_hops instead of sk_buff::csum_start
> 
> This patch moves the hop counter storage from skb->csum_start to the CAN
> skb extension field can_skb_ext::can_gw_hops.
> 
>> diff --git a/net/can/gw.c b/net/can/gw.c
>> index ad89a1913b34..2c134c9e5159 100644
>> --- a/net/can/gw.c
>> +++ b/net/can/gw.c
> 
> [ ... ]
> 
>> @@ -480,19 +480,8 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *data)
>>   	/* Do not handle CAN frames routed more than 'max_hops' times.
>>   	 * In general we should never catch this delimiter which is intended
>>   	 * to cover a misconfiguration protection (e.g. circular CAN routes).
>> -	 *
>> -	 * The Controller Area Network controllers only accept CAN frames with
>> -	 * correct CRCs - which are not visible in the controller registers.
>> -	 * According to skbuff.h documentation the csum_start element for IP
>> -	 * checksums is undefined/unused when ip_summed == CHECKSUM_UNNECESSARY.
>> -	 * Only CAN skbs can be processed here which already have this property.
>>   	 */
>> -
>> -#define cgw_hops(skb) ((skb)->csum_start)
>> -
>> -	BUG_ON(skb->ip_summed != CHECKSUM_UNNECESSARY);
>> -
>> -	if (cgw_hops(skb) >= max_hops) {
>> +	if (csx->can_gw_hops >= max_hops) {
>              ^^^^^^^^^^^^^^^^
> Is csx->can_gw_hops initialized to zero for fresh CAN frames?
> 
> The old code used skb->csum_start which was zeroed by skbuff_clear() during
> skb allocation. The new code reads from can_skb_ext::can_gw_hops, but looking
> at alloc_can_skb() in drivers/net/can/dev/skb.c, only can_iif is initialized:
> 
>      csx = can_skb_ext_add(skb);
>      ...
>      csx->can_iif = dev->ifindex;
> 
> The skb extension memory comes from kmem_cache_alloc() without __GFP_ZERO in
> __skb_ext_alloc(), so can_gw_hops will contain garbage from the slab.

Correct. It is not only a leftover of using csum_start but also of my 
first implementation attempt using another space in struct sk_buff which 
was also zero-initialized.

I'll add some initialization in can_skb_ext_add() for the next respin.

Excellent feedback!

Many thanks,
Oliver

> 
> With default max_hops=1, if the garbage value is >= 1 (probability ~99.6%),
> the frame will be dropped at this check before any routing occurs.
> 
> Should alloc_can_skb(), alloc_canfd_skb(), and alloc_canxl_skb() initialize
> csx->can_gw_hops = 0?
> 
>>   		/* indicate deleted frames due to misconfiguration */
>>   		gwj->deleted_frames++;
>>   		return;
> 
> [ ... ]


