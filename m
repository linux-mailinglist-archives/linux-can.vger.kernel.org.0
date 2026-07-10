Return-Path: <linux-can+bounces-8293-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zzagB4H0UGoc9AIAu9opvQ
	(envelope-from <linux-can+bounces-8293-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 15:32:49 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8246573B484
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 15:32:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=NvUWuuRX;
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8293-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-can+bounces-8293-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AA462300A126
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 13:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA0021FF2E;
	Fri, 10 Jul 2026 13:31:34 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DAC78F26;
	Fri, 10 Jul 2026 13:31:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783690294; cv=none; b=AFIEw+Rsbb9F2sLWiR4e7+kXifRxQM4f0MqQR7PExLzroHvompAPM0yxpu3hOakzMDHxCtXn4/sUAPNX7CuzLLld7+AsoD0+2TgVKiGTozXBFdzUoWrENQMpxiIfTQUKf4+DGQpiltaHwWDRp9dSq+aY535lR9ftaNT51Kt2VJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783690294; c=relaxed/simple;
	bh=54spsH38fkltmlTeS0fPxbfcoNt0muhafJ6arfo+/VI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iZVGblnf8ch2SFF6HzKpaXpUFJaCznlFMUVDPOIObPoEja1cfjCU/eyB5rqICaF29TjM07sCre8usMx6ZdwAcTqFRK5jkg8hdWSwqd36kC7fAvSp1ZK76qXA3fxS2xFDk+DyQ9zq7vFVa0B6nZu8u69vSG5ZccXr/Ou7J3Kd8Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NvUWuuRX; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E64591F000E9;
	Fri, 10 Jul 2026 13:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783690292;
	bh=gd67u83X9mD7rQ0A2ywYAeabi5MI/7ohcs3gZ3c5PNE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NvUWuuRXo+5/hGFE0H65WiXZ6Joaj0mhYLvEwlcRqnljpQ47JJ/JNPu0N+Cx1tMjT
	 VkYxTHIwsWOpsxbRjiqeLKs6lJdRiZiNLhfzlb4WAsiYYkNNjFGKefc8a1Va158B3h
	 4uTTGzW9cP2c/EWCTQSmsHTNSSi8h64ZtZA3wR+I=
Date: Fri, 10 Jul 2026 15:31:28 +0200
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
Message-ID: <2026071049-barrier-quote-624f@gregkh>
References: <20260617-pats-coif-316245c6@mheyne-amazon>
 <2026062556-residue-anybody-e756@gregkh>
 <20260710-wry-moral-3892dd17@mheyne-amazon>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710-wry-moral-3892dd17@mheyne-amazon>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8293-lists,linux-can=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,gregkh:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8246573B484

On Fri, Jul 10, 2026 at 12:49:54PM +0000, Maximilian Heyne wrote:
> Hi Greg,
> 
> On Thu, Jun 25, 2026 at 12:37:31PM +0100, Greg KH wrote:
> > On Wed, Jun 17, 2026 at 08:25:31AM +0000, Maximilian Heyne wrote:
> > > The upstream commit 7b735ef81286 ("rtnetlink: add missing
> > > netlink_ns_capable() check for peer netns") doesn't apply on older
> > > stable kernels due to refactoring. Therefore, this patch is an attempt
> > > to implement the same capability check just directly in the respective
> > > interface types.
> > 
> > Why can't we take the full series of patches instead?  Otherwise this is
> > going to be a pain over time for any other fixes/updates in this area,
> > right?
> 
> Agree that this would be a pain. The issue is that this requires to
> backport >10 patches. I think for 6.12 it would be like 15 patches so
> that each patch doesn't need to be reworked too much.

15 is trivial, we have taken hundreds in the past :)

> The reason for me submitting this was that it's easily backports to all
> stable kernels. I haven't tested for 6.6 or earlier how many patches
> would need to be backported.
> 
> I can try to post the series for 6.12 after some more testing (after my
> vacation) but I'm think I won't succeed backporting the refactoring
> patches back to, say, 5.10.

Full series is best because maintaining this over time will be easier if
you do that, not harder.

thanks,

greg k-h

