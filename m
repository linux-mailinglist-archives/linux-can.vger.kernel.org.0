Return-Path: <linux-can+bounces-7371-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id bJ6LI9g75GmiSwEAu9opvQ
	(envelope-from <linux-can+bounces-7371-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sun, 19 Apr 2026 04:20:08 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A7A422E04
	for <lists+linux-can@lfdr.de>; Sun, 19 Apr 2026 04:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DDF3530075EB
	for <lists+linux-can@lfdr.de>; Sun, 19 Apr 2026 02:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA651176FB1;
	Sun, 19 Apr 2026 02:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b="M68cStHl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Db6rIZ1J"
X-Original-To: linux-can@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7694B28DC4;
	Sun, 19 Apr 2026 02:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776565114; cv=none; b=eDAaQ1+61XuFvvi+WBtZk6eVNWecSEyAbdoPWzGyQHD1tAE38Ty1mvnjdQyQQaThhF5tAdVYG5QIpT0Q2pgR05ehztJ5EaZxz4S6WfnYAfWzSRljPMZ6A43xez7DJQAK3GyfDDXqXu7G1U07sSMKaoGtIEaP3ARdvaxZaV9hpy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776565114; c=relaxed/simple;
	bh=hc9yjXTvFE5hQRZtgAPnvRo6IKxNCc/DLaoBFkkR73M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uQKgUxpIHMrTY5nmuZyICzgQ0r4TioPLMdMU0qW/hEtaLDB3sTztD7ULrCLZWgG88EGkEAubtYfzxwPwBcC7Bs9MytR/dbr1dM0zFoSmfsByZG8qWI/k+CQ8WtVxXA82XE6OA6tJDOQg7LpzOHPCyYrsnMYFM51oEhapvfeaQnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com; spf=pass smtp.mailfrom=ethancedwards.com; dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b=M68cStHl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Db6rIZ1J; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ethancedwards.com
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 744AF7A008F;
	Sat, 18 Apr 2026 22:18:31 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sat, 18 Apr 2026 22:18:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	ethancedwards.com; h=cc:cc:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1776565111;
	 x=1776651511; bh=TYLsRJ5Z49GMVYyuofLnGMu8XEo64b0ve+1ho39BAZY=; b=
	M68cStHlxI0EFlek9lOr8ztPg0S2APMi45pKyBqQdN4Qwr5fYj6b0nnZUGBfqtCU
	WI3uEnTn/M9iDlX5bHZXzx//8T6IZhppr6NyZiZHrvdMuCw0ns8unas7OZhN5iZK
	g8WNt9yAqw8tTHmViBjxaVxefXQNOWXYVr4ckx24BmaCNhPEQ2acJtsNy1BlcOeC
	B96iXcwXNER4NiEjvz2f6lv8LZPQuaVLXcBPQ+LIiVtNWMiNzgq88Nsq0lCfLdzt
	3VAOzDtqsDH+7j3Wuy86hPq4p+KoecJiyWWhhk9llMw3j6425B5wKkiF5V83/YhH
	S2+LWAQHHlToIEYWOcRRxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776565111; x=1776651511; bh=TYLsRJ5Z49GMVYyuofLnGMu8XEo64b0ve+1
	ho39BAZY=; b=Db6rIZ1JMu/e68tnv5e1gMYSsDixCHSNMmMzKJQ1AqQnRWaPgPu
	xTcwnu9uFwvyDmFL+fFqGpa31oKEwvL2VqvUXqJq2U6zxOYLK/cTx5nrV0WTvvxi
	FvkS0tcfxCxoZ30HROxzewMOfrUnGydmeJekHhKixU9eMw3VyhA9pL3to8JqNps6
	6tQaRV5JjHe6WJ9ijFYGDURUxkp7eGtdKV/TsGhHmPtlFGVAS6w8LjseRRW7aJ7q
	joU/a0/ixp8bN6om+IoNhf+O1hwKNqNbHoP7fgf+pkV1YhUMODfRFTPcJYqpHYzZ
	/Qmu2jgX7LQiQceqAhLi4BF0yQiyZnRvT4A==
X-ME-Sender: <xms:djvkaVUvaxDIf9ioxVj-4d27AtOIUmnfxGDTa85tmkg8NF8UzMtlJg>
    <xme:djvkaX2JU6HY60r-WWdbwwD9QDetrqnOAlNYbwYfrHcUO18BKTwafBSc48UBaecCd
    4NjslVz5iwSSG-SkW7yAqro7hlW_DXHRbPtxKJieGlM4b_GYTKq-30Q>
X-ME-Received: <xmr:djvkaTq0l87kTbsQOKfKdIpUTIcIAbJLyFZpnW-pNo0CDo0uiOKcjmAXfso3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehgeegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdfstddttddvnecuhfhrohhmpefgthhhrghnucev
    rghrthgvrhcugfgufigrrhgushcuoegvthhhrghnsegvthhhrghntggvugifrghrughsrd
    gtohhmqeenucggtffrrghtthgvrhhnpedtfefhffehhfehueevtddtkeetkefgkeegjeel
    uddtffeiffevgfelheejteeljeenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhkvg
    hrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpegvthhhrghnsegvthhhrghntggvugifrghrughsrdgtohhmpdhnsggprhgtph
    htthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsohgtkhgvthgtrghn
    sehhrghrthhkohhpphdrnhgvthdprhgtphhtthhopehmkhhlsehpvghnghhuthhrohhnih
    igrdguvgdprhgtphhtthhopehlihhnuhigqdgtrghnsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheplhhinhhugidqhhgrrhguvghnihhnghesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehkvghrnhgvlhdqjhgrnhhithhorhhssehvghgvrh
    drkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:djvkaeVGq0JjPKIz-FaaLaXKJFoTNmbS-g3w1w2EOTwpdme6itp-tw>
    <xmx:djvkaebBb31wCzB0w5iXVgH7avEUXDjgBzCLmVwFlbxcSsBRyWB45A>
    <xmx:djvkabeSH1fexqS-x2nW1saKMMisXsT15Wj-LoKmHEZFM7uNGQ3wLQ>
    <xmx:djvkaY090NyIVEINGsi8EUVd52r497RviXKzXQARO9ZgTJZw7r_CWg>
    <xmx:dzvkaeI0h8p_cvgn6lVkuCOBZChGVyBXGnMnhnavZyQvOwYUCjNKruXW>
Feedback-ID: ibf9e487c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 18 Apr 2026 22:18:30 -0400 (EDT)
Date: Sat, 18 Apr 2026 22:18:30 -0400
From: Ethan Carter Edwards <ethan@ethancedwards.com>
To: Oliver Hartkopp <socketcan@hartkopp.net>, 
	Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] can: bcm: Replace strcpy() with strscpy(), simplify call
