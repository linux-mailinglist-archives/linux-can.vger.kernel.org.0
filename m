Return-Path: <linux-can+bounces-5943-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CB01DCDF2D9
	for <lists+linux-can@lfdr.de>; Sat, 27 Dec 2025 01:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87DDA3006A88
	for <lists+linux-can@lfdr.de>; Sat, 27 Dec 2025 00:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D271E1DB125;
	Sat, 27 Dec 2025 00:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fel.cvut.cz header.i=@fel.cvut.cz header.b="S6KJo4cI"
X-Original-To: linux-can@vger.kernel.org
Received: from smtpx.fel.cvut.cz (smtpx.feld.cvut.cz [147.32.210.153])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D48C3A1E6E;
	Sat, 27 Dec 2025 00:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=147.32.210.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766794814; cv=none; b=RCZPEm4YRC5v4D+X4s+/42sD2/uAiIGwcUR5ky9LUpgG/AWOw6BPlnaCG5cQX5AZL17GD2XEq7n6wKGODxew/dE1kITfhyzvD715vvyTCELw6O6oyY3KpSVdSUJtGQJB13FbZvEJwy5xYC4SCEaGGpc7d+Kh0aTP8UzDBFLODdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766794814; c=relaxed/simple;
	bh=mxzYxkFXm1WBNIb5Yog/dRDInADTKBjxopk94N7WIFM=;
	h=From:To:Subject:Date:Cc:References:In-Reply-To:MIME-Version:
	 Content-Type:Content-Disposition:Message-Id; b=V9/k7eKjj3WYdN5ikZTVuw+6B+YbAYCgHzNcOBc8ffuo4sCqAamHZCh7jGbyVo5KcV6HW/N/8LybN5CQxwEcRZdxZT+q3SNNoxO7D5pxUkt2YKJnO1NrLdDv/CB0IqhMcymPZNlR3RQBEkeM/9z/BIGSfafbOfY806IhUldIUKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fel.cvut.cz; spf=pass smtp.mailfrom=fel.cvut.cz; dkim=pass (2048-bit key) header.d=fel.cvut.cz header.i=@fel.cvut.cz header.b=S6KJo4cI; arc=none smtp.client-ip=147.32.210.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fel.cvut.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fel.cvut.cz
Received: from localhost (unknown [192.168.200.27])
	by smtpx.fel.cvut.cz (Postfix) with ESMTP id E153316404;
	Sat, 27 Dec 2025 01:20:02 +0100 (CET)
X-Virus-Scanned: IMAP STYX AMAVIS
Received: from smtpx.fel.cvut.cz ([192.168.200.2])
 by localhost (cerokez-250.feld.cvut.cz [192.168.200.27]) (amavis, port 10060)
 with ESMTP id BqD-eCiLjk-B; Sat, 27 Dec 2025 01:20:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fel.cvut.cz;
	s=felmail; t=1766794342;
	bh=8OGPj4UIzGsRvEleY+WUlbELMJzYb1fwdxvZmVVR3kE=;
	h=From:To:Subject:Date:Cc:References:In-Reply-To:From;
	b=S6KJo4cIytIweL5rd951zqpgPQ7Ltt+wOjYOMDK00eteWf9Qa8tr+M5lV8LgpnvSc
	 /vVXAoY9et/pm/NjfK1ms32NJA6ZAbYatycXHfRgk/cvNrWod669ZsIGBYQfn8y3eu
	 9HL5AhUKsxAeY1lDKHdfDiBiCufK2ZTCYI/RJOe3iwBhcW1xzR43SBhlTIyIVope+U
	 mrj9adJK3Q6AqWsx+hhUYz4ooyd1Rm5CjWqIMUId5eHFkNNwAJAEwjYyr2odIX2U3u
	 0PxcKQg08xnYrJN7lKxAnVczBFCNn1Y+w5RepdAFT+VE/z5cqiiX3ZifVchq7h7q5U
	 k/EjPLMVYzwyQ==
Received: from baree.pikron.com (static-84-242-78-234.bb.vodafone.cz [84.242.78.234])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pisa)
	by smtpx.fel.cvut.cz (Postfix) with ESMTPSA id 6477216145;
	Sat, 27 Dec 2025 01:12:21 +0100 (CET)
From: Pavel Pisa <pisa@fel.cvut.cz>
To: Ondrej Ille <ondrej.ille@gmail.com>
Subject: Re: ctucanfd: possible coding error in ctucan_set_secondary_sample_point causing SSP not enabled
Date: Sat, 27 Dec 2025 01:12:19 +0100
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
 netdev@vger.kernel.org,
 Jan Altenberg <Jan.Altenberg@osadl.org>
