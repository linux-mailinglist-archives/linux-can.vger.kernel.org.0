Return-Path: <linux-can+bounces-7527-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNhCD5wC+ml1HAMAu9opvQ
	(envelope-from <linux-can+bounces-7527-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 16:45:48 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 965204CFAAD
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 16:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C56C3064AD1
	for <lists+linux-can@lfdr.de>; Tue,  5 May 2026 14:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1491444D014;
	Tue,  5 May 2026 14:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uwz9RBpu"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A808544BCAC;
	Tue,  5 May 2026 14:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777992151; cv=none; b=GFgdZnqVK/UrOouVWG43w1XbZms4U9BWCMTYYO2vdEweLf8KdJyePJ7J7ntEOWX2d7PP/HGQgofIvuBhbJ+57Gjc0SXUC7gA0ZlDjWbv9fwosJAQYXaj9wtsPBUeSpzoqlXPvOMFxonHWCRjzWk2nshRmruYuERWaamfI4x72J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777992151; c=relaxed/simple;
	bh=yaRmq/h8X6rxfU9pBhHHqPzmyAEwgac80kFaDayrP3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Av5rEOfleSOzd7gsE86DAgUfO/7/CnBywaz+jHQyfumGDXpDHueI1PqfEI4fa/lxkAJbJVk1fvc6Ry6x74ivagVhXP/J54qZ/+9NcWWn22LzCdautNsMtCw8RlJRCuNlu7l97tTEXzRyv1R8vFZ8fgUwzv9ddvykr+DEyte4Ahs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uwz9RBpu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FD35C2BCC7;
	Tue,  5 May 2026 14:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777992151;
	bh=yaRmq/h8X6rxfU9pBhHHqPzmyAEwgac80kFaDayrP3Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uwz9RBpu7ny+vU4tU+ph2mG3CFfxFcgpDXdFVMsUqbLPlMhEdfP5fOxr4vdy8NoG9
	 Gi/QD47408eDoAkPApcO3SvEwkJ63uRZItaVMLzILVs8haiEyhD7H0HNSikLgReix0
	 C87+G2egdnRs5rCl8rlYE5akDT4LIi02osh8i5JbCjiZD/jV+uAz9g7CXW9ioOCzfX
	 1uo2372+oPkdNrOYs/0kLfKZXA6ynb/26cmxOct5JWbavjbjqewfEdObups5l01hBw
	 UTSUVRCGeBJA82qDw6BiipttO94GBnJs42ADms3A1w1+hsWAKhA7L9tmlEYnDAn3fj
	 1Vu9NAkc1XAmw==
Date: Tue, 5 May 2026 15:42:27 +0100
From: Lee Jones <lee@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] can: bcm: prevent thrtimer UAF in rx path by
 checking RX_NO_AUTOTIMER
Message-ID: <20260505144227.GB2661693@google.com>
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
X-Rspamd-Queue-Id: 965204CFAAD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7527-lists,linux-can=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hartkopp.net:email]

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
> 
> > I also thought Marc would add the Fixes tag on his own.
> 
> If you add it in the thread, b-4 will pick it up automatically and this
> less work for me :)

Any luck with this one Marc.

This should be send to the -rcs ASAP please.

-- 
Lee Jones

