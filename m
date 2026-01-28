Return-Path: <linux-can+bounces-6366-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cC1aIWxAemm14wEAu9opvQ
	(envelope-from <linux-can+bounces-6366-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 17:59:24 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA46CA66F2
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 17:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB0DC3129EA6
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 16:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C81830EF7B;
	Wed, 28 Jan 2026 16:25:51 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B04F17D6;
	Wed, 28 Jan 2026 16:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769617551; cv=none; b=tqKD6iLC5nfsa44iveSNwrGGcvDXon4aRStVK+RzerXlYl4GKFP+A0aXWzFpv7r4udKnYxTcZSMhAKyH0QFf8RgkXsj2MftKkclmDoQ2DzoGS6wt4dMQ9gQPgrepyp1DnZmbaKIt1ImSOWqDmCEqeGrLdyubgWdlc+zsak+RwA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769617551; c=relaxed/simple;
	bh=31X9JFSHzmvgdIey95VPsmriefKTQ9kT3QGAlb5Keks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mOjMHDH/viKRZtLAh3j9jtz2MkyNjodkAytQiXNDhsF9OASbkotDLv1vEyZWWUpTD7I7MN0aMha6wepFNQ2EgNP24x6pG/TgWG1VW0e2w03bkF9d42dnNDQYIZ+0dSMl1XKZuHjHsNj1K8o0w5bKA3cV1PjaU1VuCbuLKd1Ziiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 4802F60625; Wed, 28 Jan 2026 17:25:47 +0100 (CET)
Date: Wed, 28 Jan 2026 17:25:48 +0100
From: Florian Westphal <fw@strlen.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	linux-can@vger.kernel.org
Subject: Re: [net-next 0/6] move CAN skb headroom content to skb extensions
Message-ID: <aXo4jP9M0EQPOaeI@strlen.de>
References: <20260125201601.5018-1-socketcan@hartkopp.net>
 <20260127174937.4c5fc226@kernel.org>
 <aXn0iLuRqdOdcIBN@strlen.de>
 <4909066f-cf9c-49ac-b02f-d2e16908bbd9@hartkopp.net>
 <aXoMqaA7b2CqJZNA@strlen.de>
 <e2033d96-e900-4013-a18a-c2e0ffa269d3@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2033d96-e900-4013-a18a-c2e0ffa269d3@hartkopp.net>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-6366-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,linux-can@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,strlen.de:mid,hartkopp.net:email]
X-Rspamd-Queue-Id: EA46CA66F2
X-Rspamd-Action: no action

Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> Ok. But then I don't see any real pressure to do the extension right 
> now. There doesn't seem so much changes adding new skb extensions users. 
>   And we still have a free slot even if all users would have been 
> enabled (which is not the case due to the mutually exclusive options).

Yes.

> The good thing is that skb extensions are very efficient. Which leads to 
> the bad thing that we only can detect the problems at build time with
> 
> BUILD_BUG_ON(SKB_EXT_NUM > 8);
> BUILD_BUG_ON(skb_ext_total_length() > 255);
> 
> For (SKB_EXT_NUM > 8) the upgrade of active_extensions to u16 should 
> simply make it. Probably with some #ifdef magic only.
> 
> But thinking about BUILD_BUG_ON(skb_ext_total_length() > 255):
> 
> Shouldn't this be SKB_EXT_CHUNKSIZEOF(struct skb_ext) + sum of the skb 
> ext user data which can be up to 255 *  SKB_EXT_ALIGN_VALUE (= 2040) ???

Why?  Its not about the size in bytes, its there to make sure
ext->offset[] (u8) won't overflow for any of the extensions.

Maybe a comment would help.

