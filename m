Return-Path: <linux-can+bounces-7718-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKyHFVnoF2osVQgAu9opvQ
	(envelope-from <linux-can+bounces-7718-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 28 May 2026 09:01:45 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A012C5ED74B
	for <lists+linux-can@lfdr.de>; Thu, 28 May 2026 09:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5BA3F30C6171
	for <lists+linux-can@lfdr.de>; Thu, 28 May 2026 06:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80EB3446C8;
	Thu, 28 May 2026 06:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonic.nl header.i=@protonic.nl header.b="IMd0SWO1"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp28.bhosted.nl (smtp28.bhosted.nl [94.124.121.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92784343D8A
	for <linux-can@vger.kernel.org>; Thu, 28 May 2026 06:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.124.121.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779951551; cv=none; b=JefzrJiVJJ5Fp593xc0iNRcq+tZfFhm/cSxHD/xTTun6ASXn6QGqyma6bcV0v+oKW1+m3FiqTnd1YEYihJo7VqrjnRtDQiEb4ilTp9PWWi0yq1fncsxJba3qGRwBpoCsHErg5iqpU0NaJxwWNwohzjK5d3i2Ts4FLf/uMH+G0lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779951551; c=relaxed/simple;
	bh=K5y++0pTZzXpoafaQOXDLQI0Jxm7mYJv/K4c5JEl+9k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ajDTpvvufNLsTwann/IGQ7EjPOvdMtKSyLAoN0GapyA3gdhuAslo+1xzD9j/3zc+tZuLyLPoU03eAA9z8aEMtLf/qO4Y2dcPB+Nke4kVcSPRfI0e22j6DoqTJhlXeg0FtD/xCt5xBFh7vpzlzIr4ppb7UfIgnj7/hD7dncauAbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=protonic.nl; spf=pass smtp.mailfrom=protonic.nl; dkim=pass (2048-bit key) header.d=protonic.nl header.i=@protonic.nl header.b=IMd0SWO1; arc=none smtp.client-ip=94.124.121.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=protonic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonic.nl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=protonic.nl; s=202111;
	h=content-transfer-encoding:content-type:mime-version:references:in-reply-to:
	 message-id:subject:cc:to:from:date:from;
	bh=dMkXZt73+dmsCO76lZDfKzhW+pTC9F2GeIZkDN4ijtE=;
	b=IMd0SWO17mr85B5W7+A4sJ9fI11XaMfxA2Rstx978fUKuskAZYu1VjaCoRkGW89FW27uRL+Af7Wco
	 pxSjYn2j25mabST/5KIwDWwV9lsF6Lp2XoYGWXjolnlb0xnmYCNjWAF+uH/ybhCa0UEgJ+zk9OC9Ox
	 sppu/gCJcGriAfQY51KZg2QOtStoinMd/D5gkVInb6O93KXDwRh+GkEWeiUgogg9rFpKtsXrlqwh2c
	 xF0DIQs2mRGU4/icCwdJ1UC5owf8SCKIsUuBBcC1l0esxQBUiFOy7eq/EeUUsAbu46eemeCNkZZUOd
	 f13lTD88532xJG3FaHqx/4OedIIoQ3w==
X-MSG-ID: 8e8991c4-5a62-11f1-9d12-0050568164d1
Date: Thu, 28 May 2026 08:57:56 +0200
From: David Jander <david@protonic.nl>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Andrei VOLKOV <andrey.volkov@munic.io>, Pavel Pisa <pisa@fel.cvut.cz>,
 Bernhard Beschow <shentey@gmail.com>, =?UTF-8?B?TWF0ecOhxaE=?= Bobek
 <matyas.bobek@gmail.com>, Matyas Bobek <bobekmat@fel.cvut.cz>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, Oliver Hartkopp
 <socketcan@hartkopp.net>, Nikita Ostrenkov <n.ostrenkov@gmail.com>, "Daniel
 P. Berrange" <berrange@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, linux-can@vger.kernel.org, Sascha Hauer
 <s.hauer@pengutronix.de>
Subject: Re: [PATCH v3 0/7] hw/arm/sabrelite: Add FlexCAN support
Message-ID: <20260528085756.322eb221@erd003.prtnl>
In-Reply-To: <20260527-durable-festive-millipede-f6e2b9-mkl@pengutronix.de>
References: <cover.1777571962.git.matyas.bobek@gmail.com>
	<CAFEAcA95RcGhhN8ZqVeOgRyhRqSar23EnJhCjVgKBwoqXBJwjw@mail.gmail.com>
	<08A7BC6B-7019-45C4-B581-0A26AD3AA554@gmail.com>
	<202605271738.21722.pisa@fel.cvut.cz>
	<20260527-fast-unbiased-flamingo-5c5cbe-mkl@pengutronix.de>
	<07cc057c-61b3-4744-96fa-1d792989cb4c@munic.io>
	<20260527-durable-festive-millipede-f6e2b9-mkl@pengutronix.de>
Organization: Protonic Holland
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[protonic.nl:s=202111];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DMARC_NA(0.00)[protonic.nl];
	HAS_ORG_HEADER(0.00)[];
	TAGGED_FROM(0.00)[bounces-7718-lists,linux-can=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[protonic.nl:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david@protonic.nl,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[munic.io,fel.cvut.cz,gmail.com,nongnu.org,hartkopp.net,redhat.com,linaro.org,vger.kernel.org,pengutronix.de];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-can];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,protonic.nl:dkim,erd003.prtnl:mid,pengutronix.de:email]
X-Rspamd-Queue-Id: A012C5ED74B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 27 May 2026 20:38:10 +0200
Marc Kleine-Budde <mkl@pengutronix.de> wrote:

> On 27.05.2026 18:25:37, Andrei VOLKOV wrote:
> > As the original author, I have no objection to reusing (my part of) the
> > header under GPL-2.0-or-later. The reason it was not done that way in
> > 2005/2006 is simple: only GPLv2 existed at the time.
> >
> > All the more so since, as already noted, the code in question is essentially
> > a direct transcription of offsets and bit-fields from the Freescale/NXP
> > datasheets, which leaves very little room for a meaningful copyright claim
> > in the first place.
> >
> > Personally, I would prefer that this code not be rewritten and be kept as
> > is, to avoid introducing subtle bugs in QEMU later on.
> > That said, @Sascha and @David may have a different opinion.
> >
> > PS: andrey.volkov@munic.io is my correct current work address, but I would
> > prefer to use my personal one for this discussion.  
> 
> I've added David on Cc and given them a short overview of this
> discussion and linked this thread.
> 
> I'll agree to re-license the register definitions of the flexcan driver
> to GPL-2.0-or-later. I'll poke Sasha tomorrow.

I have no objections for this part to be used under GPL-2.0-or-later.

Best regards,

-- 
David Jander


