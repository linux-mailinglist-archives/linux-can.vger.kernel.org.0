Return-Path: <linux-can+bounces-7897-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ntBiHgEVPWoVwwgAu9opvQ
	(envelope-from <linux-can+bounces-7897-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 25 Jun 2026 13:46:09 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BED3F6C53F4
	for <lists+linux-can@lfdr.de>; Thu, 25 Jun 2026 13:46:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=Znl0J5WX;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7897-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-can+bounces-7897-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE611301C159
	for <lists+linux-can@lfdr.de>; Thu, 25 Jun 2026 11:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A8B3DD539;
	Thu, 25 Jun 2026 11:45:58 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755113DD509;
	Thu, 25 Jun 2026 11:45:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782387958; cv=none; b=gvGILitB7Y8bguFiEQmUbIiv2OhCtAVsTvIrddgNSV3AzPKhKxTwEWpe5+mFtalWcfgSP78Jn0kkj3Pv94L1ELI7bY+yW9OpdaTPfeM6KKlHmGPoHjJLlNyAOXz/hdPOVn6bwUO4IpmLBqwQKHT1jtG5tE8zR3QghtpWDQooD6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782387958; c=relaxed/simple;
	bh=Nd8YdKOzt+Ca9w1TBuYqUtzZR7XwfY1USeE0VwvaT6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u99wDeQiMpgSFgZsKatsufulilodh3dCvp83WYBjM59fEF8gkrV/Di9+1mrnz5malQqq4U6O13avo6RsI9nlvnBIL34x3Y2PMdcM8k6oKfkSnWg8vsiyOkayfTohe7jiMg7dFB6KVcjVihUZ5o8MZmLGqkngzI9bAIu0WJ2QZcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Znl0J5WX; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83B1F1F00A3A;
	Thu, 25 Jun 2026 11:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782387957;
	bh=O5Nsrv7dbKI0TRU5J5+1J9WSCqQWpJP9oDy03m9SzNA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Znl0J5WXUw2BJePR4uI199t/XyfCjUR1y2S0ZdLOBKfKzFKxD0zqS/V8CB2IYvHNB
	 d9HimkDYCBzFzBmV7ttG+L7jwRZALoWqvFG0jKBefPxxhwZqAvnbzahqYyj9sYsErX
	 TfsI9prfOT9Apmv68QSqkDKVko2x38Kx4r0AYTcU=
Date: Thu, 25 Jun 2026 12:37:31 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Maximilian Heyne <mheyne@amazon.de>
Cc: stable@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	"Eric W. Biederman" <ebiederm@aristanetworks.com>,
	linux-can@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 6.12.y] net: add missing ns_capable check for peer netns
Message-ID: <2026062556-residue-anybody-e756@gregkh>
References: <20260617-pats-coif-316245c6@mheyne-amazon>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617-pats-coif-316245c6@mheyne-amazon>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7897-lists,linux-can=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,linux-can@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS(0.00)[m:mheyne@amazon.de,m:stable@vger.kernel.org,m:mkl@pengutronix.de,m:mailhol.vincent@wanadoo.fr,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:daniel@iogearbox.net,m:razor@blackwall.org,m:ebiederm@aristanetworks.com,m:linux-can@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,linux-can@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,pengutronix.de,wanadoo.fr,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,blackwall.org,aristanetworks.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,gregkh:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BED3F6C53F4

On Wed, Jun 17, 2026 at 08:25:31AM +0000, Maximilian Heyne wrote:
> The upstream commit 7b735ef81286 ("rtnetlink: add missing
> netlink_ns_capable() check for peer netns") doesn't apply on older
> stable kernels due to refactoring. Therefore, this patch is an attempt
> to implement the same capability check just directly in the respective
> interface types.

Why can't we take the full series of patches instead?  Otherwise this is
going to be a pain over time for any other fixes/updates in this area,
right?

And if not, then we need acks from the maintainers here...

thanks,

greg k-h

