Return-Path: <linux-can+bounces-5905-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CB87ECD76EF
	for <lists+linux-can@lfdr.de>; Tue, 23 Dec 2025 00:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BB9FE30139A7
	for <lists+linux-can@lfdr.de>; Mon, 22 Dec 2025 23:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F40830E834;
	Mon, 22 Dec 2025 23:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fel.cvut.cz header.i=@fel.cvut.cz header.b="BVktmx/n"
X-Original-To: linux-can@vger.kernel.org
Received: from smtpx.fel.cvut.cz (smtpx.feld.cvut.cz [147.32.210.153])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C291946BC;
	Mon, 22 Dec 2025 23:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=147.32.210.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766445007; cv=none; b=NpWPSlHa0ODbO+iOZGeFD3R1HZkXMPDojsP8HcLHiZy+ni+vQjxMAMrMDIlRoNn1kagzlT1ZaezOwHg78SE5tI01jKqELRkU8H7ZVLHDWqjqH6d55JAFYaUJAG2cueTst7LIJ59eiaNfiA5MeWaNBR85r0i2EhNYY6KEp7bKpaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766445007; c=relaxed/simple;
	bh=f27tGy5cquTQRFVyDH5OCRVQRDiM82KixEj1y7ztRnY=;
	h=From:To:Subject:Date:Cc:References:In-Reply-To:MIME-Version:
	 Content-Type:Content-Disposition:Message-Id; b=j85oDjiMT4G+cI97G+5y00IkEZ+VPyExoyu7tWlghaUd2rqKDjJRA7h6Tj074LY+hcs0LIG8F5CvoRsU8CSPYnhxqA84P0fe6gqwdoekqWAXvtmcyuuS8TeAPXp+LwJOXAuK1KBYKFAIOKmTEv77DFv9yys7UWFCqw4cYkNivdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fel.cvut.cz; spf=pass smtp.mailfrom=fel.cvut.cz; dkim=pass (2048-bit key) header.d=fel.cvut.cz header.i=@fel.cvut.cz header.b=BVktmx/n; arc=none smtp.client-ip=147.32.210.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fel.cvut.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fel.cvut.cz
Received: from localhost (unknown [192.168.200.27])
	by smtpx.fel.cvut.cz (Postfix) with ESMTP id 935AC106CB;
	Tue, 23 Dec 2025 00:00:02 +0100 (CET)
X-Virus-Scanned: IMAP STYX AMAVIS
Received: from smtpx.fel.cvut.cz ([192.168.200.2])
 by localhost (cerokez-250.feld.cvut.cz [192.168.200.27]) (amavis, port 10060)
 with ESMTP id Y3VrUZi3bXf9; Tue, 23 Dec 2025 00:00:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fel.cvut.cz;
	s=felmail; t=1766444114;
	bh=8v+WXp/tB+n3z/ZgBxM9EEYQ0edbO0d8fOruNB5DOO8=;
	h=From:To:Subject:Date:Cc:References:In-Reply-To:From;
	b=BVktmx/nhu285TOOGhZCl0rLH7dGMUQ7ZyL4VJjvoZQmmJkiTTePz8w4Mh8v8Zane
	 G/0ItO3UM3g7yWptycRcLs3uwudGYeMrkGThwxBqXDXS90abKafhxAyD5BtpPOXjmu
	 A8h7q0aRwko2410SgbG6klYHr8mCmOUIzYNH+nadnnCWd7Q1HQ4G401hNfRqBMLogp
	 nnBUeSF8XnGEdUOcPTC6Zyf4hH5oZq+OVb8I1dZ3kSUX2gFsX8xFfQcNmhcdBUkMoJ
	 vQNxSUtcuL4TnnIMMHgHCaXA+3FNRkEvrS2el06684UMtCIHpGjR0prFwyLu0MXUyg
	 NO7pup0NKqQkw==
Received: from baree.pikron.com (static-84-242-78-234.bb.vodafone.cz [84.242.78.234])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pisa)
	by smtpx.fel.cvut.cz (Postfix) with ESMTPSA id 254DD1098C;
	Mon, 22 Dec 2025 23:55:13 +0100 (CET)
From: Pavel Pisa <pisa@fel.cvut.cz>
To: David Laight <david.laight.linux@gmail.com>,
 Ondrej Ille <ondrej.ille@gmail.com>
Subject: Re: ctucanfd: possible coding error in ctucan_set_secondary_sample_point causing SSP not enabled
Date: Mon, 22 Dec 2025 23:55:10 +0100
User-Agent: KMail/1.9.10
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>,
 Andrea Daoud <andreadaoud6@gmail.com>,
 linux-can@vger.kernel.org,
 Wolfgang Grandegger <wg@grandegger.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 netdev@vger.kernel.org,
 Jan Altenberg <Jan.Altenberg@osadl.org>
