Return-Path: <linux-can+bounces-4476-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E56B436A7
	for <lists+linux-can@lfdr.de>; Thu,  4 Sep 2025 11:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8AD13B409C
	for <lists+linux-can@lfdr.de>; Thu,  4 Sep 2025 09:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ABC32D77E7;
	Thu,  4 Sep 2025 09:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RVSBI4qi"
X-Original-To: linux-can@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DF12C2343;
	Thu,  4 Sep 2025 09:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756976908; cv=none; b=tW/YXzNyY44/SoQaoGQn5OSu0tffL+pfzUm+VuKaupScP/GGxS2pXcYqpDkEV5vUE4WanvEEBHKdbZyEis3YsrIQz+2Ai9crYKmmfB2EF9AcAE/iifQkncKazSLZSDj9rAKnBdH47DQ0GAhDp2ms+n5Y2NvRwnAx9swnUylZkrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756976908; c=relaxed/simple;
	bh=znHciAzO/yzlymIkccfnvZC3KRxuQndHbYL5aRt7RX8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o1rX6gcE5gUIRZ8lDNBM9KW4pkxhtzyM5Af6OMJwr1Q4kPzCRmOSr7XBNs95n196Sv4DMPLbtSTuslvZ/bXCsOsaMkk3KWmLPlEte4Tz+LBaXPhBbkqTrZxUlKUPgjZ/nSdwb3ZUynBVD17yWq/fH+424Rm0t5hTUdFTTXZrsJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=RVSBI4qi; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58498G0E3436146;
	Thu, 4 Sep 2025 04:08:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756976896;
	bh=IjjhoKB/ImG3OuG9t915vQoJ+GWmj1wL2LkncRTXzfI=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=RVSBI4qiPm40Xgj7fvM8dVo18wh+hMra0ZuQnURCxIBR2ms0vEg4/CH9XD2NTFJ0K
	 r7SuhHv99WP8ZBTZ6XOGI4P469HycYRgllky85MLxtCFJ/WOOqKVcbrUGxmKG3LYyd
	 5N7wbHpXNwGbtZWIgPQaB2QmFsreLLbAYRNBdp+4=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58498FtS3705362
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 4 Sep 2025 04:08:16 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 4
 Sep 2025 04:08:15 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 4 Sep 2025 04:08:15 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58498Epc3022684;
	Thu, 4 Sep 2025 04:08:15 -0500
Date: Thu, 4 Sep 2025 14:38:14 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Markus Schneider-Pargmann <msp@baylibre.com>
CC: Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Marc Kleine-Budde
	<mkl@pengutronix.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Vishal Mahaveer
	<vishalm@ti.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Sebin Francis
	<sebin.francis@ti.com>,
        Kendall Willis <k-willis@ti.com>, Akashdeep Kaur
	<a-kaur@ti.com>,
        Simon Horman <horms@kernel.org>,
        Vincent MAILHOL
	<mailhol.vincent@wanadoo.fr>,
        <linux-can@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 3/4] can: m_can: Return ERR_PTR on error in allocation
Message-ID: <20250904090814.nsphr76ixnc4mck6@lcpd911>
References: <20250820-topic-mcan-wakeup-source-v6-12-v9-0-0ac13f2ddd67@baylibre.com>
 <20250820-topic-mcan-wakeup-source-v6-12-v9-3-0ac13f2ddd67@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250820-topic-mcan-wakeup-source-v6-12-v9-3-0ac13f2ddd67@baylibre.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Aug 20, 2025 at 14:42:27 +0200, Markus Schneider-Pargmann wrote:
> We have more detailed error values available, return them in the core
> driver and the calling drivers to return proper errors to callers.
> 
> Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---
>  drivers/net/can/m_can/m_can.c          | 6 +++---
>  drivers/net/can/m_can/m_can_pci.c      | 4 ++--
>  drivers/net/can/m_can/m_can_platform.c | 4 ++--
>  drivers/net/can/m_can/tcan4x5x-core.c  | 4 ++--
>  4 files changed, 9 insertions(+), 9 deletions(-)
> 

Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

