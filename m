Return-Path: <linux-can+bounces-7719-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHgANEEGGGqdZggAu9opvQ
	(envelope-from <linux-can+bounces-7719-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 28 May 2026 11:09:21 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECFA5EF3E6
	for <lists+linux-can@lfdr.de>; Thu, 28 May 2026 11:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C91C233E3138
	for <lists+linux-can@lfdr.de>; Thu, 28 May 2026 08:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F3638E12D;
	Thu, 28 May 2026 08:54:01 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B9034165B
	for <linux-can@vger.kernel.org>; Thu, 28 May 2026 08:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779958440; cv=none; b=bsVJa3RZTuELRyK3h/YH50gSUUiucthCnRrYQNqc7w7QH2BIhAnvsU/vt90mNsuVO/v+KQmY7TRERXfE8xkgIOujr+gsdoAF6PF6++mrkxln5mL4bRJYbbh1QgAbD0ePCLRGEWToOIrdNiOppKwn2KLhnYGecjJA0LxG9ymRMN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779958440; c=relaxed/simple;
	bh=0Gw37sNlsR91KhgF8/wQW3ulj7WrcxlZU/MAaALgfFw=;
	h=From:Subject:To:Cc:In-Reply-To:Content-Type:Date:Message-Id; b=r6GLl6jEDCpAvRhVZN30dEGVKFx3CUAkYnBw9urN/2ivu0PxcCtJ04Zj+BSZj7lSnQwmYaTfIEwIX0ja8w2/yIQCmsGY8sc7/0sFKwZ0O/bEl+m9ZAVT1oDEnp+tWECldjsizwVY1nJJimVFXMeP3jz69nljWJFvR46I40oAqG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1wSWUp-0003kh-Hb; Thu, 28 May 2026 10:53:43 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1wSWUo-002FGE-0Z;
	Thu, 28 May 2026 10:53:42 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <sha@pengutronix.de>)
	id 1wSWUo-00000003ZfC-2dBa;
	Thu, 28 May 2026 10:53:42 +0200
From: "Sascha Hauer" <s.hauer@pengutronix.de>
Subject: Re: [PATCH v3 0/7] hw/arm/sabrelite: Add FlexCAN support
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: "Andrei VOLKOV" <andrey.volkov@munic.io>, "Pavel Pisa" <pisa@fel.cvut.cz>, "Bernhard
 Beschow" <shentey@gmail.com>, =?utf-8?b?TWF0ecOhxaEgQm9iZWs=?= <matyas.bobek@gmail.com>, "Matyas
 Bobek" <bobekmat@fel.cvut.cz>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Nikita Ostrenkov" <n.ostrenkov@gmail.com>, "Daniel
 P. Berrange" <berrange@redhat.com>, "Peter Maydell" <peter.maydell@linaro.org>, linux-can@vger.kernel.org, "Sascha
 Hauer" <s.hauer@pengutronix.de>, "David Jander" <david@protonic.nl>
In-Reply-To: <20260527-durable-festive-millipede-f6e2b9-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 08:53:42 +0000
Message-Id: <E1wSWUo-00000003ZfC-2dBa@pty.whiteo.stw.pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [2.04 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[munic.io,fel.cvut.cz,gmail.com,nongnu.org,hartkopp.net,redhat.com,linaro.org,vger.kernel.org,pengutronix.de,protonic.nl];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7719-lists,linux-can=lfdr.de];
	DMARC_NA(0.00)[pengutronix.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[s.hauer@pengutronix.de,linux-can@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.990];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,munic.io:email,pty.whiteo.stw.pengutronix.de:mid,pengutronix.de:url]
X-Rspamd-Queue-Id: 2ECFA5EF3E6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-05-27 20:38, Marc Kleine-Budde wrote:
> On 27.05.2026 18:25:37, Andrei VOLKOV wrote:
> > As the original author, I have no objection to reusing (my part of) the
> > header under GPL-2.0-or-later. The reason it was not done that way in
> > 2005/2006 is simple: only GPLv2 existed at the time.
> >
> > All the more so since, as already noted, the code in question is essent=
ially
> > a direct transcription of offsets and bit-fields from the Freescale/NXP
> > datasheets, which leaves very little room for a meaningful copyright cl=
aim
> > in the first place.
> >
> > Personally, I would prefer that this code not be rewritten and be kept =
as
> > is, to avoid introducing subtle bugs in QEMU later on.
> > That said, @Sascha and @David may have a different opinion.
> >
> > PS: andrey.volkov@munic.io is my correct current work address, but I wo=
uld
> > prefer to use my personal one for this discussion.
>=20
> I've added David on Cc and given them a short overview of this
> discussion and linked this thread.
>=20
> I'll agree to re-license the register definitions of the flexcan driver
> to GPL-2.0-or-later. I'll poke Sasha tomorrow.

No objections from me as well.

Sascha

--
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