References: <CAOprWotBRv_cvD3GCSe7N2tiLooZBoDisSwbu+VBAmt_2izvwQ@mail.gmail.com> <202512222355.10509.pisa@fel.cvut.cz> <CAA7ZjpbhWQab77T42URMxQqv4SZwN+5FfDB9VEn0g9-ZKCqdOQ@mail.gmail.com>
In-Reply-To: <CAA7ZjpbhWQab77T42URMxQqv4SZwN+5FfDB9VEn0g9-ZKCqdOQ@mail.gmail.com>
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
Message-Id: <202512270112.19801.pisa@fel.cvut.cz>

Dear Ondrej Ille,

On Friday 26 of December 2025 23:45:55 Ondrej Ille wrote:
> Hello everyone,
>
> As for this specific case, I am aware of it for longer time
>
> > but the last time when we met with Ondrej Ille this part
> > as been the last one on the table and the firm confirmation
> > what is the best value have not been stated.
>
> Pavel, the sample point should definitely be set to the variant of
> "measured + offset". That is
> what why the offset is calculated above the way it is. The aim is to place
> the sample point
> on CAN_RX "as-if the same as normal sample point", just with the TX->RX
> delay accounted for.
> One only needs to be careful that the value is not in Time Quantas, but in
> "number of cycles".
> But AFAICT should be accounted for by the ssp_offset calculation.
>
> As for leaving there comment, or leaving it up to the compiler to optimize
> away since the value is
> anyway initialized to zero, I don't know what is the preferred way in
> kernel.
> Personally, I would not leave any "meaningless code", so, I think comment
> is better.

I am not sure, I would probably prefer code there because it can be
easily modified to other value or make it configurable. So this
would look like

        if (dbt->bitrate > 1000000) {
                /* Calculate SSP in minimal time quanta */
                ssp_offset = (priv->can.clock.freq / 1000) * dbt->sample_point / dbt->bitrate;

                if (ssp_offset > 127) {
                        netdev_warn(ndev, "SSP offset saturated to 127\n");
                        ssp_offset = 127;
                }

                ssp_cfg = FIELD_PREP(REG_TRV_DELAY_SSP_OFFSET, ssp_offset);
                ssp_cfg |= FIELD_PREP(REG_TRV_DELAY_SSP_SRC, 0x0);
        }

It matches currents state of the driver in the IP CORE repository where
you have propagated change lat week

https://gitlab.fel.cvut.cz/canbus/ctucanfd_ip_core/-/commit/6188ca673f823873f7b37dbb588a2d4c0a0cc98c

But I would suggest to cover even else case for dbt->bitrate <= 1 Mbit/s by else
statement which should be probably 

        } else {
                ssp_cfg = FIELD_PREP(REG_TRV_DELAY_SSP_OFFSET, 0);
                ssp_cfg |= FIELD_PREP(REG_TRV_DELAY_SSP_SRC, 0x0);
        }

It is right that ctucan_set_secondary_sample_point() is called from ctucan_chip_start()
only and it is called from ctucan_do_set_mode() and ctucan_open() only and the chip
reset is done in both paths prior to ctucan_chip_start() but I think that
state should be defined there even for case that core is only stopped by
by REG_MODE_ENA and then re-enabled an no leftover from setup with higher
data bitrate to some followup change to lower one should be left there.

If there is already some defined way how to control/enable/disable
SSP from userspace for some of other drivers then I would
ted to have such option for CTU CAN FD as well to have
option to test/diagnose and correct (in the case of some problems)
its behavior without driver recompile.  

> 1) the driver is fixed on 4 Tx Buffers synthesis value
>
> > for CTU CAN FD IP core. I am not aware about any other value
> > in real use (FPGA or silicon) but if the core is synthesized
> > with other value then driver would fail.  If more are used,
> > then current driver code stuck on Tx empty infinite interrupt,
> > if less, messages would be lost.
> > The option to obtain the number of Tx buffers from hardware
> > has been added into design and we have proper code in RTEMS
> > driver
>
> Yes, this would be useful, I believe there is a tracking issue for that. I
> believe querying it
> at run-time is the simplest way to do it, but I don't know if it is "the
> right way" in kernel.

I think that it is OK, we have there already option to propagate
value from PCI and OF specific CTU CAN FD mapping into base code
but it is fixed on four buffers fr now and no mapping to OF is provided.
So I would change it such that ntxbufs = 0 specified by PCI or OF
mapping would result in configuration from info register.
If the requested ntxbufs from PCI or OF is higher than value reported
by info register then it should be limited as well and final limit
should be some define

#define CTUCANFD_NTXBUFS_MAX 8

We have that tested info register reading in RTEMS driver
for 2.5 as well as older branch so I hope that risk
of breaking someone's CTU CAN FD specific integration
is relatively small.

I prepare patches. The SSP one can be considered as bugfix
if Marc, David or somebody with the need proposes that
and may it be it can get to 6.19. Or I prepare both
for the next merge window.

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

