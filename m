Return-Path: <linux-can+bounces-4371-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A92B351AB
	for <lists+linux-can@lfdr.de>; Tue, 26 Aug 2025 04:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72C621B61394
	for <lists+linux-can@lfdr.de>; Tue, 26 Aug 2025 02:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0083E268C55;
	Tue, 26 Aug 2025 02:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="h24wJEnO"
X-Original-To: linux-can@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013027.outbound.protection.outlook.com [40.107.159.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF11525B1DC;
	Tue, 26 Aug 2025 02:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756175332; cv=fail; b=OMKpQcYhUw99EGnSdmmemqVcfv8sHQV1OEIz/Ep33hENw0VONYUtl+Th0Hw8cJ+LD3SHZ1mtTCtRTsbGchmshNsGsI4FgAmS0Utyu2UVbR0EO7JtmQ/a2mELiRwy5fmkuR5l1FmuPRGOS1gvy064Mtpc3nCRMQp19lVcDMoLszc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756175332; c=relaxed/simple;
	bh=iDSg6BCByaqZz9hZUsCvUdvXjSMiGdX6DHhYeZ5hWJs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qIfrUUwY7iI/SSXIPIlUnnhCX0nn4F8nYaCd/eMj6GinFKhn8q2Kp/WZLnCPF53tSA7Lqe8Ka6xh4RORodMT6MoF3aNJ5MNliLDDufeaUya+0S5LpVeajBvRN+REYtZYw+fgNFbsG08vpBgqzKvvob+RkIGfsmSE38cdzcsOEx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=h24wJEnO; arc=fail smtp.client-ip=40.107.159.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Og9zyoU9Me7zvDaRX8q8f5eTu2GJjA5Ne5TJRFmdGfwSlwYqnuxTvFo/vj0UMdiGL1zo44PE1ZqnVWbIMvO3QnAuHos6E4NlNj2AsSKBN/FusSiVaO4SjWa4stbfo6vunc30Ix4rj8i0E94MRhq+LA/CEBJVYmPK/OySoH8/CYyTdFBiCis5c/Up06kMvRLXfr2rB923kHXaaIoAVaguTnA+e2rcJGugJMj5RYdrvZHJMYkfEi8Q/7D1sS0n/kNpKnJiBr4puahk3l8nuvk5kEHwhqUvcBkNRe+T9PUCI4cbc+H2D6UEaFlRwFsJyPY9wDFOU3mJYDmHABj7UB7uVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iDSg6BCByaqZz9hZUsCvUdvXjSMiGdX6DHhYeZ5hWJs=;
 b=F9MOxvaLxYWNHY2DkhOVncQ1HGF43CsPAQMEGj/lZDBSYJ3ZNCE6yOOE1QRQrVWuth6KnSWnd2ZkP+4wiKu2M3BoFJF0S7ASACy0j5HsNAI2f2biTtfa+lvMCiJRYAz8Ko/G3KF9gfWKKmRc0Urn5aptLGxASKoj8MAKO+v3NK/fIs/u/CRjyEFg4XY4B7wrO+3X8i9yuOXkQkj5e2VnvuAL0A6Iu6VXrl8TC9bdBJcXpkvaZfY9UOezudHtmF+c5tChplKrlttO081bGidiZg6vJfzoQd25p5d8E5go1QVEK6C3hvbw9EbOZ3NOmHYIC2qVcaJ6YhVGh1nop4XXoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iDSg6BCByaqZz9hZUsCvUdvXjSMiGdX6DHhYeZ5hWJs=;
 b=h24wJEnOl6MUZi24MR40AL+ly6XMPN81P2srDBoWMui4YzxLmQjvhiyXWxrz497yvd0hplPnb69KLMTeF4RkyrpQX+MUgUkiZ20agEdLZtSfDE8bVCxCy7wLHTtKGFVpjJ66+MpStcBn/gWIz+3PauMl/An+bq3asLGBno9f9CTZa8I0ST8Prh+7gulP9lvBL9u3FsO1kOVStfkYPnntIAHILWOPHo9mZeinMrXdOFQfAqKlXIn/ufWMt+eLuHFzZRAXYgliFCNTQxFSLYGxi5san612VGiuLj/57JIEF3K/UnAg30ottL4mnVXykr4IuM+Vxq9EZbVnd3u++xQd0Q==
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by PA1PR04MB10889.eurprd04.prod.outlook.com (2603:10a6:102:491::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.11; Tue, 26 Aug
 2025 02:28:47 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%4]) with mapi id 15.20.9073.010; Tue, 26 Aug 2025
 02:28:46 +0000
