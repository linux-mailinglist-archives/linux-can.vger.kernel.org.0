Return-Path: <linux-can+bounces-3728-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 411B8AC7530
	for <lists+linux-can@lfdr.de>; Thu, 29 May 2025 02:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C4635003B9
	for <lists+linux-can@lfdr.de>; Thu, 29 May 2025 00:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C37126F0A;
	Thu, 29 May 2025 00:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Bq2CVbct"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (outm-53.smtpout.orange.fr [193.252.22.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D5515D1
	for <linux-can@vger.kernel.org>; Thu, 29 May 2025 00:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748479858; cv=none; b=lJtV64XBv9kjtqftxsO3wFHTQuGzphjpKmGWoZPsoLJyqrinH4qiXAR47ZGJ2sDDtF5n8Wx+P0hPICi6jmW2nsLomhTogBwUE2HBsjgjRU/5pgZXR/63YjrlUqW7pq0lCB4VD+uCFb3Ye11Lg+Pp7wU4PlG7ybhtQZQ4aUI3y30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748479858; c=relaxed/simple;
	bh=Sq3iN24j0EqrqF7BlSHi/upV1Re05AEmslRc0OHgE7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YdsKFBTDG9ryRD/sJuIQdxM3twgt/0HxXWrilm5/f8cAltcfnWUwzOjanvMbWF+/lu8M7qa7fuFbvCDYQo2qJoqchDvmdRERPXSVqNZOQNOTvkuNwl917kZGSpz9cWT2RKOkJ5FnGE4uSa7pbwx85iXRwpD2p1vrLZEqhy6mQ9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Bq2CVbct; arc=none smtp.client-ip=193.252.22.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from mail-ed1-f46.google.com ([209.85.208.46])
	by smtp.orange.fr with ESMTPA
	id KRSputYrU2e2BKRSpu5Dq3; Thu, 29 May 2025 02:49:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1748479783;
	bh=jnB5RCbG9/sXhr3bb82Ztf4ZuU81DU6IRTJ9KlGZtf4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=Bq2CVbctnqxUrtZgvYStBDraQZP0K+3YBGdoZ4nzKp2gyIaezz213BAUfmYZM6p/r
	 DtW1Y0T1uPovMm/UfNWxoSFmXVLppvCAVkYMx5SkvHJARqGOxus6Ma8mGzxKu8yAjX
	 ik3QiL7X+i1HjHmOQkyija21VXY60QGH1GhJU1tWvjrsd9lXHv3TTW3Z40OHwY2sNx
	 DanzeW45e/U+sk/Cdr79HNUWMXeRBpgPKSpbWrODjbeyI5W57BJprWhzlk1FDi/r0A
	 Nkiltb/qYP1NrnZTjRsx7V7G3rlxIJhIGv472K3QpxMwcaMjmECBfBscPthOfm3OPo
	 l7HPTNdT/Bv8g==
X-ME-Helo: mail-ed1-f46.google.com
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Thu, 29 May 2025 02:49:43 +0200
X-ME-IP: 209.85.208.46
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-604e2a2f200so772623a12.1
        for <linux-can@vger.kernel.org>; Wed, 28 May 2025 17:49:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXLL9byFOcMjZG4+coIFl+ULDGR0oIV8uTHWDHVvedxIIo+9DkdT3KbLeDdOzjiEmZBv6hG962+gSE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLmk7L/hiFShXE8UIIytiZ7Fhfu/GSCcGFkEYYsil6jnUwIWsD
	TiAe46MEf0mz5hkTBXi5KSaOfrcrN50H/6MlVElMk/G5hX1E11J2xzVT5dB2Rqiil9L8mZmF+5E
	6heBwGcZ7ipDeLySYVgcHa35R6p04KOw=
