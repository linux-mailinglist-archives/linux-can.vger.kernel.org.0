Return-Path: <linux-can+bounces-7705-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLNgGn9+FWqtWAcAu9opvQ
	(envelope-from <linux-can+bounces-7705-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 26 May 2026 13:05:35 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1915D4A1C
	for <lists+linux-can@lfdr.de>; Tue, 26 May 2026 13:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9AED9300E253
	for <lists+linux-can@lfdr.de>; Tue, 26 May 2026 10:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF653DD856;
	Tue, 26 May 2026 10:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="JeaGSPnD";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="UOY/OOmp"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E92F3CA4BF
	for <linux-can@vger.kernel.org>; Tue, 26 May 2026 10:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.216
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779793191; cv=pass; b=CS6df2ixwpSu/ulzLR97JybptqLt4peSSQ6aTeJ9mtyT/qaez7Rh6yBo9mN9XtkcVvymseIhC4eNmW7s2QzgQdkhphEqH3hKVBLJB4KztwEjSpswYJt2j1g+2iOt8bwhwhWG8I+aCwCH9pyoj47/74CflhnUguZJ9zUb40e6TEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779793191; c=relaxed/simple;
	bh=VSjxwCB3YAnEvJ9x9a/8TJR4ulTC8lJKW7S6/kgHmyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DfB98L3X3W2p1Bba2tEla7x1DF8pRq5ypcnowN+GmyRe76Ifkctmb8Fu4mxWBkYoHYofo9Xsl2+5k+sM9gROP0d7XpgE6mmBYJHyFQAS9DYV42eOrcIBVQEjg9VP+sedjtnk/cWxASf8xJOT5wS7dYD8CmbFDVtb6qrs3DTsgbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=JeaGSPnD; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=UOY/OOmp; arc=pass smtp.client-ip=81.169.146.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1779793181; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ApOQVBhItoA5hzQTyYhLDpj9YiFW5LZ7n7Cxf+Vmo6tl4Lg+4B84b4GhAgb7zzsLjx
    MAGcDq77nlJV9E0E6NqM0CBW7lUr6PQKtsZRl5QoDjS14Nl/3Q9uIWyubM0fSa6odsGZ
    arGV1iBsugb++URrFlcPPiTQEgFNmwhjcmKPpOuiarDTm9X8T3EDFOXyU5zsrP9FovkK
    5eRXSgJGD95DseCRcGdNv72x05OvohuQesjgHukybQ1V3h8vHZ4SO04+PWOil6KHzjjc
    s18KygGxa+/KA6ypYdE6AiVfPGoMxSJWX31TR1QE471qx322a+SFAbO+3/F7QClhe1gG
    OGTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1779793181;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Wsog6vkIHYV+XZ+McVYGFSFZFxQ8V2JlCaLz89lVYqg=;
    b=alkdm3bQI/4DhrNkXaHdEbqnLu1eHMWy/pby7iJE61AP1j3aBcZLJN8mDTMK9nuB3c
    pg7MTIDB5ycOPEj6C22tkh/cWKtIizbQzaXUFpDmfUOEJy9biY1VPOOStbUuwJ2MUbxN
    c+KgQ3nFdrrQ/KtHK1UKOY/LDUwQfn2kcgT4sHwwus0zFQQvuCx2vWbRhaOobpc/f/A/
    Va5czB+wOAwDtH54wu0IItKT/CKPW+CzHNW98UUtcApbjWZAg45lCXn37eQelNXJ7DK1
    yykejxu2vMvU0oZ1JsWtmOz1LeZ/Y4HEZecWLoGwjQRcuE8avy4O8k4Sr44Zbm/rXCEi
    Wh7Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1779793181;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Wsog6vkIHYV+XZ+McVYGFSFZFxQ8V2JlCaLz89lVYqg=;
    b=JeaGSPnDgSPYknoys2wZN7UkrIyLRpNMvwTTUMe+Z7dHipFiE/7V8w/IeFpUcL6LLa
    YYZsZ2kl/hgXFRNrgs3gCImYNtxCMgtyRnH/UOUBkoOREFrHkJu4yM8pYOx7jqKd2WM4
    r34PBrug1XWyQTyvlWf4E/aJrzuxxGulpKGfdxBu4z1nfjvjn3kJ8UHb9eApcziheZn3
    WakoXN3ueAl55JkjYZ6PmDB94kHeHx/vmitZRXYPeAu+1uRdXQzH4F+HcBjgUEF9jUOy
    AqqTPDuUSQlnn9vfaCCtSymw7vu+lQ4C/saSRD80cMtfEk/Br0IzxNZHTzwe/4XIyg9m
    pHog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1779793181;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Wsog6vkIHYV+XZ+McVYGFSFZFxQ8V2JlCaLz89lVYqg=;
    b=UOY/OOmpCmPqgXIF3SNcAvEjn/WVVyH4NSEKVkhsu1SRhHcTPRkqSmmj43kmJewH4H
    9PDLHCSUSrq+XsS8hSAw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeFQ7s0ZDT0tksFSR+Aix0esQJVIAlZEg=="
Received: from [IPV6:2a00:6020:4a38:6800:217d:dfe3:b063:ecb0]
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id Kba96d24QAxfcud
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 26 May 2026 12:59:41 +0200 (CEST)
Message-ID: <c2ab7868-35bd-4c50-9257-73c743bfad81@hartkopp.net>
Date: Tue, 26 May 2026 12:59:41 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH can] can: bcm: add synchronize_rcu() in bcm_delete_rx_op()
 to fix UAF