From: Bough Chen <haibo.chen@nxp.com>
To: Sherry Sun <sherry.sun@nxp.com>, Peng Fan <peng.fan@nxp.com>, Marc
 Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
	<mailhol.vincent@wanadoo.fr>, Vinod Koul <vkoul@kernel.org>, Kishon Vijay
 Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Aswath
 Govindraju <a-govindraju@ti.com>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Frank Li
	<frank.li@nxp.com>
CC: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Peng Fan <peng.fan@nxp.com>
Subject: RE: [PATCH v2 3/5] arm64: dts: imx95-15x15-evk: Use phys to replace
 xceiver-supply
Thread-Topic: [PATCH v2 3/5] arm64: dts: imx95-15x15-evk: Use phys to replace
 xceiver-supply
Thread-Index: AQHcFZt4BQdNsJVtLE2c7MgeVFovJrR0NHqAgAACGVA=
Date: Tue, 26 Aug 2025 02:28:46 +0000
Message-ID:
 <DU0PR04MB9496B00796E5B862A10CDF849039A@DU0PR04MB9496.eurprd04.prod.outlook.com>
References: <20250825-can-v2-0-c461e9fcbc14@nxp.com>
 <20250825-can-v2-3-c461e9fcbc14@nxp.com>
 <DB9PR04MB8429631F164C8AE7571AE3CB9239A@DB9PR04MB8429.eurprd04.prod.outlook.com>
In-Reply-To:
 <DB9PR04MB8429631F164C8AE7571AE3CB9239A@DB9PR04MB8429.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9496:EE_|PA1PR04MB10889:EE_
