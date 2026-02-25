Return-Path: <linux-can+bounces-6623-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AASOBGPfnmmCXgQAu9opvQ
	(envelope-from <linux-can+bounces-6623-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 25 Feb 2026 12:39:15 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A1918196AA3
	for <lists+linux-can@lfdr.de>; Wed, 25 Feb 2026 12:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5DBF303EAB7
	for <lists+linux-can@lfdr.de>; Wed, 25 Feb 2026 11:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF93E395D8C;
	Wed, 25 Feb 2026 11:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="aXvbtisV";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="aXvbtisV"
X-Original-To: linux-can@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023099.outbound.protection.outlook.com [40.107.162.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB85395243;
	Wed, 25 Feb 2026 11:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.99
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772019296; cv=fail; b=ftbS4YSyIRB09/T+7wdZsrWNY1oHFGDYHm0rFBXQZyxLYivQp743WuzM8p4lGb+brwqxov8uvcw4u8vpjz+5WEp95YOWjIifQHyEoY2efvACbsesxH1EXEfm0aNHHjPEDSfPo7Swh5PH0cnt8tLu5yV0Pg8gPyG19ukqux/FB08=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772019296; c=relaxed/simple;
	bh=gIoxlHu7rlzYmhBeBqU5S+sw7hNrppAAqkVqt71hd3s=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Ywm0uMAj7PrCo3polGm2fu6Eu4kz2HrrHi/Fg4akgJeYyaKXDk+FgYL/bkrRpZ2Y0pAS3zE94YHBZKqSdrUeE6VJj06g2Eu1ds1jJxBetblbiWj8lkhCGdAiTXAsnPknhbJLZvu9fQ8GZ6J9WkmrANW5YzbhRBBkMmy4PcRNsHw=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=aXvbtisV; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=aXvbtisV; arc=fail smtp.client-ip=40.107.162.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=LrALs/XXdOVqI+jnEVQW54+0GMavaSlIBLC4rCDe/8bLdTUln+x6layPyyapPN5jdkW2EZcij1qToHbZYmS2eVLXGslIRMul9EVGjzDRBI0tZMNG7oVINyGYYPbsi8p5R8peAk35yZre27l+5Osn2kRW9ShWy3aHpJx9VoJlYxv+oFA9iFo2l56Em5OrLWwD5RiyXTvP2eRAHP0tpTRCb1u2E4xqU7qtKUv+bGPGA1tzRJPTvG/ONgOzH1JwnWkbjW1eaIPzOIN+q1SkPL7JTtX7oyXLg91i+/8enCMDg4p9/nqK58V/pAmVO2SMGPrJV3JnN2ZstN4UjeYvq8poWQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nzAyXBOs8pV58MkKLE2L8RWopmmcBRu6qI84jVDHazs=;
 b=mnvn8o+qu648e+fG28RmlDPawwYlViUbwm1jDIbM/tXurH0V0F25pnIjOrF8dyuke5ylGNIM+ZzwYbE9AD3+L7cZtGd/tJU8cuV5YusFtCEnVIHHLXs1ALkxL1NR3vAn00YxrMpfYGZk9Dy/g8zlxHEekASoUKNt7p8BVSf7kXMTldtwrBpGM8loYtIWnjGW/7kl5P+Knskz3LBDhW6Fm//FDMi5WkHH0EdPrA/6dllAnDlXvzVSSfDP0Qq3Vf+U5VleESj+8y4tMn14yVcjCXAaou5wMG15CYrYGZETikEwqWCpDXGpwUvnYeRvz6nykNzT6L33rBelCTG5LxHczw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=softfail (sender ip
 is 52.17.62.50) smtp.rcpttodomain=atomide.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nzAyXBOs8pV58MkKLE2L8RWopmmcBRu6qI84jVDHazs=;
 b=aXvbtisVL10+fC5EbCDj+Mj95ZdbVV2/cEM9G2+QliDK9X9cFXx8crSLSmM8d1HATdfHri+6dCTBpXb7HiW7aNIwhQyfVyfcaxuXLwez2Aix1GJSFIMqymGE+xfacGCaM2NcIbDrStVMmTCL2JTzpFdZ3gaDw1Ffsvul+glIbfs=
Received: from AM9P192CA0007.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:21d::12)
 by GV2PR04MB11421.eurprd04.prod.outlook.com (2603:10a6:150:2ae::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 11:34:45 +0000
Received: from AMS1EPF0000004D.eurprd04.prod.outlook.com
 (2603:10a6:20b:21d:cafe::af) by AM9P192CA0007.outlook.office365.com
 (2603:10a6:20b:21d::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.23 via Frontend Transport; Wed,
 25 Feb 2026 11:34:19 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 solid-run.com discourages use of 52.17.62.50 as permitted sender)
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 AMS1EPF0000004D.mail.protection.outlook.com (10.167.16.138) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.12
 via Frontend Transport; Wed, 25 Feb 2026 11:34:45 +0000
Received: from emails-1969853-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-5-66.eu-west-1.compute.internal [10.20.5.66])
	by mta-outgoing-dlp-670-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id A26828058D;
	Wed, 25 Feb 2026 11:34:44 +0000 (UTC)
