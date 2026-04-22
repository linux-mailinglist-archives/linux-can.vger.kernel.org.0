Return-Path: <linux-can+bounces-7392-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGmuJN3F6GmYQAIAu9opvQ
	(envelope-from <linux-can+bounces-7392-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 22 Apr 2026 14:58:05 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6575C446521
	for <lists+linux-can@lfdr.de>; Wed, 22 Apr 2026 14:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A849D303B18D
	for <lists+linux-can@lfdr.de>; Wed, 22 Apr 2026 12:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABB43D3318;
	Wed, 22 Apr 2026 12:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Pu+uUp2p";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="umYBCoY6"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213AB3A6F07;
	Wed, 22 Apr 2026 12:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.161
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776862566; cv=pass; b=INgbxgviMsIskcfLGcS+md5L5beB9PWE43R+GQpqo4ExJc11AfZWZ/ZZO4wWSahe3EGJ5zRFRTg/ZmCOuxP8zWqYTESRAAri0llmi7jbIsj5kmBydUIMhD1INu7nS6B/LZXuYyrph2pNNLLb0zG+eFWCEwUAil0OpA3g5uBrQZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776862566; c=relaxed/simple;
	bh=o5Dv9glclspdfCzxiu5Rr1tCvunF5uf10h81Z3mtwEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GWlWZRbPsksAjv78DLLphv+nk3XXg9b1NNI7yj/FBqCkiHCn9iucM2xKCbHg1q+DM3BydHJfZVONh8ZYsQQdUBvNsIAJPnFozok5bftwmYoN/gi1jrAYQ7/In/OYYs3fYbvfFuSM6i7eiqEV05xx8bXKgAgfhY6A5ax5w0wlFgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Pu+uUp2p; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=umYBCoY6; arc=pass smtp.client-ip=81.169.146.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1776862556; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=cxrA67yAN6KF2DIAzwFuxrz/19i8amGtQRbZgccVzsgTcM/iMomBX+LXZCnRVYhSvC
    DjGCVRezoukhIfZDUdr8b/GSqmnC0kgRb5rwhYyvCHG3Sezo1SK2rLT5FKQh4EP00len
    JJu0BmHDM9+cgXAMZJso7B9KrJk+Wo8w/eGtGUWnYLBGWEyZsLO4EHeSqdJE/aaXL4kY
    tuR7vvt+bzdK/1T7XcH1T4aU2X3mpRWhfUN8piYD9aj4pb4D0QOFT27J2WR1zgBvETOB
    jJ7HprL01EYhnfGmxwvI0hzsiGkyPXk6iVqJ7bK8odhQcc0QPd1BbG9jjA6+uXbQ/9MY
    WJhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1776862556;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=KSCLGV8Hqoe+LFR+hxqyyN1voPNYYv2H4N+2OOqgeeE=;
    b=V0WXk7++nSVeYPCckk2sMBf+G/V1gR96VjbmEZwBH51FLJxjKynVf4qD7Llh8kVh5U
    CAbk1g6K/Wd+lzR331gE/PdP15Du6aimMWumfXwUg0+neEt1cyC8fOTmfXInkpTPL/s0
    zUWwu1nvGjWES/2JPzDFvpwVsZY4PT08frHs9vqCrT3CLGuiGWdKWF/WS7akhh2/arZh
    BhlAMyzW2kE1AYN4VBKwoxIj/ptuG82KqlgUIrIntwjelxuKWo6gysXQ/ix9uUkj+QH4
    /C7tcyCUXsRN4blh913o9epAB90xSJTR4SQxkELqN3QXqtPeOMkslRJlwuu/M886TJ63
    b2PA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1776862556;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=KSCLGV8Hqoe+LFR+hxqyyN1voPNYYv2H4N+2OOqgeeE=;
    b=Pu+uUp2pjOm23D+no+b5gdVIq8YYL+/7+rcSCKS6sKv2IjG4avpq0EtFHuPaYbSmS5
    VIgu8d0Z5/h0ncsB9eh89dDBXnlHgEpwEz1/BnPVNS9pHcKdRmdd67ggCjjyIcV7gxw9
    o7oBz/SLsmm5a9yX3t9j96wA7l6+YZL6exiMPksC0Sw/PMu3hBZCEs7bh7bTFO7syhdI
    GsWXhWA1nQ23IPanDnQTFXcMqPoXQk3HcP6QWwhgAeqdUOlgt1ZWCgWRT/1puzK6jw0L
    SGtcORfTJ0nOQpbKCkLDx2YlyRkAP9H9FWOiVU5RT+3hwmNxkBJbjhinQeP/QTPa/MM4
    Sy2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1776862556;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=KSCLGV8Hqoe+LFR+hxqyyN1voPNYYv2H4N+2OOqgeeE=;
    b=umYBCoY6ZC79iodSczEONM8+pK1oZHBNlhbh/w/80dWrMrddQOR8v6Xau1j49/+dwB
    ovQ/dyOJ+BmjgCeg7PBw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeFQ7s1YTqptmo87qzm6sElmZEI+VN6rw=="
Received: from [IPV6:2a00:6020:4a38:6800:3499:34c0:1f42:76da]
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id Kba96d23MCtugGA
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 22 Apr 2026 14:55:56 +0200 (CEST)
Message-ID: <6cc6eec9-2e8a-4a39-955a-0eeefc93fe97@hartkopp.net>
Date: Wed, 22 Apr 2026 14:55:50 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] can: bcm: prevent thrtimer UAF in rx path by checking
 RX_NO_AUTOTIMER
To: Lee Jones <lee@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>,
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260422102239.948594-1-lee@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260422102239.948594-1-lee@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7392-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MAILSPIKE_FAIL(0.00)[172.232.135.74:query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hartkopp.net:email,hartkopp.net:dkim,hartkopp.net:mid]
X-Rspamd-Queue-Id: 6575C446521
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 22.04.26 12:22, Lee Jones wrote:
> Commit f1b4e32aca08 ("can: bcm: use call_rcu() instead of costly
> synchronize_rcu()") removed the synchronize_rcu() call from
> bcm_delete_rx_op() and introduced the RX_NO_AUTOTIMER flag to prevent
> timers from being rearmed during deletion.  However, it only applied
> this check to op->timer via bcm_rx_starttimer().
> 
> It missed the fact that op->thrtimer can also be rearmed by an
> in-flight bcm_rx_handler() (which runs as an RCU reader) via
> bcm_rx_update_and_send().  This allows op->thrtimer to be queued after
> bcm_remove_op() has already cancelled it, leading to a use-after-free
> when the timer fires on the deferred-freed struct bcm_op.
> 
> Address the omission by checking the RX_NO_AUTOTIMER flag
> in bcm_rx_update_and_send() before starting op->thrtimer, effectively
> preventing it from being rearmed concurrently with teardown.
> 
> Signed-off-by: Lee Jones <lee@kernel.org>

Many thanks for the investigation and the fix!

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

Best regards,
Oliver

> ---
>   net/can/bcm.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index a4bef2c48a55..67e5b3149a8f 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
> @@ -539,6 +539,12 @@ static void bcm_rx_update_and_send(struct bcm_op *op,
>   	if (hrtimer_active(&op->thrtimer))
>   		return;
>   
> +	/* bcm_remove_op() may have cancelled thrtimer concurrently with this
> +	 * RCU-protected handler; do not rearm it. Mirrors bcm_rx_starttimer().
> +	 */
> +	if (op->flags & RX_NO_AUTOTIMER)
> +		return;
> +
>   	/* first reception with enabled throttling mode */
>   	if (!op->kt_lastmsg)
>   		goto rx_changed_settime;