x-ms-office365-filtering-correlation-id: d8869a3f-16bf-422a-6003-08dde44848ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|7416014|366016|1800799024|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?bVBhWWVOVGZsUXJVZFBldngybWhtMk1rNVJ0OFhPRnRhd1VJQXljSS9INk1H?=
 =?utf-8?B?M2FNWFFWTHl2YXdJWkJ4Q1Rzam1NNWFQa1hFaCszcEtNT2JQUDlSeW5iajQw?=
 =?utf-8?B?Rkl0SG1mY21vWDdDZ29oc2VHcUpLTG9LSzhwdVl3c0VKd05TN29QQlFScmFF?=
 =?utf-8?B?YUJSU3NRTTJ4ZmRFd01wYjNnREUzanlpRVNtQUNiSG9udVp6dUJST3dCMExC?=
 =?utf-8?B?U203OWROSzlTMHEyVEl0SzJsRjRoNWxkU1JIQW1jMTMwYUhxazNlYklwdTJG?=
 =?utf-8?B?dGxLNkFHMy8zN0pFYkI0dlg2eCtvckNQTlB6Q1Axc3lyVkx2d2x4THNNY3Z6?=
 =?utf-8?B?UWp0QWxQRGJ5RHowV0NHeXJuME5aaHpXeDc1OWpsZC8yU2VMdFAxeS9xQnVW?=
 =?utf-8?B?WGxhRGxNZlZwM0hLUkY5Ty95b2pjaFBaYWZ4MlIrRTJTU0RCckRpejUxa0JG?=
 =?utf-8?B?QzQwVytCV05vSEZBVFh5K1dUL2RQTVF6amlvMjVwM1JZUE5hTUJNb2VZVVlY?=
 =?utf-8?B?M2U1TkJieGFtQVBGaEI1K3g5S0VnT1FBMnp1YzI0elFSNkxNTnBtN0d3S1pU?=
 =?utf-8?B?L09VRVFXd21iTUwwNjVyeno2cHQ3OU52cXFmTGk5dUxLVWpXblprK25pR3J0?=
 =?utf-8?B?RTlvWHJaK2JLL00zS3lQaE13VjJlZlllVHlpS2FETGlrYlNLSDRndHl3T3J3?=
 =?utf-8?B?ejhENVQzNGp5OUJuUjVlUDhmMVphcXNiaG5Vd0ZpeWVzWVlPaUY0SWloNlpJ?=
 =?utf-8?B?d1lCc1k3WlN1TC9mL3BhTVlPakl5UTlQZlY5YmFDeUh2eDJLSklDOFpDZVkw?=
 =?utf-8?B?R0VmaHhBTTVyVmxMc1g1eG5ZTjZpV201aC9Tb1MzTlVvUmYrYU43dTB3VzRX?=
 =?utf-8?B?dEtCcFVVbncyRk1naDdZNzk4dUpBT3Z2SUhjUTREb1p0RG5FTjJ0QWFuejFR?=
 =?utf-8?B?T0RZa3dmYnVqQkJRZ2lKYWtHL2ZsZFRqcnVLVTd0NlgyeFJkbUF4R3N2Z1lj?=
 =?utf-8?B?V1c5N25LNEpIdmhwcUl0MGFxU1ZpaTBTems4UHdnMHUweldTSCtFRjAwTTAy?=
 =?utf-8?B?bW1Ia0Z4RHhxbWFEWWFrZXhVak5oTERMZ01BUEcwdmpiWXNCdDVnc25ZMXRl?=
 =?utf-8?B?R05HR2F2NGFZVHloWE5xalVrVnZUazQrR0kxZkYxMm9SNlNzKzNNTHlDZ2hY?=
 =?utf-8?B?dm9YKzVjQTNPRmRxTkhXS21PejF5eDFId2dobmFKTGRFaFZrWmRyazdEYTJh?=
 =?utf-8?B?V2ZLbVU0K3NvOWVCUWNrc0xSZVdqNGM3NzVIRldkYWZjNTVDa2U5c1dwRi9j?=
 =?utf-8?B?TGFFbC9ScmlZNitSWFNXWFpmSXFvZ3MxeGhLUTR6UTVNYTZsMHQ3VTVWSDk3?=
 =?utf-8?B?ZlgyY254M3VydjdZNVUzL0FnY2VVUDhwek5yR0NXakxjU3I5UlR6MGdwMkRa?=
 =?utf-8?B?dTlYRkpPUzIzL25UVTZJS0Z0dURPNTZlUkpyNXJBK3J3YmdzUGZla3VrbHFm?=
 =?utf-8?B?QVUwamYzbVFKN25EcncxUHJ5OVZlSmRKQkhBTXlsNzgveTlOWXFLYlA0aEZF?=
 =?utf-8?B?cDFqeEdlSTNrazJkai82Q3JvRS8wNm5aQVdMOEI4c3BzQVc1V0twSllDNnVQ?=
 =?utf-8?B?WHNiZ3JyV2JvYVJpU1BpM3M4WjVCUENySC85cklmZmxsSHBqa21WR081MmF0?=
 =?utf-8?B?NkVqTVo0cTVMenJldEIySGVQb0cyT3dUNjdZeUNCTU9KeGpjSzJuTnQrRnhG?=
 =?utf-8?B?VGFNSnovb1hBNWhnZndDQUdTc24vZmFudnFyT3d2Q0VFY1FFTmszamJhYmY4?=
 =?utf-8?B?ekl4Y2Y5RGora0ZBdHFRMkN2cjByWDMrb25VTDQ1dmhWNU03aVkxRFRuN2dG?=
 =?utf-8?B?V0F6WnduQzgwUXdpbjRTNE40dmtEQVY0akRWc1NEeHV3ekNNUzVpNkQydytm?=
 =?utf-8?B?V25IMjJvK3JjaVRXZUsvcmlHM2pzcVYrZCtmN2tBcVdmUE5IS1JLV3o2YllO?=
 =?utf-8?B?aFZzR1FBM2xZbEltdHdEYWZZWGdqa0J0M3pCZFR0bDdKRHpDc205MVpuR1Zt?=
 =?utf-8?Q?3Q1HyX?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(7416014)(366016)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YWpoRUlNdlhVaWs3emRrZ09VVFBOMFhWZlRHYjFteTNqUFRDKzJDMFQ0Zmdq?=
 =?utf-8?B?N05pWStWUGp3N044WGFzeXpxTDVqNTV1RDZWbzd6VHpLTitrLy91eXJ0bHpH?=
 =?utf-8?B?VzUxQ1FIWXJRdUVic1NhNkwyUTZFTk84T2dYcEVtWnoyT1hZZHk5TGM0WU9X?=
 =?utf-8?B?MGxONUVwUXpSWFJRYjluZUpHdzhyKzFETkprb0VyTVBiYVFWeW0zamp1NFNE?=
 =?utf-8?B?R1JyUmwydm94T0h5bmNTUFNlaTg4MU1oYjM1SFh3d2haakJEdDVEV3g3RnR6?=
 =?utf-8?B?bmJKdGZ2Q1IxRktpSjkwZis4UlVCQlcvaWdEdHFrbjNDdVd5Q1J2dVdJb01R?=
 =?utf-8?B?Y21aUGlkV2ozQTRha24vUHlvM3R6R2pYaGN2TjloUzFFREpyQXlNS3hFS3R3?=
 =?utf-8?B?SkxTZ2ZOSWZmckxvSnNhVTg5SlhNc3dPb3BWVnEvZUFscGlPOURkeldITkQr?=
 =?utf-8?B?TkdEWUxrWjl6ZTZoVUhkMTh1VEdlVy9MVVZlUlN6c3NLbktVblgrSTFLcnhi?=
 =?utf-8?B?NEFTYkZGaEJ3cTYzNkpaVmROZjRURjhVYUd2eVRWYzlwNUFMMnlKU3ZIdnJ2?=
 =?utf-8?B?aW9KSDFCQkprR25jbjdsbkwyMXJjSmtWdEV1V3ZxWUlFTnp1ZEIzK3MwdFNJ?=
 =?utf-8?B?YzFxbTFERy9uT0RSVWEzQWM5VnF2cTMrKzVTNThvamRjWjhBSy9yOGFhSnJU?=
 =?utf-8?B?SldBdklVdjdVMmVxTGpWSE43Q0FWS0RRM3VPSThPblNZK3dpdjhMUGtWVS9K?=
 =?utf-8?B?SThQRGtPVUErMkU3elNrNmtoZGRnU0szOGFsdUlxaHZ2RU44OHZtUkkrVTVT?=
 =?utf-8?B?RXA1dEtpS2NDRHJjcktWMW00OFBZQWhxclN1Z0hKUHo4QVFra2RtWWc0ekRP?=
 =?utf-8?B?WW54ZjBwYm4xRjBiZ2grUXlleWdibTVQS1c3M0JYSnpwb1VHNXhBbERWa2hw?=
 =?utf-8?B?OHMwVkZwQ0o5eXN1dDFTcDlPNEo1WXcxdFN5MVpSMlk4V1lpVUFaSGpJZ1Q2?=
 =?utf-8?B?WWcydllFTEpWUWlTc2pnbjZYQzRES053eDEzVTlzdHBOUnQvcU9jY1ZrYXlh?=
 =?utf-8?B?cHlrVENBcXhHVXJreEpzc3d5amlyY0ZWQVBXUkcvUTg0MDRWWUhZYXl3eW0z?=
 =?utf-8?B?eGlEUUlFVmpFVHdsaDRXS3V1dE1vUDZYK3VPbW55YWt4R0x1b3FVNnNOTmUz?=
 =?utf-8?B?eFk4RitCUitoL0sxR29tS3gxTTdSVHpPUTVzQ2pMUWxBQVh2bEdLcW5pbWcx?=
 =?utf-8?B?bmVqcGtrNTM3VHNFN0QxRy9ZbHNPTVFYWEt0Rlc4a0JtVkNLaXV3Y1ZZS29Z?=
 =?utf-8?B?ZEV1YS80bG5CVFNvemVVeWRxVER2dVBFTlltR1FPUCtCVzNPMHVnbzhoVHhJ?=
 =?utf-8?B?S2E2QUtNTzcrVmVqbjhSeWs1OEdJUnJBRThkWVppU20wUitXTVZXTEFHMis2?=
 =?utf-8?B?YktveU9LUHh6T3Vhb3RVckRGL1JBcEV2a25KWVNvbVp2R0hNUzBqRit3MHc2?=
 =?utf-8?B?MXZ3ZXBmTlNLaDQvNFVzdHNscjZQZzFkMmgzN0dhMVBLclNHaUxhRFZyaFR5?=
 =?utf-8?B?eVNuNWRUWWpPbnhCY3o5RzAzQ3Bwb3BpQjQ4QXZEd0x6VnUycjFwcVhFbFUv?=
 =?utf-8?B?a21vVW9OSTRiOWJYeVN5V1RnMTFOaW82eVY3MkZVOUpaU0Vnck9rY1lDVUNz?=
 =?utf-8?B?NnhORG1aaWwrM2I5NWRXWlJNcGt2VFkrR1FTWkRPRTcyZFFBajI1S1dqWDBS?=
 =?utf-8?B?ZHl1c29XWEpiTFgzWXNOSU9JelRvTEEvNzFjb2lzekVZcHVLaHhMd2F3NStq?=
 =?utf-8?B?Sm5GS0JWYjNGV21wVEJsUEN5NUd3OWcrTlh6SmFoRjVXNTF2OE9UWkt3VXZH?=
 =?utf-8?B?YS8zTFhpMGZSaDVXQ2grZ0M1QmhFZW9TZGJYK1kwOEx5NHdSNGFlVjNjYmdE?=
 =?utf-8?B?SGxvSzZWWDdqWG11dkVoWTZqY2tIZTVUWGkyaTA5T0E5TUFzWVdSOEE4dWVK?=
 =?utf-8?B?WnpRNmpzNTRZUHJnWHR1UDRHbXVVbEFwakhQQ1FXeWRrM2xsOVhuMng1MUxW?=
 =?utf-8?B?OW9waGlPMTJFTk5mbjJqZm9taE1zS3NlTWdFZGY0QlZGWU5QK1FXekRBL3pr?=
 =?utf-8?Q?IrN1W48KVCpiKhFiEcFEntXg0?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8869a3f-16bf-422a-6003-08dde44848ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2025 02:28:46.6531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zcBCaeCLhUvqQOKuXLZfmmIxYx6XbCJ8lC0HJspnEcNg53N4Awd4P+tLWlpjtGWhWprFjaPXDRjvWL98Uf8C6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10889

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTaGVycnkgU3VuIDxzaGVycnku
c3VuQG54cC5jb20+DQo+IFNlbnQ6IDIwMjXlubQ45pyIMjbml6UgMTA6MTkNCj4gVG86IFBlbmcg
RmFuIDxwZW5nLmZhbkBueHAuY29tPjsgTWFyYyBLbGVpbmUtQnVkZGUgPG1rbEBwZW5ndXRyb25p
eC5kZT47DQo+IFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI+OyBW
aW5vZCBLb3VsDQo+IDx2a291bEBrZXJuZWwub3JnPjsgS2lzaG9uIFZpamF5IEFicmFoYW0gSSA8
a2lzaG9uQGtlcm5lbC5vcmc+OyBSb2IgSGVycmluZw0KPiA8cm9iaEBrZXJuZWwub3JnPjsgS3J6
eXN6dG9mIEtvemxvd3NraSA8a3J6aytkdEBrZXJuZWwub3JnPjsgQ29ub3IgRG9vbGV5DQo+IDxj
b25vcitkdEBrZXJuZWwub3JnPjsgQXN3YXRoIEdvdmluZHJhanUgPGEtZ292aW5kcmFqdUB0aS5j
b20+OyBTaGF3bg0KPiBHdW8gPHNoYXduZ3VvQGtlcm5lbC5vcmc+OyBTYXNjaGEgSGF1ZXIgPHMu
aGF1ZXJAcGVuZ3V0cm9uaXguZGU+Ow0KPiBQZW5ndXRyb25peCBLZXJuZWwgVGVhbSA8a2VybmVs
QHBlbmd1dHJvbml4LmRlPjsgRmFiaW8gRXN0ZXZhbQ0KPiA8ZmVzdGV2YW1AZ21haWwuY29tPjsg
RnJhbmsgTGkgPGZyYW5rLmxpQG54cC5jb20+OyBCb3VnaCBDaGVuDQo+IDxoYWliby5jaGVuQG54
cC5jb20+DQo+IENjOiBsaW51eC1jYW5Admdlci5rZXJuZWwub3JnOyBsaW51eC1waHlAbGlzdHMu
aW5mcmFkZWFkLm9yZzsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc7IGlteEBsaXN0cy5saW51eC5kZXY7DQo+IGxpbnV4LWFybS1rZXJu
ZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+IFN1
YmplY3Q6IFJFOiBbUEFUQ0ggdjIgMy81XSBhcm02NDogZHRzOiBpbXg5NS0xNXgxNS1ldms6IFVz
ZSBwaHlzIHRvIHJlcGxhY2UNCj4geGNlaXZlci1zdXBwbHkNCj4gDQo+IA0KPiANCj4gPiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAu
Y29tPg0KPiA+IFNlbnQ6IE1vbmRheSwgQXVndXN0IDI1LCAyMDI1IDQ6MzcgUE0NCj4gPiBUbzog
TWFyYyBLbGVpbmUtQnVkZGUgPG1rbEBwZW5ndXRyb25peC5kZT47IFZpbmNlbnQgTWFpbGhvbA0K
PiA+IDxtYWlsaG9sLnZpbmNlbnRAd2FuYWRvby5mcj47IFZpbm9kIEtvdWwgPHZrb3VsQGtlcm5l
bC5vcmc+OyBLaXNob24NCj4gPiBWaWpheSBBYnJhaGFtIEkgPGtpc2hvbkBrZXJuZWwub3JnPjsg
Um9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz47DQo+ID4gS3J6eXN6dG9mIEtvemxvd3NraSA8
a3J6aytkdEBrZXJuZWwub3JnPjsgQ29ub3IgRG9vbGV5DQo+ID4gPGNvbm9yK2R0QGtlcm5lbC5v
cmc+OyBBc3dhdGggR292aW5kcmFqdSA8YS1nb3ZpbmRyYWp1QHRpLmNvbT47IFNoYXduDQo+ID4g
R3VvIDxzaGF3bmd1b0BrZXJuZWwub3JnPjsgU2FzY2hhIEhhdWVyIDxzLmhhdWVyQHBlbmd1dHJv
bml4LmRlPjsNCj4gPiBQZW5ndXRyb25peCBLZXJuZWwgVGVhbSA8a2VybmVsQHBlbmd1dHJvbml4
LmRlPjsgRmFiaW8gRXN0ZXZhbQ0KPiA+IDxmZXN0ZXZhbUBnbWFpbC5jb20+OyBGcmFuayBMaSA8
ZnJhbmsubGlAbnhwLmNvbT47IEJvdWdoIENoZW4NCj4gPiA8aGFpYm8uY2hlbkBueHAuY29tPg0K
PiA+IENjOiBsaW51eC1jYW5Admdlci5rZXJuZWwub3JnOyBsaW51eC1waHlAbGlzdHMuaW5mcmFk
ZWFkLm9yZzsNCj4gPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZzsNCj4gPiBpbXhAbGlzdHMubGludXguZGV2OyBsaW51eC1hcm0ta2VybmVs
QGxpc3RzLmluZnJhZGVhZC5vcmc7IFBlbmcgRmFuDQo+ID4gPHBlbmcuZmFuQG54cC5jb20+DQo+
ID4gU3ViamVjdDogW1BBVENIIHYyIDMvNV0gYXJtNjQ6IGR0czogaW14OTUtMTV4MTUtZXZrOiBV
c2UgcGh5cyB0bw0KPiA+IHJlcGxhY2UgeGNlaXZlci1zdXBwbHkNCj4gPg0KPiA+IFRoZSBUSkEx
MDUxVC8zIHVzZWQgb24gaS5NWDk1LTE1eDE1LUVWSyBpcyBhY3R1YWxseSBoaWdoLXNwZWVkIENB
Tg0KPiA+IHRyYW5zY2VpdmVyLCBub3QgYSByZWd1bGF0b3Igc3VwcGx5LiBTbyB1c2UgcGh5cyB0
byByZWZsZWN0IHRoZSB0cnV0aC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFBlbmcgRmFuIDxw
ZW5nLmZhbkBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVz
Y2FsZS9pbXg5NS0xNXgxNS1ldmsuZHRzIHwgMTMgKysrKysrLS0tLS0tLQ0KPiA+ICAxIGZpbGUg
Y2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAt
LWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDk1LTE1eDE1LWV2ay5kdHMN
Cj4gPiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDk1LTE1eDE1LWV2ay5kdHMN
Cj4gPiBpbmRleA0KPiA+DQo+IDQ2ZjZlMGZiZjJiMDkxMDZlNmU3MjZmZjhiNjE1MjJkMTM1OWNm
YTQuLmY2MTk3YmEzNTZkNDliOTdiZjcyODdjM2YwDQo+ID4gZjg2ZWY4NGY4OWJhYzkgMTAwNjQ0
DQo+ID4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OTUtMTV4MTUtZXZr
LmR0cw0KPiA+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDk1LTE1eDE1
LWV2ay5kdHMNCj4gPiBAQCAtODksMTIgKzg5LDExIEBAIHJlZ19hdWRpb19zd2l0Y2gxOiByZWd1
bGF0b3ItYXVkaW8tc3dpdGNoMSB7DQo+ID4gIAkJZ3BpbyA9IDwmcGNhbDY1MjQgMCBHUElPX0FD
VElWRV9MT1c+Ow0KPiA+ICAJfTsNCj4gPg0KPiA+IC0JcmVnX2NhbjJfc3RieTogcmVndWxhdG9y
LWNhbjItc3RieSB7DQo+ID4gLQkJY29tcGF0aWJsZSA9ICJyZWd1bGF0b3ItZml4ZWQiOw0KPiA+
IC0JCXJlZ3VsYXRvci1tYXgtbWljcm92b2x0ID0gPDMzMDAwMDA+Ow0KPiA+IC0JCXJlZ3VsYXRv
ci1taW4tbWljcm92b2x0ID0gPDMzMDAwMDA+Ow0KPiA+IC0JCXJlZ3VsYXRvci1uYW1lID0gImNh
bjItc3RieSI7DQo+ID4gLQkJZ3BpbyA9IDwmcGNhbDY1MjQgMTQgR1BJT19BQ1RJVkVfTE9XPjsN
Cj4gPiArCWZsZXhjYW4yX3BoeTogY2FuLXBoeSB7DQo+ID4gKwkJY29tcGF0aWJsZSA9ICJueHAs
dGphMTA1MSIsICJ0aSx0Y2FuMTA0MyI7DQo+ID4gKwkJI3BoeS1jZWxscyA9IDwwPjsNCj4gPiAr
CQltYXgtYml0cmF0ZSA9IDwxMDAwMDAwPjsNCj4gDQo+IEhpIFBlbmcsIHNob3VsZG4ndCB0aGUg
bWF4LWJpdHJhdGUgb2YgVEpBMTA1MSBiZSA1MDAwMDAwPw0KDQpZZXMsIGFjY29yZGluZyB0byB0
aGUgZGF0YXNoZWV0IG9mIFRKQTEwNTEsIENBTiBGRCBmYXN0IHBoYXNlIGF0IGRhdGEgcmF0ZXMg
dXAgdG8gNSBNYml0L3MNCmh0dHBzOi8vd3d3Lm54cC5jb20vZG9jcy9lbi9kYXRhLXNoZWV0L1RK
QTEwNTEucGRmDQoNClBsZWFzZSBjb3JyZWN0IHRoaXMsIGhlcmUgdGhlIG1heC1iaXRyYXRlIGFs
c28gbGltaXQgdGhlIGRhdGEgYml0cmF0ZS4NCg0KUmVnYXJkcw0KSGFpYm8gQ2hlbg0KPiANCj4g
QmVzdCBSZWdhcmRzDQo+IFNoZXJyeQ0KPiANCj4gPiArCQlzdGFuZGJ5LWdwaW9zID0gPCZwY2Fs
NjUyNCAxNCBHUElPX0FDVElWRV9ISUdIPjsNCj4gPiAgCX07DQo+ID4NCj4gPiAgCXJlZ19tMl9w
d3I6IHJlZ3VsYXRvci1tMi1wd3Igew0KPiA+IEBAIC0zMDAsNyArMjk5LDcgQEAgJmVuZXRjX3Bv
cnQxIHsNCj4gPiAgJmZsZXhjYW4yIHsNCj4gPiAgCXBpbmN0cmwtMCA9IDwmcGluY3RybF9mbGV4
Y2FuMj47DQo+ID4gIAlwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KPiA+IC0JeGNlaXZlci1z
dXBwbHkgPSA8JnJlZ19jYW4yX3N0Ynk+Ow0KPiA+ICsJcGh5cyA9IDwmZmxleGNhbjJfcGh5PjsN
Cj4gPiAgCXN0YXR1cyA9ICJva2F5IjsNCj4gPiAgfTsNCj4gPg0KPiA+DQo+ID4gLS0NCj4gPiAy
LjM3LjENCj4gPg0KDQo=

