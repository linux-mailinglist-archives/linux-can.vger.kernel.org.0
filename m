Return-Path: <linux-can+bounces-6474-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OIaJY/ygWkMNAMAu9opvQ
	(envelope-from <linux-can+bounces-6474-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 03 Feb 2026 14:05:19 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1983D99AF
	for <lists+linux-can@lfdr.de>; Tue, 03 Feb 2026 14:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 90CCF3023F0C
	for <lists+linux-can@lfdr.de>; Tue,  3 Feb 2026 13:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97696350A0B;
	Tue,  3 Feb 2026 13:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="EzsVhbiZ";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="EzsVhbiZ"
X-Original-To: linux-can@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021081.outbound.protection.outlook.com [52.101.70.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC533502A4;
	Tue,  3 Feb 2026 13:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.81
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770123734; cv=fail; b=LYB7v/GAMY3qEeu9XDmTaNfYOv049hYeSoFrDzsvOGCJr/g5DS2EI/tmNrSRE7gNCMacNIGc31OhWhl5jXWBFYyYnoqBllrZT5J4EoCZoHVjnP9M7DCeZbU6ezfZfeTjOgw31n7wOxWryH7/ZFVGz7BXV1G+/CjMaAADAFx4sd4=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770123734; c=relaxed/simple;
	bh=j8j/C/LDUxiw5Kg141MCogACtfhr61VhYNRd5DV0ZPM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=mnzv7hrBWZvDij7f+j02JY9iH4SN9xBS3HHZ+9zQ/wpxZiNdj8pmBgo21DQBCRtle2bKe3FQsHbiBbBA+91MxPLJ2BJEIwNFd5JbFCXQJ5Qi3TFWaNU3IQyTjDb9Tneji1k2FR8zgGdwwek8GSZ0L8IpWKJiM5CKBmi6PuV2/Ic=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=EzsVhbiZ; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=EzsVhbiZ; arc=fail smtp.client-ip=52.101.70.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=H1PBo2VN86G1qYFWp9EUkpUECew9Hgv+27Qr3NOspfum0fy8vdOsFRVoTmS4z3SxJozpJulT/wyDPi66bhSjGUkB9UELdJOS07OTFXBmTA+jw6OCHZpGkAj01knJx7zgu5VWMQ8oOu9GpmlGOMHEy3sPiL84Pl/luMl2CaKs5VXXpXBbt25vILob8dYLPy+w1jFWGtNJbAvvOVFzVw+kDzys1qF96rNMTZ8ZfQXI0v23UBpGiYFzcEAaA7zG7QpBd3c0Kd6QfpDvi+neGW2TedEYEHPqqKdP94dSaG1ZNEot2ovZU60ay9cg3cqqhUUqAIOgPQ+RyA4SX692AAQxMg==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ULCi1SpJrr0UlzTJlHicP6tFRMYDJCqD/7fiUoffcwI=;
 b=ooPFoahT/eguzd75DPb+VH3GFw20hxQoMZgQM2IS1x0RFn+I/+uh2Tsifnhu7M7i5hc7FLyT25vlhGYgfR3Sp+rBkTUCYVke86NKw7GP/5QWu6vHoKrYeHKN9OF/I//DBzZzS6bmdtVT5H5icx5F9hDHPcf2quMhOMybTiZQQEWOQqs3xp7d0q1RuP+v2VPKl98RoltGhNLxw/hRzfCnCQhWeDuUAWvHPzHGEW09SZZlTNPxH7iFWXrokhenCV084z/nbOGJpvyN2/NgTHCee1HpneBsROffbFhy11rdpC8umeXea9d9SADjCYTl0ixei60ZQHwDgS7CxCLJk8lNLg==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=softfail (sender ip
 is 52.17.62.50) smtp.rcpttodomain=atomide.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULCi1SpJrr0UlzTJlHicP6tFRMYDJCqD/7fiUoffcwI=;
 b=EzsVhbiZ5PVxYJUJeSB/9AujxLpdu3UDljlZbvX1iDR1g/IJ09G/5yRQ4G8JuaCZKXD4MINEbSfEDQKeY13XN/eFZ7Xfg6pzwQu+Ls6ewAyCPKPtSFc+G2HXSMmaLiQUYWuhnaYnoNxnIMjQdL6YAjxasTPsuxkjawxxdFdEdaE=
Received: from DUZPR01CA0024.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::11) by PAXPR04MB8112.eurprd04.prod.outlook.com
 (2603:10a6:102:1cd::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 13:02:10 +0000
Received: from DB1PEPF0003922D.eurprd03.prod.outlook.com
 (2603:10a6:10:46b:cafe::6d) by DUZPR01CA0024.outlook.office365.com
 (2603:10a6:10:46b::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Tue,
 3 Feb 2026 13:02:13 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 solid-run.com discourages use of 52.17.62.50 as permitted sender)
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DB1PEPF0003922D.mail.protection.outlook.com (10.167.8.100) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.10
 via Frontend Transport; Tue, 3 Feb 2026 13:02:09 +0000
Received: from emails-6194871-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-5-175.eu-west-1.compute.internal [10.20.5.175])
	by mta-outgoing-dlp-141-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id CB94580578;
	Tue,  3 Feb 2026 13:02:09 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com;
 arc=pass;
 dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1770123729; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=ULCi1SpJrr0UlzTJlHicP6tFRMYDJCqD/7fiUoffcwI=;
 b=Lw5Ir8FcWWhTsvjL/Yt8OwSMN+uBXwJZARBIdBWrZBUUOfqo/rWbciU54+awLOFQevPIk
 iX1H8Zg6dsuEKcxF9F5SH6drHPEKn1u168thJQ68OnDAH2T45Yy2wGpwv+FFOFopl2+Oa4P
 Za43rodwaDjV8/msMC1kOeuiEjLrtdY=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1770123729;
 b=BSWHr7TPKcF+mYtgfPZrBNX5D4F/nbkMivLArvJOXTRgR8aMdrSja+gfRDCUGf0xkAYK9
 Jn5BUKbkFp+T34+JAZWxy2zX/QJ6X93+rLjE1YOtagbCiPjH9qsh7fT2ID+mw6kypbDG/c6
 +xYFCAsLIw3AsQB1XBtrGRzRik/+a4g=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kjQdP034XsSxvgfU28tEGMn6ynsCb1oWv+9/4/fDWJFZiNa7Y1tHhoiiEyv0iTm2ak+fkuQ/BXg0wge5pn2dyngo9EnVHH4Z5a4JThxpWitX/+Jug2TVdASkQ4yFR/wsouw+/CzjMk8uBnZMJSrh9zuqHUHJXwPngpkwgArouug1Df1RnHUeWRihVjtaaQnKXN+KLFdeTuebK75Qy0tIXDo4maLCl+CaDgpX3QNMFNxUWgU65RcpIwNyR40V7/Q+jZnLdYPkUcYjc2Rf2s+qQNbYN3Td9GXwnwkz9peTkuxUwTCn1Gs5hiTzZOddIX2kIm5tsDlHf+MFlF10YuAlGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ULCi1SpJrr0UlzTJlHicP6tFRMYDJCqD/7fiUoffcwI=;
 b=FNFeJimQEzBvBklorq7NJ0MMhk+XciUK9v+eYCeOXrMPIOSbmtEV6ELOcL+MpCl11yckXuoWOMONJObI2y47SrqxxWpXyNDSgQfM+vUzWArk9sNT1AfWaq7Hob7yU9G8OALFOUcABUdGQm5mUQQ9slPdpccjIzlCmKR+Rmi+r42hTedlkf8DOrMN67GaP/g98FzFIBqgxFnyuIwV4w7wFi4xz2E54CsXRaH2ic+fkrTuUJeZ3lCP5Fm9zu4V05578sAyVGJOW7Fjiloyy3YOJD1iDqjX5ac58vwnuiPCBvwSoYlK4/+NXEQu/5NVlB2oib6vCuc/SAzJXb6eh6MRbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULCi1SpJrr0UlzTJlHicP6tFRMYDJCqD/7fiUoffcwI=;
 b=EzsVhbiZ5PVxYJUJeSB/9AujxLpdu3UDljlZbvX1iDR1g/IJ09G/5yRQ4G8JuaCZKXD4MINEbSfEDQKeY13XN/eFZ7Xfg6pzwQu+Ls6ewAyCPKPtSFc+G2HXSMmaLiQUYWuhnaYnoNxnIMjQdL6YAjxasTPsuxkjawxxdFdEdaE=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by AS8PR04MB7686.eurprd04.prod.outlook.com (2603:10a6:20b:290::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 13:01:57 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1%3]) with mapi id 15.20.9587.010; Tue, 3 Feb 2026
 13:01:57 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Tue, 03 Feb 2026 15:01:40 +0200
