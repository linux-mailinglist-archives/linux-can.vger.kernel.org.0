Return-Path: <linux-can+bounces-947-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7289260DF
	for <lists+linux-can@lfdr.de>; Wed,  3 Jul 2024 14:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26A7E1F21734
	for <lists+linux-can@lfdr.de>; Wed,  3 Jul 2024 12:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12BC178CFA;
	Wed,  3 Jul 2024 12:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="Mdj1CD/z";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="m5aSbOPw"
X-Original-To: linux-can@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A504A178CEE;
	Wed,  3 Jul 2024 12:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720011028; cv=none; b=jSnthUhwJnjBLs8lF8+gWxhWnWLLm0c9Rf3M+IPQFAG9fQSV7GkTtUL8TJjKHC8reNIkgSHcfWSKDNR2qjmvmerLGtHzbPVK3ySbzT6OMuQLanEfqL19igiOo8cLiG/TFcbaU8lSwDFvwAzmjSLTXpkQ3YTK2d2mHXoeKbm1NN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720011028; c=relaxed/simple;
	bh=//htds0Gxwdc60HRVxJ4E2umUzYUbcipiNv8kYB+0lo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LR8jpTyuVvi/r6wShVpSV4FXQPOW3P8gxHX8cqsyyZXzk99BYZ104QThRZLMJEoEjRVnBORTXWZxxncWVRXqX645jjCqqv4UYDA7whAMDVg7eYbu6BvgFRoLOf1AX5PYvwsrtcuB+gFA3t78fFqNGOn9cNBJyp0gC0coFCJXe4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=Mdj1CD/z; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=m5aSbOPw reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1720011026; x=1751547026;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=//htds0Gxwdc60HRVxJ4E2umUzYUbcipiNv8kYB+0lo=;
  b=Mdj1CD/zVc1eseetasYglak9Ifzs7BLugUWvUGxLj1Dl1IE90D09MROu
   6xQoggrMHYCP0F/3f2TfVWCA4nutHvP4jfyaYnowBySoCTRT3kfvnndg7
   vmr1KDfxyG/pVHCQot5P0uyXmUTM/9X2Z4xGHncbper0Nnq+/VguTkR5N
   iCCkUsxpzXmbf8IkhuL3odj+2We1vIMvSd84bAuekpnbFfYMZp8Ndt1hU
   IyOiKjWoyfR00WFzsqqaOGkWCQ2oy/f4x4BsOh/yXSu+kq145fQ6kJ1BK
   8MLnJzmPc2BjOWrfLrkJ5FK9UlrrULwiueTUg8uHvKnv0UM6Sjyh9gYOS
   Q==;
X-CSE-ConnectionGUID: UmoDDHTySqmy3obZG+emog==
X-CSE-MsgGUID: E3uAuytsQTaT+bzp83WV6Q==
X-IronPort-AV: E=Sophos;i="6.09,182,1716242400"; 
   d="scan'208";a="37726950"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 03 Jul 2024 14:50:23 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A8D9F1667A7;
	Wed,  3 Jul 2024 14:50:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1720011008;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=//htds0Gxwdc60HRVxJ4E2umUzYUbcipiNv8kYB+0lo=;
	b=m5aSbOPwNA8DlMbJCgRwbV7PyXvKbpIn70J+te46DpME8mLBQXLbkBCA3WCZCI80xKnGVO
	G529PFjz9zq3fawD3YcJZOz8jnRZlUbLcdebaC54mY/6kbsHDlZbzXi5uFEFKl9e3hF+IU
	+09q+tzRlK4vNIoSIfGvhNm0q+YwVVmtry6xry4LoklhXWgM1RUbJ5Afr7uEPqYaFFF6tl
	EfmpuBFBWvlH+vf6RIPBvXbX4FqenHjsICDuzh4dayXSDTwDbuPgkOPCxrsnXMjaimfITx
	bB5dwwP+2Y3Ij/0sH2QgeNGWzs1fJLCrsX7WuMGQ/6B0+aW/lgvn4QEBpTct1A==
Message-ID: <76faeb323353b584b310f2f1b53e9b2745d2f12c.camel@ew.tq-group.com>
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
Date: Wed, 03 Jul 2024 14:50:04 +0200
In-Reply-To: <734a29a87613b9052fc795d56a30690833e4aba9.camel@ew.tq-group.com>
References: <e72771c75988a2460fa8b557b0e2d32e6894f75d.camel@ew.tq-group.com>
	 <c93ab2cc-d8e9-41ba-9f56-51acb331ae38@leemhuis.info>
	 <h7lmtmqizoipzlazl36fz37w2f5ow7nbghvya3wu766la5hx6d@3jdesa3ltmuz>
	 <08aabeaf-6a81-48a9-9c5b-82a69b071faa@leemhuis.info>
	 <734a29a87613b9052fc795d56a30690833e4aba9.camel@ew.tq-group.com>
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

