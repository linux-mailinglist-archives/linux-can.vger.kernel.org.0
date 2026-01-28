Return-Path: <linux-can+bounces-6338-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4I+HDdQMeml72AEAu9opvQ
	(envelope-from <linux-can+bounces-6338-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 14:19:16 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E14A2029
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 14:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2574D300A5A6
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 13:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F0D352C5B;
	Wed, 28 Jan 2026 13:18:36 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A72350A10;
	Wed, 28 Jan 2026 13:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769606316; cv=none; b=QQZAn5XaW7bXxugcgc5ZywhEFU9TzTovAxAo+tehhyZb0/557bvueHjqe9/QbHbaXlfclk4qlNzh6pFVcARGR4zJlcQTE0vPbeBWmBXKeRuARpOnNt2jM2wckpc2aRLrQr8IZ34a3xyXrgVHovUZngqxU1L1ClUu9NqxxCFRCl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769606316; c=relaxed/simple;
	bh=HLA3KBAbG9prRMqMch1vIUqdUb5IBPCaATRXV05fbr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gr8NoMdE+YE67BJz8FUuXMUBc5zkhbu//6ssF58xMKNsmLC7yQ0CUJr6JWAoXGw12Pl5spHWIgS7vWRK69s9k7S5BlWcKoKNj3BhOPoOmSYR07d/H4a8+9SuFI1nFsmjidef6spbr0SEhAbig9jS2NQimHlKjultyiUFnxdARU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id BE35C60516; Wed, 28 Jan 2026 14:18:32 +0100 (CET)
Date: Wed, 28 Jan 2026 14:18:33 +0100
From: Florian Westphal <fw@strlen.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	linux-can@vger.kernel.org
Subject: Re: [net-next 0/6] move CAN skb headroom content to skb extensions
Message-ID: <aXoMqaA7b2CqJZNA@strlen.de>
References: <20260125201601.5018-1-socketcan@hartkopp.net>
 <20260127174937.4c5fc226@kernel.org>
 <aXn0iLuRqdOdcIBN@strlen.de>
 <4909066f-cf9c-49ac-b02f-d2e16908bbd9@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4909066f-cf9c-49ac-b02f-d2e16908bbd9@hartkopp.net>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-6338-lists,linux-can=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,strlen.de:mid]
X-Rspamd-Queue-Id: 84E14A2029
X-Rspamd-Action: no action

Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> > When the first extensions were added all of them could be enabled
> > at same time, but I think that has changed.
> 
> IMO we do not need to 'union' extensions as long as automatic enum 
> calculation does it job with the enabled Kconfig options.
>
> My only concern would be distribution kernels that have an all-yes 
> config policy ;-)

Well, thats the norm, no?  Allmodconfig.
So we have two issues:
1. Turn active_extensions in sk_buff into u16
2. Growing memory usage of the skb_ext blob.

No need to add this 'union' now of course, but I think its something
that should be kept in mind: originally, all extensions could be
turned on for the same skb, but it looks like we now have mutually
exclusive ones.

> With my patch set the enum would now look like this:
> 
> #ifdef CONFIG_SKB_EXTENSIONS
> enum skb_ext_id {
> #if IS_ENABLED(CONFIG_BRIDGE_NETFILTER)
>          SKB_EXT_BRIDGE_NF,
> #endif
> #ifdef CONFIG_XFRM
>          SKB_EXT_SEC_PATH,
> #endif
> #if IS_ENABLED(CONFIG_NET_TC_SKB_EXT)
>          TC_SKB_EXT,
> #endif
> #if IS_ENABLED(CONFIG_MPTCP)
>          SKB_EXT_MPTCP,
> #endif
> #if IS_ENABLED(CONFIG_MCTP_FLOWS)
>          SKB_EXT_MCTP,
> #endif
> #if IS_ENABLED(CONFIG_INET_PSP)
>          SKB_EXT_PSP,
> #endif
> #if IS_ENABLED(CONFIG_CAN)
>          SKB_EXT_CAN,
> #endif
>          SKB_EXT_NUM, /* must be last */
> };
> 
> => SKB_EXT_NUM is then 7
> 
> When we (correctly) add another extension, SKB_EXT_NUM would become 8 
> which is still fine IMO. But then the BUILD_BUG_ON check in 
> skb_extensions_init() would need the below fix, right?
> 
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 648c20e19038..609851d70173 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -5156,11 +5156,11 @@ static __always_inline unsigned int 
> skb_ext_total_length(void)
>          return l;
>   }
> 
>   static void skb_extensions_init(void)
>   {
> -       BUILD_BUG_ON(SKB_EXT_NUM >= 8);
> +       BUILD_BUG_ON(SKB_EXT_NUM > 8);

True, the last valid extension id can't be 8, but
SKB_EXT_NUM could be.

> Should I send a proper patch?

You can, otoh I think we should have consensus on what
to do when the 8th extension is added, do we just s/u8/u16' and
eat the growing memory cost for the skb_ext growth, or do we go
to a drawing board and figure out how to best merge mutually exclusive
extensions to save space?

