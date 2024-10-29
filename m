Return-Path: <linux-can+bounces-1820-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A189B42AF
	for <lists+linux-can@lfdr.de>; Tue, 29 Oct 2024 07:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C6B1283A2A
	for <lists+linux-can@lfdr.de>; Tue, 29 Oct 2024 06:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE2A2022C5;
	Tue, 29 Oct 2024 06:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UHroTNxA"
X-Original-To: linux-can@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6313B2010FE;
	Tue, 29 Oct 2024 06:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730185170; cv=none; b=fYNEQLcF4fX2lTMJJnpkl2njTtAM+xngMaSuOq+5HQMqAEqBxicud3e0+qKABIuYkPiUBrk4BOmQk84pp7JjH4YKuCKCemsDS0ozAVbZdvyDrXbVWxbv+WD6ihczTCrD7J7h5dnEfc6BniGDe9ULYJQf2qFssbR4eXyeDPLE13k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730185170; c=relaxed/simple;
	bh=grxhf0V40VHF/BaBFnLDQuku1Ix0uw8f395qXMXO/i4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H4S0WhikxSBnlW0T9gx53mLHrPRos/uGWdqmD2pAxmlQLfyh5vLLuv62ctDaiZKN7l33P3wENhfVYshKpAdKTS5jWv9R0bEOEZOO3JioHLfH5mgAR8F4CV8Yi/P6HQ96kJOicjfWSkD+PhV0jVz5LDHge0MgUbPC4n8rkrUJfLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=UHroTNxA; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49T6xCUp108247;
	Tue, 29 Oct 2024 01:59:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730185152;
	bh=usfQSp4ID09XPptN/k4NYA3l+YM/MoIxTl/d5ntjX44=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=UHroTNxAUbb0j3rhrwVhF8mP2c016TJuwPdcR6zlppwzPKT1+4zIB36qG5XoC5Sxq
	 M81GNxZimPdMZivQBHHdppafHGntLx2+nGvnErHGpsOPIYNyoZFoUd4mEi5TWxEZQ/
	 oDkOyUkDAJ2zBWfhuv0xHmJgg7LVc3mZppd2SvP4=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49T6xCUl024126
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 29 Oct 2024 01:59:12 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 29
 Oct 2024 01:59:11 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 29 Oct 2024 01:59:11 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.227.226])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49T6xAUf088949;
	Tue, 29 Oct 2024 01:59:11 -0500
Date: Tue, 29 Oct 2024 12:29:10 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Markus Schneider-Pargmann <msp@baylibre.com>
CC: Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Marc Kleine-Budde
	<mkl@pengutronix.de>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        "David S.
 Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, <linux-can@vger.kernel.org>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Matthias Schiffer
	<matthias.schiffer@ew.tq-group.com>,
        Vishal Mahaveer <vishalm@ti.com>, Kevin
 Hilman <khilman@baylibre.com>,
        Simon Horman <horms@kernel.org>
Subject: Re: [PATCH v5 7/9] arm64: dts: ti: k3-am62: Mark mcu_mcan0/1 as
 wakeup-source
Message-ID: <20241029065910.yqzec4ileedx32ex@lcpd911>
References: <20241028-topic-mcan-wakeup-source-v6-12-v5-0-33edc0aba629@baylibre.com>
 <20241028-topic-mcan-wakeup-source-v6-12-v5-7-33edc0aba629@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241028-topic-mcan-wakeup-source-v6-12-v5-7-33edc0aba629@baylibre.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Oct 28, 2024 at 18:38:13 +0100, Markus Schneider-Pargmann wrote:
> mcu_mcan0 and mcu_mcan1 can be wakeup sources for the SoC. Mark them
> accordingly in the devicetree.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---

Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

