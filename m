Return-Path: <linux-can+bounces-5465-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E313C646FC
	for <lists+linux-can@lfdr.de>; Mon, 17 Nov 2025 14:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 646754F075D
	for <lists+linux-can@lfdr.de>; Mon, 17 Nov 2025 13:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF1B332916;
	Mon, 17 Nov 2025 13:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="fM71aA9X"
X-Original-To: linux-can@vger.kernel.org
Received: from smtpfb2-g21.free.fr (smtpfb2-g21.free.fr [212.27.42.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B36F33556C;
	Mon, 17 Nov 2025 13:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763386656; cv=none; b=Y6DVeP5OAv/H+e1YyKLrS/Ham7pFqgfCZ83qDB9s84u5QSifgxzGB+ayV4mjubTNDEfNtdN7DeiREgcuu6Lv6RmttOFFcDd/HQovtoXbftPTljMD5b8v7cbuhtYO2UB6bxhV+RkxiGVsqFkDax+ccwQ1yu3oYlqJXsxJJJBjlNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763386656; c=relaxed/simple;
	bh=xED8t/egsDUASzU6YzpvEL9qdEDzrwbPuclwRLvS2L0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:Subject:MIME-Version:
	 Content-Type; b=fIlLGLYU8wPN3H5L91nbipIaqjXfChr+x6R6LiHL6u/8HHGyHBREZFQSkpu+d4grsmwj7vObgN3+EmUbBSowAUnlv6cDZAz2mvYV0wNWvE0N9ugA0Xj0xBt+Hw/Ep1ronu9aKaSMKdsCEVx+yRRCskx6QtxIm1zXawn0LwHl0FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=fM71aA9X; arc=none smtp.client-ip=212.27.42.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id CFE344D005;
	Mon, 17 Nov 2025 14:31:45 +0100 (CET)
Received: from zimbra65-e11.priv.proxad.net (unknown [172.20.243.215])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 4BB38B0054E;
	Mon, 17 Nov 2025 14:31:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1763386298;
	bh=xED8t/egsDUASzU6YzpvEL9qdEDzrwbPuclwRLvS2L0=;
	h=Date:From:To:Cc:In-Reply-To:Subject:From;
	b=fM71aA9XpnYdxnQ6iIkKzmQfisTFy937P3O9gje3zQ4Svpir3noZCinx3NRLzmdJK
	 xfgyzbn1Fvt2hSYVC3iLpwvSkdmo/t/96IVnhnPwg3/WH2oXWfY+PO/Bnzd8Yin0lb
	 9FUuLiicUaB209sNwHZWDy2ZBDr5wcbuUJzTqMvfyoskfOMvs/45+Zc0Ubrgbcyc/0
	 SmHucygKU95sorsRnpn9iFtbt8ZSXTZDllWvQ+2MShVyHy+FdYNldBiaqwqE1iApYC
	 6pbbYgx8NG9p2BXAZf3ue/UiRFy+Sla+g1pj/VZSrduAKis4lsBlH/107RnyiFtpc/
	 aFihVi0A+9KXw==
Date: Mon, 17 Nov 2025 14:31:38 +0100 (CET)
From: =?utf-8?Q?St=C3=A9phane?= Grosjean <stephane.grosjean@free.fr>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: =?utf-8?Q?St=C3=A9phane?= Grosjean <stephane.grosjean@hms-networks.com>, 
	Robert Nawrath <mbro1689@gmail.com>, 
	Minh Le <minh.le.aj@renesas.com>, 
	Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Oliver Hartkopp <socketcan@hartkopp.net>, 
	Marc Kleine-Budde <mkl@pengutronix.de>
Message-ID: <2145685673.654764160.1763386298170.JavaMail.root@zimbra65-e11.priv.proxad.net>
In-Reply-To: <72d2721c-6713-4e6a-b0d4-28f600715808@kernel.org>
Subject: Re: [PATCH 3/9] can: netlink: add initial CAN XL support
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 7.2.0-GA2598 (ZimbraWebClient - GC142 (Linux)/7.2.0-GA2598)
X-Authenticated-User: stephane.grosjean@free.fr

Hi Vincent,

> Then, should we go for this or not? The benefit I see to add this
> check would be
> less effort on the patch reviews for new devices (which I am mostly
> doing
> recently). I can foreseen that people will wrongly use
> CAN_CTRLMODE_LISTENONLY
> instead of CAN_CTRLMODE_RESTRICTED. This piece of code will make sure
> that they
> will implement CAN_CTRLMODE_RESTRICTED. And because this feature is
> mandatory, I
> thought this wasn't a too bad idea. This will also save me the effort
> to ask if
> to people submitting patches if this feature is supported or not.

I understand the benefits for you. But I see the disadvantages for the user=
. Regardless of whether RESTRICTED mode is mandatory, not requesting this m=
ode should not result in what looks like an error message for the user. As =
it stands, the fact that it is even a warning is even more confusing, since=
 the interface is configured anyway. And I don't think I'm an average user.=
 Given that the interface will be configured anyway, this warning is more d=
isruptive than useful to me. And that's really a strong opinion.
=20
> If someone comes with a non-compliant device, we can still statically
> set the
> flag. So this isn't even a blocker for non compliant devices.
>=20

After reading the very strict interpretation of the ES bit (which I also ag=
ree with, despite being the originator of the initial simplification propos=
al), I admit that I don't understand this:

Speaking of my case: our CANXL core does not currently include RESTRICTED m=
ode (which is considered more of an option to be added in the future). If C=
ANXL grows in popularity, it will be much more due to its finally relevant =
throughputs and payload length than to this mode, which is close to LISTEN_=
ONLY in my opinion.

Furthermore, I find it hard to imagine that the RESTRICTED flag would be ad=
ded statically, whereas in reality, considering it as an option, the driver=
 could add it as a feature finally supported by new firmware versions.

I see it more like CAN_CTRLMODE_CC_LEN8_DLC: if I'm not mistaken, DLC value=
s > 8 have always been allowed by the standard, and yet it was only added i=
n 5.11.

At worst, let's define a flag such as CAN_CTRLMODE_FD_NON_ISO, i.e., CAN_CT=
RLMODE_XL_NON_RESTRICTED.


> So, at the end, this is mostly a selfish feature to remove some patch
> reviewing
> effort (while still pushing toward ISO compliance, which isn't a bad
> thing either).
>=20
> I prefer to have it like this, but this isn't a strong opinion
> either.
>=20
>=20
> Yours sincerely,
> Vincent Mailhol
>=20

Looking forward to hearing from you,

-- St=C3=A9phane=20