X-Google-Smtp-Source: AGHT+IFy9CgGzO9/Y/sFdVBWN/Ve79gRYEIyDwRtTDOYjRaL9PVeA0iLgpMLlQvSBSKiFQhTSSvTNP9Bbh7SPxh9K1M=
X-Received: by 2002:a17:907:7207:b0:ad8:9428:6a27 with SMTP id
 a640c23a62f3a-ad894286c2cmr710288566b.50.1748479783281; Wed, 28 May 2025
 17:49:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250528144814.17721a4e@hermes.local>
In-Reply-To: <20250528144814.17721a4e@hermes.local>
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Date: Thu, 29 May 2025 09:49:32 +0900
X-Gmail-Original-Message-ID: <CAMZ6RqJPRXEJFTM0wP6uo_enb-9ZcV5zxUoOdugi3rm9Z_X6XQ@mail.gmail.com>
X-Gm-Features: AX0GCFtFwLxV391uSUt83_ZmGe8IFEBHeSl7mtbC1sRb1Ab2l9iXrsuIL3kVkwU
Message-ID: <CAMZ6RqJPRXEJFTM0wP6uo_enb-9ZcV5zxUoOdugi3rm9Z_X6XQ@mail.gmail.com>
Subject: Re: Fw: [Bug 220168] New: flexcan-core.c
To: Stephen Hemminger <stephen@networkplumber.org>, robbinvandamme@gmail.com
Cc: Oliver@web.codeaurora.org, Marc Kleine-Budde <mkl@pengutronix.de>, 
	linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+To: Robbin

Hi Stephen and Robbin,

Thanks for forwarding us this bug report.

On Thu. 29 May 2025 =C3=A0 06:48, Stephen Hemminger
<stephen@networkplumber.org> wrote:
> Begin forwarded message:
>
> Date: Wed, 28 May 2025 15:19:21 +0000
> From: bugzilla-daemon@kernel.org
> To: stephen@networkplumber.org
> Subject: [Bug 220168] New: flexcan-core.c
>
>
> https://bugzilla.kernel.org/show_bug.cgi?id=3D220168
>
>             Bug ID: 220168
>            Summary: flexcan-core.c
>            Product: Networking
>            Version: 2.5
>           Hardware: All
>                 OS: Linux
>             Status: NEW
>           Severity: normal
>           Priority: P3
>          Component: Other
>           Assignee: stephen@networkplumber.org
>           Reporter: robbinvandamme@gmail.com
>         Regression: No
>
> Bit15 (TDCEN) should not be enabled according to the spec if dbrp > 2 and=
 in
> the driver it gets enabled when i set dbrp =3D 10. Resulting in RX Error =
Frames.
>
>
> spec:
> ISO11898-1:2015(E), section 11.3.3 (Transmtiter delay compensation) (page=
 52):
> It shall be programmable whether the mechanism is used at all. When this
> mechanism is used, the value of the prescaler for the data time quantum m=
(D)
> shall be one or two.
>
> The "prescaler for the data time quantim m(D)" is commonly referred to as
> "dbrp" by implementations.

The issue which you describe here as well as the issue in bug 220170
[1] share roughly the same root cause: the driver is setting the TDC
parameters manually without doing any proper checking. The reason is
that, at the time of writing, the CAN subsystem did not have a
framework to handle the TDC logic. This has changed since.

We had a very similar issue on the mcp251xfd driver recently which was
fixed in [2]. Other relevant background information can be found in
[3]. The flexcan needs to be modified in a similar fashion.

I do not have the hardware so it would be hard to fix on my side.

@Robbin: I assume you have access to the hardware. Would you like to
try to write the patch for this? I can provide guidance.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=3D220170

[2] commit 5e1663810e11 ("can: mcp251xfd: fix TDC setting for low data
bit rates")
Link: https://git.kernel.org/torvalds/c/5e1663810e11

[3] Re: mcp251xfd: forced TDC
Link: https://lore.kernel.org/all/CAMZ6RqKdyFPRwMbCZY5HwzLTeT9jcbxFiOfcuHbo=
+VgFF3ZViw@mail.gmail.com/