References: <CAOprWotBRv_cvD3GCSe7N2tiLooZBoDisSwbu+VBAmt_2izvwQ@mail.gmail.com> <20251222-kickass-oyster-of-sorcery-c39bb7-mkl@pengutronix.de> <20251222182211.26893b94@pumpkin>
In-Reply-To: <20251222182211.26893b94@pumpkin>
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
Message-Id: <202512222355.10509.pisa@fel.cvut.cz>

Dear David Laight, Ondrej Ille and others,

On Monday 22 of December 2025 19:22:11 David Laight wrote:
> On Mon, 22 Dec 2025 17:20:49 +0100
>
> Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> > On 22.12.2025 16:51:07, Ondrej Ille wrote:
> > > yes, your thinking is correct, there is a bug there.
> > >
> > > This was pointed to by another user right in the CTU CAN FD repository
> > > where the Linux driver also lives:
> > > https://github.com/Blebowski/CTU-CAN-FD/pull/2
> > >
> > > It is as you say, it should be:
> > >
> > > -- ssp_cfg |=3D FIELD_PREP(REG_TRV_DELAY_SSP_SRC, 0x1);
> > > ++ ssp_cfg |=3D FIELD_PREP(REG_TRV_DELAY_SSP_SRC, 0x0);
> >
> > This statement has no effect, as 'ssp_cfg |=3D 0x0' is still 'ssp_cfg'.
>
> The compiler will optimise it away - so it is the same as a comment.
>
> > IMHO it's better to add a comment that says, why you don't set
> > REG_TRV_DELAY_SSP_SRC. Another option is to add create a define that
> > replaces 0x1 and 0x0 for REG_TRV_DELAY_SSP_SRC with a speaking name.
>
> Looking at the header, the 'field' is two bits wide.
> So what you really want the code to look like is:
> 	ssp_cfg |=3D REG_TRV_DELAY_SSP_SRC(n);
> There is nothing to stop working - it just needs the right defines.
> Sort of FIELD_PREP(GENMASK(25, 24), n) - but you can do a lot better than
> that. The inverse is also possible:
> 	val =3D GET_VAL(REG_TRV_DELAY_SSP_SRC, reg_val);
> #define GET_VAL(x, reg) ((reg & x(-1))/x(1))

I have no problem to prepare patch against=20

git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git
git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git

and we have running daily testing at CTU for latest mainline and RT

https://canbus.pages.fel.cvut.cz/#can-bus-channels-mutual-latency-testing

and each CTU CAN FD master RTL and related driver is tested on FPGA
as well id the change in IP core repo is detected

https://gitlab.fel.cvut.cz/canbus/zynq/zynq-can-sja1000-top/-/pipelines

As for this specific case, I am aware of it for longer time
but the last time when we met with Ondrej Ille this part
as been the last one on the table and the firm confirmation
what is the best value have not been stated.

ssp_cfg |=3D FIELD_PREP(REG_TRV_DELAY_SSP_SRC, xxx);

There are three options

SSP_SRC Source of Secondary sampling point.
  - 0b00 - SSP_SRC_MEAS_N_OFFSET - SSP position =3D TRV_DELAY
    (Measured Transmitter delay) + SSP_OFFSET.
  - 0b01 - SSP_SRC_NO_SSP - SSP is not used. Transmitter uses
    regular Sampling Point during data bit rate.
  - 0b10 - SSP_SRC_OFFSET - SSP position =3D SSP_OFFSET. Measured
    Transmitter delay value is ignored.

there is filed for manual setting or adjustment

SSP_OFFSET Secondary sampling point o=EF=AC=80set. Value is given as multip=
le of minimal Time quanta.

As for the change, I can test the change in normal conditions
but I am afraid that there can be chance that automatic tuning
can lead to problems in some specific cases and I would like
to hear some confirmation from others there and may it be information
how it is solved in other drivers. SSP seems to be supported by

  usb/esd_usb.c  seems to be set to 0 only
  m_can/m_can.c for bitrate > 2500000

I am not sure if there is some option to (at least) switch is on and off
through some netlink, iproute2 or other API. It would worth to have
there some option to switch it off (for example through /sys) in case
that it causes some problems.

As for the driver, there are more ideas pending on my table.

1) the driver is fixed on 4 Tx Buffers synthesis value
for CTU CAN FD IP core. I am not aware about any other value
in real use (FPGA or silicon) but if the core is synthesized
with other value then driver would fail.  If more are used,
then current driver code stuck on Tx empty infinite interrupt,
if less, messages would be lost.
The option to obtain the number of Tx buffers from hardware
has been added into design and we have proper code in RTEMS
driver=20

