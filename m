Return-Path: <linux-can+bounces-5466-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F326C64E2A
	for <lists+linux-can@lfdr.de>; Mon, 17 Nov 2025 16:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E44954E8CB5
	for <lists+linux-can@lfdr.de>; Mon, 17 Nov 2025 15:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D01263F54;
	Mon, 17 Nov 2025 15:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="vN/gKoI5"
X-Original-To: linux-can@vger.kernel.org
Received: from smtpfb1-g21.free.fr (smtpfb1-g21.free.fr [212.27.42.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E3A2627F9;
	Mon, 17 Nov 2025 15:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763393572; cv=none; b=HgWG5DKkCqqtKCEP8EhPPRLuUKKDzCQiEApYjvNQkG8Qyn/TIYrcjRRv8UuImdmLPzhAC1n2rNLRioTc5RGFJ7XPWiOzgGtpfNonzG1OzShKuruOlI57NbGxlnVgU1f48XXghwWxCtxdD20UN2b5rb9RYWm2uiDWjwq3m9knJdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763393572; c=relaxed/simple;
	bh=hx2XFGP18eIkRAmhNGWfvqk6Q/SSP1WeIkSzsRkRiGI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:Subject:MIME-Version:
	 Content-Type; b=nRWDFXGYwsbXDpJSUPnjjOA82KG4nxgQUWorI8hdVEXDJFcgL60IAUeAoQdaFdw5TL0xmbnLlTegFtH9t2pUK59LULm5KszJrUS85YTj3ciaIjBKMUkP7zq0P9GakbEeGsJWAkJT/b3wIJxjaomnDERu78ePsuBtFJ45dXjei3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=vN/gKoI5; arc=none smtp.client-ip=212.27.42.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id A0BF4DF82F1;
	Mon, 17 Nov 2025 16:32:39 +0100 (CET)
Received: from zimbra65-e11.priv.proxad.net (unknown [172.20.243.215])
	by smtp3-g21.free.fr (Postfix) with ESMTP id EE91513F89C;
	Mon, 17 Nov 2025 16:32:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1763393552;
	bh=hx2XFGP18eIkRAmhNGWfvqk6Q/SSP1WeIkSzsRkRiGI=;
	h=Date:From:To:Cc:In-Reply-To:Subject:From;
	b=vN/gKoI5u97QXAZSUTVxC67bXn/YprldfgOgc8OHAdopzqHMIojj7mkgqGyYTq3Cw
	 z/2fy38cF3f7+N7J/EBVHngfdCvDpHZDUhhSMp7/90w3bqMSCe7pmY1N2LRVTuyK5X
	 fQMVhwyJND5Dix+mi1OBBD6kSH09KAvuAJmEFWI3uXDEpwuhXr5wi71D/wjBgZaGdz
	 O3euXayjxRllO7zBNA3jycqWTQ8MSuPNCGyga/rIkkY4dyXr5vQeCBsPpx9ll4Bra8
	 DNNqY+ncKxbQKbROpjnEeI0/Ts72JwV9oAx0NqKqLSiGBIt8GEWhsc6GwtXCiTcZrA
	 QL2tMMLA5FGvg==
Date: Mon, 17 Nov 2025 16:32:31 +0100 (CET)
From: =?utf-8?Q?St=C3=A9phane?= Grosjean <stephane.grosjean@free.fr>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Message-ID: <1277298823.655244587.1763393551815.JavaMail.root@zimbra65-e11.priv.proxad.net>
In-Reply-To: <a84c66ff-c5ad-418e-afb6-31f114eda17c@kernel.org>
Subject: Re: [PATCH RFC 1/3] can: calc_bittiming: get rid of the incorrect
 "nominal" word
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

Hello again Vincent,

(Sorry all, I can only slowly work through the list of emails from this wee=
kend.)

> >>  static int
> >>  can_update_sample_point(const struct can_bittiming_const *btc,
> >> -=09=09=09const unsigned int sample_point_nominal, const unsigned int
> >> tseg,
> >> +=09=09=09unsigned int sp_origin, unsigned int tseg,
> >=20
> > Please don't remove the "const".
> I always considered it silly to tag a scalar parameter as const.
> Because C
> passes the function argument by value, it is pretty meaningless.

The "const" attribute means that the parameter cannot be used on the left s=
ide of an assignment in its block. Even if this parameter is not an input/o=
utput parameter, without =E2=80=9Cconst=E2=80=9D it can be modified within =
the function, just like a local variable (which it is, since it is theoreti=
cally also declared on the stack). Explicitly stating =E2=80=9Cconst=E2=80=
=9D is a strong indicator that the value cannot be modified in the block im=
ho.

> Yours sincerely,
> Vincent Mailhol
>=20

Best regards,

-- St=C3=A9phane


