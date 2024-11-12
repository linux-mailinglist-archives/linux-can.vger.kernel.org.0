Return-Path: <linux-can+bounces-1982-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1D89C51E8
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2024 10:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D39BC1F24686
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2024 09:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E11C20B814;
	Tue, 12 Nov 2024 09:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="I7kIkpg2"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-25.smtpout.orange.fr [80.12.242.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC4720B204
	for <linux-can@vger.kernel.org>; Tue, 12 Nov 2024 09:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731403511; cv=none; b=d5a1ndLi/i3kCK011wXoYmsHWcb2XVtmSoc/zVyngnijLog9xKzQaOOMblUuJWlm4OUGxvs2lU9b3eyk0rEtaujBTukpAYn4h9rEjfAU6pK3+O+teocg5UC+us6cc0lS/nFfFmT+bvdhpcfKT72qQVu1qmkSytClF/4P4aGIsLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731403511; c=relaxed/simple;
	bh=BU7m7rZZq1HHHq0QxbCE+wOFiXNa8llmnVI+sDE5zqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WzcgfVDjP1p4/HqlBRFEvkBvQnToIt8CQE40sWPaLllV7+RSkiVYjOaPyGLmoMAx4NfIlzD9H/KqWeBv7kcAPVtKy+stXJZxCChWBwGMnf7ih376GZoH//aswGkAluQtkFOKJNTP5KTeQxeMsAPg/ZK4Rba3rN2atwgfKRTRHI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=I7kIkpg2; arc=none smtp.client-ip=80.12.242.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from mail-ed1-f49.google.com ([209.85.208.49])
	by smtp.orange.fr with ESMTPSA
	id An90tcNYfYmvZAn90tdgz6; Tue, 12 Nov 2024 10:25:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1731403507;
	bh=QzbTwWjIUdl6B6k9AcznxwNMY56K1qPblxZ32msVFjo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=I7kIkpg2tGBNAS8PlaRNTbKQMHT2cVLEWrxsJpYeP8/VaRzrUV5joJVzkOfObWmWK
	 8Am4Td2ZSQTXi9ryRiWYyUQwzXRm3Gl20ceYoGVJSy+EHtIjsDzDC/fRb1UcqieFBF
	 Ts7hXitjxjM0F/Kti+hfqbCifabpVt946JB08mQzWYlCzkwXtxhTZDLRdPp36Ngphc
	 YM4Qsu+OmFyGidiRivr0Xurc60sjCUmLpJPnOIgzBj2hF8V1piM4XDde7yPpl2SSEl
	 qUY/5OLkrOd+Z2btw+Xbl19kEwe3xE1UzSTk1CmksrhTu/FmE2OuYDGgtPOaCJYcM0
	 47CRSx73eGCqw==
X-ME-Helo: mail-ed1-f49.google.com
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Tue, 12 Nov 2024 10:25:07 +0100
X-ME-IP: 209.85.208.49
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c948c41edeso7425443a12.1
        for <linux-can@vger.kernel.org>; Tue, 12 Nov 2024 01:25:06 -0800 (PST)
X-Gm-Message-State: AOJu0YwNTpZba5+PHGTB4Lax3zDTiBe+1kc6hUHTaOPTWkDIpgDRjDnm
	kgwVbIMl8ulo+pCNRK9lP/x7xwXKhAHY6T7Dgv36yJUpGJTxf/88ZrVky0OlSMKF5ShhTXspvc4
	lymvLAcPmGGNgR3ohuIiH08gWqKQ=
X-Google-Smtp-Source: AGHT+IH9M2SSXOI2K0DhJh6gDtnIh39VWEuqA6+PTHeh52X2h/nsfUwLWuj6FsVRvGuFm1sqjhC5m2cxqohEqPxm2YQ=
X-Received: by 2002:a17:907:3d9f:b0:a9a:6633:3a90 with SMTP id
 a640c23a62f3a-a9eefeb157bmr1510217466b.8.1731403506606; Tue, 12 Nov 2024
 01:25:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241110155902.72807-16-mailhol.vincent@wanadoo.fr> <20241112-glittering-khaki-uakari-8e15cb-mkl@pengutronix.de>
In-Reply-To: <20241112-glittering-khaki-uakari-8e15cb-mkl@pengutronix.de>
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Date: Tue, 12 Nov 2024 18:24:55 +0900
X-Gmail-Original-Message-ID: <CAMZ6RqJVgsJ0EpXs-seO4MNMVADM17Pf0KNdZ7QYGgJK_oa1aw@mail.gmail.com>
Message-ID: <CAMZ6RqJVgsJ0EpXs-seO4MNMVADM17Pf0KNdZ7QYGgJK_oa1aw@mail.gmail.com>
Subject: Re: [RFC PATCH 00/14] can: netlink: add CAN XL
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>, 
	Robert Nawrath <mbro1689@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On  12 nov. 2024 =C3=A0 17:53, Marc Kleine-Budde <mkl@pengutronix.de> a =C3=
=A9crit :
> On 11.11.2024 00:55:49, Vincent Mailhol wrote:
> > Because of popular request [1] and to celebrate the fact that I joined
> > the kernel web of trust this week [2], here is an RFC to introduce the
> > CAN XL netlink support.
>
> yeay \o/
>
> > The logic is simple. The CAN XL basically just reuse the same kind of
> > parameters as CAN FD: the databittiming and the TDC. So the series is
> > just a bunch of refactor to either:
> >
> >   - factorize code.
> >   - rename some variable to differentiate between CAN FD and XL.
> >   - make some function more generic to accept both CAN FD and XL.
> >
> > The feature is working=E2=84=A2: there is a dummy driver at the end of =
the
> > series to show the traffic from the userland to a driver. This said, I
> > did close to zero testing. Once I had one CAN XL frame reaching the
> > driver, I call it a day, and decided to send the work. Regardless, it
> > is Sunday night. If I do not send it now, that would be next week-end.
> > Probably some mistakes are hidden here and there, but this should be
> > enough for an RFC level.
> >
> > Also, I am not fully happy that can_dbt_changelink() requires 8
> > parameters. I will probably revisit this later on. But for the moment,
> > I think this is acceptable for an RFC.
> >
> > Overall, I do not want to rush this series. Linus should send the rc7
> > anytime soon, and the merge window will probably start in eight days.
> > I do not think this series will be finalized by then. I still need to
> > give a deeper look at ISO 11898-1:2024 [3] to check that everything is
> > good. However, if I receive positive feedback on this RFC, I would
> > probably like to have the first patch merged so that I do not have to
> > rebase that tree wide patch each time someone makes a change.
> >
> > I will send a second RFC series for iplink2 just after this one. Stay
> > tuned!
>
> What's the base commit of this series? It doesn't apply to
> net-next/main. For a series this big, try using 'b4', it also
> automatically sends the base commit.

It is linux-can-next/main.

I will rebase at least the first patch and maybe some of the trivial
renaming onto net-next/main before the merge window opens. This way,
we will not have to worry about these anymore. After this, the other
patches should apply smoothly.

Yours sincerely,
Vincent Mailhol

