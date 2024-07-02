Return-Path: <linux-can+bounces-943-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC788923B03
	for <lists+linux-can@lfdr.de>; Tue,  2 Jul 2024 12:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70CE11F21C55
	for <lists+linux-can@lfdr.de>; Tue,  2 Jul 2024 10:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61F9156228;
	Tue,  2 Jul 2024 10:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="nO1TVLg3";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="ZOrQNQtM"
X-Original-To: linux-can@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56639152500;
	Tue,  2 Jul 2024 10:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719914603; cv=none; b=IQf1m4n1QQER5SqJ26we+rE5aZ67pZR5iBHaY7V8fGo7dLCH1wluYtswh9XCk0friBUu2F0DN4ALyxyWm3IK2Doc2/35wLX6Ne7e5YMh3XU/7ZoRVCjD28ZZ/eCVtrPKmiIe+BSd/WKqwb89QsBS88EYkJ3dBNbjS5gV2vE/WC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719914603; c=relaxed/simple;
	bh=ZZC6RUME3C3T+j6uBSf5KK5uj8Trge04Cv6a6nZ23VQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eV8iN9PXrkRUkf8h1mek8+LVWoGzaK7L314kSEfy7iFSnvsaWdEW1R1n4y6Iq2x0jLmDXvqCjoL7qUVzdMzTjvHROab5HQdVAQlEB1xpvJxhINxc/HObmxOQdleCpSez7YXNj7x2b8xzfzCdE37qNbjWXKuSKYNmREScKBKh8Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=nO1TVLg3; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=ZOrQNQtM reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1719914600; x=1751450600;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=ZZC6RUME3C3T+j6uBSf5KK5uj8Trge04Cv6a6nZ23VQ=;
  b=nO1TVLg3rMM+RdaZYYDVe7ZBZDKdwLH1mAjHz0dk7CuC2C4+C8YiPZ6d
   IEBqM5GMsG9sLCTf8K5+rJjejbl0fdlp+MDIrBxn4H7c1kJYZT9574iv9
   xcsyWv96bGA7tshC8dwheCwTAJYRVKjwn/+/pQ5KOl5wrELVXJYSCvwTx
   3QGEb22mgyg5dEYPsnxShiLb4hj21bwYM8Zx1cqLtxzChcwzamQ5PV5+m
   cjU/h4c6+zxX0LFn/wRPlbim7kSVwNQ9/4CnFN8/6gycJhPd2l504XAC7
   qZ7lMOJKGG+TZn9AOmwxe7JbRAMHDOQu2ayOFWwv6hvjXp1hkZ9kQvpMf
   w==;
X-CSE-ConnectionGUID: LYzK7jUlQ2y1hld4f6tLmA==
X-CSE-MsgGUID: uNEUPFhTQ+KBuwDotQUbhQ==
X-IronPort-AV: E=Sophos;i="6.09,178,1716242400"; 
   d="scan'208";a="37697386"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 02 Jul 2024 12:03:10 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 968581658FC;
	Tue,  2 Jul 2024 12:03:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1719914586;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ZZC6RUME3C3T+j6uBSf5KK5uj8Trge04Cv6a6nZ23VQ=;
	b=ZOrQNQtMSkAIaicd+ssSgMSS1f+2sT2dsUkHW279QXJMAqSbTxnzoRPxc0FgXXNwdiHVCB
	nSZ4yfF2iFgFsFuQ3fb1K6Rj3NM1OjCGGWLFgEm0vbn1+LHZA272r4EoZuV5aaNlgFFG8q
	jhZ/D3aa/i1yQBV8oymhfJtmjSBlzSPf5nen2Sub0M8Lx0rJSannB9FREn/TynYfxLDJHc
	T5+iNFM07fZ2aoMQSjH2m4GJnuG/2aqubOWMB/+RNEYotShXZdMvDtl8amC6157oDG0otU
	WedOEuLJFj5dqT79l51MHNvODXL9cMToZmUR6Hnjh6XJUshbZHd6S+U3GbBVOw==
Message-ID: <734a29a87613b9052fc795d56a30690833e4aba9.camel@ew.tq-group.com>
Subject: Re: Kernel hang caused by commit "can: m_can: Start/Cancel polling
 timer together with interrupts"
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Linux regressions mailing list <regressions@lists.linux.dev>, Markus
	Schneider-Pargmann
	 <msp@baylibre.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Chandrasekar Ramakrishnan
 <rcsekar@samsung.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>, Tony Lindgren
 <tony@atomide.com>, Judith Mendez <jm@ti.com>,  linux-can@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,  linux@ew.tq-group.com
