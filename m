Return-Path: <linux-can+bounces-1979-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E379C50BE
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2024 09:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE629B26CD4
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2024 08:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A3E20B7E5;
	Tue, 12 Nov 2024 08:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Wp1Nddj0"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-15.smtpout.orange.fr [80.12.242.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F49D20B21E
	for <linux-can@vger.kernel.org>; Tue, 12 Nov 2024 08:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731400319; cv=none; b=rNSyj/EPpk57mroTktr+scPKsB7ibV+C4lsDPrzMVOAybMzycO1WQP9OqYstekPaie922BHcO7/mlKMbD5FSrT81P9hYXY7mneW64AQTqc6WMJQoMCrEhTtgTMWD+NiBWd1qxSl2cyyVAJ7Ln81lNz39TYVBwhdQfZltUtqo/bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731400319; c=relaxed/simple;
	bh=gfbDswPzTGe0ZkNl3bI8ZPupYNGVQQkVQnWqg8B/t0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qpOvVbUhK+S26EplJ7zrEcPy7SjLU0ZHI7c0GgPbPyWihniV/nwCGRS2sjTr386lhxibd5PavY/e76BQqojCXN4Xhuhbv1MWVkWNCkNCZRhRJnMpCh18jH2idnXJlqzMhaRLx5wacjWd4MewzlA1UqKb2saY37bKUZyS0slmdYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Wp1Nddj0; arc=none smtp.client-ip=80.12.242.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from mail-ej1-f52.google.com ([209.85.218.52])
	by smtp.orange.fr with ESMTPSA
	id AmJRtdkMjPFIGAmJRth8Y1; Tue, 12 Nov 2024 09:31:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1731400309;
	bh=yGy/NagY9JML1yyH6/vlBti3JPThTR20Klpbk3peuE0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=Wp1Nddj07lIDJdFG7EHZk1DbZa+rA/MJ1VPjbHLJK0+XWrFMO4mnR9kv404dgk+rr
	 88F03G2UVE9UAQb6/3I1Xrl3zWGZ7ZKqbhQgGIUg3+5tkPwLrcsC7AOw5gCJdTK7CW
	 e2cyQ1ve9gKa6NVtSg4iZ0gQhc6p6o/hPt+NrtuImYJcczlKDcoW+CV0fYojgP6Bx+
	 Jh4+i1cH8Fxojhj/H5Tzmu5k8X56f4Ao2TEODldiGAsijvXQYbiPK6XBJle55FAqJw
	 76aKhmFf9mpzV4lLB6dWwLYnuh6DheJEkvqDY3wuqalIw7xKkaSjBCzpkGAjmlgaMq
	 obT8+oxiF62cw==
X-ME-Helo: mail-ej1-f52.google.com
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Tue, 12 Nov 2024 09:31:49 +0100
X-ME-IP: 209.85.218.52
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9e8522445dso947802366b.1
        for <linux-can@vger.kernel.org>; Tue, 12 Nov 2024 00:31:49 -0800 (PST)
X-Gm-Message-State: AOJu0Yx3zV7nNbX8wLHuVS0lp2BhPIVf2/+weFNYkn0BqBCz7E1iWX42
	OW7mrNXn4L19gtQAiYc9iy5fyfocd5w+YL3OB8ysCxYGY8UW38nP3VCJCK5yPnCe+W3tiKfrJpN
	hVKc9f9xvdM1ANYR2MmMA1L7z86s=
X-Google-Smtp-Source: AGHT+IHcM0BQlNJ7wj3HNx+rJNjiB++OMvdo58qnAisJ/wXasj24GPpSE6rz4YVyRgQ6cI5lsn9hf8OSd/8aSeQjBRQ=
X-Received: by 2002:a17:907:1c0e:b0:a80:f840:9004 with SMTP id
 a640c23a62f3a-a9eefeade00mr1532651966b.12.1731400309025; Tue, 12 Nov 2024
 00:31:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241110155902.72807-16-mailhol.vincent@wanadoo.fr>
 <20241110155902.72807-28-mailhol.vincent@wanadoo.fr> <20241112-flashy-straight-poodle-9a796d-mkl@pengutronix.de>
