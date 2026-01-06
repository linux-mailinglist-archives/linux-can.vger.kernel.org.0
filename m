Return-Path: <linux-can+bounces-6004-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93717CF61DC
	for <lists+linux-can@lfdr.de>; Tue, 06 Jan 2026 01:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AB8FA3009267
	for <lists+linux-can@lfdr.de>; Tue,  6 Jan 2026 00:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9ED1F5435;
	Tue,  6 Jan 2026 00:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fel.cvut.cz header.i=@fel.cvut.cz header.b="ARugXRoZ"
X-Original-To: linux-can@vger.kernel.org
Received: from smtpx.fel.cvut.cz (smtpx.feld.cvut.cz [147.32.210.153])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F984A33;
	Tue,  6 Jan 2026 00:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=147.32.210.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767660811; cv=none; b=ELrwdP6HfeY1wowyAHzOcfKmTNvZpHE+zc3D0KK+b9RVgQbCd2O8ENt2pgMThVF7lDwQz5xhMxiQb+ovMoScYPWLa7bpo9477Ztwpwq31VvzEVacTZPEb9aTm5Guk71tsd1GOW8YcL02W9ejpByp43UmchrhmnXa1JQq7t3HrrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767660811; c=relaxed/simple;
	bh=17z0exQ7SnMFSXdXXuhMDstFuqJF4KKZ0y/RjgFYiYQ=;
	h=From:To:Subject:Date:Cc:References:In-Reply-To:MIME-Version:
	 Content-Type:Content-Disposition:Message-Id; b=GVi0O0jLjfdJ0A6PIaa063GGXtBJCzWQ/bb85DgHFiQiP+6XIcJ4BzRauKUW5jXGR2rWKYcIVdF8eLofPAcZJF9LIZgHXkVIn6bIL6H7BwJ4GIHulCu8VF4ImycAnFS5RmyoFBO78Pzrh0o/SpbsBPu2Dx2Qc8E+fW+PR33gdHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fel.cvut.cz; spf=pass smtp.mailfrom=fel.cvut.cz; dkim=pass (2048-bit key) header.d=fel.cvut.cz header.i=@fel.cvut.cz header.b=ARugXRoZ; arc=none smtp.client-ip=147.32.210.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fel.cvut.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fel.cvut.cz
Received: from localhost (unknown [192.168.200.27])
	by smtpx.fel.cvut.cz (Postfix) with ESMTP id A2A3D11616;
	Tue, 06 Jan 2026 01:53:24 +0100 (CET)
X-Virus-Scanned: IMAP STYX AMAVIS
Received: from smtpx.fel.cvut.cz ([192.168.200.2])
 by localhost (cerokez-250.feld.cvut.cz [192.168.200.27]) (amavis, port 10060)
 with ESMTP id AFthos-VVGwq; Tue,  6 Jan 2026 01:53:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fel.cvut.cz;
	s=felmail; t=1767660803;
	bh=gwEadOXuM8MSaAQONaiEvqD9GaYdaBSiDkJe/eYwSto=;
	h=From:To:Subject:Date:Cc:References:In-Reply-To:From;
	b=ARugXRoZMNBZb7m6oJaDjCpE/gYe4W7TAmGvTgVCOlT/FEu/Vm7U+Zv5aIKO+97o2
	 +MDgibg25hQGmS5uwHVKkmp+x3Hy8CzFE7opVjQzP14jw739djnrZKUJFHiEuaD2vx
	 1bD/UMH3q/x/tCu/dFzMIQ9+GbWlVHcESp4kBCC2QEm+xawC4CNIJlwPtzFd4bRhU3
	 a9Yfd4KrjRbU63bXaMfr9AoLYr7VfKPrJwWn0KVLyoXsRKLtnH7T2fAq0X09RewT4R
	 w/1wRlU2rKvP8MD8MnykwbVBfmH7CPpNZmCDIYx6q1BXM0y18We00N3FjrTmHMW79f
	 X9nioHEUdM/Kw==
