Return-Path: <linux-can+bounces-7723-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJBXHtguGGpwfggAu9opvQ
	(envelope-from <linux-can+bounces-7723-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 28 May 2026 14:02:32 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 171105F1C68
	for <lists+linux-can@lfdr.de>; Thu, 28 May 2026 14:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4954D3131F58
	for <lists+linux-can@lfdr.de>; Thu, 28 May 2026 11:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFFF3C5526;
	Thu, 28 May 2026 11:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fel.cvut.cz header.i=@fel.cvut.cz header.b="YNTGvdoq"
X-Original-To: linux-can@vger.kernel.org
Received: from smtpx.fel.cvut.cz (smtpx.feld.cvut.cz [147.32.210.153])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDA23CAE63
	for <linux-can@vger.kernel.org>; Thu, 28 May 2026 11:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=147.32.210.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779969309; cv=none; b=bX5NvfZYzFaqoSGX/Ke2yL9thaZUnZtZ42uBAsGTGk0KmEzuqB8HdufNVVCtVPaSmzcrKZbZkvjxNiSn1zGvIp0AcEkLdFPJaD6R8Xi7yUxZzccbrrSOgeW8ZjB51g270MbX6qgcH+h8tNCZzvN+y9Fa2TntAF6IoiB0bYBdW70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779969309; c=relaxed/simple;
	bh=0At4YU1zGGhv4Nu3YZRacGtb5pHz23n57C0fHaqYEHU=;
	h=From:To:Subject:Date:Cc:References:In-Reply-To:MIME-Version:
	 Content-Type:Content-Disposition:Message-Id; b=rKwRdyi7GZP+cw62c8n48a2XqwkCA6KBHy5M7zfjWyQZpSHUnnRIkSX+DW/bgpqVNdTXO7FxLqa/4DJX5RNAUrAhzWLx9ZmByY+jYpK4CJZwVJgzfMmIAgqN0+BJaGtHQoexUtEshuCFgOiKz6AhW9fY9MQzcx4H+Fe7qYaxexM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fel.cvut.cz; spf=pass smtp.mailfrom=fel.cvut.cz; dkim=pass (2048-bit key) header.d=fel.cvut.cz header.i=@fel.cvut.cz header.b=YNTGvdoq; arc=none smtp.client-ip=147.32.210.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fel.cvut.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fel.cvut.cz
Received: from localhost (unknown [192.168.200.27])
	by smtpx.fel.cvut.cz (Postfix) with ESMTP id B086812203;
	Thu, 28 May 2026 13:55:02 +0200 (CEST)
X-Virus-Scanned: IMAP STYX AMAVIS
Authentication-Results: cerokez-250.feld.cvut.cz (amavis);
 dkim=pass (2048-bit key) header.d=fel.cvut.cz
Received: from smtpx.fel.cvut.cz ([192.168.200.2])
 by localhost (cerokez-250.feld.cvut.cz [192.168.200.27]) (amavis, port 10060)
 with ESMTP id iwBrw4awZ_wn; Thu, 28 May 2026 13:55:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fel.cvut.cz;
	s=felmail; t=1779968891;
	bh=GPh3LNaQ2i/wzbh5HH3LftNFiXUcK4Sg3CA/5ASG9Tc=;
	h=From:To:Subject:Date:Cc:References:In-Reply-To:From;
	b=YNTGvdoqdoAkDGXTQuAHoBwfixseZ2NA2D7vSaZPP7mLJx1kSmqkl9RjPkB/2zji1
	 mEYK/Ya911eVH1maqKCpBI4YAAZWudk0YahCsCJCC1J62ZcXR14gB9SYGiN2nOwKs/
	 lrC86rBnJ+61FmgSnkLGLxzOWFqiu066ECHKA26nSs3z5D/2PN1K0FSmZK8YqBJXDj
	 1HpwI7PRuhkvkUdPYuArgcXpYpkFHftxMiBeHR8x19IF8jQyfFm8tciF9Dj1keVFAI
	 Xm9Ml2TDBATdw8ru7QP4C3P7ymY2INg9vuY3/phWOgXru1mf5IPYEpLALz0vVb8wq0
	 Rd+ZgTsWLZi1w==
Received: from [147.32.86.150] (unknown [147.32.86.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pisa)
	by smtpx.fel.cvut.cz (Postfix) with ESMTPSA id 1516012097;
	Thu, 28 May 2026 13:48:11 +0200 (CEST)
From: Pavel Pisa <pisa@fel.cvut.cz>
To: "Sascha Hauer" <s.hauer@pengutronix.de>,
 "Marc Kleine-Budde" <mkl@pengutronix.de>,
 Andrey VOLKOV <andrey@volkov.fr>
Subject: Re: [PATCH v3 0/7] hw/arm/sabrelite: Add FlexCAN support
Date: Thu, 28 May 2026 13:48:10 +0200
User-Agent: KMail/1.9.10
Cc: "Bernhard Beschow" <shentey@gmail.com>,
 =?utf-8?q?Maty=C3=A1=C5=A1_Bobek?= <matyas.bobek@gmail.com>,
 "Matyas Bobek" <bobekmat@fel.cvut.cz>,
 qemu-devel@nongnu.org,
 qemu-arm@nongnu.org,
 "Oliver Hartkopp" <socketcan@hartkopp.net>,
 "Nikita Ostrenkov" <n.ostrenkov@gmail.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 "Peter Maydell" <peter.maydell@linaro.org>,
 linux-can@vger.kernel.org,
 "David Jander" <david@protonic.nl>
References: <E1wSWUo-00000003ZfC-2dBa@pty.whiteo.stw.pengutronix.de>
In-Reply-To: <E1wSWUo-00000003ZfC-2dBa@pty.whiteo.stw.pengutronix.de>
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
Message-Id: <202605281348.10786.pisa@fel.cvut.cz>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[fel.cvut.cz,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[fel.cvut.cz:s=felmail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7723-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[cvut.cz:query timed out];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,fel.cvut.cz,nongnu.org,hartkopp.net,redhat.com,linaro.org,vger.kernel.org,protonic.nl];
	DKIM_TRACE(0.00)[fel.cvut.cz:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pisa@fel.cvut.cz,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,fel.cvut.cz:mid,fel.cvut.cz:dkim,cvut.cz:url,cvut.cz:email]
X-Rspamd-Queue-Id: 171105F1C68
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello All,

On Thursday 28 of May 2026 10:53:42 Sascha Hauer wrote:
> On 2026-05-27 20:38, Marc Kleine-Budde wrote:
> > On 27.05.2026 18:25:37, Andrei VOLKOV wrote:
> > > As the original author, I have no objection to reusing (my part of) the
> > > header under GPL-2.0-or-later. The reason it was not done that way in
> > > 2005/2006 is simple: only GPLv2 existed at the time.

thanks everybody for the approval to reticence
as GPL-2.0 and latter.

To Andrey Volkov, excuse for using inappropriate address,
but the questionable copyright situation has been raised
and was main problem even for the v2 series version from
March and it seems not to move forward from that time
so I have tried to find some address on which you could
respond as the original author and I expect that your
original address at varma-el.com is no longer valid.

I think/remeber that there is no other request for changes
in this round of review. May it be, the additional
authors can be added to the headers code excerpt.

But generally I approve this FlexCAN support
to be merged into QEMU master as CAN subsystem
co-maintainer and I would be happy merge is proceed
by somebody with commit right. Directly, directly
with addition of Andrey Volkov and Sascha Hauer to
the last line of notice in

hw/net/can/flexcan_regs.h

and

include/hw/net/flexcan.h

+/**
+ * These macros ware originally written for the Linux kernel
+ * by Andrey Volkov, Sascha Hauer and Marc Kleine-Budde.
+ */

or Matyas Bobek can modify the line and send
v4 version.

I would be happy if the code is merged, and it can be the base
for some future project to extend support to iMX8
FlexCAN 3. Maybe I can find a student or somebody
provides resources, time, GSoC funding, or some other option
to attract some students to take the opportunity
to work on a project and learn something as a summer job...
There are a lot more interesting controllers to support,
I (with Michal Lenc) lead RTEMS D-CAN driver support
GSoC for AM335x this year, QEMU support would be nice
for CI there, we would continue on the PolarFire driver
for RTEMS, one day, matching QEMU support would help.
Long-term, multiqueue and priority for Linux would be worth
solving; results on CTU CAN FD on RTEMS are exceptional.
There are plenty of opportunities to have fun.

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

