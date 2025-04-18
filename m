Return-Path: <linux-can+bounces-3440-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B29A7A935ED
	for <lists+linux-can@lfdr.de>; Fri, 18 Apr 2025 12:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3261A1B60630
	for <lists+linux-can@lfdr.de>; Fri, 18 Apr 2025 10:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937D826FD86;
	Fri, 18 Apr 2025 10:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fel.cvut.cz header.i=@fel.cvut.cz header.b="aDnJx9Gi";
	dkim=pass (2048-bit key) header.d=fel.cvut.cz header.i=@fel.cvut.cz header.b="gPXHCgQz"
X-Original-To: linux-can@vger.kernel.org
Received: from smtpx1.feld.cvut.cz (smtpx1.feld.cvut.cz [147.32.210.191])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EEC2528EA;
	Fri, 18 Apr 2025 10:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=147.32.210.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744971669; cv=none; b=G/FKjHvrNCsAWe2Iw9HdjswAABvAimVZIDMP24rVxPazUY96gFmmoRJPjnNY3pEnV61ao66fW44RydkPCxf3H1YVa2YKD5cfhpc91f5iDqndlCLdg82+2cnKxkXTX9srnrwW4JhiM2g3ifSNcZPqTr3932QoxQDeb7KP/4IStZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744971669; c=relaxed/simple;
	bh=exFdmBB4YtQi78HkYK9tHYCz7NpFcrbi4bTabGprP+8=;
	h=From:To:Subject:Date:Cc:References:In-Reply-To:MIME-Version:
	 Content-Type:Content-Disposition:Message-Id; b=HSIBC4jbdnOEpe/vw0L7e9hvEtrK0wMQG+6BveXh0tQ0SonCpFcP8N13CRR/FA3iaGZ0H2yXzivgpeEhK0lC/iVm4YYRMT6obLWNm3EDxw16SFmBXDj77+hAgdVh1MGd2JyPDpxq8f2B1WN90k4K36am28efjiYWfzu21WD9g3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fel.cvut.cz; spf=pass smtp.mailfrom=fel.cvut.cz; dkim=pass (2048-bit key) header.d=fel.cvut.cz header.i=@fel.cvut.cz header.b=aDnJx9Gi; dkim=pass (2048-bit key) header.d=fel.cvut.cz header.i=@fel.cvut.cz header.b=gPXHCgQz; arc=none smtp.client-ip=147.32.210.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fel.cvut.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fel.cvut.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fel.cvut.cz;
	s=felmail; t=1744971116;
	bh=zeCHnzdzJ7WmitTwfQHAhoQybBfjFWYJsTF/8AQiuMU=;
	h=From:To:Subject:Date:Cc:References:In-Reply-To:From;
	b=aDnJx9GivkN4u5LnT1JhjLexoVQP0b4DRGnzmi0kQzSY7Vtr6z0bDsxZCWsPx8/fM
	 +Z2twOCevxylBLCvUO4MWIXMoMbPIG66rKXMvMc17QXPsoXIunjmFvGGgPi4AXGdKm
	 vt5qwcqRs8UD+Tud/lZcQGjNebjUMLHIMu2iiPYx4jkt+5gUPWUvCaNPwlAtxX0TZT
	 xUgIF/oDqCn8txmnYU5L/HRvyE6IHwINeXcSr+P/t9vPh7mZ+GinfNum6qomlRZdO4
	 dg8reL5CjdfrzEe4Y3sGPJq3zj+Lt7ZC/N6ha2ysdodz8lbi+ACBFLiOzL2zLm3Xwf
	 I1UclYQUMT1nA==
