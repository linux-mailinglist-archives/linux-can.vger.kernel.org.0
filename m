Return-Path: <linux-can+bounces-7409-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHHBHmVZ72n5AQEAu9opvQ
	(envelope-from <linux-can+bounces-7409-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 27 Apr 2026 14:41:09 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1CA472A32
	for <lists+linux-can@lfdr.de>; Mon, 27 Apr 2026 14:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 72A993002D07
	for <lists+linux-can@lfdr.de>; Mon, 27 Apr 2026 12:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6543B1A6819;
	Mon, 27 Apr 2026 12:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pHqIRXXc"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CA7F9C0;
	Mon, 27 Apr 2026 12:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777293663; cv=none; b=dnE44Cyftne8auyb0zFIslvORKNkTopxEgjuNX5RXX3XzOU/8bOa3kik7E/G/QkDLAd+LvhmDzd9g2Zl4ekpVs8NZtQhuNp8HPK1u2XOn7rP8nBsNl/jtdMTQIYqxT4wvpDDNeFxvlBycwXxaGolUthYRbieE01WZQwfdpScMS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777293663; c=relaxed/simple;
	bh=DsV3dh6/IS0SE6uwl1VVDKgGkUxcnVhoAm69d3w8Xxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oirfQ67jtmwHQabMV1ikCqH7QiwQxYODUMn77bELKa45SaDm4kBrtUDBA+K9AELX8rF5W60/AKJAYPesLU0sK293GWUlZR4S8uo8jZJoaE0Y50Zpfq8eqoVpmNcr4uK/n3rsWFnbBvMwQYtbV3SlAmOGrU7z7EpTkm9G87upZMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pHqIRXXc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0501C19425;
	Mon, 27 Apr 2026 12:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777293662;
	bh=DsV3dh6/IS0SE6uwl1VVDKgGkUxcnVhoAm69d3w8Xxk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pHqIRXXcLWUtL3q4qp3xQuWOQ+cgsgUTq6LytQtYjum9uQTFX5NREYiAw6+XY/FvY
	 0wm/OxgswuOHHvB4R8K85732F1q9xcP+SDPEMPkFJhoByJF3A0nnbHqWnw89ZdL2Qv
	 W8R78VIJ/E56MP/8wvYxMPl6eTkTWUItuM602Pnol1MAmT94Wisq8/7zv530BexdyN
	 kD6VjPhx3Lj52SHF8lguDuyxv/S2qT/6KW+qf7pyHFqtqYX/y7NzT35GVSWf5SrFKb
	 6ezbrgC7xkkygLpilYJ5ZsoCgmugB+4WZt4hldcLFf469CwTsgcQ01HFV4jAsGC11N
	 tXG3iohXIvhew==
Date: Mon, 27 Apr 2026 13:40:58 +0100
From: Lee Jones <lee@kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] can: bcm: prevent thrtimer UAF in rx path by
 checking RX_NO_AUTOTIMER
Message-ID: <20260427124058.GA8212@google.com>
References: <20260422102239.948594-1-lee@kernel.org>
 <6cc6eec9-2e8a-4a39-955a-0eeefc93fe97@hartkopp.net>
 <20260424-magic-snobbish-rabbit-0865cf-mkl@pengutronix.de>
 <eef6917f-38c2-4bb4-a5d6-98f5a71adf65@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eef6917f-38c2-4bb4-a5d6-98f5a71adf65@hartkopp.net>
X-Rspamd-Queue-Id: 6B1CA472A32
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
	TAGGED_FROM(0.00)[bounces-7409-lists,linux-can=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On Sat, 25 Apr 2026, Oliver Hartkopp wrote:

> 
> 
> On 24.04.26 21:08, Marc Kleine-Budde wrote:
> > On 22.04.2026 14:55:50, Oliver Hartkopp wrote:
> > > 
> > > 
> > > On 22.04.26 12:22, Lee Jones wrote:
> > > > Commit f1b4e32aca08 ("can: bcm: use call_rcu() instead of costly
> > > > synchronize_rcu()") removed the synchronize_rcu() call from
> > > > bcm_delete_rx_op() and introduced the RX_NO_AUTOTIMER flag to prevent
> > > > timers from being rearmed during deletion.  However, it only applied
> > > > this check to op->timer via bcm_rx_starttimer().
> > > > 
> > > > It missed the fact that op->thrtimer can also be rearmed by an
> > > > in-flight bcm_rx_handler() (which runs as an RCU reader) via
> > > > bcm_rx_update_and_send().  This allows op->thrtimer to be queued after
> > > > bcm_remove_op() has already cancelled it, leading to a use-after-free
> > > > when the timer fires on the deferred-freed struct bcm_op.
> > > > 
> > > > Address the omission by checking the RX_NO_AUTOTIMER flag
> > > > in bcm_rx_update_and_send() before starting op->thrtimer, effectively
> > > > preventing it from being rearmed concurrently with teardown.
> > > > 
> > > > Signed-off-by: Lee Jones <lee@kernel.org>
> > > 
> > > Many thanks for the investigation and the fix!
> > > 
> > > Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
> > 
> > Can we add a Fixes: tag?

Fixes: f1b4e32aca08 ("can: bcm: use call_rcu() instead of costly synchronize_rcu()")

Do you need me to resubmit or are you okay to apply manually / with b4?

> Yes, we should.
> 
> Thanks!
> 
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

I'm a little confused by the SoB.  Does this mean you've applied it?

-- 
Lee Jones

