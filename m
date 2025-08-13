Return-Path: <linux-can+bounces-4223-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24193B2440A
	for <lists+linux-can@lfdr.de>; Wed, 13 Aug 2025 10:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94EA31B65B16
	for <lists+linux-can@lfdr.de>; Wed, 13 Aug 2025 08:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E112ED85F;
	Wed, 13 Aug 2025 08:18:02 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E432D190C
	for <linux-can@vger.kernel.org>; Wed, 13 Aug 2025 08:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755073082; cv=none; b=lBFgNsnhPRgpGn0+zfqKwVnhdlkGLGUnzX/Z6cYOrq3AgX70h9RVvNfABKXJYL5iiIk6hJ6q7+A/oiPs0H4jIVreCvnqJaH0VVgJK0sfBtwsuKL1AOyTIevX50WYKc5jTntss+xfY9+eWAsZvHLQ8Xzt8W63lHkOtnOLsV+vIuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755073082; c=relaxed/simple;
	bh=abEsGjaUdk6F6Crnm8dR4Aqi1CyjDey/R/XrpgG3A7c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U49Bv8A+1k2tCaLMlO7e07fvG2ZdHYMjElmM/7y9GVjgNOuhGe0p8TdpuevELu9komaFAwPy39iWx3KTS7b0kksjDV/fNvljJ56Cx5sQAwiiLe7DlP8AfetnFqpy3QkotRuOirOnKbIUnYH/UefoStlGXQ/duqWjsscpxu8kg7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1um6gB-00036X-0G; Wed, 13 Aug 2025 10:17:51 +0200
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1um6g9-0003nI-1E;
	Wed, 13 Aug 2025 10:17:49 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1um6g9-0004i6-0x;
	Wed, 13 Aug 2025 10:17:49 +0200
Message-ID: <239711fdd1eb6f79a89af7396ef7eb60f485ec12.camel@pengutronix.de>
Subject: Re: [PATCH 0/7] can: m_can: fix pm_runtime and CAN state handling
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Chandrasekar Ramakrishnan
 <rcsekar@samsung.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Patrik
 Flykt <patrik.flykt@linux.intel.com>, Dong Aisheng <b29396@freescale.com>,
 Fengguang Wu <fengguang.wu@intel.com>, Varka Bhadram
 <varkabhadram@gmail.com>, Wu Bo <wubo.oduw@gmail.com>, Markus
 Schneider-Pargmann <msp@baylibre.com>
Cc: linux-kernel@vger.kernel.org, kernel@pengutronix.de, 
	linux-can@vger.kernel.org
Date: Wed, 13 Aug 2025 10:17:49 +0200
In-Reply-To: <20250812-m_can-fix-state-handling-v1-0-b739e06c0a3b@pengutronix.de>
References: 
	<20250812-m_can-fix-state-handling-v1-0-b739e06c0a3b@pengutronix.de>
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
> The first patch fixes a pm_runtime imbalance in the m_can_platform
> driver.
>=20
> The rest of this series fixes the CAN state handling in the m_can
> driver:
> - add the missing state transition from from Error Warning back to
>   Error Active (Patches 2+3)
> - address the fact that in some SoCs (observed on the STM32MP15) the
>   M_CAN IP core keeps the CAN state and CAN error counters over an
>   internal reset cycle. Set the correct CAN state during ifup and
>   system resume (Patches 4+5)
> - add support for optional shared external reset, to properly reset
>   the IP core (Patches 6+7)

Should this declare a dependency on
https://lore.kernel.org/all/20250807-stm32mp15-m_can-add-reset-v2-1-f69ebbf=
ced1f@pengutronix.de/
or is that already merged?

regards
Philipp