Received: from baree.pikron.com (static-84-242-78-234.bb.vodafone.cz [84.242.78.234])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pisa)
	by smtpx.fel.cvut.cz (Postfix) with ESMTPSA id 962AA11539;
	Tue, 06 Jan 2026 01:53:22 +0100 (CET)
From: Pavel Pisa <pisa@fel.cvut.cz>
To: Vincent Mailhol <mailhol@kernel.org>,
 Ondrej Ille <ondrej.ille@gmail.com>
Subject: Re: [PATCH v2] can: ctucanfd: fix SSP_SRC in cases when bit-rate is higher than 1 MBit.
Date: Tue, 6 Jan 2026 01:53:21 +0100
User-Agent: KMail/1.9.10
Cc: linux-can@vger.kernel.org,
 "Marc Kleine-Budde" <mkl@pengutronix.de>,
 David Laight <david.laight.linux@gmail.com>,
 "David S. Miller" <davem@davemloft.net>,
 Andrea Daoud <andreadaoud6@gmail.com>,
 Wolfgang Grandegger <wg@grandegger.com>,
 Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org,
 Jiri Novak <jnovak@fel.cvut.cz>
References: <20260105111620.16580-1-pisa@fel.cvut.cz> <c5851986-837b-4ffb-9bf7-3131cf9c05d1@kernel.org>
In-Reply-To: <c5851986-837b-4ffb-9bf7-3131cf9c05d1@kernel.org>
X-KMail-QuotePrefix: > 
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <202601060153.21682.pisa@fel.cvut.cz>

Dear Vincent Mailhol,

thanks for pointing to Transmission Delay Compensation
related code introduced in 5.16 kernel. I have noticed it
in the past but not considered it yet and I think
that we need minimal fixes to help users and
allow change to propagate into stable series now.

More details inline

