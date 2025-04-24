Return-Path: <linux-can+bounces-3462-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FFEA99ED6
	for <lists+linux-can@lfdr.de>; Thu, 24 Apr 2025 04:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3006819468B1
	for <lists+linux-can@lfdr.de>; Thu, 24 Apr 2025 02:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E5D4C62;
	Thu, 24 Apr 2025 02:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="qlLyndTY"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (outm-52.smtpout.orange.fr [193.252.22.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E739460
	for <linux-can@vger.kernel.org>; Thu, 24 Apr 2025 02:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745462022; cv=none; b=Yv3lniEP1NbeZDNDSsans5AOol5ycUk9u/5FoNXYMZRNzGWqD3AiK+CPFejhDu0CPpvakjKQKSOWvyrq0zz1oeJh4RBCg8nLCw8T/HcrnAR0YVCIX982NQElnhb5lOU6ikEOlyUGQXHIl+frfVBr9PFihqrBO2fJzEZW/c4K+G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745462022; c=relaxed/simple;
	bh=PRc1EaKS815eLh27ig8AVUM8mHELpux39tDDYa1qaMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lN6mandcaxMiHyN0mDqaO3QMagyfvvmxzGUD6sn1HNeVa5Ak244A6aatdGV/j+4Q7PcSGoudUH4GcRfKtrul96odVU7rNDOA12xGOpbvg/pl/k1mVz+HpuyA1H0uH15wuDGf00hQrKkmpJf3sS8L96jDAegJVNC/7DXEAWI0EcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=qlLyndTY; arc=none smtp.client-ip=193.252.22.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from mail-ed1-f54.google.com ([209.85.208.54])
	by smtp.orange.fr with ESMTPSA
	id 7mG2uqJ4s1J2g7mG6u0R6n; Thu, 24 Apr 2025 04:24:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1745461454;
	bh=GcELfArsFFvPxDLCWXA4HVw7uvUWj8oWP17A4OFJBvw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=qlLyndTY0d2pUMbs4o8MjPo2AiKQl0IL9+MOFc169lzdXOACxtYfzFFYch8R4SMi8
	 jzKXozeQmPav4xvqMLwzdeyae2bmEOWDnm6CYzSelrQjsYplZJ3nlPy1xc6D+WeuLp
	 aUuzQpwM/r4JBQXhXATIWVmc2NtIxR7Ik2mVVIJJLYFu0tU+npBDJKLauAdEiPp2bx
	 F4abtveq3jJ0K7cBb2Y4KFg2ahlWJjGzhMnDsqtyKHjmU+wNPloXILJ/Vu31VtuNjU
	 ubeURF+wT06icsmLDPte0tXCYBk12+Fmh2L7uPc7ujEajxyFP0RlEA+6fe54X4tWJp
	 5LZurSV6OJWqw==
X-ME-Helo: mail-ed1-f54.google.com
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Thu, 24 Apr 2025 04:24:14 +0200
X-ME-IP: 209.85.208.54
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5f4ca707e31so734218a12.2
        for <linux-can@vger.kernel.org>; Wed, 23 Apr 2025 19:24:14 -0700 (PDT)
X-Gm-Message-State: AOJu0YzmK8Lk6m3xAragxc5Y1vDKwYrjO+qjZXxyI4gZtY2xHCxzSZrZ
	wA5564HTRp94JVYfkuD8Q4/h0rHjJF2Zgk2Ua6oFQvmx7sZvvNwZl3kbE4p2JafMuWjlStTfTPv
	LhdRpjzdQssnZZkPS0tSg7YIzKLA=
X-Google-Smtp-Source: AGHT+IHCDWxAXwChsHUZfytHJcS36xfsPOVEDSf+UlwlTskUgRgqTRnLDTM1bealZLCBjpqALuvcgG8Cw8ZuGasZqyo=
X-Received: by 2002:a17:907:6d1e:b0:acb:8492:fe with SMTP id
 a640c23a62f3a-ace5748b945mr87496566b.52.1745461450652; Wed, 23 Apr 2025
 19:24:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <C2121586-C87F-4B23-A933-845362C29CA1@vpprocess.com>
In-Reply-To: <C2121586-C87F-4B23-A933-845362C29CA1@vpprocess.com>
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Date: Thu, 24 Apr 2025 11:23:59 +0900
X-Gmail-Original-Message-ID: <CAMZ6RqKdyFPRwMbCZY5HwzLTeT9jcbxFiOfcuHbo+VgFF3ZViw@mail.gmail.com>
X-Gm-Features: ATxdqUEkNBEyxmIVyrj5ICpxiKEoK0HTOvb4pKgiswuvYgYAjF_nAjGr8VUPl0Y
Message-ID: <CAMZ6RqKdyFPRwMbCZY5HwzLTeT9jcbxFiOfcuHbo+VgFF3ZViw@mail.gmail.com>
Subject: Re: mcp251xfd: forced TDC
To: Kelsey Maes <kelsey@vpprocess.com>
Cc: linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kelsey,

On Thu. 24 Apr. 2025 at 08:48, Kelsey Maes <kelsey@vpprocess.com> wrote:
> Hello,
>
> I have a custom board attached to a Raspberry Pi using a MCP2518FD and a =
40MHz clock. I have a problem where I get a bus-off condition when using bi=
t rates that use a DBRP > 1.
>
> Here is a reproduction method:
>
> 1. In config.txt:
> [all]
> dtoverlay=3Dmcp251xfd,spi0-0,interrupt=3D25,rx_interrupt=3D24
>
> 2. Run the following commands:
> sudo ip link set can0 type can sample-point 0.875 bitrate 125000 dsample-=
point 0.875 dbitrate 500000 fd on berr-reporting on restart-ms 100

dbitrate 500000?

Do you really mean 500 kbps? TDC is only relevant for higher bitrates,
typically above 2Mbps.

> sudo ethtool -C can0 rx-usecs-irq 10000 rx-frames-irq 8 tx-usecs-irq 1000=
0 tx-frames-irq 2
> sudo ip link set can0 up
> cansend can0 00000000##1.00.00
>
> 3. Observe the bus-off condition in dmesg.
>
> This also happens for 250 / 1000 but works for 500 / 2000 and 1000 / 4000=
.

So what you mean is that it works for higher bitrates but fails on slower o=
nes?

> I have tested a hack where TDC is disabled if DBRP > 1 in mcp251xfd_set_b=
ittiming() and this fixes the issue, though I=E2=80=99m not sure it=E2=80=
=99s the right fix in the long run.

I see, so the TDC is always on, even when it shouldn't.

> TDC should probably be controlled from userspace somehow as its usage is =
highly dependent on external factors.

This makes sense. The TDC userspace logic already exists but was
introduced later on, after the mcp251xfd module already existed. And
it was never updated and it still uses some hard coded logic.

If you are confident with writing the change, maybe you can give it a
try? It shouldn't be that hard and we can guide you through it. You
can refer to the patch below for an example on how to integrate the
TDC.

  https://git.kernel.org/torvalds/c/1010a8fa9608

The key is just to use can_tdc_is_enabled()

  https://elixir.bootlin.com/linux/v6.14.3/source/include/linux/can/dev.h#L=
90

This function will be controlled by the userspace (and should provide
a correct behavior by default).


Yours sincerely,
Vincent Mailhol

