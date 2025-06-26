Return-Path: <linux-can+bounces-3900-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 520FBAE945F
	for <lists+linux-can@lfdr.de>; Thu, 26 Jun 2025 04:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F7A95A1217
	for <lists+linux-can@lfdr.de>; Thu, 26 Jun 2025 02:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4007812C544;
	Thu, 26 Jun 2025 02:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="AXKcreC2"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-68.smtpout.orange.fr [193.252.22.68])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738F12F1FC6;
	Thu, 26 Jun 2025 02:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750906061; cv=none; b=UZK7SegTyyZ5vuDRox/XwV8z1ojLPELUiAi5aNuv8+lOKNtMv0j58FpLOkvTR2YYQrusrDW3CF4DclztM342wqWquGa0RHpuWVQxpbsdLiJ71T1ChBQ7K3hbGIKPjcNzsG6KgR4nPbXaxtjOmFocc3op8ZRceBLb8+srkYHICi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750906061; c=relaxed/simple;
	bh=ScQib/iIummUOWXbX8F7fB94LmFMCLeWS/9/eLvbi8I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=is9/3FCVugXEYj859d26AAqZybbtpxaJMdaLJhCczQRF0+4SmQOMA2813QMpMV5ET396mDO+BpM8K+6GTXBrgkNiK5Jg/zA3ImRfnX0Ux1mnm6qBoS1olLdEog1fylhLDvGN4BCycouXYFNmJ32/O5F/xKqu9irserB5Kyxgjoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=AXKcreC2; arc=none smtp.client-ip=193.252.22.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from mail-ed1-f48.google.com ([209.85.208.48])
	by smtp.orange.fr with ESMTPA
	id Uce6uBOZ4XsbBUce6uYh0i; Thu, 26 Jun 2025 04:47:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1750906047;
	bh=V/WDGm52hjpGx8ncCcYjJQ6PVfKZmpK1IbtetFcAPZo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=AXKcreC2hdhLd56+Cey94Qh+dtSb4I1iZ4F7tzKufV3IjHBmxIB/b2JAISrtiqr8h
	 AkiniknS7H5b/fs1p98bDforeC1c9oO+ZA2F2IFe66qb1pwyNFqER3fkfKfGNXdy/n
	 9UPrhZyyOmVjK7Zt5jJeVgF1QKTMUu8usI0uZaJVMl1svvvC3bgcLtDKifZOM1MxaG
	 sIguHRExXuyLw4yoJst0bcEuBBVF2RvoQL5tTjc6OLhnF5DTFJI+LOpMRJtvj8mz/E
	 SQBIbsgbTtLqt142XCkiLZC9KBF3rCNTlms3VDvi40tOX5q/VKMLSSGdIzuXcEVVdA
	 vWawg+qiYa/PQ==
X-ME-Helo: mail-ed1-f48.google.com
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Thu, 26 Jun 2025 04:47:27 +0200
X-ME-IP: 209.85.208.48
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-60768f080d8so866660a12.1;
        Wed, 25 Jun 2025 19:47:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV+ohoYjU5M+e3OTzaId6wGj22wLl9pV4L2K8uT64VQ0VsSmswsh8b/oLKYhpfnclT15bt7C5SiqFg1yDOABO4=@vger.kernel.org, AJvYcCVs0mHN/eG6dylXrVECvQOp35vWuzuP0/7tP3SkwivbFNNYre+Ma6g9k7sCerFql0JCyVQ+dzYRLocpsoet@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6bwiaPtO/PbnP80vxpXo1d/B3I0soAoJrm8Vw8dF3dTBV5wac
	FGmD38YgRpp74LoUb8hWRO8cGN0CjVa9ejxQL3pBmE05vHkoSxqWsH0cCYoyqDVgcErclhJHlos
	8Fj6rSXHEhvoLluUDi15IQXM5gpVSzyM=
X-Google-Smtp-Source: AGHT+IGrHj2tMbiZ2QeqZjQlXbTaO+MvqmYe6H6UjmXckgl2wWAV/SH/jd2Fj2A10MlMl3Fc5SZuuFIsEb6X+IB+Lpo=
X-Received: by 2002:a17:907:7b85:b0:ae0:d54d:2d0e with SMTP id
 a640c23a62f3a-ae0d54d3185mr115037266b.38.1750906046477; Wed, 25 Jun 2025
 19:47:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <48e217a7-b90e-4af3-b535-812c449dd3ba@web.de> <bf5442d1-34e0-495f-8a56-4e47f53ca4ad@wanadoo.fr>
 <a7a00125-b393-4283-a7dc-6c80ced8e7e6@web.de> <c96a5d2c-0ee1-4e3e-a95d-d38a8f668feb@wanadoo.fr>
 <0768a008-d4a9-41ec-bc47-1e7c63362296@web.de> <c04376f2-6ab7-4256-8bdc-aa6ff3ea88b4@wanadoo.fr>
 <7e6f8929-6665-45af-b01b-167a1aa80305@web.de>
