Return-Path: <linux-can+bounces-2345-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B149E86CF
	for <lists+linux-can@lfdr.de>; Sun,  8 Dec 2024 17:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41EA71885584
	for <lists+linux-can@lfdr.de>; Sun,  8 Dec 2024 16:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD1F189B84;
	Sun,  8 Dec 2024 16:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="AOnJoTG9"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA4A17BEA2
	for <linux-can@vger.kernel.org>; Sun,  8 Dec 2024 16:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733677177; cv=none; b=nTG3JYOdXihc/tmkwp4qbaEmjzgbmpS84JdA80Lmx8PPMLa68DPRQ7H9scCBhBg6IhNDNwD0qy2u5g9qz/cBCBv88q9y0+uiRqwSq+OTbYr+CzGWDCYm9LcQTo6LQ6uBt7JlTeeJK/QeDbYteA8bNHEj4QSnvlklF8J9Nhn3RQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733677177; c=relaxed/simple;
	bh=azq1B8QuNnX4C8HwV3S96dnhxIhN0sy//FVR989QCMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LyFqj/4yGC9jT6QnwJ7Q+ECuHoK4hAxiIcMHgUxUw04fyMNAHtYkn1mzWYt9MRth8xPj1R9iXNnBWRN53MLGEO3S3CDUmV5DUhbrzNYb2Z6cEeQrqqu96mQtTIKu+GFR9uzf7CCQi8vCpkRJcpdrSXnf5RnjUNF3OI6MtYOruMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=AOnJoTG9; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e3a0d2d15adso2052643276.0
        for <linux-can@vger.kernel.org>; Sun, 08 Dec 2024 08:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1733677174; x=1734281974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AlFfwVqRXK/paRpbQAVFV3F3tMqaWvPJwZQA+19pyHg=;
        b=AOnJoTG9p2WTiuOX21wG2tfNrHtxElmyUm8i+ieHRJ877b+Fp4/uY74Jyli20N0Dv2
         KB2Abi53ZVGJznrbhvACI9+nc9YfnO5Mqwrktp6iQjwndUPBT4Tguv+SKN7/trb0QjPK
         s8TBQfnQqPn06STQn1EJY7t+QPan58cMwgv9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733677174; x=1734281974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AlFfwVqRXK/paRpbQAVFV3F3tMqaWvPJwZQA+19pyHg=;
        b=Q44cYIpHrLHLq+TA+hGOQKB7ZDxDVyv5S1BxbQWALlzzKGg8DHAvijY0glVLpEOlu9
         QMiBxoy0T+uIBN9bCn7a5ycIVji8IhERu0Zz80PeKfNlujKG0N1sDtL7hBO2YodzvNXG
         eSogzfNxRYbLKZrsYQatGFfy3xnOVz5EDlt3e+tF10eNnhO06V+VT5JN5M82HOB9DMUo
         heiHY3oagNz1homYwYg1ic0m39ZA2V+mtoVvLYH33rLf9suc/H5AvZyrVbrF8f1V8aBu
         /MAuPytebo/IFDzKY/+XSdjxIC6rQyPWnH3Ie4luFTQco/Unsg0LwxQ7XJvs6GyWlfzX
         kYoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVT/wzKeVSAcFe3JrPByP/dOjdqUG9WjCtob9opct8nn73N04KjwgECNC2nsgVclEc0B0v35iC7OWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqRnvzW/+0+V2VbVCzg06zHLmbwCw5ddx2fdYkprYmcOIvxabM
	M1JkCAUdjajRcLzrrtYxluQRvclRvNqw3/BIvZOTvOkerifpg6S1leWkKefsKPGLRex1D2IBU3V
	vBQHki3hIV4cJwNuNHbWjHnXEeJbmrXnGD3sELg==
X-Gm-Gg: ASbGnctDe0RhUIqsb6yhvaRGJQgbizYZgTf+EqTEPTcFhI14ex6YCmc37cC9aA9kSGR
	LRVFVXrwzMnsqgO1u9bDYLCny0HXf
