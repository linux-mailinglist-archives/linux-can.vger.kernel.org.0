Return-Path: <linux-can+bounces-2025-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCB29C84E2
	for <lists+linux-can@lfdr.de>; Thu, 14 Nov 2024 09:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66B612849BC
	for <lists+linux-can@lfdr.de>; Thu, 14 Nov 2024 08:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C301F7551;
	Thu, 14 Nov 2024 08:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="rY67IInr"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-15.smtpout.orange.fr [80.12.242.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBCFE573;
	Thu, 14 Nov 2024 08:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731573461; cv=none; b=YaV8mprSACOAZenNPyBxpNHzHw7zjC0zXvrxMcwFrwT0LjwsZsBVQYHrWeDKcSpR8f0bX+XE3pB4UI/WtozN8PxkoPbyIEWSkz84LKCshV/LnAiGSYjQpUvKvau2hGodrqa1FD51sLbOyrnm9tk+Xqhomc8Edcu9Du5Da8z3bmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731573461; c=relaxed/simple;
	bh=U3qmdgcH6MMkMelPnEG3r8KizQ6+9vcmJmFZuVHxiJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=slMKIi2xm1zj/C7N5/fqW9IyGvdwnZ6gTc5CBA3VWj/kC+gKxVOebstbb5hRJ9LOag4fm4guE+d7tiQGZVLJrsdMfmQaEx30Y2q8etVe62Eg2uKRiiVrnjFzM7iimmZLVrMFTlzZ9xBV7nRwklqkVeLKTRCiNGK/m5+NCP5iFCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=rY67IInr; arc=none smtp.client-ip=80.12.242.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from mail-ed1-f45.google.com ([209.85.208.45])
	by smtp.orange.fr with ESMTPSA
	id BVL2tzHaL3yyBBVL2tOKmr; Thu, 14 Nov 2024 09:36:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1731573388;
	bh=gXAcLSWilqPFLEu11EWRGdVfTFC2/7ErD7HP3mFVwXQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=rY67IInr0mBBP0OiqVyUn9P7Gl/AYlY1bbEpKCHeQnel+U11jeglkrEZZAuPoNVoU
	 XJ4uQc9jL2+bZdloxiNy5FP53bHdu2HxpEy3UHs8/KVarB3hKANtnTQc96+Be063eD
	 VPPgmFn3YWWp/Qb+fgWjycXYzsqvOaRkcmNZnv6dsfIhCs9d6dq4PhPe2d/k2nNzbo
	 MwjiZ2in08qDqjqTbc2SpMPVgwVDq6I52ZNJGM4MwQOah8S6dTk+N2BasY9kKvJnfd
	 5Z7CaV/sfLQlSAIgvGLPM88nl6qY9Cw8BT3L0dxzI4CVbAzdumC4fbwldNciobj6Gt
	 XNM/XuMuBD2tQ==
X-ME-Helo: mail-ed1-f45.google.com
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Thu, 14 Nov 2024 09:36:28 +0100
X-ME-IP: 209.85.208.45
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5ceb75f9631so454413a12.0;
        Thu, 14 Nov 2024 00:36:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU5OphQJgA8iPNQxJznnwjcSimC3YKj2rarIdru/aFRFLiCrKtCHFkzsDIrPrxhjyX1Aq881LDremX+@vger.kernel.org, AJvYcCUNDVZ/VSDymco9pEQOl2IzwEnSoNnoXAZ4MLeMWxNwRUeUQPm+bmpBDOjA61cTr9gjjpL2DDxcdjUFz1uh@vger.kernel.org, AJvYcCWvkGWcdu2+f08+dWBu6dNTmQ+cI38s73w5H2M31HPM54epwNp2KhFc6lKoWZq+o9Qq4li4N+NbV/hC@vger.kernel.org, AJvYcCXr0DULzgS4NwJ4yk5bL7JvFFDuFfN5OdfJ7Hu9E+dAfzPp8L9FzGusaOGfM722mVBwaw7Me2ix@vger.kernel.org
X-Gm-Message-State: AOJu0Yyil8pNgd73j07v41vx9O8m0lrhm4bKk90wAhA4iUGiXlrgqe3F
	Urs3zUYifp4rfsI31TTxqeB5wgsfNbwL197Q2OGRFgHjVHY2FUUt4rWn32ys5/S2AWc5D+TB/Wz
	2r92AbQyz2S2F/HFYaFXjpQMeTic=
X-Google-Smtp-Source: AGHT+IEstSibTpytnkaLQd2f49BeKoBVqOwbRbmmb2UHX5x8V4EZg3n6d4T2cSfTwfjKsIE0fatwfTowT9iTIr1JnSQ=
X-Received: by 2002:a05:6402:2550:b0:5cf:466f:d474 with SMTP id
 4fb4d7f45d1cf-5cf4670c998mr11066042a12.16.1731573388036; Thu, 14 Nov 2024
 00:36:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111-tcan-wkrqv-v2-0-9763519b5252@geanix.com>
 <20241111-tcan-wkrqv-v2-1-9763519b5252@geanix.com> <CAMZ6Rq++_yecNY-nNL7NK48ZsNPqH0KDRuqvCCGhUur24+7KGA@mail.gmail.com>
 <zgyd3zghhwivsr3b4pcipt2wfc26ypavjygd6lu5tg3k6ztwbr@t52w4p5kyvaa>
In-Reply-To: <zgyd3zghhwivsr3b4pcipt2wfc26ypavjygd6lu5tg3k6ztwbr@t52w4p5kyvaa>
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Date: Thu, 14 Nov 2024 17:36:16 +0900
X-Gmail-Original-Message-ID: <CAMZ6RqJ0SMojXS5sbZBxeA9t6Q_=ns_dV5DCyyZJu2DjNzMsFg@mail.gmail.com>
Message-ID: <CAMZ6RqJ0SMojXS5sbZBxeA9t6Q_=ns_dV5DCyyZJu2DjNzMsFg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] can: tcan4x5x: add option for selecting nWKRQ voltage
To: Sean Nyekjaer <sean@geanix.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu. 14 Nov. 2024 at 16:33, Sean Nyekjaer <sean@geanix.com> wrote:
> Hi Vincent,
> On Thu, Nov 14, 2024 at 01:53:34PM +0100, Vincent Mailhol wrote:
> > On Mon. 11 Nov. 2024 at 17:55, Sean Nyekjaer <sean@geanix.com> wrote:
> > > nWKRQ supports an output voltage of either the internal reference voltage
> > > (3.6V) or the reference voltage of the digital interface 0 - 6V.
> > > Add the devicetree option ti,nwkrq-voltage-sel to be able to select
> > > between them.
> > > Default is kept as the internal reference voltage.
> > >
> > > Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> > > ---
> > >  drivers/net/can/m_can/tcan4x5x-core.c | 35 +++++++++++++++++++++++++++++++++++
> > >  drivers/net/can/m_can/tcan4x5x.h      |  2 ++
> > >  2 files changed, 37 insertions(+)
> > >
>
> [...]
>
> > >
> > > +static int tcan4x5x_get_dt_data(struct m_can_classdev *cdev)
> > > +{
> > > +       struct tcan4x5x_priv *tcan4x5x = cdev_to_priv(cdev);
> > > +       struct device_node *np = cdev->dev->of_node;
> > > +       u8 prop;
> > > +       int ret;
> > > +
> > > +       ret = of_property_read_u8(np, "ti,nwkrq-voltage-sel", &prop);
> > > +       if (!ret) {
> > > +               if (prop <= 1)
> > > +                       tcan4x5x->nwkrq_voltage = prop;
> > > +               else
> > > +                       dev_warn(cdev->dev,
> > > +                                "nwkrq-voltage-sel have invalid option: %u\n",
> > > +                                prop);
> > > +       } else {
> > > +               tcan4x5x->nwkrq_voltage = 0;
> > > +       }
> >
> > If the
> >
> >   if (prop <= 1)
> >
> > condition fails, you print a warning, but you are not assigning a
> > value to tcan4x5x->nwkrq_voltage. Is this intentional?
> >
> > What about:
> >
> >         tcan4x5x->nwkrq_voltage = 0;
> >         ret = of_property_read_u8(np, "ti,nwkrq-voltage-sel", &prop);
> >         if (!ret) {
> >                 if (prop <= 1)
> >                         tcan4x5x->nwkrq_voltage = prop;
> >                 else
> >                         dev_warn(cdev->dev,
> >                                  "nwkrq-voltage-sel have invalid option: %u\n",
> >                                  prop);
> >         }
> >
> > so that you make sure that tcan4x5x->nwkrq_voltage always gets a
> > default zero value? Else, if you can make sure that tcan4x5x is always
> > zero initialized, you can just drop the
> >
> >         tcan4x5x->nwkrq_voltage = 0;
> >
> > thing.
>
> Thanks for the review.
> You are right, so I reworked this for v3:
> https://lore.kernel.org/r/20241112-tcan-wkrqv-v3-0-c66423fba26d@geanix.com

I see. So this v2 was already outdated at the time of my review. Well,
glad to hear that this was proactively fixed in the v3 and sorry for
missing that.

Yours sincerely,
Vincent Mailhol

