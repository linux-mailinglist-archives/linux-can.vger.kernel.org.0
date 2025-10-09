Return-Path: <linux-can+bounces-5118-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F478BC8064
	for <lists+linux-can@lfdr.de>; Thu, 09 Oct 2025 10:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0E224352B16
	for <lists+linux-can@lfdr.de>; Thu,  9 Oct 2025 08:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050892BE653;
	Thu,  9 Oct 2025 08:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hzWOPSwI"
X-Original-To: linux-can@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D77827B335;
	Thu,  9 Oct 2025 08:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759998143; cv=none; b=BWpukvMNtKXz0itS8CYDdANCVH2pZyXq+PG3nBrus0E9auS2Jy3tgOBy4hNUBhfmbi4hY4ZMPrCdXCR0i4QuXLfdg0a3wPH3Cnf3TjyK/kHdsigO+HYmr7x02GyrlRnWxXHBmp5XUlMcAZyQD0GyEL+CmoOdtN3bElmN6Z6RGcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759998143; c=relaxed/simple;
	bh=d4nMhRJRgVKHqOxp4Cv3ylWk/Rf2n4odm3asg7xrZdw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tGIIKzAaE/7bqSZjCBVa46WurvCo1B7H9jpXIjaP8NY2oL6P303pYYfFeJSYJmHE0U4lgIufgTpDAJBULwJvYbDcNmwfBicSkPlNkWnMdPuKutrYPukqRB7u7ltlGVQ0dkkJh7YcWwOfKHOAba3wLfNyErbWECWiXopmD4XZByw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hzWOPSwI; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5998LurT419248;
	Thu, 9 Oct 2025 03:21:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1759998116;
	bh=3zR3JLgcX2MJPGpymvMdyoK4s2pHVkh24mNeHETQpUM=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=hzWOPSwIxJAHyz7aRUcb2KxYgRC7rtVcOYke/Em+AdDY5j1MUU9cVoYZcN39moTmi
	 kueGt3T/7Wk66+XSeEkT+53LH5jkUkJp+fV+zhqPZ2h7wGKopmQDH5SF2o6HXklECa
	 /dgVIZG15VqrydFvHP/M09EcI5d/PiJTgRvSWaT8=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5998LuZq1290780
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 9 Oct 2025 03:21:56 -0500
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 9
 Oct 2025 03:21:55 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 9 Oct 2025 03:21:55 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5998Lsbo3921630;
	Thu, 9 Oct 2025 03:21:55 -0500
Date: Thu, 9 Oct 2025 13:51:54 +0530
From: Dhruva Gole <d-gole@ti.com>
To: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
CC: Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Marc Kleine-Budde
	<mkl@pengutronix.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vincent Mailhol
	<mailhol@kernel.org>,
        Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman
	<khilman@baylibre.com>,
        Sebin Francis <sebin.francis@ti.com>,
        Kendall Willis
	<k-willis@ti.com>, Akashdeep Kaur <a-kaur@ti.com>,
        Simon Horman
	<horms@kernel.org>, <linux-can@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 1/4] dt-bindings: can: m_can: Add wakeup properties
Message-ID: <20251009082154.imhray7thsp35eda@lcpd911>
References: <20251001-topic-mcan-wakeup-source-v6-12-v10-0-4ab508ac5d1e@baylibre.com>
 <20251001-topic-mcan-wakeup-source-v6-12-v10-1-4ab508ac5d1e@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251001-topic-mcan-wakeup-source-v6-12-v10-1-4ab508ac5d1e@baylibre.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Oct 01, 2025 at 16:30:19 +0200, Markus Schneider-Pargmann (TI.com) wrote:
> The pins associated with m_can have to have a special configuration to
> be able to wakeup the SoC from some system states. This configuration is
> described in the wakeup pinctrl state while the default state describes
> the default configuration. Also add the sleep state which is already in
> use by some devicetrees.
> 
> Also m_can can be a wakeup-source if capable of wakeup.
> 
> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
> ---

Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