https://gitlab.rtems.org/rtems/rtos/rtems/-/blob/main/cpukit/dev/can/ctucan=
fd/ctucanfd.c?ref_type=3Dheads#L1783

2) there is problem with bus monitor mode in pre 2.5.2 CTU CAN FD
IP core version. I have found as solution for some mass produced
silicon. It should be propagated into Linux driver.=20

         mode_reg =3D (mode->flags & CAN_CTRLMODE_LISTENONLY) ?
                         (mode_reg | REG_MODE_BMM) :
                         (mode_reg & ~REG_MODE_BMM);

+         mode_reg =3D (mode->flags & CAN_CTRLMODE_LISTENONLY) ?
+                         (mode_reg | REG_MODE_ROM) :
+                         (mode_reg & ~REG_MODE_ROM);
+
=2D        mode_reg =3D (mode->flags & CAN_CTRLMODE_PRESUME_ACK) ?
+        mode_reg =3D (mode->flags & (CAN_CTRLMODE_PRESUME_ACK | CAN_CTRLMO=
DE_LISTENONLY)) ?
                         (mode_reg | REG_MODE_ACF) :
                         (mode_reg & ~REG_MODE_ACF);

But it should be checked for which versions it is applicable.
There were more variants of the problem around listen only
mode for older core version.

3) there is long term prepared support for Rx timestamping
which is used for years in our latency tester, but it did not
pass review yet. It is result of
https://dspace.cvut.cz/bitstream/handle/10467/101450/F3-DP-2022-Vasilevski-=
Matej-vasilmat.pdf
and would worth to be cleaned up with help of reviewers feedback
and other help to pass. Waits for my or others time as well.

4) there is even option to implement HW Tx timestamps on later
core version which can feed Tx frames to Rx queue with timestamp
filled. But only latter core versions can report sending
Tx buffer for loopback frames in Rx queue

5) the multiqueue support. Again, it is tested in our RTEMS
complete CAN FD framework which will be extended by SJA1000
and LPC drivers soon. The theory
https://wiki.control.fel.cvut.cz/mediawiki/images/c/cc/Dp_2024_lenc_michal.=
pdf
CiA article
https://www.can-cia.org/fileadmin/cia/documents/proceedings/2024_lenc_pisa.=
pdf
and implementation in RTEMS driver
https://gitlab.rtems.org/rtems/rtos/rtems/-/tree/main/cpukit/dev/can/ctucan=
fd
https://docs.rtems.org/docs/main/bsp-howto/can.html

6) solving trimming issues of Linux kernel SocketCAN implementation.
Our RTEMS characted driver code has maximal latancies of 65 used even
with full BSD TCP/IP stack stress testing when CAN related stuff has
highest priorities. No matter what we done or Linux even with suggestions
of others, we experience multi-millisecond latencies on Linux even of
preempt RT kernels.

I have donated one system from CTU pocket (original Martin Jerabek's design
of Zynq based CAN latester) and one from my personal pocket (our Zynq based
MZ_APO design) to OSADL https://www.osadl.org/OSADL-QA-Farm-Real-time.linux=
=2Dreal-time.0.html
but I have not found time and external interest to start more work there. A=
gain some
cooperation and interrest by these who work on the projects as SocketCAN an=
d even
earn some money on it (not my case for 20+ years of work) would help. Some =
small
money or GSoC for example to find some studnet to work on project for examp=
le
for summer work could help. OSADL offers latency hunting services as well so
some cooperation and funding could help there. But no car marker or Automot=
ive
Grade Linux funded people have expressed interrest yet. They sell Kubernetes
containers on the wheel, AI camera processing but that the commands
do not pass though CAN or other HW in time so save pedestrian life
seems to be unimportant detail.

Best wishes,

                Pavel Pisa
    phone:      +420 603531357
    e-mail:     pisa@cmp.felk.cvut.cz
    Department of Control Engineering FEE CVUT
    Karlovo namesti 13, 121 35, Prague 2
    university: http://control.fel.cvut.cz/
    personal:   http://cmp.felk.cvut.cz/~pisa
    social:     https://social.kernel.org/ppisa
    projects:   https://www.openhub.net/accounts/ppisa
    CAN related:http://canbus.pages.fel.cvut.cz/
    RISC-V education: https://comparch.edu.cvut.cz/
    Open Technologies Research Education and Exchange Services
    https://gitlab.fel.cvut.cz/otrees/org/-/wikis/home

