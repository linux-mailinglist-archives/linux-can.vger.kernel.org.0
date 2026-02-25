Return-Path: <linux-can+bounces-6622-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFfWEljfnmmCXgQAu9opvQ
	(envelope-from <linux-can+bounces-6622-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 25 Feb 2026 12:39:04 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E039B196A6C
	for <lists+linux-can@lfdr.de>; Wed, 25 Feb 2026 12:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CF5D31096A7
	for <lists+linux-can@lfdr.de>; Wed, 25 Feb 2026 11:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17D9393DF6;
	Wed, 25 Feb 2026 11:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="chT1iyWp";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="chT1iyWp"
X-Original-To: linux-can@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021116.outbound.protection.outlook.com [52.101.65.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A00B395242;
	Wed, 25 Feb 2026 11:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.116
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772019295; cv=fail; b=hfGRaTyBcwH1g5rVcUsE+pz/mIw70sbCVgDarchVO0RGerwphOIyzOFS78KjPcLA9C2GtA9QUOvrmulgNot5fueYIisuLZABD5z98s4gKIn/C3fnSA5TbtGmmc77Ps7Z5XBzWqlZbr8eiOvXpZVwn7GDXkyVDYKS2Swhxk7K/TY=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772019295; c=relaxed/simple;
	bh=jYQ1syx5r2WBhT07ohpkyhqnSMifMMTWAkOsCNa3X0Q=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=G/F/504QrxqON1SBaBj8L5yNKQGBlPfjCDXlKQ4p6nkBTUChinFXIP/a/W57sYlX0Y/drbxwk1nzZ6qwpgVutWLwu9fRNoJnZuDpsii0KxS4Y6uUoBuIQYYbamIBQFpWJ+0l8xoodrGAXyhO4mArDr97moPMn95YQ2OHlaf0dO0=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=chT1iyWp; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=chT1iyWp; arc=fail smtp.client-ip=52.101.65.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=wdPrt0oBwXwYEmQNjQm5NALaAuAXkvH/uMhhE1a0cHeVo9wylDa7fpe0sjxyS6v6D776YS+flfD5VW0gNUD+mk2A+mOxZg8Y31ijobB+dTdyood48y46mUaMK/9cLYhlQAC1VwjmMQYNP1u/AxC8C4gqUBxhjS3QyNGg9WjbFCc2L6NrVs3bFJ/fZnSQzlv0z1LEOwBpVB5DwfUUVv7lJsyAmBepeh+0uzDdikdGHEhdVMtH6Xk1wTqcWHC6/xENyYvLPTVt5UM0vdy9Yc6tWmrr3Y/1Gr8aA2SUanwXa166dMivcoCCfiDt8OlUOB00O9Y5P4iBCOj2z2fyMPGXUQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=75G/CfPQjsG3DlUp2fLUtPEYQ1QAhNdy3xV2UPRXowg=;
 b=G572wLEDNNyAObApInLSXfyyyJcrtdi0qgRQkhjDii80oLEJJDOPMQKGIEbYRtU607LBufp5DHqBK3DiWgtyCgmLhZNZEL7LotUV2V1G1aYhTVCG31UTiG6hZ62ymIyxjb3+MpHDOoaM2Rh+1fyUXJv1gOTJK/eQRUlWFZ05QplZm5hJNID1iH5Q5rekLLIe9HAmKkWUjUbODz3KrpOG3+ufqx29/myLIW4fdxHZHksdrHLakl+aRiV5Ndj3Z6Rhgnu0OWgULrgmyoz6RzvyJ2GCGMku9vDJ5gJF5vT2JGAPGi4hqbWZO7dbvsa8VXRSW+Zxd0i0f6GzewWfG+X2fw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=softfail (sender ip
 is 52.17.62.50) smtp.rcpttodomain=atomide.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75G/CfPQjsG3DlUp2fLUtPEYQ1QAhNdy3xV2UPRXowg=;
 b=chT1iyWpIsBw55UX+yy1O+HNoNKFPeCkGpspYxO3cHFjhDAgy5LKJkSre2SDDALt1tG63JHFQgnrTUlsYTPQXs9Va6MbV49RV1nhu6NWD596/9v/KJu3GHHFAjh4rNL3soUFiqtJ/R0eOIdq+nwM939o6bZLS8lzVf9JmQe26is=
Received: from DU6P191CA0007.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:540::22)
 by VE1PR04MB7359.eurprd04.prod.outlook.com (2603:10a6:800:1a0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Wed, 25 Feb
 2026 11:34:46 +0000
Received: from DB1PEPF000509FF.eurprd03.prod.outlook.com
 (2603:10a6:10:540:cafe::39) by DU6P191CA0007.outlook.office365.com
 (2603:10a6:10:540::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.23 via Frontend Transport; Wed,
 25 Feb 2026 11:34:39 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 solid-run.com discourages use of 52.17.62.50 as permitted sender)
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DB1PEPF000509FF.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.12
 via Frontend Transport; Wed, 25 Feb 2026 11:34:45 +0000
Received: from emails-3371313-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-236.eu-west-1.compute.internal [10.20.6.236])
	by mta-outgoing-dlp-141-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id B98CB80609;
	Wed, 25 Feb 2026 11:34:45 +0000 (UTC)
X-Mailbox-Line: From b'josua@solid-run.com' Wed Feb 25 11:34:40 2026
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iY59cbZxYJWp4ImT8M/8bIbE8VsOLuyBbHarltScLY1UDfNUJeGIjE0ZkkdPI3upA0sSS/Zld/bHIFMt+GZLABBxzxQAbseiAF9+U2dNq9+PICAPzB32NxYgvDOYPt+QFeFEWU2x5msog5flO1OIEYg+gyvp1Z3ai6oHkBKcDNtRnLusSk/4gA4VI5wk2anGDhLsP+YNldKkhvq8B9+3DOPU12QfbtRCxOK8IdukHCXFfUHSinnLef8uV01rzn37CCpFaMo65HRRdulWaSuE77ZDwxKJTaahs/2L6SQOMJ1jbntUl+tMHrFjmFUs0w5MnNtu7173h7RDqzuKrkBSUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=75G/CfPQjsG3DlUp2fLUtPEYQ1QAhNdy3xV2UPRXowg=;
 b=QbZU+AWSenwktabwJlH/lXh0aoEthlj+27+WTVdPZzkiynMMUx8d28bSDhGBmyh/08zGtLahbcI76oXSwVLiqtLhRsl7hJ3XM7dNBmfNxINirfDwU3kWDVTIXuMmNQW5YXu3Yj1guVGm6bgM0E2r+yzMtMUT+YxBbJze3ZQA7PWOaX9FZacpq4uL68JBJ60QRFGH1/JWTsLzHIhxI4d9Rz4dp1H9hfRDoRZ3/YfabtVraqLgvOW+2zLVa6CW8QxkNm+GDn5p697ZytTLaRZeixI8RtlTT7ejXJPgpFOnmc3ZBASQZ3StnIpSf1cq2+EvOsY8ecROHeK1JRPPPlooSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75G/CfPQjsG3DlUp2fLUtPEYQ1QAhNdy3xV2UPRXowg=;
 b=chT1iyWpIsBw55UX+yy1O+HNoNKFPeCkGpspYxO3cHFjhDAgy5LKJkSre2SDDALt1tG63JHFQgnrTUlsYTPQXs9Va6MbV49RV1nhu6NWD596/9v/KJu3GHHFAjh4rNL3soUFiqtJ/R0eOIdq+nwM939o6bZLS8lzVf9JmQe26is=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by AM8PR04MB7827.eurprd04.prod.outlook.com (2603:10a6:20b:247::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Wed, 25 Feb
 2026 11:34:38 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1%3]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 11:34:38 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Wed, 25 Feb 2026 13:34:18 +0200
Subject: [PATCH v10 4/9] phy: can-transceiver: drop temporary helper
 getting optional mux-state
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260225-rz-sdio-mux-v10-4-1ee44f2ea112@solid-run.com>
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
	PAXPR04MB8749:EE_|AM8PR04MB7827:EE_|DB1PEPF000509FF:EE_|VE1PR04MB7359:EE_
X-MS-Office365-Filtering-Correlation-Id: 57319a33-cc76-4e5a-5a2d-08de7461e06f
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info-Original:
 MUn3rEsmwImIeqrUOPA8r0VzArNKmE7KeiNZ9IcYgZp5tSkG+NKQoqiEtSLHGKHmS+l6kR2Tor91ZmgIbEVYMZm05A55mf+qtUB3YFzSMyEwA1wmyM0DJ82VGdceCo8K1PTfQIYafAv4k5ZZtw5+HEidzqprZxGtUmh2HWm2S1hi8Affi+XpnSURCvdpfGf8Pi1OfRpyBQ2sBjzMbDcmoYebUJd8dbEtcZKSQPc8IRPrUe4r3PeQ88pvjQZQGsSbKj8eus98UyKVp56j767PtJmJydb9CJxVmgqWL5Ef/geMz7Dg/bbDGoncmDjDq234RxBiffDkzykcASSpD3heeHGYsW6VmolScnnuA14nGL8yb+Dqs0QhNMr89sKB1iRSVO5015IcplGMzuEHU505oiWdZRUN4lapU+oFB7MPTY9jGnhkiwJORLSWhuXupfrNr/qxY1ElFfhjTMD1RkpR7SjjnQvcy/lT12PfeRySj5WGnewWipc2TRb0bgDcVTcW59hTYeB6Hh0mh0wY04NU3xnTXTAKRwT6HfdYGrmUz/C3pTlMbXDg5SuBroOHQnfJ5W/BYxpX9eXVj/ahX9YJqyvXg1vPvsyLlbvUbeZ6CeSvi2VXCcqFOMoG4UA+2UO+Ac5kAywEc+2sEb5jSlJN1tdNBx1DQ10kQD5pWC2S1MgOd5Uyto8ktScGTUrgkP9gDtZX2gUpFktyMHOy0d1X3L8/YUJoN0+jSzJeZr5vA0EFE2n9O+dJE8mVAJz6pSDCbg3oJhEc8V1IigJYXnav7H1mFYIwaSRHMwC34AbiEtoH90tb2zx94SE2UE3dvz20
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7827
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: db51d327cfb14a75be0da2148416f751:solidrun,office365_emails,sent,inline:c1cd8ff72a3c708341fd9de96626bab6
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509FF.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	c7df03b3-1f6d-4ad2-ccac-08de7461dbc6
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|82310400026|35042699022|1800799024|376014|7416014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	n3oxywzXx0h7JLPTrw8IXZSEo+6cav+mI3B+jMLU4IewAr7I2AVxnrYw6VY/Kcc+Y7kd93GO2uCCCpCG80TXzTVct0oiqJt1bNDbaZ/6exJCX/N9fAfVk4Z7iCm7m0xhruiOr10oTyotadbZeSH2pb3hKlCJ3qxMz7onJHSTW4ZubEdaz3E3W46uCK7wAapsL7c0hrQ0bktV8QWu2SQA7qav6DJp6miIeu8OoJZz9XXImUs+bnJu6L2scPzTbUAj9VAytv359GOuKHUPugaDnKI6CTLXjuvDCxIRj4PXJJiFa+q2sEd/LCrEgyJDbxz9271w0GF+Uo9f/1y5jhMLdwXHbrYQhPq5odjsMRDpLHcGOw8Rgpm39ZaJb9/1hLQfm5W+JKTaa8g0+ey7NmAaNhblCjI/Pi5yTeWtFF4LifPWlm49csrEqnhQeYj6xfkwTLS7/RcC8Dde9TiqwxKotV/g/Iamg6ccgBpyq9ht+jIMenLVjxcG1voee2rEYvULqsbMlb27FYbMBnMgIwUQHzw/il+ef5AInAt1gqBT3O+YMXc+d41u1+ZnxGaSOzKoAwvQiKIn3B0OGbSlZbRhvjO3PGUVIyD8RO/8vDyWWwyTNihhgZOYFJV8+0BDRMBw4xlWWCRJqgb6F9NZ/hDsc3PKB3fUvc6PMfP3ePjntNkHvpfSBogXBSGPMYsHzI8Al0jVWHQ5yaD2O8zNf2F4e9MF4DPOEi36UFZ5hqzDnhF9AsuzrxSuo8/mQ4fsyz8XzCPHfWLkLCvYK5zqAkl1naHaB8aFeMUasVDJQ9wDBZqqmNimp3ea1nlknf7HkOBTY6AbwVJ6gYkcuMDQC2c+pkTwhR1xY5Tz2o/fuVtlnvU=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(14060799003)(82310400026)(35042699022)(1800799024)(376014)(7416014)(36860700013)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7VZBvp8uqK6tB5vItqscnQri17rrXRBb2r1CC3bj16Wg7x0lkyHGxExd/tcmRs7OPkpIk7F5nNDFhujclashvPbZMdOmhhEpzBPlVxhzj15nER9hRWLt0ixtwFaovaepv0qOXNAJ6VRib2ro4vfc8pBK87oeK1momwptgO5FxhcuHf7bkToSVxdxyAq5QBZ2CRXJMypMbi/nGtdLX1+P9FyIDp0v5L6g3P3bqdhT04DgovGU1soaAVkyIeRZQ9L7R7ylDSpz/rMLSHYZSwMAXXhJS0ANDElgQdHzbMqGo1MiPf5lAivabcLhLJSGMOxfFsXbYrswXlPILfXGwgndij+LC5geFZGCsqP7g3lyezZP4C7jynfcn0TcKKPX17YxlOSAQKthDtOpL5L9Hf7B4EBpTOKSkcbLvKwscPX8oj3cRUeeC74C+NZmsElvWyPx
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 11:34:45.8807
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57319a33-cc76-4e5a-5a2d-08de7461e06f
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509FF.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7359
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
	TAGGED_FROM(0.00)[bounces-6622-lists,linux-can=lfdr.de];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,linaro.org,axentia.se,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com,renesas.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,solid-run.com:mid,solid-run.com:email,glider.be:email,sang-engineering.com:email,solidrn.onmicrosoft.com:dkim];
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
X-Rspamd-Queue-Id: E039B196A6C
X-Rspamd-Action: no action

