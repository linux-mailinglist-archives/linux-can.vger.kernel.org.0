Return-Path: <linux-can+bounces-6321-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDIWJo7GeWl0zAEAu9opvQ
	(envelope-from <linux-can+bounces-6321-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 09:19:26 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F909E246
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 09:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 144C03010219
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 08:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFD23382C4;
	Wed, 28 Jan 2026 08:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="JGkaXnvQ"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A759337BAA;
	Wed, 28 Jan 2026 08:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769588054; cv=none; b=VRyAfhJzF6ObQC1q3gN803LYZsb2tewXOsBTwjZpSkHcyN4nPR5p0Y7toX/hD3fCipZgHt93PHqm6gI2niezNJi4eQcyFwv/nUg7enk4E2LRVW3Abgde/iyQEfyBRSSHElOfY3WE0ZT+QwkgK1zAWj+07TwFrbSAIO/sQoFLMZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769588054; c=relaxed/simple;
	bh=z+Salvh3Z5+fu/3DF6Rxi+obK3Ji2aWWWYKCglT6Jhg=;
	h=Message-ID:Date:MIME-Version:Subject:References:From:To:Cc:
	 In-Reply-To:Content-Type; b=UPMHAiJUU7V6Hv+WmZEZqKC6QO1eztp8KSzhGlsqkRGVLmvUlmshtKyXqPwESwVkmEBwyhdniXv8qc70wDjFqgNzoBqtiNcfzDJ2JPERDjmKG8fbgx37bzk2PUHWmAK0rBvAaT9sqFFqg+0/+3R8k+LwzS1EwvC7INIAuq3tJxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=JGkaXnvQ reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4f1FRP61Jbz1DDhH;
	Wed, 28 Jan 2026 09:14:09 +0100 (CET)
Received: from [192.168.0.5] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4f1FRP0bFFz1DHYW;
	Wed, 28 Jan 2026 09:14:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1769588049;
	bh=5dbAuysCezI5UD5DuhEYGSHxJd1dLtZCL9nLyM/1xwg=;
	h=Date:Subject:References:From:To:Cc:In-Reply-To;
	b=JGkaXnvQorXSRuQCmVSiJrIQ/3kCXNKXQWEaeYQpoQ+fQpScobQbWQRqG9gy+fOmH
	 BhCsqHUBWMPIfJ5VM5y7Pedp77fu6qWcb6SQgDiWKKRcY/lEv1mrrzo4kgnw5100OF
	 ZpsgWIY40YTNDW909H5XFaU3x5zs64B14UFYV9FTqx2qz8uLN09CcUH6Om+gZK6VYQ
	 DiKWGdj7VevDtK89JS3QFCCGY6fxpRItzGt0C/MZJ1u+x62qQdACw4RP1/W5EumuKh
	 Y2iTDUKYHn0Jg8wLqVFhPpEIyD6ImgaZcM1RyUeISN0al9g688Qmps18/SsuLwjsHc
	 2bdyaZgvHnk1Q==
Message-ID: <98f03830-b52b-4dfb-b256-a5c545f48bf2@gaisler.com>
Date: Wed, 28 Jan 2026 09:14:08 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/15] can: grcan: Update echo skb handling to match
 variable length CANFD frame
References: <20260122121038.7910-1-arun.muthusamy@gaisler.com>
 <20260122121038.7910-16-arun.muthusamy@gaisler.com>
 <20260123-jolly-orangutan-of-finesse-5a9bb3-mkl@pengutronix.de>
Content-Language: en-US
From: Arun Muthusamy <arun.muthusamy@gaisler.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 mailhol@kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-can@vger.kernel.org
In-Reply-To: <20260123-jolly-orangutan-of-finesse-5a9bb3-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[gaisler.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6321-lists,linux-can=lfdr.de];
	DKIM_TRACE(0.00)[gaisler.com:~];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_PERMFAIL(0.00)[gaisler.com:s=simplycom2];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arun.muthusamy@gaisler.com,linux-can@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,dt];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 97F909E246
X-Rspamd-Action: no action


On 1/23/26 15:17, Marc Kleine-Budde wrote:
> On 22.01.2026 13:10:38, Arun Muthusamy wrote:
> [...]
>
>> @@ -1575,7 +1591,16 @@ static netdev_tx_t grcan_start_xmit(struct sk_buff *skb,
>>   	 * can_put_echo_skb would be an error unless other measures are
>>   	 * taken.
>>   	 */
>> -	can_put_echo_skb(skb, dev, slotindex, 0);
>> +
>> +	priv->echo_skb_idx = priv->next_echo_idx;
>> +
>> +	can_put_echo_skb(skb, dev, priv->next_echo_idx, 0);
>> +
>> +	/* Move to the next index in the echo skb buffer */
>> +	priv->next_echo_idx = (priv->next_echo_idx + 1) % priv->can.echo_skb_max;
>> +
>> +	if (priv->can.echo_skb[priv->echo_skb_idx])
>> +		netif_stop_queue(dev);
> You also use "if (unlikely(space == 1)) netif_stop_queue(dev);", that
> looks suspicious. Why have 2 independent ways to check if the TX queue
> is full?

That's correct.
Current implementation introduces two independent checks where space reflects hardware TX descriptor availability and echo slot availability.
I’ll rework this to use a single check, covering both TX ring space and echo slot availability.

-- 
-- 
BR,

Arun Muthusamy
Software Engineer
Frontgrade Gaisler
T : +46 (0) 700 558 528
arun.muthusamy@gaisler.com

Frontgrade Gaisler AB, Kungsgatan 12, SE-411 19 GÖTEBORG, Sweden.
+46 (0) 31 775 8650, www.gaisler.com