Received: from smtpx.fel.cvut.cz (smtpx.feld.cvut.cz [147.32.210.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtpx1.feld.cvut.cz (Postfix) with ESMTPS id 80E2629F77;
	Fri, 18 Apr 2025 12:11:56 +0200 (CEST)
Received: from localhost (unknown [192.168.200.27])
	by smtpx.fel.cvut.cz (Postfix) with ESMTP id 771CC47ED2;
	Fri, 18 Apr 2025 12:11:56 +0200 (CEST)
X-Virus-Scanned: IMAP STYX AMAVIS
Authentication-Results: cerokez-250.feld.cvut.cz (amavis);
 dkim=pass (2048-bit key) header.d=fel.cvut.cz
Received: from smtpx.fel.cvut.cz ([192.168.200.2])
 by localhost (cerokez-250.feld.cvut.cz [192.168.200.27]) (amavis, port 10060)
 with ESMTP id Uid27AREP-RT; Fri, 18 Apr 2025 12:11:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fel.cvut.cz;
	s=felmail; t=1744971113;
	bh=zeCHnzdzJ7WmitTwfQHAhoQybBfjFWYJsTF/8AQiuMU=;
	h=From:To:Subject:Date:Cc:References:In-Reply-To:From;
	b=gPXHCgQzvVl3536KUg+b1HXPEGsNDy+IBAQzfzm4QLUj9W5SalAHTgdmCzHgJ+76G
	 oD+7ri1LuQKCDnJfHN5pH+yWzgveUI9GsPGEIqdd9XFhBJFtM8i9ooxM5AxoGp/J+b
	 9gW9drZKkgUpda/ris3lY7WrnG6cwqE0+MO7gNyjAyXdNC44vPaLmJrHT1CwLVZOJL
	 wnPGANKaUy+WOvSxG7trgNHgjXvclb0w64X1jkmxnmHSpcHfxnU0Dq40ipNQkCoaY0
	 wYhUuWE7JH0pZQvbyzxHF8ln/T/0BC4F06jOR3qC2cONtedepJKQcKaGpiIEL+qeqh
	 mVSvTWmTomJUg==
Received: from baree.pikron.com (static-84-242-78-234.bb.vodafone.cz [84.242.78.234])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pisa)
	by smtpx.fel.cvut.cz (Postfix) with ESMTPSA id 10FF247ED1;
	Fri, 18 Apr 2025 12:11:51 +0200 (CEST)
From: Pavel Pisa <pisa@fel.cvut.cz>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: CAN latency measuremet on AMD/Xilinx Zynq with PREEMP_RT - added threaded NAPI configuration
Date: Fri, 18 Apr 2025 12:12:22 +0200
User-Agent: KMail/1.9.10
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>,
 linux-rt-users@vger.kernel.org,
 Carsten Emde <c.emde@osadl.org>,
 linux-can@vger.kernel.org,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Jan Altenberg <Jan.Altenberg@osadl.org>,
 Pavel Hronek <hronepa1@fel.cvut.cz>
References: <202501281629.27139.pisa@fel.cvut.cz> <202503281304.47808.pisa@fel.cvut.cz> <20250417081254.EUqrBagT@linutronix.de>
In-Reply-To: <20250417081254.EUqrBagT@linutronix.de>
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
Message-Id: <202504181212.22699.pisa@fel.cvut.cz>

Hello Sebastian,

On Thursday 17 of April 2025 10:12:54 Sebastian Andrzej Siewior wrote:
> The IRQ thread should be limited to one CPU which is the same where the
> IRQ it itself is set to. I don't think that this done the NAPI thread
> automatically so it is probably free floating in the system.

you are right, I have added

  taskset -p 1 $pid

in can-latester-automation/device-scripts/set-can-threaded.sh

the effect can be seen after some days on the midnight
build and testing records.

Our system is small and simple and all CAN IRQs are
mapped to CPU0 now. But I have looked if I can find some
easy way how to find affinity of the IRQ thread from
/sys/class/net/canX and have not succeed a much.
There is queues/rx-0/rps_cpus but it is probably another
level.

There is easy way to find matching kernel driver task
and copy affinity to NAPI task. But I am not sure how
much naming match is guaranteed if some interfaces aliasing
etc. is in effect. I see next names now

  [irq/48-can2]
  [irq/49-can3]
  [irq/50-can4]
  [irq/51-can5]

and

 [napi/can2-19]
 [napi/can3-20]
 [napi/can4-21]
 [napi/can5-22]

One question to Oliver, in which thread/callaback context
is running kernel CAN gateway? I think that it does not
use separate task. Because with threaded NAPI it seems
that simple user space "gateway" (task to forward all
messages from one interface to another) has more stable
results than routing of messages directly in kernel.

Some side note, project implementing FlexCAN controller
emulation for QEMU (initial target sabrelite iMX6)
is moving forward. And as Bernhard Beschow submitted
iMX8 platform support into mainline QEMU, the FlexCAN
emulation support can be extended to it in future as well.
If somebody is interested then we can somehow join
resources. Foe example if some funding is found
I would discuse if the studnet working on the thesis
project finalized by submitting iMX6 support would
be willing to continue on iMX8 or other targets support.

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

