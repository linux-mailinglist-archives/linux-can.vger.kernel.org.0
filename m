Return-Path: <linux-can+bounces-5944-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B85CDF309
	for <lists+linux-can@lfdr.de>; Sat, 27 Dec 2025 01:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A973E300092E
	for <lists+linux-can@lfdr.de>; Sat, 27 Dec 2025 00:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113B621FF30;
	Sat, 27 Dec 2025 00:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fel.cvut.cz header.i=@fel.cvut.cz header.b="FjRX0xZk"
X-Original-To: linux-can@vger.kernel.org
Received: from smtpx.fel.cvut.cz (smtpx.feld.cvut.cz [147.32.210.153])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB5F21D3E2;
	Sat, 27 Dec 2025 00:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=147.32.210.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766796308; cv=none; b=PDQ/FcR9wwqvJDgdVb8Vv8l7oaa9Vog+lMtP4BDeT2V8Yc6DQb1OZECw4ruAt32g/gaR/42OoXhsx2z+agAP5ifMFoVBfF/pub0KtD1VeKSIGyBbtX7hpO4611HhhqyolHXDfJbqBT3VvG/fTBNHLTMDAesqDyCb9QrZC0ZurDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766796308; c=relaxed/simple;
	bh=IEBm1SxcXBuo96w3k4LPR8IigGiimqKKQp9AJiCr01c=;
	h=From:To:Subject:Date:Cc:References:In-Reply-To:MIME-Version:
	 Content-Type:Content-Disposition:Message-Id; b=QzGdIDCfz+1TlZseAQSvuS0XXq2pWvicUPfOEm4Uh65mHt4Bk4bX8ShdrKFsP9mCm/jkEz7Ts1o5Px9V9iWNImv3jcv3+UUedPd1Gjrk03Fxuqah8QR/vSHxP7ETDcY4kslkaQDvnM7r5uV70bhtgm6lFB0VpfyNkXfQDS3KozI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fel.cvut.cz; spf=pass smtp.mailfrom=fel.cvut.cz; dkim=pass (2048-bit key) header.d=fel.cvut.cz header.i=@fel.cvut.cz header.b=FjRX0xZk; arc=none smtp.client-ip=147.32.210.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fel.cvut.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fel.cvut.cz
Received: from localhost (unknown [192.168.200.27])
	by smtpx.fel.cvut.cz (Postfix) with ESMTP id DEA6B1626B;
	Sat, 27 Dec 2025 01:45:02 +0100 (CET)
X-Virus-Scanned: IMAP STYX AMAVIS
Received: from smtpx.fel.cvut.cz ([192.168.200.2])
 by localhost (cerokez-250.feld.cvut.cz [192.168.200.27]) (amavis, port 10060)
 with ESMTP id q42iJ87A4n5D; Sat, 27 Dec 2025 01:45:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fel.cvut.cz;
	s=felmail; t=1766795951;
	bh=DndPp7+zVQ7BD6MgvFgzA5RxURbGF01KCj8ehwdRK1w=;
	h=From:To:Subject:Date:Cc:References:In-Reply-To:From;
	b=FjRX0xZkm8CaHeFIyjdUKU4YnECrzEyZ78vv3HHWXIvozmR7u8cGpB/+DnsDG7+1L
	 7zK+ixtHx7NFv8B0ksFMpWBbt8yN2o2Ar2APrF1RpYCK0F7RRYI5Q87WIH5RL1Cp+b
	 nqoA3O7hZ9XjMQUv8SW8HigaTFBJ+L8SZlXlmLs/E358KvhZq02+BZKAGeJMiNv4Vb
	 u4tZ/Ib+XRPJMBXqAyHpIXJgrtBa9fkJwaAiG0lR4Su+GjXGbSbLHlVET0WUbBoqAi
	 8iZVAf7ukOEsdrgvydRyjSZ8yriw9v4MkrgbolG3G0RmhWpIwZozLg+SeD341LIX9V
	 esUfspJYXoPbA==
Received: from baree.pikron.com (static-84-242-78-234.bb.vodafone.cz [84.242.78.234])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pisa)
	by smtpx.fel.cvut.cz (Postfix) with ESMTPSA id 5EDD416156;
	Sat, 27 Dec 2025 01:39:10 +0100 (CET)