X-Mailbox-Line: From b'josua@solid-run.com' Wed Feb 25 11:34:36 2026
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h2tIiryOWwTWqFUXwLB7a2shkRRYZbwsDWHPj1O21QmqK7MWYcuNpq+6nTN5yVOfMT7vyqHxzCiT3Bsofwe+jRNbtJyHP66lfKEd0H8W9N7obglltYfN+btN38eIpZ9Pc007Bea6squowx7tmk+jI7T6LRwhHCrA0oasD0trSpijqTP2ILmaDK+qkCkfM6x+5uMLl5wlc+6+Cr2j+hrDm1cRFyM2N6vpO4UOLmKZLdrzR1r+R/FdJTCD0M76s9Uv07orhTWOfGVC7AdmgKkJCWhGDxQ1+sKm3NapFVjsRkiBTBeX0TMLDTzj7QBVVBeg14jQxPyBZmscTsd33Tc3SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nzAyXBOs8pV58MkKLE2L8RWopmmcBRu6qI84jVDHazs=;
 b=jiCNca8s4NR5/sZbE6g0FksrSzp8xPS2ynEhEQ0NrYAnDGBAeOa9Yo6qIj54XUulWLMauYDsT91rcVpHElMsD2Yj65d5CkGMDb69P2E+l6ZWbPHo0uVOoUswXGYx1JosmZ1Gz0xiJlQqQ8NW3r42YPpaejXE0/qW0iSEvjLy2+syf3TrSK9t0SucmkpltaEq/sYvWsr+OeP8GZBD9v7cVKjr+VOMIr39m2ydWg3HA0yLeqvtXJLmJ9hc/CJAOUAFS0UesSzzQBm7ALailn0yYN3bboDkapQONPq8nHB7iYJ4/Gmz+VumwVwdKPFLAmTaEiSWO8XeBZMweAw2nTYixw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nzAyXBOs8pV58MkKLE2L8RWopmmcBRu6qI84jVDHazs=;
 b=aXvbtisVL10+fC5EbCDj+Mj95ZdbVV2/cEM9G2+QliDK9X9cFXx8crSLSmM8d1HATdfHri+6dCTBpXb7HiW7aNIwhQyfVyfcaxuXLwez2Aix1GJSFIMqymGE+xfacGCaM2NcIbDrStVMmTCL2JTzpFdZ3gaDw1Ffsvul+glIbfs=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by AM8PR04MB7267.eurprd04.prod.outlook.com (2603:10a6:20b:1df::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 11:34:31 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1%3]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 11:34:31 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Wed, 25 Feb 2026 13:34:15 +0200