X-Google-Smtp-Source: AGHT+IHc2fwFI+591nR9iKIG3YHjGTjB6Bxuk5sHYVwNbNdHEzV9blLi8vqQvdYTmxx4bc63U1c9ZKmKAJezuz8XeJ8=
X-Received: by 2002:a05:6902:268a:b0:e39:6c6a:f2da with SMTP id
 3f1490d57ef6-e3a0b0b6415mr8620220276.19.1733677173884; Sun, 08 Dec 2024
 08:59:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029114622.2989827-1-dario.binacchi@amarulasolutions.com>
In-Reply-To: <20241029114622.2989827-1-dario.binacchi@amarulasolutions.com>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Sun, 8 Dec 2024 17:59:23 +0100
Message-ID: <CABGWkvp=VdpOUGdHep8E6p8C+gFGsZyhMEtcjkx-zNaG-X_r3g@mail.gmail.com>
Subject: Re: [RFC PATCH v3 0/6] Add helpers for stats and error frames
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Frank Li <Frank.Li@nxp.com>, 
	Gal Pressman <gal@nvidia.com>, Haibo Chen <haibo.chen@nxp.com>, Han Xu <han.xu@nxp.com>, 
	Jakub Kicinski <kuba@kernel.org>, Kory Maincent <kory.maincent@bootlin.com>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, Paolo Abeni <pabeni@redhat.com>, 
	Rahul Rameshbabu <rrameshbabu@nvidia.com>, Rob Herring <robh@kernel.org>, 
	Sabrina Dubroca <sd@queasysnail.net>, Shannon Nelson <shannon.nelson@amd.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 12:46=E2=80=AFPM Dario Binacchi
<dario.binacchi@amarulasolutions.com> wrote:
>
> This series originates from some tests I ran on a CAN communication for
> one of my clients that reports sporadic errors. After enabling BERR
> reporting, I was surprised that the command:
>
> ip -details -statistics link show can0
>
> did not display the occurrence of different types of errors, but only the
> generic ones for reception and transmission. In trying to export this
> information, I felt that the code related to managing statistics and hand=
ling
> CAN errors (CRC, STUF, BIT, ACK, and FORM) was quite duplicated in the
> implementation of various drivers, and there wasn't a generic function li=
ke
> in the case of state changes (i. e. can_change_state). This led to the id=
ea
> of adding can_update_bus_error_stats() and the helpers for setting up the
> CAN error frame.
>
> Regarding patch 5/6 ("can: netlink: extend stats to the error types (ack,
> CRC, form, ..."), I ran
>
> ./scripts/check-uapi.sh
>
> which found
>
> "error - 1/934 UAPI headers compatible with x86 appear _not_ to be backwa=
rds
> compatible."
>
> I included it in the series because I am currently interested in understa=
nding
> whether the idea behind each of the submitted patches makes sense, and I =
can
> adjust them later if the response is positive, following your suggestions=
.
>
> Changes in v3:
> - Drop double assignement of "priv" variable.
> - Check "dev" parameter is not NULL.
> - Drop the check of "cf" parameter not NULL
>
> Changes in v2:
> - Replace macros with static inline functions
> - Update the commit message
> - Replace the macros with static inline funcions calls.
> - Update the commit message
>
> Dario Binacchi (6):
>   can: dev: add generic function can_update_bus_error_stats()
>   can: flexcan: use can_update_bus_error_stats()
>   can: dev: add helpers to setup an error frame
>   can: flexcan: use helpers to setup the error frame
>   can: netlink: extend stats to the error types (ack, CRC, form, ...)
>   can: dev: update the error types stats (ack, CRC, form, ...)
>
>  drivers/net/can/dev/dev.c              | 45 ++++++++++++++++++++++++++
>  drivers/net/can/flexcan/flexcan-core.c | 29 +++++------------
>  include/linux/can/dev.h                | 38 ++++++++++++++++++++++
>  include/uapi/linux/can/netlink.h       |  6 ++++
>  4 files changed, 97 insertions(+), 21 deletions(-)
>
> --
> 2.43.0
>

A gentle ping to remind you of this series.

Could this series or some of its patches make sense to consider?
IMHO, if all the controllers indicate the type of error, I would expect
the user space to be aware of it as well.
Or is there something I might be missing?

Thanks and regards,
Dario


--=20

Dario Binacchi

Senior Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com