In-Reply-To: <7e6f8929-6665-45af-b01b-167a1aa80305@web.de>
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Date: Thu, 26 Jun 2025 11:47:15 +0900
X-Gmail-Original-Message-ID: <CAMZ6Rq+PEZWzxNYDODq-Rz_Y8T_XEihyZKoY-MYo6bn5ATaGLQ@mail.gmail.com>
X-Gm-Features: Ac12FXxlciyP7y1Op9Ovh1hpCQMsTtZ2R8U4meStboJJffsNcUC2zhdd5dGfQGY
Message-ID: <CAMZ6Rq+PEZWzxNYDODq-Rz_Y8T_XEihyZKoY-MYo6bn5ATaGLQ@mail.gmail.com>
Subject: Re: can: ucan: Use usb_endpoint_type() rather than duplicating its implementation
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-can@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	kernel-janitors@vger.kernel.org, Chen Ni <nichen@iscas.ac.cn>, 
	Marc Kleine-Budde <mkl@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu. 26 Jun. 2025 at 01:47, Markus Elfring <Markus.Elfring@web.de> wrote=
:
> > A real quick search shows me that this ucan driver is not an isolated c=
ase.
> > Here is an example:
> >
> > https://elixir.bootlin.com/linux/v6.16-rc3/source/drivers/media/rc/imon=
.c#L2137-L2148
>
> Thanks that you pointed another implementation detail out from
> the function =E2=80=9Cimon_find_endpoints=E2=80=9D.

What I did here was simply to look at all the users of the
USB_ENDPOINT_DIR_MASK macro:

https://elixir.bootlin.com/linux/v6.16-rc3/C/ident/USB_ENDPOINT_DIR_MASK

and bingo, the very first user of that macro is the imon driver with a
true positive. I did not check the other drivers from the list, but
that is what I meant by the manual hunt: I believe that 15 minutes
would be enough to quickly check all those drivers. Of course, doing
it manually is a one time solution whereas adding the coccinelle
script is a long term solution. Also, I am just sharing my thoughts. I
am not trying to discourage you in any way, it is even the opposite:
such initiatives are really nice! Even if I do not participate in
these myself, I want to tell you my gratitude for your efforts!

> > But it does not seem to occur so often either. So not sure what is the =
best:
> > do a manual hunt
>
> Unlikely.
>
> I am unsure if such an aspect would become relevant for a code review
> by other contributors.
>
>
> >                  or write a coccinelle checker.
>
> I would find it more convenient to achieve corresponding adjustments
> to some degree with the help of such a development tool.
> I constructed scripts for the semantic patch language accordingly.
>
>
> >> Can the functions =E2=80=9Cusb_endpoint_is_bulk_in=E2=80=9D and =E2=80=
=9Cusb_endpoint_is_bulk_out=E2=80=9D
> >> be applied here?
> >> https://elixir.bootlin.com/linux/v6.16-rc3/source/include/uapi/linux/u=
sb/ch9.h#L572-L595
> >
> > Further simplification, nice :)
> >
> > I didn't see that last one, so glad you found what seems to be the opti=
mal solution!
> I am unsure if the check reordering would be desirable for this function =
implementation.

Ah, you want to confirm whether

  usb_endpoint_dir_in(ep) && usb_endpoint_xfer_bulk(ep)

is the same as

  usb_endpoint_xfer_bulk(ep) && usb_endpoint_dir_in(ep)

?

In this case, that is OK. *Mathematically speaking* we have this equivalenc=
e:

  a & b <=3D> b & a

In C it is roughly the same except if the expression has some
undefined behaviour. The typical example is:

  foo && foo->bar

Here, the short cut evaluation of the && operator will prevent the
undefined behaviour to occur if foo is NULL. And so, obviously,
refactoring as:

  foo->bar && foo

would be a bug. In our case, there is no undefined behaviour on the
right hand operand (I mean, if ep is NULL, the undefined behaviour
will already occur on the left hand operand). So we are totally safe
to reorder the operand here.


Yours sincerely,
Vincent Mailhol

