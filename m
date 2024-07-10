Return-Path: <linux-can+bounces-961-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E5592CC2F
	for <lists+linux-can@lfdr.de>; Wed, 10 Jul 2024 09:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E7611C21316
	for <lists+linux-can@lfdr.de>; Wed, 10 Jul 2024 07:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C2A7BB17;
	Wed, 10 Jul 2024 07:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="opPjPT1V";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="G6+JlULH"
X-Original-To: linux-can@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D68D535;
	Wed, 10 Jul 2024 07:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720597596; cv=none; b=ksyQgXPmespgOJmEu2tkN1KurHalmuqoRt/zMj2wCYTPlkyk74k1BppqJ2dABIl1aI64Ph7KZkybP/GV7bqBJyFREKhzAolBuxHaM/Il8kVZlIDbHfgTz7n84b+C+cD4kqJnMLZsgcecJYN1ha2GROWGXn9R0eqVbZ53bmTSIow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720597596; c=relaxed/simple;
	bh=jL9QRqaslQ4cEHAQYLLzFk0VWk2T4B6GOv5rS797vwU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VIZoYvIksbkao/Qp1YFuTic1hZhVmJKnczWVgc/+049Jbyf7Qc2e2FQZ+7ZXmjEvZTPfng1G1XvpESbyd2NjSPVBp1/q5tlYp+mgUtMxsJX3TwE+bDlxhXZwLBRD/0l7hBKnJN4F6vhn/j9B7awmJURt/XfLYQUle2Y7XmUpD+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=opPjPT1V; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=G6+JlULH reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1720597593; x=1752133593;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=jL9QRqaslQ4cEHAQYLLzFk0VWk2T4B6GOv5rS797vwU=;
  b=opPjPT1V32E+iz/61tSnxKU9yQuTCaQNRa2vmdoaixbKru7CGzj+dYZe
   HqXNaZlEds4xH2N8tzQUVy+CHEGIvT3FK435n8X/r6UxBcUIj9zUgshvw
   FCd5YGBDGPuF95nA6PaQptvTzM7KSaOQipjIb55j1xqsqhzXObRLDcZ1F
   JhlGlEpBOUp5ulbGnZFpA1EYkVo3vkibibGTm2PkG5LMyLoNxcTr4Zwj8
   k8koMEmqTD8wu8KdXiB0ety9YY6tFp/RpA3UNXG5sdVM9bHBi6/bR397g
   qokjUEaj0GHOPlVxl56pJJtPOMbPGkBy5ROR2sxTU9++uo/WeQySleS6p
   Q==;
X-CSE-ConnectionGUID: 64uWWlOzSQuI3t/PZnqU+A==
X-CSE-MsgGUID: y01Ja1aVQpeS9GgMNhflVw==
X-IronPort-AV: E=Sophos;i="6.09,197,1716242400"; 
   d="scan'208";a="37832087"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 10 Jul 2024 09:46:30 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 92D67161586;
	Wed, 10 Jul 2024 09:46:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1720597586;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=jL9QRqaslQ4cEHAQYLLzFk0VWk2T4B6GOv5rS797vwU=;
	b=G6+JlULHlgxjKBkO66J+9gmPBqq8KA3KCBjgbtlBQDdeUi7Z3GVeK/c92zYk+W8xGqmwZI
	/mFRTfXaHvEifEGzefycU3tTEF9lErB89f8Be0+zN1B/IH62Yd+MY0IT2kXqJ1PGSsIn1M
	j1LPn/548m9C9V8CoQoSyR2T4rZVfjWuQmU94BmrRjSQQZfDKTgcKKdAyXdK3dCmg7rBAu
	SixBSOo2MahFucnMVJPvDQrOuwd3t/RSuAGJFTTxHzVxfkwiDnBjQoRTGII9hUhuhWORHQ
	Z1URs5RUU30cNhAAZ9AjNBwXTRZyldYb/j/nk9XlXl6Eo8X3jc/uVDRx9y36jA==
