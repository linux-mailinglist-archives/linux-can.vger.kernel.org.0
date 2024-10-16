Return-Path: <linux-can+bounces-1708-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD0D9A0065
	for <lists+linux-can@lfdr.de>; Wed, 16 Oct 2024 07:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 251B628478D
	for <lists+linux-can@lfdr.de>; Wed, 16 Oct 2024 05:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225DD17B425;
	Wed, 16 Oct 2024 05:06:13 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0722E14EC47;
	Wed, 16 Oct 2024 05:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729055173; cv=none; b=kX7fzd4DHzxD8c57dPW1MTx3H1/ZYIYecLxDJfjwfzEjGE3QNOt9hUAdQ2e0M65MD0Zl+GuXqla0owafsMchIUCEvDUgk7MsNXq3ZZiYER0J00wbq2Iyf6Oh7JQToW5h3UfoQBmXX4zsCNwEmj6FdFfZCqpMGbH2AlIBigCgsI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729055173; c=relaxed/simple;
	bh=HKQvGwPYr1inwgwgCF3hWMFzy3rV5u7emolGbmj55I4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f4QbawLEtgsmFSl1xA7jmFZmV27nuH/Olkg1x8C2eHS62unGdFmu8SNpCnzOXg9efproxV4+fJjYFr5sHhcsO+YuNQHzgXR31QMczwerTK95k2hQlQPwV82i8fLzZuwbDHDxx45oRoj5+9ly3ZThmIh78vLlAx+iB66EkgRpMic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a99cc265e0aso654479866b.3;
        Tue, 15 Oct 2024 22:06:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729055169; x=1729659969;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aJpmoZDHNXOCQ0hPtAG85Btn1S/XrnkL2QxgMJLjgU0=;
        b=a/oMt7MoIsK8G3ahbTGmmbP+W15lj58WpYx63xhSFO6rVykKE5Ak0z7vRTAgQUi49/
         6evokxNjleyXKfB+qKpsa0wJKXDUdZApLpgfXHqO7ZOM8eIP/b2+BRDhdKdVHONW0Ayz
         k+hEirEqSZv7Tmaa78VyauZMhdgRKMqZI9ChB5NQlls2cJSMHc1Fc67Sz7gbSMAR6bll
         iglcA++MMO3kDXWB3totRt8uWRR1aNFGM46ui1M/UusITxdaaNltSAW/Ijk09Biwcie4
         uDw0dNIEAJDPDb+axoBQEtI3mIS1zLRbk5bspT8zCZAiCVxTQR0fzCjKRaOl/47MBi/F
         lXKA==
X-Forwarded-Encrypted: i=1; AJvYcCUYcVSDbtsTRM2i69ZCJCQbOp6xoBTuS6l5GhyICgEn5LQBa+tAbOeh4YBJXkYvkAAqCdspnXAx@vger.kernel.org, AJvYcCUy93uismFbHVCmOMjvcQ0vr14ysQYfYJV6G/ZWrzk2kiuzg5S5g0bqt53M8s6kZ6Q+P9q7FRFTCIEU@vger.kernel.org, AJvYcCVo+BcqV9fQKO99MYBd/2pQDw6vRFFxOsrmI1sFhd4jXT4ee2whkd0NuoRUx9S6xkY+MAkZ91rexZuQ@vger.kernel.org, AJvYcCX3te1Q2aIFoWCC0zUbysKa/drQRaFQarfvvriuaovIVjxgW+IJoZqbwivrQJfEY5MnGupYpGiRe5C+UDKn@vger.kernel.org
X-Gm-Message-State: AOJu0YzuG7sn1wE4eFY4TllGfc6EU8ohzBQq+twsjuojSM3YcCDVdDRs
	h17BQoJYp3w7xXfT/PtUYg56hLeJy8Vl6ybI0gTrhPNOmY8xkAZnB77Q/+0F2ufJSFZvJz7wjPi
	dzeTHNxMaUjUwUBxvum+RdZto7oU=
