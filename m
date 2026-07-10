Return-Path: <linux-can+bounces-8287-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Io+ZBIbqUGqS8QIAu9opvQ
	(envelope-from <linux-can+bounces-8287-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 14:50:14 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9218C73AEA5
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 14:50:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amazon.de header.s=amazoncorp2 header.b=P90cKxXP;
	dmarc=pass (policy=quarantine) header.from=amazon.de;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8287-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-can+bounces-8287-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 00782300A326
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 12:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DAF428492;
	Fri, 10 Jul 2026 12:50:09 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com [34.218.115.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348D5403EAE;
	Fri, 10 Jul 2026 12:50:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783687809; cv=none; b=MMweYJkCkQsO5Pa1jjj4cB2Bx2fjmXax4sR68QWQPEAuc8dfUqnrLFALYPWFOQFtEoNtzmp1HRzlNuSQhJVSID4Lulto2pTo7vnItTFNPD39olckJfbcRTOhuRSQcA8GjlSZTQK8Aj2C0L8Mwpg3UQMtMAuUUFcvK0Hq1PQfFn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783687809; c=relaxed/simple;
	bh=s7FK3uy0wyTmiT30bqnatZgOuAJHS1beiJ6EgyUxc5U=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JGhZe99ty7qBz71hQiUQ/aXgkQPdcv1J97sTcc9x7WAnpYksT1sCmnb8kVPQj52WEXUQKOxJrAgN9h0dqPsT/iE1AioTv87Ko6cqVHxyxGvXeEADM0kI3/pbzpiA2S9f8OYwv46Sc/6bzHpNXqTnBWIp9T8OiZKvj6ROLas7UvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=P90cKxXP; arc=none smtp.client-ip=34.218.115.239
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1783687808; x=1815223808;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Fw2vftZ+PMLxv43trdP7hYgE/5hVii1GM/a6mEOhYM0=;
  b=P90cKxXPWwVuj2/EuhI1epGZQu9iwXVEbvUax3lGWYlcJlxYgsXkYWXE
   AGLNiJHVpGnrR4jXgF9uhwqhiAD9+W3WAn6GDMIzeOrUID/EZYqceXsQj
   gs2sHO0r1/PqWpapE4Qp8NEYTQ9VMjOZJfrtzoC7PBxA/qjQknlCSNL9R
   +LAGw1tArlW7AtSOfxW0XqjyGM7RRutQJ/di6TiYEFMN7t4Tp9gLSEVwW
   cIlS4TjzSHOXElorCERYZAZiUxwCz9kTIXc6vzNciRTTqVJLVfnGJ56ze
   c9BP9TWh1VuzNVOSaO1zlG+p2i1tnlprxCeDz4/5i3USka0BaHgUmMmHG
   A==;
X-CSE-ConnectionGUID: XQNd2qLCRgyq+BAfiY3SJA==
X-CSE-MsgGUID: EttK6KOnQDGVmOZy4i9VYw==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; 
   d="scan'208";a="23233577"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 12:50:05 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:30472]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.26.212:2525] with esmtp (Farcaster)
 id 0975f33c-db1f-41e4-94f8-4c7a86ae8d76; Fri, 10 Jul 2026 12:50:05 +0000 (UTC)
X-Farcaster-Flow-ID: 0975f33c-db1f-41e4-94f8-4c7a86ae8d76
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Fri, 10 Jul 2026 12:50:04 +0000
Received: from dev-dsk-mheyne-1b-8cc83676.eu-west-1.amazon.com (10.13.235.223)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Fri, 10 Jul 2026 12:50:02 +0000
Date: Fri, 10 Jul 2026 12:49:54 +0000
From: Maximilian Heyne <mheyne@amazon.de>
To: Greg KH <gregkh@linuxfoundation.org>
CC: <stable@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>, "Vincent
 Mailhol" <mailhol.vincent@wanadoo.fr>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Nikolay Aleksandrov <razor@blackwall.org>,
	"Eric W. Biederman" <ebiederm@aristanetworks.com>,
	<linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH 6.12.y] net: add missing ns_capable check for peer netns
Message-ID: <20260710-wry-moral-3892dd17@mheyne-amazon>
References: <20260617-pats-coif-316245c6@mheyne-amazon>
 <2026062556-residue-anybody-e756@gregkh>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2026062556-residue-anybody-e756@gregkh>
X-ClientProxiedBy: EX19D037UWB002.ant.amazon.com (10.13.138.121) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[amazon.de:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.de,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[amazon.de:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8287-lists,linux-can=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:mkl@pengutronix.de,m:mailhol.vincent@wanadoo.fr,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:daniel@iogearbox.net,m:razor@blackwall.org,m:ebiederm@aristanetworks.com,m:linux-can@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mheyne@amazon.de,linux-can@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,amazon.de:from_mime,amazon.de:dkim,mheyne-amazon:mid];
	DKIM_TRACE(0.00)[amazon.de:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mheyne@amazon.de,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,pengutronix.de,wanadoo.fr,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,blackwall.org,aristanetworks.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9218C73AEA5

Hi Greg,

On Thu, Jun 25, 2026 at 12:37:31PM +0100, Greg KH wrote:
> On Wed, Jun 17, 2026 at 08:25:31AM +0000, Maximilian Heyne wrote:
> > The upstream commit 7b735ef81286 ("rtnetlink: add missing
> > netlink_ns_capable() check for peer netns") doesn't apply on older
> > stable kernels due to refactoring. Therefore, this patch is an attempt
> > to implement the same capability check just directly in the respective
> > interface types.
> 
> Why can't we take the full series of patches instead?  Otherwise this is
> going to be a pain over time for any other fixes/updates in this area,
> right?

Agree that this would be a pain. The issue is that this requires to
backport >10 patches. I think for 6.12 it would be like 15 patches so
that each patch doesn't need to be reworked too much.

The reason for me submitting this was that it's easily backports to all
stable kernels. I haven't tested for 6.6 or earlier how many patches
would need to be backported.

I can try to post the series for 6.12 after some more testing (after my
vacation) but I'm think I won't succeed backporting the refactoring
patches back to, say, 5.10.

> 
> And if not, then we need acks from the maintainers here...

So for the backports to older stable kernels we might need this.

Links:
- 6.6.y backport: https://lore.kernel.org/all/20260617-sprain-dye-86c242ac@mheyne-amazon/
- 6.1.y backport: https://lore.kernel.org/all/20260617-keyed-dude-3493dbdb@mheyne-amazon/
- 5.15.y backport: https://lore.kernel.org/all/20260617-forgot-manic-27dda774@mheyne-amazon/
- 5.10.y backport: https://lore.kernel.org/all/20260617-thaws-enid-af4ad67d@mheyne-amazon/

Regards,

Maximilian

