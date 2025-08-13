Return-Path: <linux-can+bounces-4224-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A02B24427
	for <lists+linux-can@lfdr.de>; Wed, 13 Aug 2025 10:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECE587282A1
	for <lists+linux-can@lfdr.de>; Wed, 13 Aug 2025 08:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50372EE5F0;
	Wed, 13 Aug 2025 08:18:02 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438AE2ED178
	for <linux-can@vger.kernel.org>; Wed, 13 Aug 2025 08:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755073082; cv=none; b=p5RF2udSNhXPW1rM9m7LNRrIndcWGbdtjQc9K9kGyP4xUYUMNiguzboPAUjQR4qbzEyO6/bGAy4HAzPOfJCU4St2gsitZbAN78rIWxLIKCljN9NfECin2ARNjHepHoHgb2KCHiShYNqYNUO8VRjTzp2EbdHRbTI/vhrrZbVPlMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755073082; c=relaxed/simple;
	bh=BOQm1gfTRn5piARkr7daF/P0HADwbUi8oBh5V8Qy9lk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HKl7i45LlFHuFpAfe1rOHGSGTGNz4283gGIDDcpWg0ecuTWA6/LnAFTkQhh9HkE0U35UvmrxRhyKouXyqQJTA2JiBtNKJwrd40hJPbQaHH+Kx8Yi7K61h26vXiDkEa6T+JYGZAfeQonOm7ptQwRRqQfBOsjdX2dMkLVgx8vMrVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1um6gD-000389-E7; Wed, 13 Aug 2025 10:17:53 +0200
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1um6gC-0003nM-2z;
	Wed, 13 Aug 2025 10:17:52 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1um6gC-0004ib-2k;
	Wed, 13 Aug 2025 10:17:52 +0200
Message-ID: <6f138742fe92b6d26f0cd87d3c57e141d63c6f3b.camel@pengutronix.de>
Subject: Re: [PATCH 7/7] can: m_can: add optional support for reset
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Chandrasekar Ramakrishnan
 <rcsekar@samsung.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Patrik
 Flykt <patrik.flykt@linux.intel.com>, Dong Aisheng <b29396@freescale.com>,
 Fengguang Wu <fengguang.wu@intel.com>, Varka Bhadram
 <varkabhadram@gmail.com>, Wu Bo <wubo.oduw@gmail.com>, Markus
 Schneider-Pargmann <msp@baylibre.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel@pengutronix.de
Date: Wed, 13 Aug 2025 10:17:52 +0200
In-Reply-To: <20250812-m_can-fix-state-handling-v1-7-b739e06c0a3b@pengutronix.de>
References: 
	<20250812-m_can-fix-state-handling-v1-0-b739e06c0a3b@pengutronix.de>
	 <20250812-m_can-fix-state-handling-v1-7-b739e06c0a3b@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

On Di, 2025-08-12 at 19:36 +0200, Marc Kleine-Budde wrote:
> In some SoCs (observed on the STM32MP15) the M_CAN IP core keeps the
> CAN state and CAN error counters over an internal reset cycle. The
> STM32MP15 SoC provides an external reset, which is shared between both
> M_CAN cores.
>=20
> Add support for an optional external reset. Take care of shared
> resets, de-assert reset during the probe phase in
> m_can_class_register() and while the interface is up, assert the reset
> otherwise.
>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  drivers/net/can/m_can/m_can.c | 26 +++++++++++++++++++++++---
>  drivers/net/can/m_can/m_can.h |  1 +
>  2 files changed, 24 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.=
c
> index c24ea0e5599f..0a6d4b523c33 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -23,6 +23,7 @@
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/reset.h>
> =20
>  #include "m_can.h"
> =20
> @@ -1833,6 +1834,7 @@ static int m_can_close(struct net_device *dev)
> =20
>  	close_candev(dev);
> =20
> +	reset_control_assert(cdev->rsts);

Nitpick, "rsts" as in plural?=20

[...]
> @@ -2462,8 +2478,10 @@ int m_can_class_register(struct m_can_classdev *cd=
ev)
>  		 KBUILD_MODNAME, cdev->net->irq, cdev->version);
> =20
>  	/* Probe finished
> -	 * Stop clocks. They will be reactivated once the M_CAN device is opene=
d
> +	 * Assert rest and stop clocks.

Typo, s/rest/reset/.

Otherwise,


Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp

