Return-Path: <linux-can+bounces-1161-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4272594A272
	for <lists+linux-can@lfdr.de>; Wed,  7 Aug 2024 10:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 741BA1C21714
	for <lists+linux-can@lfdr.de>; Wed,  7 Aug 2024 08:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914201C57B0;
	Wed,  7 Aug 2024 08:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="N4RWhCQI";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="qu+uEfPh"
X-Original-To: linux-can@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12CF1B86DC;
	Wed,  7 Aug 2024 08:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723018271; cv=none; b=Qt/kljc1KieLDiSRCBR86AWbw/hXmMfsMjy7fKB73kcyfrOmHCwtpM/WuztaTlwpDv6ItETFAFGYBD6jC7CTJyHiHiw0gpM9bbruw53OIkgzdi1QHF3fQTnsItPqGD9tobW1wApL8ibEoDd7Y0+2GQbmrBnK5agznk1cHPPDV8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723018271; c=relaxed/simple;
	bh=+yCVqk49ajOkZuHoI/zV3gI0V8ytHOEMSm8ggTK9hgg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QfrEu4ry/G8Qc/OAn8+RYNk6I1H0BGGgcyCxfXHSyPhFpVouWXC8x7VUVmROxLkF45hHw42jN6NnUYvCuKcXSHAFZr3i8Rao+UoWVkU2v1l0fftq7Pa2TXZqhog9Hi1f3GGJCvO0s3C0TKn0YlI9adD9ThNHweF90pSz7aPpHbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=N4RWhCQI; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=qu+uEfPh reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1723018267; x=1754554267;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=4OeGaUxz8kjHxLe9YSzCVy9UlVICeIgRRXpVZVS9784=;
  b=N4RWhCQIy1AHoANk1nWLHWsmbMtg6vJ14cQtzGVuCBPzCilS2g1eeYoG
   sNI+81EAtject6yDlrfUN1uU18ubGaQDTA81jqngC9UDbs6wAseDS10Xy
   8w/MKYFVXsGtKqqLMxYfZ9HwGFTJt52m6ECQjEeFwToHtSGIk9wqEHp5N
   aCjmM7FMHrZRL84cx9bmV+nQ3u9ozWfykzbY94QdveS+38H3KScu4ZQdF
   lLiUhOernnj8epdCYEfIP0eVBfiMKT5baT4YJUdnXQQ+XcahzAGcw8Ji9
   4mXT+4sVmQc9Ity0MqYb7k9bVw0TPCoQsg8bGAeay2Q80em3x2Z868sME
   g==;
X-CSE-ConnectionGUID: vL4BY8/bSfSSK4VULycfvw==
X-CSE-MsgGUID: 9EPCPu3QQkClBkU4cibRQg==
X-IronPort-AV: E=Sophos;i="6.09,269,1716242400"; 
   d="scan'208";a="38285481"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 07 Aug 2024 10:11:03 +0200
X-CheckPoint: {66B32C17-19-CC8A42C9-EEB26961}
X-MAIL-CPID: 927B592D4A3966CC78C5FCD753514530_2
X-Control-Analysis: str=0001.0A782F22.66B32C17.01D5,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 368AF160D5D;
	Wed,  7 Aug 2024 10:10:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1723018259;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=4OeGaUxz8kjHxLe9YSzCVy9UlVICeIgRRXpVZVS9784=;
	b=qu+uEfPh2Zdr90bFwJzD1H1nRYjuh71QbswHZyNtG/cT+gabk23qBoiOsU8gA7gE9wLS+h
	/zB1mDkqQo/PjqQcpxXIpmMRIOW8BYEPWtEDOZz5vj+v7wip3cEid6c80RJcYUtSCqkcmU
	Rm8sPmyRme2/iPX/Jda6cglErzMfJbf3/LbTkw8D9g2aNIGgQMqzGFvbGokpXy9Fsf6CTg
	stErBjfm5UExCMGaRzhNN3k1V2XLdmzS5RxBmXEfyxIKJYOoJJMfK+ae5Q9/JQsIr125i2
	DaHUQg5zx+3IeYr+GRXVizwJMur+gkGkhmt0mIBXN3l3YamxphKV6FgR39Mi6Q==
Message-ID: <ab4b649b32ca9a1287e5d1dc3629557975b7152f.camel@ew.tq-group.com>
Subject: Re: [PATCH v2 0/7] can: m_can: Fix polling and other issues
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Linux regression tracking <regressions@leemhuis.info>, 
 linux-can@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,  Chandrasekar Ramakrishnan
 <rcsekar@samsung.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Vincent
 Mailhol <mailhol.vincent@wanadoo.fr>, "David S.Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,  Martin
 =?ISO-8859-1?Q?Hundeb=F8ll?= <martin@geanix.com>, Judith Mendez
 <jm@ti.com>, Tony Lindgren <tony@atomide.com>,  Simon Horman
 <horms@kernel.org>, linux@ew.tq-group.com
Date: Wed, 07 Aug 2024 10:10:56 +0200
In-Reply-To: <20240805183047.305630-1-msp@baylibre.com>
References: <20240805183047.305630-1-msp@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3

On Mon, 2024-08-05 at 20:30 +0200, Markus Schneider-Pargmann wrote:
> Hi everyone,
>=20
> these are a number of fixes for m_can that fix polling mode and some
> other issues that I saw while working on the code.
>=20
> Any testing and review is appreciated.

Hi Markus,

thanks for the series. I gave it a quick spin on the interrupt-less AM62x C=
AN, and found that it
fixes the deadlock I reported and makes CAN usable again.

For the whole series:

Tested-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>




>=20
> Base
> ----
> v6.11-rc1
>=20
> Changes in v2
> -------------
>  - Fixed one multiline comment
>  - Rebased to v6.11-rc1
>=20
> Previous versions
> -----------------
>  v1: https://lore.kernel.org/lkml/20240726195944.2414812-1-msp@baylibre.c=
om/
>=20
> Best,
> Markus
>=20
> Markus Schneider-Pargmann (7):
>   can: m_can: Reset coalescing during suspend/resume
>   can: m_can: Remove coalesing disable in isr during suspend
>   can: m_can: Remove m_can_rx_peripheral indirection
>   can: m_can: Do not cancel timer from within timer
>   can: m_can: disable_all_interrupts, not clear active_interrupts
>   can: m_can: Reset cached active_interrupts on start
>   can: m_can: Limit coalescing to peripheral instances
>=20
>  drivers/net/can/m_can/m_can.c | 111 ++++++++++++++++++++--------------
>  1 file changed, 66 insertions(+), 45 deletions(-)
>=20

--=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
https://www.tq-group.com/

