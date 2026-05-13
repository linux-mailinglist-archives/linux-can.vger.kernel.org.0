Return-Path: <linux-can+bounces-7618-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBXvENGTBGrULgIAu9opvQ
	(envelope-from <linux-can+bounces-7618-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 13 May 2026 17:08:01 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA013535C53
	for <lists+linux-can@lfdr.de>; Wed, 13 May 2026 17:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AFC6430CC5B3
	for <lists+linux-can@lfdr.de>; Wed, 13 May 2026 15:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2C1472798;
	Wed, 13 May 2026 15:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BcRv1FDF"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656123603D7;
	Wed, 13 May 2026 15:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778684441; cv=none; b=FfHRF0/rZJKjpnxcPzmx44PzZg0UgKvnf2hCnb+E02i08jlQo06LW8LvN3SC4y5Q+WbuopLher/UclD01mjgL+aX03M+AF9ZYv+dSOZ6sGcEpXX8dkRvQT9g8L4yENWSj2yo4a1yRH3YqeJOzBMgyz87h1OxioV2/yu2zX9gtw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778684441; c=relaxed/simple;
	bh=84t/pd/SJhy0zRG2PGZkNM8TlL2ts9O2cu1Dx18WwBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a1W6QnA2yqWsjWfEFmYUqpIrT636pqq39+SQsdiL+4bhFGdN3vayaYB13tvpzB5Z80SUYHuEowW/7QWchkXK60svUExAwoNk80jLUCm7XphfIoWjByFJ8eEleQjVlIgBjiIurGhVFsgtlIN+msoYuOs7BqBNSq50VvzJchPTBxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BcRv1FDF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F71AC2BCB7;
	Wed, 13 May 2026 15:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778684441;
	bh=84t/pd/SJhy0zRG2PGZkNM8TlL2ts9O2cu1Dx18WwBM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BcRv1FDFcFe2FTsX8HhAECfuLFrRyZjY8BV+BImTwSlT2ifUIBS6/ClGCkxkTYJij
	 TryB6E7xRekXG1WqtGpoSbWWrhV1VWvxsOY9HuQV4iT4KWZ0rxk0Bp+U/6krealeeP
	 VmH7dibGVEr929TPXjFIsXBgLLbyvWvoN1u4Eg9nXtyLZlE4cB342cgUcaXgjzoWpK
	 O6yE+ms9k0c2VVMwORbE6OOeLuzBivMyEM3/fMVbGB706gcGDYGqVEDifPLNU/B9Vn
	 TjqAUbiamax7On3Vn/IlGAeGMGKh+HSL70Dibr4tTMalFU1i39IdwyEQBe8AyQlf41
	 /25IO49hTPe3Q==
Date: Wed, 13 May 2026 16:00:36 +0100
From: Lee Jones <lee@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	davem@davemloft.net, linux-can@vger.kernel.org,
	kernel@pengutronix.de, Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH net 2/6] can: bcm: prevent thrtimer UAF in rx path by
 checking RX_NO_AUTOTIMER
Message-ID: <20260513150036.GF305027@google.com>
References: <20260507112321.439968-1-mkl@pengutronix.de>
 <20260507112321.439968-3-mkl@pengutronix.de>
 <20260508151237.7d0a9105@kernel.org>
 <20260513135913.GA305027@google.com>
 <20260513-abstract-purring-inchworm-f6daa3-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513-abstract-purring-inchworm-f6daa3-mkl@pengutronix.de>
X-Rspamd-Queue-Id: EA013535C53
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7618-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lee@kernel.org,linux-can@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Wed, 13 May 2026, Marc Kleine-Budde wrote:

> On 13.05.2026 14:59:13, Lee Jones wrote:
> > On Fri, 08 May 2026, Jakub Kicinski wrote:
> >
> > > On Thu,  7 May 2026 10:22:24 +0200 Marc Kleine-Budde wrote:
> > > > Commit f1b4e32aca08 ("can: bcm: use call_rcu() instead of costly
> > > > synchronize_rcu()") removed the synchronize_rcu() call from
> > > > bcm_delete_rx_op() and introduced the RX_NO_AUTOTIMER flag to prevent
> > > > timers from being rearmed during deletion.  However, it only applied
> > > > this check to op->timer via bcm_rx_starttimer().
> > >
> > > All AIs point out this is insufficient:
> > >
> > >     reader (bcm_rx_handler, RCU) | writer (bcm_delete_rx_op)
> > >     -----------------------------+-------------------------------
> > >     test op->flags (no AUTOTIMER)|
> > >                                  | op->flags |= RX_NO_AUTOTIMER
> > >                                  | bcm_remove_op()
> > >                                  |   hrtimer_cancel(&op->thrtimer)
> > >                                  |     /* not armed: no-op */
> > >                                  | call_rcu(bcm_free_op_rcu)
> > >     hrtimer_start(&op->thrtimer) |
> > >     return from RCU section      |
> > >                                  | grace period elapses
> > >                                  | bcm_free_op_rcu() -> kfree(op)
> > >     thrtimer fires               |
> > >       bcm_rx_thr_handler(op)     | <-- UAF
> >
> > Noted.  Leave it with me and I'll follow up shortly.
> 
> Please send a new patch against net-next/main, I'll drop this one.

Wilco - working on it now.

-- 
Lee Jones