Subject: [PATCH v8 7/7] mmc: host: renesas_sdhi_core: support selecting an
 optional mux
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260203-rz-sdio-mux-v8-7-024ea405863e@solid-run.com>
References: <20260203-rz-sdio-mux-v8-0-024ea405863e@solid-run.com>
In-Reply-To: <20260203-rz-sdio-mux-v8-0-024ea405863e@solid-run.com>
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
 Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>,
 Jon Nettleton <jon@solid-run.com>,
 Mikhail Anikin <mikhail.anikin@solid-run.com>, linux-can@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org,
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: TL0P290CA0008.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::19) To PAXPR04MB8749.eurprd04.prod.outlook.com
 (2603:10a6:102:21f::22)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAXPR04MB8749:EE_|AS8PR04MB7686:EE_|DB1PEPF0003922D:EE_|PAXPR04MB8112:EE_
X-MS-Office365-Filtering-Correlation-Id: 97dde16a-2baf-491d-369a-08de63247107
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?QitFUFVJTjJPTFR4YTRwTVZTTUhyc2ZPV2w1aDZKWlJjczVkZmFLUXRrWEs4?=
 =?utf-8?B?Z2FHTndPK2paQWdNNzhHaFR3T0ZWbWRyMjJEY2dDaTVEc3NQS2JYdmtPd01G?=
 =?utf-8?B?amFwQzdObDJVaDdRNUdtd3FKNGJTZnFiU2pRNmhqdFAvb1k4VWtNZk5Qc2Zo?=
 =?utf-8?B?QVdJOWpySlA3SVJ1NW1JTXNVVXNZem1LOWZ1WjNrK3FGb0tqWTkrU2szZmcv?=
 =?utf-8?B?NHV0d0NhV1pjS2piM0NldVVuejBsN0ZST29wWmxvVmowUy85VmZoUU9aMUJP?=
 =?utf-8?B?WG8yMDd0WFViYllyYWp4WmhmNVdzZ2FoWTR2bGZrWGlwTDN5VW1BYU54RkF2?=
 =?utf-8?B?NUlGRG9mVTYrdXlCQWFNWDZzWWRaaDQ1VHl1OTY1eTV5ekg3M05saFhNNjBO?=
 =?utf-8?B?Nnhoazd5Q3Q2TnpJYzRpV2NQM1dRMEdYTHhJY1VXNHkrOUhLTms4UXdyTm1L?=
 =?utf-8?B?Vzd4TjA1U3pMWDlyTGtlN3dCWEpZQkFZamdJaDFVYzV4dFBPZ01VUjlOa2xW?=
 =?utf-8?B?VWpCeDZzMmx3L0xtcmpwWDRSTW9tekRZSWFTMTh2YTVsaFF1VGtFRi9HUXlD?=
 =?utf-8?B?SnVqc2h2ejZCVEJiQ3lJbng0TC9acG15ZW1kejhkK1g1blE4M2JaaUxqSm40?=
 =?utf-8?B?UGdFRjFIRE15ZkQvcW1lTzZyVGRjY2VuZnFyNHN1OGMwTExjQjBwS3B3Q21Y?=
 =?utf-8?B?VlBPZ0NTSGFDWW00K3RiamNKRWFmM1JQREJuY2lvaDIzUmQ1dzdZMmhGL095?=
 =?utf-8?B?cktLUUlRSEVkajE2WkdIeFEyYTB6czhlYmhxWXF6QmE2NE85bFlPUGhrV1lm?=
 =?utf-8?B?Y1VYZlNWVDNnbklwbmZWaWVEbEY1TFZsWE4wSHVTYzJEenZsYjdIQzhwZnJP?=
 =?utf-8?B?N0VwSXF6TGJBVWRiUXBucjVad2RIL3d6WmdrenFFN0x0dUUvYytmRlZlYmtM?=
 =?utf-8?B?VWpMaUxBNVdSTUE2bGNjczBvbnF6ejRWdGJtaUNobzNjSS96Ykg1SGJKVHkz?=
 =?utf-8?B?L3d3SWg5dklMdmtwcVl3M1dhYk1wZE5kbjZRUkJRdzA3YlNPVmErTVdVMnhn?=
 =?utf-8?B?ZDMzUkpDR2ZFOVhwS2VFVEY4RmFiampIUE4wQU5YZ0YxcmxsTnF5d3k0RXFN?=
 =?utf-8?B?R2p0UEJtcGR1c0htZnFDQnlIVmVkb2E5clRXTEM3ZkpLc1VjZFAvY3NlQ2VU?=
 =?utf-8?B?QXJYNExkbVZrdnNyK2Fyd2VLSDJBUDFCTzVWOTl3MVUrY1Jlam5iakR4OXpj?=
 =?utf-8?B?RzVyOXFwUHlsTHE1d09CVnBIOTN6SG9nc3BWSVpxbWdxOHRlZU9rVERXemM2?=
 =?utf-8?B?dXZGeHhoNzNJYzYzNjZkOHp4N1VwNHNGY1V1ZFVvSExvQ3QxT1R5Ykc3VzJB?=
 =?utf-8?B?RGZCODAwVVJPNlpxSmZ6dVF6WldkY2RKc3ZoZ0pBT28vYUFHNXh5dkNDYmdo?=
 =?utf-8?B?WndSODNpK3d2aTVIZmZmQjA2YmdvUTlINElvR2dqTk41WWxSYjJsZm5MRkZt?=
 =?utf-8?B?VWdxV0FIU3F5YlFGZEYrNXFZVnhRU24rc3M5dzc2aE44Ujdmd1ZyS0NyWDF6?=
 =?utf-8?B?allvc09tVk9tZ2t3ckVxdks3STJZdUJmNjg5M1JVeUNsK2ZCK2R2Sm9ONFgy?=
 =?utf-8?B?azdoN3MrWnFhemJwbkRtVVY5U09BOVFPK0VhYjU1cC8xRTFoa0dmWXdXLytD?=
 =?utf-8?B?dWhXVWIwSzdKMDJ2a0J0SDJlamxsenpCZEFDZFZEZnAzWkgwblc0K3N2RTM2?=
 =?utf-8?B?TGxsYXgzazlWSm1rRmxkRGIvREVvdVI0T0JkRnFKRW94UGNnM0VqekkxVkJR?=
 =?utf-8?B?K1puT3Jsc0pOZ1hrV2R6SjNKYlZwcW44STA5QUN1ZkJYM0E2MjRqenp6YUJX?=
 =?utf-8?B?SjBLbHBTSnY4WkJDeU9iRDRuMjdsVXNrVjkxSTNhQVZaQlBadWtuNXpISXhz?=
 =?utf-8?B?QXhwNldJQ3M4alB1WnB4cnVwRVhsM0pHWUJkbldZa2oxT1lTdjJiTCtxRzdY?=
 =?utf-8?B?M2RmZzcrL2pzYVBtalNZZXV3azFlYnFHUmJVWEsvdzhnaTFSUFpWREgwU1N4?=
 =?utf-8?B?QW5IWWFUNkNMUkRPNThPQ2QvY3JxcVFlRlZQRjhhSTlaT0diM0NnYkRPb3Jx?=
 =?utf-8?B?QVpseXBhZFo5NytpMkZTa3J4ZzZRTlRBYW9ZR2pvTVRHVFQvTlBxVnBhWlVT?=
 =?utf-8?Q?H5UoUEYAR/+koKuKnbWSr7AKanwaSFeczPPjw7VWcea3?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7686
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: aa0fa1c8f3f845a28bd38f00197f2506:solidrun,office365_emails,sent,inline:325c726d7bb4eee7ea0486ee39a741b0
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF0003922D.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	8d87c828-b561-4afb-8289-08de63246975
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|14060799003|36860700013|7416014|376014|35042699022|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L1BER2FTdGIxTnJTdTFRd2ZWbnkxcVl5Q1Boazh4MTZMUUx5QzVhaGhZRHFF?=
 =?utf-8?B?dmkrT1B6RUhkN1lFby9PSUNDVkJvOGlRV212NStIZ0ttelhzSnFBWm9QVXdx?=
 =?utf-8?B?bXhQUWE4b1czcmZTdE9mdENheHJuZ1ZSVERhQnlKOUUxS3RPUURZL3ZvVmRo?=
 =?utf-8?B?dkZZbGFSaWpURk9NdjNmamNOV21NVWlMYXY0cWFvNlVRUUZ5OWJxQmpNU054?=
 =?utf-8?B?NXc2ZXQ2dmZ5K2phUTBjTzVVMyszZGhYaWNYU2s2VXoyZU1IRE5GOHVIN29h?=
 =?utf-8?B?SGZuM2o5RUVYTERHWW5tQ3o0cUR4TnMydHUydUtvZUJ6N2VLY2wvTmZhU3Er?=
 =?utf-8?B?NXg0Yjl0b1RnTS9rVDI3WFhPN0tEdVYzVTI0dHdzUVVNTzNEVGFkSnNPUStq?=
 =?utf-8?B?WmFvdnhGc09DRkVaMDI0WkErWTBzYlBYZW1CRXVFZ09VLzJ3SG1pOU00d1Fj?=
 =?utf-8?B?RHNUVG9hcnZFVzNMQnlESC9TRU5sUXpDNnlHRGF1dVZ1VWtIbDV3SlRJV0o1?=
 =?utf-8?B?N0JTbEduZWtIOHYzWVhqcWpmRVZGSk9WelQ4QXhSanlQWEtWdzQ4bENPVy9R?=
 =?utf-8?B?bG5DOVAyZ3V4VmZ4ZWNUdEZDaEpNR1hzSmFRdnozcWFyWjhGc09LYnRQbW5s?=
 =?utf-8?B?ZUNIZHhvZDdPcHVyQkswL21LMFRBOU54cXE3Q2VYNXcvenliK2lsTW8wV0Vu?=
 =?utf-8?B?dEg5K2JtTWFsSzA2LzZxT1ZqUk9ndk5zajlTbEdoOVJhM3MvRXM4MUNIQUd6?=
 =?utf-8?B?YUFpQmpJbVVMeTNOWXU2M1RPcnBqMk9WY2kzcHdoYVFsWUUvV2paRm9KTm51?=
 =?utf-8?B?Q2pCeERPcUdVODJIazhpb0VvTVBvekxYcWliSU9vUFhJTC80VXFqNWU3d2F3?=
 =?utf-8?B?SjlRc3pJcTlPam5UaFdkVTNWcjlFcFBmdzVwUUhUamdpVWlac3dzTzNHTGdU?=
 =?utf-8?B?cGVwYWRRU1pLSnExb3F2VnhnbFVhSlQ4SVpmeHB0bTJVQ0JlaXRodWNmdkFB?=
 =?utf-8?B?WkdmcitncVJJUE9SOUltTGQ5TFZzcnltb3NTbXlEQXpOcEwxdW1Kb3QxNFJ5?=
 =?utf-8?B?bURTdlh6NlhGbVY3UE0rUVBuUS95cXRTa2Jpd2VLQmlSWTVqTVZTbTE1K1Z0?=
 =?utf-8?B?TngvaHRsM0xQcnNkRFZQeWw4cDRxdVpkdDJyVG1BUWZabHpHSCs5Umc4Q0xC?=
 =?utf-8?B?czh1SXl2cTRMZmJENFp3dGpudFpvY2dMeSt1KzlQNUZsS0kvcnhaUXZMaVFu?=
 =?utf-8?B?NzJ5Q1Z3RkdCMllnM0Nnd3VFZVhLVWNST241b3B0cDg2endocWpqNE91YjJs?=
 =?utf-8?B?a1pEeEszTTRUeWRGUjVjK1ArTEsraFBMMGJFRldSbnZVOEJ0UXE3anUzanIr?=
 =?utf-8?B?blhxOTF3MW5OenVQc3FGbmM1YkFnUnNwSjVvR3FwZHdabEg0Z2lJZ2szUE1h?=
 =?utf-8?B?YitkaHdKUmM0U2pTaUVtR0JhSVNuZktCbnh5ODFZaW1Ya0YzYzNMcS96SjRZ?=
 =?utf-8?B?NmFlcGZVQTk4SXlkNDRBS0xFRFI5TnZzQklROVY1RVpjcU03YmpobjA1eEpP?=
 =?utf-8?B?TjNVc1g5QTY3Vkd3d0IzT0V3S1QwZHlZYUNoM0Zwd0dVaHNlcDBGZ2JJdm5p?=
 =?utf-8?B?eWFsWTBJU3FrdjBqR1VWMjhnWEIrQUVUZ2xGdUpSR1RnMTNyRDdkQkRnWVBw?=
 =?utf-8?B?cUtrSkNhMDlIenI3NXJGSS9WZUF0bWYyaFpLZW5ONi9XUDN2dUExRmtycVhJ?=
 =?utf-8?B?WmJNMUlNWnNqT25GMUs2WnhzL3pxZTkwem5yWmZtRlYvbzhUNzN4YVdIbG0x?=
 =?utf-8?B?UFpDdDNUNGFsb2dBb0VyTE05T3lyMjFPTTFBZGJvbEJwVG8wTDZabTBBZGQ1?=
 =?utf-8?B?aGZhcE1HcndmaTRoNnM3Q0gvRktIcTZhSmVLY21mUVpZMFkwdGF2aUg1TzM5?=
 =?utf-8?B?RlN4NWpHbG1Od1k4bXlGdEdPWVc5UzhTaXVpRFJKK3plcFlINWNCRC9DL1dw?=
 =?utf-8?B?U3FWa2Q0RHR4VFdOeUx0VjF5czFBZllFUnZBODNISHM3K0RjZHpzSzc5MW9V?=
 =?utf-8?B?b3lYcTNvWnlNdHJHeFRzMkRQZ1B0aERXNytlZWxkUWlNTjhhK0hIdFk5c0Fw?=
 =?utf-8?B?T291RkNJUktydkJXTFVTR1hmazZobEp1dHcxSmFDb0FSME9vSVdYUk0yazk0?=
 =?utf-8?B?dnRQUjB4emVyTXhsMERSZitTKzhrTERScWp5Z21tSFB2WkxCYTJkOTdmTG9Z?=
 =?utf-8?Q?00v1YF2OhOg95MvAi6m91bgpWW8fdDY2K5xLwP8FP8=3D?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(1800799024)(14060799003)(36860700013)(7416014)(376014)(35042699022)(82310400026)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DO+ywmpBel+AxsVMRgu3iY9LeGElcelMxUDxKZT25cHG0RMBmtVAP9biMMbQl7w5LUB7O0EfCfSnFShjwh/lUaq2h5SGGfv/fFiE1ACySbYTbUcywis8waDhw9S8IHJU/YMVDUX/741a+Su/+hO66EV/cYAkJJfPN0szQn32ER1cWbeVfKoJTHHZO1+Z6kKoX6RDa6xSbsrUj2lXqs1BExlDsDJ6TJ8PkI9b0yuqUDoZPR1xpfrP4SqVf2z7I63MjkRkxNlGx632EH2alQaB/zFgAENDWeUXnESyLqBkea+MuaxEu+zZnLbww3nQZuuj6nEpv7wbFnb7Ex8kOnYrFJhXe2VKd6pw9niRm0CK8BuZL9lUNXu/enUgcOR2offPFajdhw0lBKCx3BSsXPyYZ3xm7IzjoaKDsOA0AUsyqYKgMny5ioMISwswPJi3yTwU
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 13:02:09.9033
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97dde16a-2baf-491d-369a-08de63247107
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF0003922D.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8112
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=4];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[solidrn.onmicrosoft.com:s=selector1-solidrn-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[solid-run.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6474-lists,linux-can=lfdr.de];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,linaro.org,axentia.se,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,glider.be:email,solid-run.com:mid,solid-run.com:email,solidrn.onmicrosoft.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josua@solid-run.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[solidrn.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: E1983D99AF
X-Rspamd-Action: no action

Some hardware designs route data or control signals through a mux to
support multiple devices on a single sdhi controller.

In particular SolidRun RZ/G2L/G2LC/V2L System on Module use a mux for
switching between soldered eMMC and an optional microSD on a carrier
board, e.g. for development or provisioning.

SD/SDIO/eMMC are not well suited for runtime switching between different
cards, however boot-time selection is possible and useful - in
particular considering dt overlays.

Add support for an optional SD/SDIO/eMMC mux defined in dt, and select
it during probe.

Similar functionality already exists in other places, e.g. i2c-omap.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 drivers/mmc/host/renesas_sdhi_core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 2a310a145785..f9ec78d699f4 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -26,6 +26,7 @@
 #include <linux/mmc/mmc.h>
 #include <linux/mmc/slot-gpio.h>
 #include <linux/module.h>
+#include <linux/mux/consumer.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/pinctrl/pinctrl-state.h>
 #include <linux/platform_data/tmio.h>
@@ -1062,6 +1063,7 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 	struct regulator_dev *rdev;
 	struct renesas_sdhi_dma *dma_priv;
 	struct device *dev = &pdev->dev;
+	struct mux_state *mux_state;
 	struct tmio_mmc_host *host;
 	struct renesas_sdhi *priv;
 	int num_irqs, irq, ret, i;
@@ -1116,6 +1118,10 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 						"state_uhs");
 	}
 
+	mux_state = devm_mux_state_get_optional_selected(&pdev->dev, NULL);
+	if (IS_ERR(mux_state))
+		return PTR_ERR(mux_state);
+
 	host = tmio_mmc_host_alloc(pdev, mmc_data);
 	if (IS_ERR(host))
 		return PTR_ERR(host);

-- 
2.43.0