In-Reply-To: <20241112-flashy-straight-poodle-9a796d-mkl@pengutronix.de>
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Date: Tue, 12 Nov 2024 17:31:38 +0900
X-Gmail-Original-Message-ID: <CAMZ6RqKQLaEtgoLOAa3NHJotyHcAo=7ObXf=7tLh_DJ_QTCKOg@mail.gmail.com>
Message-ID: <CAMZ6RqKQLaEtgoLOAa3NHJotyHcAo=7ObXf=7tLh_DJ_QTCKOg@mail.gmail.com>
Subject: Re: [RFC PATCH 12/14] can: netlink: add CAN XL support
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>, 
	Robert Nawrath <mbro1689@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Tue. 12 Nov. 2024 at 17:09, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 11.11.2024 00:56:01, Vincent Mailhol wrote:
> > Add the netlink interface for CAN XL.
> >
> > Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> > ---
> >  drivers/net/can/dev/netlink.c    | 78 +++++++++++++++++++++++++++++---
> >  include/linux/can/bittiming.h    |  2 +
> >  include/linux/can/dev.h          | 13 ++++--
> >  include/uapi/linux/can/netlink.h |  7 +++
> >  4 files changed, 90 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
> > index 6c3fa5aa22cf..3c89b304c5b8 100644
> > --- a/drivers/net/can/dev/netlink.c
> > +++ b/drivers/net/can/dev/netlink.c
> > @@ -22,6 +22,9 @@ static const struct nla_policy can_policy[IFLA_CAN_MAX + 1] = {
> >       [IFLA_CAN_TERMINATION] = { .type = NLA_U16 },
> >       [IFLA_CAN_TDC] = { .type = NLA_NESTED },
> >       [IFLA_CAN_CTRLMODE_EXT] = { .type = NLA_NESTED },
> > +     [IFLA_CAN_XL_DATA_BITTIMING] = { .len = sizeof(struct can_bittiming) },
> > +     [IFLA_CAN_XL_DATA_BITTIMING_CONST] = { .len = sizeof(struct can_bittiming_const) },
> > +     [IFLA_CAN_XL_TDC] = { .type = NLA_NESTED },
>
> I haven't looked at the can_xl IP-core docs yet.
>
> I don't want to pass "struct can_bittiming_const" via netlink to user
> space. It's not sufficient to fully describe the CAN-FD controllers, as
> tseg1_min cannot equally divided into prop_seg and phase_seg1.
>
> Better make it a NLA_NESTED, as you did for the TDC.

I considered this point. The fact is that the code to handle the "struct
can_bittiming_const" already exists. And so here, I am left with two
choices:

  - small code refactor and reuse the existing

  - rewrite the full thing just for CAN XL and have two different ways
    to handle the constant bittiming: one for Classical CAN and CAN FD
    and the other for CAN XL.

For consistency, I chose the former approach which is the least
disruptive. If you want this nested, what about an in-between
solution:

  IFLA_CAN_XL /* NLA_NESTED */
    + IFLA_CAN_DATA_BITTIMING /* struct can_bittiming */
    + IFLA_CAN_DATA_BITTIMING_CONST /* struct can_bittiming */
    + IFLA_CAN_TDC /* NLA_NESTED */
        + IFLA_CAN_TDC_TDCV_MIN
        + IFLA_CAN_TDC_TDCV_MAX
        + (all other TDC nested values)...

This way, we can still keep most of the current CAN(-FD) logic, and if
we want to add one value, we can add it as a standalone within the
IFLA_CAN_XL nest.

Also, the main reason for not creating the nest was that I thought
that the current bittiming API was stable. I was not aware of the
current flaw on how to divide tseg1_min. Maybe we should first discuss
how to solve this issue for CAN FD?

Yours sincerely,
Vincent Mailhol