To: Zhenghang Xiao <kipreyyy@gmail.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>, Lee Jones <lee@kernel.org>
Cc: linux-can@vger.kernel.org
References: <20260526102349.94074-1-kipreyyy@gmail.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260526102349.94074-1-kipreyyy@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7705-lists,linux-can=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,pengutronix.de,kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:url]
X-Rspamd-Queue-Id: BF1915D4A1C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Lee Jones is already working on a workqueue based approach:

https://lore.kernel.org/linux-can/20260520080523.2513957-1-lee@kernel.org/

to not(!) re-introduce the costly synchronize_rcu().

There's only some feedback from the AI bot that has to be considered.

https://netdev-ai.bots.linux.dev/ai-review.html?id=9e8842e7-59a2-4ec5-9f65-1df7973c6170

I expect the updated v2 patch this week.

Best regards,
Oliver

On 26.05.26 12:23, Zhenghang Xiao wrote:
> bcm_delete_rx_op() calls can_rx_unregister() which does hlist_del_rcu(),
> preventing new bcm_rx_handler invocations. However, already-dispatched
> handlers continue running under rcu_read_lock() on other CPUs. The
> subsequent bcm_remove_op() cancels the hrtimers and schedules deferred
> free via call_rcu(), but a concurrent bcm_rx_handler can re-arm
> op->thrtimer via hrtimer_start() after the cancel returns. The re-armed
> timer fires on freed memory after the grace period.
> 
> The RX_NO_AUTOTIMER flag added by commit f1b4e32aca08 ("can: bcm: use
> call_rcu() instead of costly synchronize_rcu()") only guards op->timer
> (via bcm_rx_starttimer), not op->thrtimer (via bcm_rx_update_and_send).
> 
> Add synchronize_rcu() between list_del_rcu() and bcm_remove_op(),
> matching the pattern in bcm_release(). This ensures all in-flight
> handlers complete before timers are cancelled.
> 
> Fixes: f1b4e32aca08 ("can: bcm: use call_rcu() instead of costly synchronize_rcu()")
> Signed-off-by: Zhenghang Xiao <kipreyyy@gmail.com>
> ---
>   net/can/bcm.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index a4bef2c48a55..ae083f59a9ef 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
> @@ -870,6 +870,7 @@ static int bcm_delete_rx_op(struct list_head *ops, struct bcm_msg_head *mh,
>   						  bcm_rx_handler, op);
>   
>   			list_del_rcu(&op->list);
> +			synchronize_rcu();
>   			bcm_remove_op(op);
>   			return 1; /* done */
>   		}