On Monday 05 of January 2026 21:27:11 Vincent Mailhol wrote:
> Le 05/01/2026 =C3=A0 12:16, Pavel Pisa a =C3=A9crit=C2=A0:
> > From: Ondrej Ille <ondrej.ille@gmail.com>
> >
> > The Secondary Sample Point Source field has been
> > set to an incorrect value by some mistake in the
> > past
> >
> >   0b01 - SSP_SRC_NO_SSP - SSP is not used.
> >
> > for data bitrates above 1 MBit/s. The correct/default
> > value already used for lower bitrates is
>
> Where does this 1 MBit/s threshold come from? Is this an empirical value?
>
> The check is normally done on the data BRP. For example we had some
> problems on the mcp251xfd, c.f. commit 5e1663810e11 ("can: mcp251xfd:
> fix TDC setting for low data bit rates").

The CTU CAN FD check is done on data bitrate

https://elixir.bootlin.com/linux/v6.18.3/source/drivers/net/can/ctucanfd/ct=
ucanfd_base.c#L290

  if (dbt->bitrate > 1000000)

the line expands to

  if (priv->can.fd.data_bittiming.bitrate > 1000000)

The value computation has been defined by Ondrej Ille, main author
of the CTU CAN FD IP core. The main driver author has been
Martin Jerabek and there seems that we have made some mistake,
flip in value in the past. But Ondrej Ille is the most competent
for the core limits and intended behavior and SW support.
He has invested to complete iso-16845 compliance testing
framework re-implementation for detailed timing testing.
There is even simulated environment with clocks jitters
and delays equivalent to linear, start and other typologies
run at each core update. The kudos for idea how to implement
this without unacceptable time required for simulation
goes to Martin Jerabek. But lot of scenarios are tested
and Ondrej Ille can specify what is right and has been
tested. May it be, even Jiri Novak can provide some input
as well, because he uses CTU CAN FD to deliver more generations
of CTU tester systems to car makers (mainly SkodaAuto)
and the need of configurable IP core for these purposes was initial
driver for the CTU CAN FD core design.

The function of SSP is described in the datasheet and implementation
in the CTU CAN FD IP CORE System Architecture manual or we can go
to HDL design as well.

I extrapolate that 1 Mbit/s has been chosen as the switching point,
because controller and transceivers are expected to support
arbitration bit rate to at least 1 Mbit/s according to CAN and CAN FD
standards and there is no chance to use SSP during nominal bitrate.

> Can you use the TDC framework?

In longer term it would be right direction. But TRV_DELAY
measurement is and should be considered as default for
data bit rate and BRS set and then the transceiver delay
should be fully compensated on CTU CAN FD.

Problem was that the compensation was switched off by mistake
in the encoded value.

But when I study manuals and implementation again, I think that
there is problem with data bitrate < 1 Mbit/s, because for these
the compensation should be switched off or the data rate sample_point
should be recomputed to SSP_OFFET because else sampling is done
too early. Delay is not added to sampling point. So we should
correct this to make case with BRS and switching to
higher data rate (but under 1 Mbit/s) to be more reliable.

There are some limitations in maximal values which can be
set to SSP_OFFET field. It resolution is high, 10 ns typically
for our IP CORE FPGA targets with the 100 MHz IP core clock.
On silicon version, as I know, 80 MHz has been used in the
last integration. So again, limit is around 2.5 usec or a little
more for 80 MHz. This matches again mode switch at 1 Mbit/s
or the other option could be switch when SSP_OFFET exceeds
250 or some such value.

> Not only would you get a correct=20
> calculation for when to activate/deactivate TDC, you will also have the
> netlink reporting (refer to the above commit for an example).

Yes, I agree that availability of tuning and monitoring over
netlink is nice added value. But at this moment I (personally)
prefer the minimal fix to help actual users.

I add there links to current CAN FD Transmission Delay Compensation
support and definition in the Linux kernel code for future integration
into CTU CAN FD IP core driver

https://elixir.bootlin.com/linux/v6.18.3/source/include/linux/can/bittiming=
=2Eh#L25

https://elixir.bootlin.com/linux/v6.18.3/source/drivers/net/can/dev/calc_bi=
ttiming.c#L174

https://elixir.bootlin.com/linux/v6.18.3/source/drivers/net/can/spi/mcp251x=
fd/mcp251xfd-core.c#L595

and in the controller features announcement

priv->can.ctrlmode_supported =3D CAN_CTRLMODE_LOOPBACK |
		CAN_CTRLMODE_LISTENONLY | CAN_CTRLMODE_BERR_REPORTING |
		CAN_CTRLMODE_FD | CAN_CTRLMODE_FD_NON_ISO |
		CAN_CTRLMODE_CC_LEN8_DLC | CAN_CTRLMODE_TDC_AUTO |
		CAN_CTRLMODE_TDC_MANUAL;

Best wishes,

Pavel

> >   0b00 - SSP_SRC_MEAS_N_OFFSET - SSP position =3D TRV_DELAY
> >          (Measured Transmitter delay) + SSP_OFFSET.
> >
> > The related configuration register structure is described
> > in section 3.1.46 SSP_CFG of the CTU CAN FD
> > IP CORE Datasheet.
> >
> > The analysis leading to the proper configuration
> > is described in section 2.8.3 Secondary sampling point
> > of the datasheet.
> >
> > The change has been tested on AMD/Xilinx Zynq
> > with the next CTU CN FD IP core versions:
> >
> >  - 2.6 aka master in the "integration with Zynq-7000 system" test
> >    6.12.43-rt12+ #1 SMP PREEMPT_RT kernel with CTU CAN FD git
> >    driver (change already included in the driver repo)
> >  - older 2.5 snapshot with mainline kernels with this patch
> >    applied locally in the multiple CAN latency tester nightly runs
> >    6.18.0-rc4-rt3-dut #1 SMP PREEMPT_RT
> >    6.19.0-rc3-dut
> >
> > The logs, the datasheet and sources are available at
> >
> >  https://canbus.pages.fel.cvut.cz/
> >
> > Signed-off-by: Ondrej Ille <ondrej.ille@gmail.com>
> > Signed-off-by: Pavel Pisa <pisa@fel.cvut.cz>
>
> Yours sincerely,
> Vincent Mailhol