Subject: [PATCH v10 1/9] phy: can-transceiver: rename temporary helper
 function to avoid conflict
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260225-rz-sdio-mux-v10-1-1ee44f2ea112@solid-run.com>
References: <20260225-rz-sdio-mux-v10-0-1ee44f2ea112@solid-run.com>
In-Reply-To: <20260225-rz-sdio-mux-v10-0-1ee44f2ea112@solid-run.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Peter Rosin <peda@axentia.se>, 
 Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Janusz Krzysztofik <jmkrzyszt@gmail.com>, Vignesh R <vigneshr@ti.com>, 
 Andi Shyti <andi.shyti@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, 
 Jon Nettleton <jon@solid-run.com>, Vladimir Oltean <olteanv@gmail.com>, 
 Mikhail Anikin <mikhail.anikin@solid-run.com>, linux-can@vger.kernel.org, 
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, 
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: TL0P290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::12) To PAXPR04MB8749.eurprd04.prod.outlook.com
 (2603:10a6:102:21f::22)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAXPR04MB8749:EE_|AM8PR04MB7267:EE_|AMS1EPF0000004D:EE_|GV2PR04MB11421:EE_
X-MS-Office365-Filtering-Correlation-Id: b5b209ab-9ccd-4e99-233f-08de7461dff9
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|52116014|376014|7416014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info-Original:
 MVnjQnVlsZfFaUKiQ3s9AauwoH0NNTW9b0hvOra4Q32/zY7C6L5MEJBkrzoZJXx0G/+hGfFin5EBs8jWsRqd+GYz6r/e2yaFd0Dn1BQiQ8Ehj6MXEXPOEAfMKVBRaYFTvRYklyHLJ5V52O1ksUS9TrSTAUKDB5i3PEstsXkQ+I1innZS0zvWFsuOuBEoJRsnmB/oJANs85c+FMcq3+evcnNxV3n+lC7TE+YvPV4dU37J1bUpM7vPfQ9BPkgTABfM0/6pNzObLOJXBx3LCuEdycwSJpQopkpiiJUFvLsOYgnkV0MJZi++fFMfpJJfWkCo+W0IoqSym6fvepoFBYbqFIa2hK3/zJaW+wcpbgi5Yv09WK/EEEU3+7UeJpRHfGUJqEaA7yf3ZEm/uCIbFXDBNLs03ce0dsDhRkpLxZv9XwgkBVIFfmc27tRU3vTWRccqTzGE9vAmGTVtTlL9aEgqdFOMfGY2v/XmJB41BSvFincMdY2mi6qC5WCjZXiUvllNEkyC03RaFpd1Tvvu6lXOt7N31PbA+DmV7BjXfmR7chddqfGrnS1rFQjMK5ENxa2YxBQ5Uknpnchy23hZExDQh8YsXTWMD80uX2GrSnynmLeKmxcP3vhOYMHRxbaBfWbxGhEuyPR4AzfYDQ5RvMmwqaootkgdkcJu9DoXuSQD7qtBxZ0/j7Aa4IhKhhVIx0kmFsSLdNVU4VjT10fGGQTq5WfJaJVGBEbKsOe+5OHDAeQq+H0eQRyoTHyBToldmB8bQsP/GkCaT7aboQL5+AILn6+rP3m+ATNET9+mokndtsmhNKn3AMElK5ROfbf3ovma
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7267
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: b0c7f784cc9e41c0b922b03a66e9781c:solidrun,office365_emails,sent,inline:c1cd8ff72a3c708341fd9de96626bab6
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF0000004D.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	8425a912-3e0f-47fa-ac84-08de7461d7a8
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|1800799024|82310400026|36860700013|35042699022|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	bW0wP/LTyWl+P7vId5aQ4d0sJIhVCC1x2LvAUvQvrceiJ7V2/lHy09EOQiX0TxTgEQ5SaSp+scOK99sY2Bsm8dNDQ9kcupZ9jbcLrMeujmeqXi3PoECzJsijYRZEYu7O7rjV6x4F2FAF8HqrdrverbrcLEHCVW3AGOhVmytJPM+lio2lbllL043vPrwUtJGnxT3GPtzzJ85VGkTL/v50gpbENFdWfRZHBNKv7KffvGIL8UxWBZhsf7DeTH03aSUtwXwJtPcXhvSHRTlegpiiO6d3wzb8mypEsR17J+w+XpO98FsZvlgbNdd/2UQP8LE9VCs7PXRKVna+CKnRaXvXSmRp4djkQm8lvYqXcHIHXYouX8l4usXShN3PT5BgWhBs5D6lioh/0NEpwNG7N3NGtHtyIR+SCRGL6GYG2T4nK1+BqpLy36cw9IHHPD6AgJQmAcXgmTWWINRys18YvefBpDkCYWODjJ7hduXvrmcZPJ8Sx1Q5EDc5JX7VSPGrnVqYsGdsJ2hsexaFFYxXYOB+qQLDvE2+PBNH2mGgM/JlqWoypWkUjN8v83cUnookY8E3MvtLgvbIAMAS18e8m655e1GoGQfBhlRlyexjtNGYgScMP7LfOthMwuD4HdpEkl1BD9O2P+VlYJDFmbzRvbxtm5mAbNwFAJ/gUFfWbuPl5VM1eLhovM3B9KSMly5s22qAbUetiGu7VshhLk47DjEEn7zxbBHfB2Sl5tnAvOD0x22HPYuH1KE3TGJB60/J5sxYtMmf/eZ1N315E8Nmwr3l9quwPwsOehjWurF0MAtWQU0jJuvw0uSuRt2gQu/hw2OEpw5sPVXyfyqyg00VX5Ke7SPXYKZZunAQy7QLUlu0Q/g=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(14060799003)(1800799024)(82310400026)(36860700013)(35042699022)(7416014)(376014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	KuNjwZI80GJch69IGhtVxWRzP/zEh/jBzCaFQnZxBEuX3Dh5TCOvq2GhcWTZKmoWD703jhw7nMZshuEM+zuStphoMdD3nIWfzXFSuyTwdwo6wOygm9sMjIuL84LOKvyj8LFCi6/PNHFhqTUEIiG6UUJMtOWp9TzjVwfGmN435wXkT0b5Wjf5P0M4qzaXvwW2Z3JKdBib/GpKx21L5Av7uXerCRPY6MsopiMRA31c0Mzxon0Dnm8EaU7TMGamnMg9lxKmygzHRkw5wpVOjgvDQXaSjWzuUx5caM2i36jjCkDOgJUpzyr/gTa8cLf/a2mX1klke2sqCFEv63pXQY1aYCWYwS5XU1HT4JIDgNZb/tvdWnyDEzlDZiQaFuoRXJM95J+aG3kXKI/Xw+QAxcvpWqLqW7IaEiDAMnKHwQZsRImPADX4BvPuCTts4jLi+kzr
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 11:34:45.0462
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5b209ab-9ccd-4e99-233f-08de7461dff9
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000004D.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11421
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=3];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[solidrn.onmicrosoft.com:s=selector1-solidrn-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[solid-run.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6623-lists,linux-can=lfdr.de];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,linaro.org,axentia.se,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com,renesas.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,solidrn.onmicrosoft.com:dkim,solid-run.com:mid,solid-run.com:email];
	DKIM_TRACE(0.00)[solidrn.onmicrosoft.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josua@solid-run.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[solid-run.com,gmail.com,vger.kernel.org,lists.infradead.org];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: A1918196AA3
X-Rspamd-Action: no action

Rename the temporary devm_mux_state_get_optional function to avoid
conflict with upcoming implementation in multiplexer subsystem.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 drivers/phy/phy-can-transceiver.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-transceiver.c
index 330356706ad7..fcbca9d2bded 100644
--- a/drivers/phy/phy-can-transceiver.c
+++ b/drivers/phy/phy-can-transceiver.c
@@ -128,7 +128,7 @@ MODULE_DEVICE_TABLE(of, can_transceiver_phy_ids);
 
 /* Temporary wrapper until the multiplexer subsystem supports optional muxes */
 static inline struct mux_state *
-devm_mux_state_get_optional(struct device *dev, const char *mux_name)
+can_transceiver_phy_mux_state_get_optional(struct device *dev, const char *mux_name)
 {
 	if (!of_property_present(dev->of_node, "mux-states"))
 		return NULL;
@@ -183,7 +183,7 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
 	priv->num_ch = num_ch;
 	platform_set_drvdata(pdev, priv);
 
-	mux_state = devm_mux_state_get_optional(dev, NULL);
+	mux_state = can_transceiver_phy_mux_state_get_optional(dev, NULL);
 	if (IS_ERR(mux_state))
 		return PTR_ERR(mux_state);
 

-- 
2.43.0


