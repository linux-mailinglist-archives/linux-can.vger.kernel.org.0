Return-Path: <linux-can+bounces-7374-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +D1kFd4M5mluqwEAu9opvQ
	(envelope-from <linux-can+bounces-7374-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 20 Apr 2026 13:24:14 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B67429E4D
	for <lists+linux-can@lfdr.de>; Mon, 20 Apr 2026 13:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7470D30036C8
	for <lists+linux-can@lfdr.de>; Mon, 20 Apr 2026 11:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E76343D7F;
	Mon, 20 Apr 2026 11:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="F6N+swyj";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="j9wDErgo"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BE72B2D7;
	Mon, 20 Apr 2026 11:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776684248; cv=pass; b=UgW+6OPIYjLE2zFW5wPsH+W+ZTguSScrDJ/canPF0PH8y+E6VZ11076mY4pT1sZCUlKfYbf5Zk0L1SLHfClEKxsyBvB1Ydhad4W8rvwsMErNnApRCTaXThEPTme0IDmCy3ayBy4BLiFQGvKGR5XFN7AcZoVTEsLtZVZsCoYLLvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776684248; c=relaxed/simple;
	bh=XyL9LHKQBM15ZRau2LEWtpW4hPqgbzio8vOy+Mz46lI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZWzhoiEIz+cLk9dPm/HPCSe152/FAmaRo7zk5zBUXQlARxdnGWWRFLIlm0Y6pud+FtbsDYp/KWC9qQ/HG3xEzkNvKw+MxBfadU7uuj/Y2+gbrsQGQLrgL1/NQJVee1jJbUzMGmzeaP8GzfwS1A1hy9IexnSWPLv5IgMZ/rQDlTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=F6N+swyj; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=j9wDErgo; arc=pass smtp.client-ip=85.215.255.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1776681239; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=rEpdHb1/K6G11n5xNguKJmzXEhVgM/tLa2J4rkWxHiK/DXZ/JhQyTMvLWM0ojoLOPG
    Mpl89iv4L2RJQDj2ZN8Z6lqOb6eOkQq4HmQM2k7XxX/rzl6JnFRfStFN3D3hvHTd5Tky
    CQkWaeVetHbY60sMYQ0u/MQ12wD/hDjoknx/IfmQPmY1nwq5BrXzpXfWYwrfEw/EJWsF
    Mo1I51kb7Qi7d6I7gG+jAfo4qHdsg+TtkIKXg0/dVDtlaXodtb1vrt8m2Lraaz41KiPs
    R2CTinnqgV8YuadioyPStiXol/logdh9r1X8LlBrIfOCnrN9hUOJ7/NoCuazfUVPnd+6
    yH/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1776681239;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Q0v4zcYQhu4TY3J+onFrpJZsn9wbFA+k0t415oWwq34=;
    b=G8M/yECGvI20v43l9L0Q/oM8kJwAjWpCvLMnC1bJInmIrVdJwHJQjGwkyPYMl1wBCO
    G4WEJYMz7KViIEdbi5i7A8pOjUQiZ1i7c/kMCSXz4iKJ/SkssuzOqUM3FpuxBc8RU6mS
    6yXv4TDjYQyb3IEemRqOqpuKXmTsrLVYlyHe3mF3PYeHglFnl3IlbiBHgYa1HOagwdrr
    MQRLso6QmCl8pzpmxe5XrqXD4jzE/nfC5TJ7pX63Ge+Z4Q8/4j0ck8g5Wkw0q2Xa8XnI
    OgxN76DXJJ0mwDgCe5zDcDT7jdmv0M/Oo0HrI2DWVQSReWnTylEl1pN2qkY9ujbTOtzR
    Vhyg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1776681239;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Q0v4zcYQhu4TY3J+onFrpJZsn9wbFA+k0t415oWwq34=;
    b=F6N+swyjjzVAzlkh9W6+30Y6w7hCpDdmbhJmZbFpcbktjHEMKuSpJR991cM8vtGOui
    3KoN51WKzHxEUsERh+b25rY9Ya8nw8oHtZCFlLo8NjjHXXnHpxdeT653WCqwOz2XzoNW
    w6WOXzrT4QUhSSkdVxcJZUybiXc62QGiUt81s0P0oK+m6nmzvuKFqc+esWeFwai8U4de
    +kd4eOM7G10BhVBbAyBfN/2Alyhz+MOOdTIHAwMeaUrpxWuKawDAiLSXStLO6yT4YVQI
    RWmkW3ZKLnbXVm4V5uDB2YF4ZMpVtnIAKfPioOkyZc9T14BVleswU1i0dTqmODJyuLFF
    i3Qg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1776681239;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Q0v4zcYQhu4TY3J+onFrpJZsn9wbFA+k0t415oWwq34=;
    b=j9wDErgoatqCelDe/mjF3uGhZSevirul12X725guW1K/ShYtNaQu8fs4iWLqX0jz5i
    cK0qQ0BBwvofs5sCwfCw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeFQ7s1YTqptmo87qzm6sElmZEI+VN6rw=="
Received: from [IPV6:2a00:6020:4a38:6800:3499:34c0:1f42:76da]
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id Kba96d23KAXwX9z
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 20 Apr 2026 12:33:58 +0200 (CEST)
Message-ID: <6d162723-a76b-400a-9b54-11a5c60c2f7d@hartkopp.net>
Date: Mon, 20 Apr 2026 12:33:53 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: bcm: Replace strcpy() with strscpy(), simplify call
To: Ethan Carter Edwards <ethan@ethancedwards.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20260418-can-bcm-strscpy-v1-1-993eb8de9f77@ethancedwards.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260418-can-bcm-strscpy-v1-1-993eb8de9f77@ethancedwards.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7374-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,hartkopp.net:dkim,hartkopp.net:mid,ethancedwards.com:email]
X-Rspamd-Queue-Id: C9B67429E4D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Ethan,

On 19.04.26 04:00, Ethan Carter Edwards wrote:
> strcpy() is deprecated; use the safer strscpy() instead.
> 
> While the src is char array at bcm_proc_getifname's call sites, the src
> is passed to the function as a char*. Including the IFNAMSIZ length
> makes the call safer.

I'm not sure what makes the call "safer" here.

The use of IFNAMSIZ in dev->name and in ifname[IFNAMSIZ] in 
bcm_proc_show() makes it 100% clear that we only can copy data between 
identical sized buffers. Adding strscpy() with IFNAMSIZ is a nop.

The only issue could be that someone reduces IFNAMSIZ to a value smaller 
than sizeof("???") - which is not addressed here.

I see no real benefit changing this code in the proposed way.

Especially as we are not talking about some dynamic content here.

Best regards,
Oliver

> 
> Use turnary over if/else to simplify code.
> 
> Link: https://github.com/KSPP/linux/issues/88
> Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
> ---
>   net/can/bcm.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index a4bef2c48a55..c133dab1202e 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
> @@ -196,10 +196,7 @@ static char *bcm_proc_getifname(struct net *net, char *result, int ifindex)
>   
>   	rcu_read_lock();
>   	dev = dev_get_by_index_rcu(net, ifindex);
> -	if (dev)
> -		strcpy(result, dev->name);
> -	else
> -		strcpy(result, "???");
> +	strscpy(result, dev ? dev->name : "???", IFNAMSIZ);
>   	rcu_read_unlock();
>   
>   	return result;
> 
> ---
> base-commit: c7275b05bc428c7373d97aa2da02d3a7fa6b9f66
> change-id: 20260418-can-bcm-strscpy-56a0e402a660
> 
> Best regards,