On Tue, 2024-07-02 at 12:03 +0200, Matthias Schiffer wrote:
> On Tue, 2024-07-02 at 07:37 +0200, Linux regression tracking (Thorsten Le=
emhuis) wrote:
> >=20
> >=20
> > On 01.07.24 16:34, Markus Schneider-Pargmann wrote:
> > > On Mon, Jul 01, 2024 at 02:12:55PM GMT, Linux regression tracking (Th=
orsten Leemhuis) wrote:
> > > > [CCing the regression list, as it should be in the loop for regress=
ions:
> > > > https://docs.kernel.org/admin-guide/reporting-regressions.html]
> > > >=20
> > > > Hi, Thorsten here, the Linux kernel's regression tracker. Top-posti=
ng
> > > > for once, to make this easily accessible to everyone.
> > > >=20
> > > > Hmm, looks like there was not even a single reply to below regressi=
on
> > > > report. But also seens Markus hasn't posted anything archived on Lo=
re
> > > > since about three weeks now, so he might be on vacation.
> > > >=20
> > > > Marc, do you might have an idea what's wrong with the culprit? Or d=
o we
> > > > expected Markus to be back in action soon?
> > >=20
> > > Great, ping here.
> >=20
> > Thx for replying!
> >=20
> > > @Matthias: Thanks for debugging and sorry for breaking it. If you hav=
e a
> > > fix for this, let me know. I have a lot of work right now, so I am no=
t
> > > sure when I will have a proper fix ready. But it is on my todo list.
> >=20
> > Thx. This made me wonder: is "revert the culprit to resolve this quickl=
y
> > and reapply it later together with a fix" something that we should
> > consider if a proper fix takes some time? Or is this not worth it in
> > this case or extremely hard? Or would it cause a regression on it's own
> > for users of 6.9?
> >=20
> > Ciao, Thorsten
>=20
> Hi,
>=20
> I think on 6.9 a revert is not easily possible (without reverting several=
 other commits adding new
> features), but it should be considered for 6.6.
>=20
> I don't think further regressions are possible by reverting, as on 6.6 th=
e timer is only used for
> platforms without an m_can IRQ, and on these platforms the current behavi=
or is "the kernel
> reproducibly deadlocks in atomic context", so there is not much room for =
making it worse.
>=20
> Like Markus, I have writing a proper fix for this on my TODO list, but I'=
m not sure when I can get
> to it - hopefully next week.
>=20
> Best regards,
> Matthias

A small update from my side:

I had a short look into the issue today, but I've found that I don't quite =
grasp the (lack of)
locking in the m_can driver. The m_can_classdev fields active_interrupts an=
d irqstatus are accessed
from a number of=C2=A0different contexts:

- active_interrupts is *mostly* read and written from the ISR/hrtimer callb=
ack, but also from
m_can_start()/m_can_stop() and (in error paths) indirectly from m_can_poll(=
) (NAPI callback). It is
not clear to me whether start/stop/poll could race with the ISR on a differ=
ent CPU. Besides being
used for ndo_open/stop, m_can_start/stop also happen from PM callbacks.
- irqstatus is written from the ISR (or hrtimer callback) and read from m_c=
an_poll() (NAPI callback)

Is this correct without explicit sychronization, or should there be some lo=
cking or atomic for these
accesses?

Best regards,
Matthias



>=20
>=20
>=20
> >=20
> > > > On 18.06.24 18:12, Matthias Schiffer wrote:
> > > > > Hi Markus,
> > > > >=20
> > > > > we've found that recent kernels hang on the TI AM62x SoC (where n=
o m_can interrupt is available and
> > > > > thus the polling timer is used), always a few seconds after the C=
AN interfaces are set up.
> > > > >=20
> > > > > I have bisected the issue to commit a163c5761019b ("can: m_can: S=
tart/Cancel polling timer together
> > > > > with interrupts"). Both master and 6.6 stable (which received a b=
ackport of the commit) are
> > > > > affected. On 6.6 the commit is easy to revert, but on master a lo=
t has happened on top of that
> > > > > change.
> > > > >=20
> > > > > As far as I can tell, the reason is that hrtimer_cancel() tries t=
o cancel the timer synchronously,
> > > > > which will deadlock when called from the hrtimer callback itself =
(hrtimer_callback -> m_can_isr ->
> > > > > m_can_disable_all_interrupts -> hrtimer_cancel).
> > > > >=20
> > > > > I can try to come up with a fix, but I think you are much more fa=
miliar with the driver code. Please
> > > > > let me know if you need any more information.
> > > > >=20
> > > > > Best regards,
> > > > > Matthias
> > > > >=20
> > > > >=20
> > >=20
> > >=20
>=20

--=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
https://www.tq-group.com/