X-Google-Smtp-Source: AGHT+IH74YJJx49nsFhkFyT1RiTJLRloxAcb38iBw6/nz//HY/ZNyBiPGvMCwwwDAg2enWh0s8igaco8Z4E7VnmPpHo=
X-Received: by 2002:a17:907:e216:b0:a99:7c14:9197 with SMTP id
 a640c23a62f3a-a9a34e9b0a6mr190098066b.64.1729055169080; Tue, 15 Oct 2024
 22:06:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240922145151.130999-1-hal.feng@starfivetech.com>
 <20240922145151.130999-4-hal.feng@starfivetech.com> <CAMZ6Rq+EM37Gvx8bLEwvhn+kUC9yGDiapwD0KX31-x-e-Rm3yQ@mail.gmail.com>
 <EAC60558E0B6E4BB+e5384c3c-ba45-48f5-a86f-a74e84309a14@linux.starfivetech.com>
In-Reply-To: <EAC60558E0B6E4BB+e5384c3c-ba45-48f5-a86f-a74e84309a14@linux.starfivetech.com>
From: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date: Wed, 16 Oct 2024 14:05:57 +0900
Message-ID: <CAMZ6RqLvzvttbCMFbZiY9v=nGcH+O3EV91c+x7GxTbkKhdTcwg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] can: Add driver for CAST CAN Bus Controller
To: Hal Feng <hal.feng@linux.starfivetech.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
	William Qiu <william.qiu@starfivetech.com>, devicetree@vger.kernel.org, 
	linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Hal Feng <hal.feng@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"

On Tue. 15 Oct. 2024 at 18:33, Hal Feng <hal.feng@linux.starfivetech.com> wrote:
> On 9/23/2024 11:41 AM, Vincent MAILHOL wrote:
> > Hi Hal,
> >
> > A few more comments on top of what Andrew already wrote.
> >
> > On Mon. 23 Sep. 2024 at 00:09, Hal Feng <hal.feng@starfivetech.com> wrote:
> >> From: William Qiu <william.qiu@starfivetech.com>
> >>
> >> Add driver for CAST CAN Bus Controller used on
> >> StarFive JH7110 SoC.
> >>
> >> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> >> Co-developed-by: Hal Feng <hal.feng@starfivetech.com>
> >> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> >> ---

(...)

> >> +       stats->rx_packets++;
> >> +       netif_receive_skb(skb);
> >> +
> >> +       return 1;
> >
> > Why return 1 on success and 0 on failure? The convention in the kernel
> > is that 0 means success. If you really want to keep 0 for failure, at
> > least make this return boolean true or boolean false, but overall, try
> > to follow the return conventions.
>
> The return value here represents the number of successfully received packets.
> It is used in ccan_rx_poll() for counting the number of successfully
> received packets.

Ack. I guess this will become more clear after you implement the queue logic.

(...)

> >> +
> >> +       if (priv->cantype == CAST_CAN_TYPE_CANFD) {
> >> +               priv->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK | CAN_CTRLMODE_FD;
> >> +               priv->can.data_bittiming_const = &ccan_data_bittiming_const_canfd;
> >> +       } else {
> >> +               priv->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK;
> >> +       }
> >
> > Nitpick, consider doing this:
> >
> >   priv->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK;
> >   if (priv->cantype == CAST_CAN_TYPE_CANFD) {
> >           priv->can.ctrlmode_supported |= CAN_CTRLMODE_FD;
> >           priv->can.data_bittiming_const = &ccan_data_bittiming_const_canfd;
> >   }
>
> OK.
>
> >
> > Also, does you hardware support dlc greater than 8 (c.f.
> > CAN_CTRLMODE_CC_LEN8_DLC)?
>
> The class CAN (CC) mode does not support, but the CAN FD mode supports.

So, CAN_CTRLMODE_CC_LEN8_DLC is a Classical CAN feature. Strictly
speaking, this does not exist in CAN FD. Do you mean that only the
CAST_CAN_TYPE_CANFD supports sending Classical CAN frames with a DLC
greater than 8?

If none of the Classical CAN or CAN FD variants of your device is able
to send Classical CAN frames with a DLC greater than 8, then this is
just not supported by your device.

Could you share the datasheet so that I can double check this?

(...)

> Sorry for the late reply. Thank you for your detailed review.

No problem, take your time!


Yours sincerely,
Vincent Mailhol

