Return-Path: <linux-can+bounces-4097-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E522B10277
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 09:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29B741CE187E
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 07:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BE026FA5A;
	Thu, 24 Jul 2025 07:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="EG1CoS/4"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-18.smtpout.orange.fr [193.252.22.18])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75BA2459D7;
	Thu, 24 Jul 2025 07:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753343734; cv=none; b=ZyP6+V2rbxCt/3yjcA26/fk1rAOUcdwN1CCR7a7NO3rI+cbv+ueVdpUlmGy0A1Pz29p0UO36fVBoSmeKSaV9urs1niBCSbjzhFDg/GDuM3TEkTFSj12fmREaZFREbNUJL327YL0gEEgKpBdP8JPc2lflOZQ2VrYUOJ994GGGS90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753343734; c=relaxed/simple;
	bh=cDTS6SYvBpPoIL6qy2wUnozxKfGX2b9UFGGUmOYX9E8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JuV0mvsiDTILBm2A/uUse66llnF2qMPou8impfwvnzsfaCbRY7kQJhSwGOYPtYLyMYJZa/+dOJSBtkOQGe4jZ1nahpeNESwGEJ1eSm3yHW2KNKeGiN4ulnRNaY/wY0EptaEgRqcSKalVpbPYKR2bBhzEGugyOhDjGnIsNWHoBFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=EG1CoS/4; arc=none smtp.client-ip=193.252.22.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from mail-ed1-f49.google.com ([209.85.208.49])
	by smtp.orange.fr with ESMTPA
	id eqmPuEdCwpTm4eqmPudItl; Thu, 24 Jul 2025 09:54:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1753343657;
	bh=14MnTsuJbjYYjuvpSxaOGuOPMJUCYT5/HxNBySMFn6s=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=EG1CoS/4cW00UU2VHatFDn+scY1jNyJIfImzfiybNl0SOdfiWPJNp8uBsmJhT+xWA
	 HMkSOw4FfKc3+HgqVfwB2vX+CPRarbdXwd4SgdROoE2gp9KFDizXNHTaUO1kVt6Cvz
	 c91boGFK1TT6FRMxgxGRyRKCY/f11yck1+MOt+cGzGtkmgYVsN9voey2lV8g6HGH4p
	 Q4PiJxaifsL/saOfStBI0PkErUtdPx27+sbGKHbF8b+hdFXWxuMoqm5UBpFt9Esfi7
	 D7R6R5/9QAw/NRLJL1L0JL+hNgEVc+GgnZ9j28cBoEnkxR/rJBm50F9oopPNOj1NGc
	 vwwVtDKf+Nu0w==
X-ME-Helo: mail-ed1-f49.google.com
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Thu, 24 Jul 2025 09:54:17 +0200
X-ME-IP: 209.85.208.49
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-60c9d8a169bso1249524a12.1;
        Thu, 24 Jul 2025 00:54:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUK9EvTKcyM+i6s8YfbHe6+6fOp4vr26PmkTKEwym3J7tSlv4nBtsH5oLJxUo7cDdfutwBPn6pn@vger.kernel.org, AJvYcCXK65NsBuAaSm9XHZmjn+2A0Kf4LEA6Wykw2namWRKCHS4EA2UNcMnjHipYEf3WNDwaFAyrVlH6XrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpqhXqrF+4BW4nA33VygUYwfpNILAawrv9xksMd7Y9gJPzqMaj
	L8Q5cSlkXLfECJeChrmSXvSZyLD4p9EZZft+pZyhgGLEQOkwXF7PQZceeGjMlwb1nJpoTu8PlJn
	c8bMLPJngWzrJsMJoE7/y0UmLQfl+pqU=
X-Google-Smtp-Source: AGHT+IEnYtNYk9rHB5umYhZiK5re5ZuGyEu0gh8JHlA3YimeF4fDr+Y1nEvKG5Kr5gjN4v2Px9e8kskJSrWe4wO7Pvw=
X-Received: by 2002:a17:907:2d0e:b0:af2:aa60:90c with SMTP id
 a640c23a62f3a-af2f917a878mr594584066b.53.1753343656906; Thu, 24 Jul 2025
 00:54:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724063651.8-1-extja@kvaser.com> <20250724063651.8-6-extja@kvaser.com>
 <a88f2cfa-69e1-400e-ad67-01ae83f3f9f6@gmail.com>
In-Reply-To: <a88f2cfa-69e1-400e-ad67-01ae83f3f9f6@gmail.com>
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Date: Thu, 24 Jul 2025 16:54:04 +0900
X-Gmail-Original-Message-ID: <CAMZ6RqKdTX0++J_TKGkK8=1mLwC3xE3ZZws85tvzv9bmvZRM0w@mail.gmail.com>
X-Gm-Features: Ac12FXyesHczDBDxjhk8yCZQ22LKEQJyryYbN5LEtfcIsyXouvLlVlz3AX4v46o
Message-ID: <CAMZ6RqKdTX0++J_TKGkK8=1mLwC3xE3ZZws85tvzv9bmvZRM0w@mail.gmail.com>
Subject: Re: [PATCH v2 05/10] can: kvaser_pciefd: Store device channel index
To: Jimmy Assarsson <jimmyassarsson@gmail.com>
Cc: Jimmy Assarsson <extja@kvaser.com>, linux-can@vger.kernel.org, 
	Marc Kleine-Budde <mkl@pengutronix.de>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu. 24 Jul. 2025 at 16:09, Jimmy Assarsson <jimmyassarsson@gmail.com> wrote:
> On 7/24/25 8:36 AM, Jimmy Assarsson wrote:
> > Store device channel index in netdev.dev_port.
> >
> > Fixes: 26ad340e582d ("can: kvaser_pciefd: Add driver for Kvaser PCIEcan devices")
> > Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
> > ---
> > Changes in v2:
> >    - Add Fixes tag.
> >
> >   drivers/net/can/kvaser_pciefd.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
> > index 7153b9ea0d3d..8dcb1d1c67e4 100644
> > --- a/drivers/net/can/kvaser_pciefd.c
> > +++ b/drivers/net/can/kvaser_pciefd.c
> > @@ -1028,6 +1028,7 @@ static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
> >               can->completed_tx_bytes = 0;
> >               can->bec.txerr = 0;
> >               can->bec.rxerr = 0;
> > +             can->can.dev->dev_port = i;
> >
> >               init_completion(&can->start_comp);
> >               init_completion(&can->flush_comp);
>
> Would it be better to submit this as a separate patch, or keep it within
> this patch series?

Even if this is a bug, I see no urgency to it, so I am happy to have
this goes first to netdev-next and is picked-up by stable later on.
Doing the opposite would require you to split and seems more
troublesome.

