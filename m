Return-Path: <linux-can+bounces-7416-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wP6lIsx68GkBUAEAu9opvQ
	(envelope-from <linux-can+bounces-7416-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 28 Apr 2026 11:15:56 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B772481196
	for <lists+linux-can@lfdr.de>; Tue, 28 Apr 2026 11:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D0EA730B8A9D
	for <lists+linux-can@lfdr.de>; Tue, 28 Apr 2026 08:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1D23D47A8;
	Tue, 28 Apr 2026 08:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KGb3SZCO"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8E92857CC;
	Tue, 28 Apr 2026 08:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777366663; cv=none; b=oDHV1BuVh/m6QYEc2NMd7DY214Pa8f/hEJATiQ5hwfmdzZ8tTgtCxtbzsKVDlslgH2N+pjrbAJSW/PdC9vZhvuXvbcluC1neOrQ847AJ01MqucMf6sM6Ohzb/JzWObjlrinZf2zQTjBdDpP05B7cqB77K1FAHoB1NbR3Nmgwj1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777366663; c=relaxed/simple;
	bh=4U9FZmBQDYQDQpdsPNpmy5dmsrae25F/1nbjaGelAF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dsUtzffqJ3yRt5JJcBDufmYxts+BieYrNw0GWqK3yDsOkjsYz+Z59++RsCmjO5/jjOTPrA2SWtnBg92ybLlI8D3cz2pbsku44pXvi2DDR8Xi0TfJtv9UjAAYs/DH66kpP95K7H0dPBQO3Fqbn+91fX5yjwF28GiPrAh9stEf4N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KGb3SZCO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2A8CC2BCAF;
	Tue, 28 Apr 2026 08:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777366662;
	bh=4U9FZmBQDYQDQpdsPNpmy5dmsrae25F/1nbjaGelAF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KGb3SZCOAuS2JgdJWXiYcnHWH2zAR7vMi0SA0SD/IJ61NXycGhxPUgWwt4Ub5GqKd
	 oLtgdFpYm82SFKXPf2ySqto/Es4KenF2VCPPQbcK/giKdPYIrEAcYkeWX2HtMdal/Q
	 HDga8Jrko02syPFHDnVICC5lVJoFzgLupgRzfDVcSkc/+g7j1Os6ynrjxsp+cB/Vps
	 EvnfOqyZQZzBszNeDFzQRAUhzd7HSJCZwW8QKgs8SULNv1TUxtllzBqGMwcZtkbyO0
	 qvEz5V3uxC24OBWsfuRhQm2WvoPn5u0G8F8ycrChWRiYyJMNztDjov+Ink+zDVdkV1
	 4y1dh6z8cq3rw==
Date: Tue, 28 Apr 2026 09:57:39 +0100
From: Lee Jones <lee@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] can: bcm: prevent thrtimer UAF in rx path by
 checking RX_NO_AUTOTIMER
Message-ID: <20260428085739.GB8212@google.com>
References: <20260422102239.948594-1-lee@kernel.org>
 <6cc6eec9-2e8a-4a39-955a-0eeefc93fe97@hartkopp.net>
 <20260424-magic-snobbish-rabbit-0865cf-mkl@pengutronix.de>
 <eef6917f-38c2-4bb4-a5d6-98f5a71adf65@hartkopp.net>
 <20260427124058.GA8212@google.com>
 <dd5315a7-87e9-4754-9e88-34c0623aca99@hartkopp.net>
 <20260427-zealous-booby-from-avalon-c9753c-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427-zealous-booby-from-avalon-c9753c-mkl@pengutronix.de>
X-Rspamd-Queue-Id: 9B772481196
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7416-lists,linux-can=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lee@kernel.org,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,hartkopp.net:email]

On Mon, 27 Apr 2026, Marc Kleine-Budde wrote:

> On 27.04.2026 19:15:29, Oliver Hartkopp wrote:
> > > > Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> > >
> > > I'm a little confused by the SoB.  Does this mean you've applied it?
> > >
> >
> > No. Marc will apply the patch.
> >
> > My SoB is probably not needed in this context.
> 
> ACK
> 
> > But Marc was sometimes asking
> > for it when I commented and discussed patches in the past.
> 
> The rule is: if you post a patch, your S-o-b has to be the last S-o-b in
> the line.

Right.  But SoBs are an indicator that a given person was part of the
patch flow; author, submitter, sub-maintainer, maintainer, etc.

In this context Oliver's SoB should have been Reviewed-by or Acked-by.

Thanks for confirming that you use b4 - that makes life easier.

-- 
Lee Jones