Date: Tue, 02 Jul 2024 12:03:01 +0200
In-Reply-To: <08aabeaf-6a81-48a9-9c5b-82a69b071faa@leemhuis.info>
References: <e72771c75988a2460fa8b557b0e2d32e6894f75d.camel@ew.tq-group.com>
	 <c93ab2cc-d8e9-41ba-9f56-51acb331ae38@leemhuis.info>
	 <h7lmtmqizoipzlazl36fz37w2f5ow7nbghvya3wu766la5hx6d@3jdesa3ltmuz>
	 <08aabeaf-6a81-48a9-9c5b-82a69b071faa@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3

On Tue, 2024-07-02 at 07:37 +0200, Linux regression tracking (Thorsten Leem=
huis) wrote:
>=20
>=20
> On 01.07.24 16:34, Markus Schneider-Pargmann wrote:
> > On Mon, Jul 01, 2024 at 02:12:55PM GMT, Linux regression tracking (Thor=
sten Leemhuis) wrote:
> > > [CCing the regression list, as it should be in the loop for regressio=
ns:
> > > https://docs.kernel.org/admin-guide/reporting-regressions.html]
> > >=20
> > > Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
> > > for once, to make this easily accessible to everyone.
> > >=20
> > > Hmm, looks like there was not even a single reply to below regression
> > > report. But also seens Markus hasn't posted anything archived on Lore
> > > since about three weeks now, so he might be on vacation.
> > >=20
> > > Marc, do you might have an idea what's wrong with the culprit? Or do =
we
> > > expected Markus to be back in action soon?
> >=20
> > Great, ping here.
>=20
> Thx for replying!
>=20
> > @Matthias: Thanks for debugging and sorry for breaking it. If you have =
a
> > fix for this, let me know. I have a lot of work right now, so I am not
> > sure when I will have a proper fix ready. But it is on my todo list.
>=20
> Thx. This made me wonder: is "revert the culprit to resolve this quickly
> and reapply it later together with a fix" something that we should
> consider if a proper fix takes some time? Or is this not worth it in
> this case or extremely hard? Or would it cause a regression on it's own
> for users of 6.9?
>=20
> Ciao, Thorsten

Hi,

I think on 6.9 a revert is not easily possible (without reverting several o=
ther commits adding new
features), but it should be considered for 6.6.

I don't think further regressions are possible by reverting, as on 6.6 the =
timer is only used for
platforms without an m_can IRQ, and on these platforms the current behavior=
 is "the kernel
reproducibly deadlocks in atomic context", so there is not much room for ma=
king it worse.

Like Markus, I have writing a proper fix for this on my TODO list, but I'm =
not sure when I can get
to it - hopefully next week.

Best regards,
Matthias



>=20
> > > On 18.06.24 18:12, Matthias Schiffer wrote:
> > > > Hi Markus,
> > > >=20
> > > > we've found that recent kernels hang on the TI AM62x SoC (where no =
m_can interrupt is available and
> > > > thus the polling timer is used), always a few seconds after the CAN=
 interfaces are set up.
> > > >=20
> > > > I have bisected the issue to commit a163c5761019b ("can: m_can: Sta=
rt/Cancel polling timer together
> > > > with interrupts"). Both master and 6.6 stable (which received a bac=
kport of the commit) are
> > > > affected. On 6.6 the commit is easy to revert, but on master a lot =
has happened on top of that
> > > > change.
> > > >=20
> > > > As far as I can tell, the reason is that hrtimer_cancel() tries to =
cancel the timer synchronously,
> > > > which will deadlock when called from the hrtimer callback itself (h=
rtimer_callback -> m_can_isr ->
> > > > m_can_disable_all_interrupts -> hrtimer_cancel).
> > > >=20
> > > > I can try to come up with a fix, but I think you are much more fami=
liar with the driver code. Please
> > > > let me know if you need any more information.
> > > >=20
> > > > Best regards,
> > > > Matthias
> > > >=20
> > > >=20
> >=20
> >=20

--=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
https://www.tq-group.com/