From: Pavel Pisa <pisa@fel.cvut.cz>
To: Ondrej Ille <ondrej.ille@gmail.com>
Subject: Re: ctucanfd: possible coding error in ctucan_set_secondary_sample_point causing SSP not enabled
Date: Sat, 27 Dec 2025 01:39:08 +0100
User-Agent: KMail/1.9.10
Cc: David Laight <david.laight.linux@gmail.com>,
 "Marc Kleine-Budde" <mkl@pengutronix.de>,
 Andrea Daoud <andreadaoud6@gmail.com>,
 linux-can@vger.kernel.org,
 Wolfgang Grandegger <wg@grandegger.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 netdev@vger.kernel.org
References: <CAOprWotBRv_cvD3GCSe7N2tiLooZBoDisSwbu+VBAmt_2izvwQ@mail.gmail.com> <CAA7ZjpbhWQab77T42URMxQqv4SZwN+5FfDB9VEn0g9-ZKCqdOQ@mail.gmail.com> <202512270112.19801.pisa@fel.cvut.cz>
In-Reply-To: <202512270112.19801.pisa@fel.cvut.cz>
X-KMail-QuotePrefix: > 
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202512270139.08818.pisa@fel.cvut.cz>

Correction

On Saturday 27 of December 2025 01:12:19 Pavel Pisa wrote:
> Dear Ondrej Ille,
>
> On Friday 26 of December 2025 23:45:55 Ondrej Ille wrote:
> > Hello everyone,
> >
> > As for this specific case, I am aware of it for longer time
> >
> > > but the last time when we met with Ondrej Ille this part
> > > as been the last one on the table and the firm confirmation
> > > what is the best value have not been stated.
> >
> > Pavel, the sample point should definitely be set to the variant of
> > "measured + offset". That is
> > what why the offset is calculated above the way it is. The aim is to
> > place the sample point
> > on CAN_RX "as-if the same as normal sample point", just with the TX->RX
> > delay accounted for.
> > One only needs to be careful that the value is not in Time Quantas, but
> > in "number of cycles".
> > But AFAICT should be accounted for by the ssp_offset calculation.
> >
> > As for leaving there comment, or leaving it up to the compiler to
> > optimize away since the value is
> > anyway initialized to zero, I don't know what is the preferred way in
> > kernel.
> > Personally, I would not leave any "meaningless code", so, I think comment
> > is better.
>
> I am not sure, I would probably prefer code there because it can be
> easily modified to other value or make it configurable. So this
> would look like
>
>         if (dbt->bitrate > 1000000) {
>                 /* Calculate SSP in minimal time quanta */
>                 ssp_offset = (priv->can.clock.freq / 1000) *
> dbt->sample_point / dbt->bitrate;
>
>                 if (ssp_offset > 127) {
>                         netdev_warn(ndev, "SSP offset saturated to 127\n");
>                         ssp_offset = 127;
>                 }
>
>                 ssp_cfg = FIELD_PREP(REG_TRV_DELAY_SSP_OFFSET, ssp_offset);
>                 ssp_cfg |= FIELD_PREP(REG_TRV_DELAY_SSP_SRC, 0x0);
>         }
>
> It matches currents state of the driver in the IP CORE repository where
> you have propagated change lat week
>
> https://gitlab.fel.cvut.cz/canbus/ctucanfd_ip_core/-/commit/6188ca673f82387
>3f7b37dbb588a2d4c0a0cc98c
>
> But I would suggest to cover even else case for dbt->bitrate <= 1 Mbit/s by
> else statement which should be probably
>
>         } else {
>                 ssp_cfg = FIELD_PREP(REG_TRV_DELAY_SSP_OFFSET, 0);
>                 ssp_cfg |= FIELD_PREP(REG_TRV_DELAY_SSP_SRC, 0x0);
>         }

As I have looked only onto patch, I have overlooked that whole
register is reset to zero if condition (dbt->bitrate > 1000000)
is not true. So then the

ssp_cfg |= FIELD_PREP(REG_TRV_DELAY_SSP_SRC, 0x0);

can is equivalent to the default and can be left in common
path (if we consider value 0 as right value for all cases)
or removed alltogether. So I am not sure at this moment
if the whole line should be removed or set to zero
and moved out of if block.

Best wishes,

                Pavel

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