Message-ID: <945b275d60c37b6d4db631c10973f04cca2b5182.camel@ew.tq-group.com>
Subject: Re: Kernel hang caused by commit "can: m_can: Start/Cancel polling
 timer together with interrupts"
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Chandrasekar Ramakrishnan
 <rcsekar@samsung.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>, Tony Lindgren
 <tony@atomide.com>, Judith Mendez <jm@ti.com>,  linux-can@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux@ew.tq-group.com, Linux regressions mailing list
 <regressions@lists.linux.dev>
Date: Wed, 10 Jul 2024 09:46:23 +0200
In-Reply-To: <tyq2h55iyfxmebysxbdv352vops7i5fhi3avs6u7h6yinwv75j@m6wicydoobbp>
References: <e72771c75988a2460fa8b557b0e2d32e6894f75d.camel@ew.tq-group.com>
	 <c93ab2cc-d8e9-41ba-9f56-51acb331ae38@leemhuis.info>
	 <h7lmtmqizoipzlazl36fz37w2f5ow7nbghvya3wu766la5hx6d@3jdesa3ltmuz>
	 <08aabeaf-6a81-48a9-9c5b-82a69b071faa@leemhuis.info>
	 <734a29a87613b9052fc795d56a30690833e4aba9.camel@ew.tq-group.com>
	 <76faeb323353b584b310f2f1b53e9b2745d2f12c.camel@ew.tq-group.com>
	 <tyq2h55iyfxmebysxbdv352vops7i5fhi3avs6u7h6yinwv75j@m6wicydoobbp>
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

On Tue, 2024-07-09 at 14:23 +0200, Markus Schneider-Pargmann wrote:
>=20
>=20
> Hi,
>=20
> On Wed, Jul 03, 2024 at 02:50:04PM GMT, Matthias Schiffer wrote:
> > On Tue, 2024-07-02 at 12:03 +0200, Matthias Schiffer wrote:
> > > On Tue, 2024-07-02 at 07:37 +0200, Linux regression tracking (Thorste=
n Leemhuis) wrote:
> > > >=20
> > > >=20
> > > > On 01.07.24 16:34, Markus Schneider-Pargmann wrote:
> > > > > On Mon, Jul 01, 2024 at 02:12:55PM GMT, Linux regression tracking=
 (Thorsten Leemhuis) wrote:
> > > > > > [CCing the regression list, as it should be in the loop for reg=
ressions:
> > > > > > https://docs.kernel.org/admin-guide/reporting-regressions.html]
> > > > > >=20
> > > > > > Hi, Thorsten here, the Linux kernel's regression tracker. Top-p=
osting
> > > > > > for once, to make this easily accessible to everyone.
> > > > > >=20
> > > > > > Hmm, looks like there was not even a single reply to below regr=
ession
> > > > > > report. But also seens Markus hasn't posted anything archived o=
n Lore
> > > > > > since about three weeks now, so he might be on vacation.
> > > > > >=20
> > > > > > Marc, do you might have an idea what's wrong with the culprit? =
Or do we
> > > > > > expected Markus to be back in action soon?
> > > > >=20
> > > > > Great, ping here.
> > > >=20
> > > > Thx for replying!
> > > >=20
> > > > > @Matthias: Thanks for debugging and sorry for breaking it. If you=
 have a
> > > > > fix for this, let me know. I have a lot of work right now, so I a=
m not
> > > > > sure when I will have a proper fix ready. But it is on my todo li=
st.
> > > >=20
> > > > Thx. This made me wonder: is "revert the culprit to resolve this qu=
ickly
> > > > and reapply it later together with a fix" something that we should
> > > > consider if a proper fix takes some time? Or is this not worth it i=
n
> > > > this case or extremely hard? Or would it cause a regression on it's=
 own
> > > > for users of 6.9?
> > > >=20
> > > > Ciao, Thorsten
> > >=20
> > > Hi,
> > >=20
> > > I think on 6.9 a revert is not easily possible (without reverting sev=
eral other commits adding new
> > > features), but it should be considered for 6.6.
> > >=20
> > > I don't think further regressions are possible by reverting, as on 6.=
6 the timer is only used for
> > > platforms without an m_can IRQ, and on these platforms the current be=
havior is "the kernel
> > > reproducibly deadlocks in atomic context", so there is not much room =
for making it worse.
> > >=20
> > > Like Markus, I have writing a proper fix for this on my TODO list, bu=
t I'm not sure when I can get
> > > to it - hopefully next week.
> > >=20
> > > Best regards,
> > > Matthias
> >=20
> > A small update from my side:
> >=20
> > I had a short look into the issue today, but I've found that I don't qu=
ite grasp the (lack of)
> > locking in the m_can driver. The m_can_classdev fields active_interrupt=
s and irqstatus are accessed
> > from a number of=C2=A0different contexts:
> >=20
> > - active_interrupts is *mostly* read and written from the ISR/hrtimer c=
allback, but also from
> > m_can_start()/m_can_stop() and (in error paths) indirectly from m_can_p=
oll() (NAPI callback). It is
> > not clear to me whether start/stop/poll could race with the ISR on a di=
fferent CPU. Besides being
> > used for ndo_open/stop, m_can_start/stop also happen from PM callbacks.
> > - irqstatus is written from the ISR (or hrtimer callback) and read from=
 m_can_poll() (NAPI callback)
> >=20
> > Is this correct without explicit sychronization, or should there be som=
e locking or atomic for these
> > accesses?
>=20
> Thanks for pointing these out. I started creating some fixes for some of
> the patches. Not done yet, but I am working on it.
>=20
> Best,
> Markus

Hi Markus,

thanks for the update. I'm going to be out of office from Jul 12-26, so I w=
ill only be able to test
fixes when I'm back.

Best regards,
Matthias



>=20
> >=20
> > Best regards,
> > Matthias
> >=20
> >=20
> >=20
> > >=20
> > >=20
> > >=20
> > > >=20
> > > > > > On 18.06.24 18:12, Matthias Schiffer wrote:
> > > > > > > Hi Markus,
> > > > > > >=20
> > > > > > > we've found that recent kernels hang on the TI AM62x SoC (whe=
re no m_can interrupt is available and
> > > > > > > thus the polling timer is used), always a few seconds after t=
he CAN interfaces are set up.
> > > > > > >=20
> > > > > > > I have bisected the issue to commit a163c5761019b ("can: m_ca=
n: Start/Cancel polling timer together
> > > > > > > with interrupts"). Both master and 6.6 stable (which received=
 a backport of the commit) are
> > > > > > > affected. On 6.6 the commit is easy to revert, but on master =
a lot has happened on top of that
> > > > > > > change.
> > > > > > >=20
> > > > > > > As far as I can tell, the reason is that hrtimer_cancel() tri=
es to cancel the timer synchronously,
> > > > > > > which will deadlock when called from the hrtimer callback its=
elf (hrtimer_callback -> m_can_isr ->
> > > > > > > m_can_disable_all_interrupts -> hrtimer_cancel).
> > > > > > >=20
> > > > > > > I can try to come up with a fix, but I think you are much mor=
e familiar with the driver code. Please
> > > > > > > let me know if you need any more information.
> > > > > > >=20
> > > > > > > Best regards,
> > > > > > > Matthias
> > > > > > >=20
> > > > > > >=20
> > > > >=20
> > > > >=20
> > >=20
> >=20
> > --=20
> > TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, =
Germany
> > Amtsgericht M=C3=BCnchen, HRB 105018
> > Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan=
 Schneider
> > https://www.tq-group.com/

--=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
https://www.tq-group.com/

