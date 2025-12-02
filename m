Return-Path: <linux-can+bounces-5809-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CA4C9D3DD
	for <lists+linux-can@lfdr.de>; Tue, 02 Dec 2025 23:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5E9AB34A677
	for <lists+linux-can@lfdr.de>; Tue,  2 Dec 2025 22:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEAF21F16B;
	Tue,  2 Dec 2025 22:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQ/lJC8M"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95561427A
	for <linux-can@vger.kernel.org>; Tue,  2 Dec 2025 22:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764715868; cv=none; b=ZZYa4ItfvyOORIhyu0/2uMmF8AnrdAIjIiSw1RdZ+VBCMndgWxNCJ1KRfrQUqPP1CpZbOSqYnGy41zL+0zujyvU9T+0F7WJCfY/GETZaaj+9zZH2oz+bmsTw4RUMgyIdPgLu0MFPYVMyiANGySrvJFgAoESvMGQKCD4Lh+/MYA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764715868; c=relaxed/simple;
	bh=W/hv1yjPLk+GG9GRr0/LJvTCAmDd7eeaMcqbLJA3HbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A6UxChAnJrQXd2XjOGiXw9vnz+6WHVUqg1I+jXjseKdP1RcKkEpC1vGvZCYkmlhKFMmZZYB2PSYJmgqy1lXQS89KWBcVJFsZ9a8iMzHTVe51BUXxZwNDlpGUUS2qcoiWueSOPlHgHWcND0ZRI2mU4wqflNSpnz08MBCWKbm7FFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQ/lJC8M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1931EC19421
	for <linux-can@vger.kernel.org>; Tue,  2 Dec 2025 22:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764715867;
	bh=W/hv1yjPLk+GG9GRr0/LJvTCAmDd7eeaMcqbLJA3HbY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PQ/lJC8MEO9Jh85Xv492pMfb4QPmuZnLPhbsMVHTkt4qlUuEu7XepPBBwizEDjhdF
	 XN6UEfeIhhamtiLUYq04sxDUw1hYCdL/76D+PLnckU3Lc+/qvppP24zzhqz7z1Byl5
	 DNlxKfsCn5gwhxhICBdgCPyvMm215kvMtOHdL9GLsXYMc6RO/XOqhpJ3siw6EuUQb8
	 RDZO/buIG7angrgh7cpNG/0JLs3+EJQPZFn0XG5j0J7ksjFwQ3B21O99Qx5iohoBfl
	 /krAEzM9oKuxeXStS/J80UIMgaloHyhHZebHX2baPD4aXoC/fXKsoQSCDtZeCCRTBS
	 Yq/9qfx6i/8JA==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b79af62d36bso499008066b.3
        for <linux-can@vger.kernel.org>; Tue, 02 Dec 2025 14:51:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWkVZoICaZR/Z8Kau+zRIGsR1RdcsFAlW2WjYKSlEpqHdJCznp6Kuu9LM6AgbmKFMNHfnZoE+e+V4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOxlmNmaE9txoLraRr5pWhQzWgmnTKFF8ME/IItVoOv9ebxr/I
	KOe3ruxIYOPaNeUvwjSSAww/vReFDgm8CP6og6sjKxqfcQubwj3BqGxvPSOPVJpiqpHOPFuVj4V
	9JipzQULFIic5clMB/u33Bq7kLI/Npjo=
X-Google-Smtp-Source: AGHT+IEcPB3FtXbdMt7d0He6zBngQKLaR4NzWWnKdWS1MpPK046kjiw1rris+ATpx4IdYjZHINtfrFyJFZJ52dtIdP8=
X-Received: by 2002:a17:907:3daa:b0:b73:826a:9102 with SMTP id
 a640c23a62f3a-b79dc73863amr4728266b.49.1764715865944; Tue, 02 Dec 2025
 14:51:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251201-canxl-netlink-v2-0-dadfac811872@kernel.org> <e9f73ce3-254b-4145-8fb3-dda105182de1@hartkopp.net>
In-Reply-To: <e9f73ce3-254b-4145-8fb3-dda105182de1@hartkopp.net>
From: Vincent Mailhol <mailhol@kernel.org>
Date: Tue, 2 Dec 2025 23:50:54 +0100
X-Gmail-Original-Message-ID: <CAMZ6Rq+GCdf_+gxL1YSagCkP5nG03nzM4BQK+rbVFRM+gNhF0A@mail.gmail.com>
X-Gm-Features: AWmQ_bnz_b1UqjmqVPqZ9rdXs5D5wmMCyqsklsM1yVNwP4oyg7uvuXX99mTf0Fc
Message-ID: <CAMZ6Rq+GCdf_+gxL1YSagCkP5nG03nzM4BQK+rbVFRM+gNhF0A@mail.gmail.com>
Subject: Re: [PATCH iproute2-next v2 0/7] iplink_can: add CAN XL support
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Stephen Hemminger <stephen@networkplumber.org>, linux-can@vger.kernel.org, 
	Marc Kleine-Budde <mkl@pengutronix.de>, =?UTF-8?Q?St=C3=A9phane_Grosjean?= <stephane.grosjean@free.fr>
Content-Type: text/plain; charset="UTF-8"

On Tue. 2 Dec. 2025 at 10:33, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> Hi Vincent,
>
> as Stephen requested some changes anyway I would like to raise a remark
> about the patch naming.
>
> On 01.12.25 23:55, Vincent Mailhol wrote:
> > Support for CAN XL was added to the kernel in [1]. This series is the
> > iproute2 counterpart.
> >
> > Patches #1 to #3 are clean-ups. They refactor iplink_can's
> > print_usage()'s function.
> >
> > Patches #4 to #7 add the CAN XL interface to iplink_can.
> >
> > [1] commit 113aa9101a91 ("Merge patch series "can: netlink: add CAN XL support")
> > Link: https://git.kernel.org/netdev/net-next/c/113aa9101a91
> >
> > Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
> >
> > ---
> > Changes in v2:
> >
> >    - add the "iproute2-next" prefix to the patches
> >
> >    - s/matches/strcmp/g in can_parse_opt()
> >
> >    - Patch #3: "s/mili second/milisecond/g" and "s/nano second/nanosecond/g"
>
> "s/milisecond second/millisecond/g" ??

Yes, the change log had a typo: "mili" -> "milli". The code in
print_usage() itself is correct.

> >    - Patch #6: s/XL-TMS/TMS/g in print_ctrlmode()
> >
> >    - Patch #7: Remove a double space in patch description
> >
> > Link to v1: https://lore.kernel.org/r/20251129-canxl-netlink-v1-0-96f2c0c54011@kernel.org
> >
> > ---
> > Vincent Mailhol (7):
> >        iplink_can: print_usage: fix the text indentation
> >        iplink_can: print_usage: change unit for minimum time quanta to mtq
> >        iplink_can: print_usage: describe the CAN bittiming units
> >        iplink_can: add the "restricted" option
>
> iplink_can: add RESTRICTED operation mode support
>
> >        iplink_can: add initial CAN XL interface
>
> iplink_can: add initial CAN XL support

Ack.

> >        iplink_can: add CAN XL's "tms" option
>
> iplink_can: add CAN XL transceiver mode setting support

Ack.

> >        iplink_can: add CAN XL's PWM interface
>
> iplink_can: add CAN XL TMS PWM configuration support

Ack.


Yours sincerely,
Vincent Mailhol