Message-ID: <bt56uwgpxdtuocw6lwbnuwz5v32evruy6zx5cbp247cpsa3dbj@oy4zzozwandr>
References: <20260418-can-bcm-strscpy-v1-1-993eb8de9f77@ethancedwards.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260418-can-bcm-strscpy-v1-1-993eb8de9f77@ethancedwards.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ethancedwards.com,none];
	R_DKIM_ALLOW(-0.20)[ethancedwards.com:s=fm1,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7371-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[ethancedwards.com:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ethan@ethancedwards.com,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim,ethancedwards.com:dkim,ethancedwards.com:email]
X-Rspamd-Queue-Id: D4A7A422E04
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 26/04/18 10:00PM, Ethan Carter Edwards wrote:
> strcpy() is deprecated; use the safer strscpy() instead.
> 
> While the src is char array at bcm_proc_getifname's call sites, the src
> is passed to the function as a char*. Including the IFNAMSIZ length
> makes the call safer.
> 
> Use turnary over if/else to simplify code.
> 
> Link: https://github.com/KSPP/linux/issues/88
> Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
> ---
>  net/can/bcm.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index a4bef2c48a55..c133dab1202e 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
> @@ -196,10 +196,7 @@ static char *bcm_proc_getifname(struct net *net, char *result, int ifindex)
>  
>  	rcu_read_lock();
>  	dev = dev_get_by_index_rcu(net, ifindex);
> -	if (dev)
> -		strcpy(result, dev->name);
> -	else
> -		strcpy(result, "???");
> +	strscpy(result, dev ? dev->name : "???", IFNAMSIZ);

On second thought:

would it just be better here to do:

if (dev)
    strscpy(result, dev->name, IFNAMSIZ);
else
    memcpy(result, "???\0", 4);

for the sake of compiler optimizations/speed?

reading this: https://lore.kernel.org/lkml/20251023092046.4f556e0f@pumpkin/

I'm not sure.

>  	rcu_read_unlock();
>  
>  	return result;
> 
> ---
> base-commit: c7275b05bc428c7373d97aa2da02d3a7fa6b9f66
> change-id: 20260418-can-bcm-strscpy-56a0e402a660
> 
> Best regards,
> -- 
> Ethan Carter Edwards <ethan@ethancedwards.com>
> 