Multiplexer subsystem has now added helpers for getting managed optional
mux-state.

Switch to the new devm_mux_state_get_optional helper.

This change is only compile-tested.

Acked-by: Vinod Koul <vkoul@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 drivers/phy/phy-can-transceiver.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-transceiver.c
index fcbca9d2bded..2b52e47f247a 100644
--- a/drivers/phy/phy-can-transceiver.c
+++ b/drivers/phy/phy-can-transceiver.c
@@ -126,16 +126,6 @@ static const struct of_device_id can_transceiver_phy_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, can_transceiver_phy_ids);
 
-/* Temporary wrapper until the multiplexer subsystem supports optional muxes */
-static inline struct mux_state *
-can_transceiver_phy_mux_state_get_optional(struct device *dev, const char *mux_name)
-{
-	if (!of_property_present(dev->of_node, "mux-states"))
-		return NULL;
-
-	return devm_mux_state_get(dev, mux_name);
-}
-
 static struct phy *can_transceiver_phy_xlate(struct device *dev,
 					     const struct of_phandle_args *args)
 {
@@ -183,7 +173,7 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
 	priv->num_ch = num_ch;
 	platform_set_drvdata(pdev, priv);
 
-	mux_state = can_transceiver_phy_mux_state_get_optional(dev, NULL);
+	mux_state = devm_mux_state_get_optional(dev, NULL);
 	if (IS_ERR(mux_state))
 		return PTR_ERR(mux_state);
 

-- 
2.43.0


