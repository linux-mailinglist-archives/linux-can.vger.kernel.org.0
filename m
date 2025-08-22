Return-Path: <linux-can+bounces-4290-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9BFB30D42
	for <lists+linux-can@lfdr.de>; Fri, 22 Aug 2025 06:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A89577A6BF4
	for <lists+linux-can@lfdr.de>; Fri, 22 Aug 2025 04:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88358274B32;
	Fri, 22 Aug 2025 04:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UhKbGfCc"
X-Original-To: linux-can@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012024.outbound.protection.outlook.com [52.101.66.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE9A21FF45;
	Fri, 22 Aug 2025 04:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755835556; cv=fail; b=qcwVDrYOK12ILzHJVT/llG+JYu/tlOsBkycYuvoJF99uXY+RYjT5OLo6e9YUACKUV5cv6tYzy75FWemPniRQRbYaGKzMJu/2x/9+aQc+ylPd/6ppIs4TvZ+8qm/1PQUFH8ofuyJfEf5mf9+9BjenedolJTIyOBlyASID9B9vD+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755835556; c=relaxed/simple;
	bh=JfY4W/EQ+RvusW516t4Xw3FLAs5A3dvKj29K86+Wz3A=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=enm7MJ+rJZMUd0fbNEVQQFlSFVApOT+L2G0hdzleiVj/1T0g2bAetDPRI8VBvTymzCd6lC2xckrsdKdJogvc7zIyBcjTbUwmpnKHffGIVlro5dIEkw/aimgobugcr9HWfC6ZLRAJDDGzECWYwvve+1YhKvj1elgReSO1jNp5pLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UhKbGfCc; arc=fail smtp.client-ip=52.101.66.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FlwAwCFIb8ThOeFvhvmmkgLZIeS8b00ym6UyjFvJDBBN43p5QB6RHyc6ZFJlawkdrf1SiWBux6L/jjl/rra5ZgtPCD8ZFPa65+OBbxGlvTkiFY+J847C16zsnjfb+s3pr3o0phNqZGutIJ2VKRv1YdEhlcEZKdk9K5vJ268eoP/h4zyt6Pu7NT5z+tVOI2yPczF+wMAF1X2Icy9BECcZnsvvok6oX4dNBf5Zzuuuy+nAKkRk3S/rFYiuX8XvEWT8L/PpTW4UyffSp/g9jEayM6qAn09kR7UCnHLEwHBGW3R0/WnvlAe9aCPI78MSwhAp0uGabfPGmJe3vRJEu3VZqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7lXEIyunQZ6jM9C6YbgZuG9uw3UxrBoeDI7oouAV4Nc=;
 b=jVFzprtN+QLCjA0eyipwUfECg3EoDTneecXhiGKRC36aU4vakIU/WMz9EpFw98E5z5nNsWrdbGCRKeLSxXdO5q4DKD+un3oHOQoE/GwO+5rmrXRGONaJsLgAs68uQft6xrmwNime3+rbrAc2FBsjr8dtXvO5iAsUqWD3kJDTWk7gD5xMKHJegyS+0trHwy+InWYf2foZj6dwdPKfwLwmtWYy2MHwoIhQpQ3IrC5rq7GgWPq/02QPR05hQJavsuRkCvb+cLAqDVf74xxKrC50GqXn1tDvKIi6VTIpWaRSF2tEXj8tu/am1PGbpUnp3aqxWBCXQjgkgDievH/tARVhRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7lXEIyunQZ6jM9C6YbgZuG9uw3UxrBoeDI7oouAV4Nc=;
 b=UhKbGfCcq0lXYBdfxFjJTRrajko4pHNx48HwfJoin4PCKVfc2h9gsUTFDqM8jIuuF1+QD4N5sRyQyhd0zaJygOMzTQDhtqKxQeZiIzeL2htTojHtHKODT/fyMwxD5ny3s1TJk3SfUD8Ps/Jca4w2FdNB5+h+7BFBQsOJM8hfbds4Hb1yTJ42IbAbWQde5yLG32t/KPROWXAPmpyGk+2u62EHp3YL6JwMOq64bwDhn8wdYdamaWXb+L5XyrHVpXWK0QWEdTpNdIpI+WYVvVTgtH5XVK+XE1SoivZJ/HAwxG8e5hbPoXzSc4q8c/JWDnm/QG8vavFjxmGDSihra1qr/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI2PR04MB10569.eurprd04.prod.outlook.com (2603:10a6:800:273::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Fri, 22 Aug
 2025 04:05:50 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 04:05:50 +0000
From: Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 0/6] phy: phy-can-transceiver: Support TJA1048/TJA1051
Date: Fri, 22 Aug 2025 12:05:27 +0800
Message-Id: <20250822-can-v1-0-c075f702adea@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIfsp2gC/1WMQQ7CIBBFr9LMWgwDJTauvIfpAqbUzkJooCE1D
 XcXu3P5fv57B2Sf2Ge4dwckXzhzDA3w0gEtNry84KkxKKmMHBQKskHQoBW5fpZaaWjPNfmZ97P
 yHBsvnLeYPme04G/99wsKKVxvrEU0dJvcI+zrleIbxlrrF1+mcxuUAAAA
X-Change-ID: 20250821-can-c832cb4f0323
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Aswath Govindraju <a-govindraju@ti.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <frank.li@nxp.com>, 
 Haibo Chen <haibo.chen@nxp.com>
Cc: linux-can@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755835544; l=1540;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=JfY4W/EQ+RvusW516t4Xw3FLAs5A3dvKj29K86+Wz3A=;
 b=igncpEXa3jIZNYs9oQH/2hbOSxg2oh3XfHeg4AcAhi+1+OWVcCaOcHFZaH+7aSrYdWoYPMnw9
 WcTzNrC7uMsDcKzBgfZpnSCFlnHYtKZDQlmmK4RgRLMQF9lKTgFHaM3
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR04CA0189.apcprd04.prod.outlook.com
 (2603:1096:4:14::27) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI2PR04MB10569:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b8ebb90-8996-4d9f-2476-08dde1312e26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|52116014|19092799006|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?REZ4TGRvYUxoRDM2L3FWTEdxaHhhbkxNRlpCZFJMQU1CVENZcUZZV0dHN0ZQ?=
 =?utf-8?B?ZmQ1TDF3Ri9uZVlOWWNZTDFuR3pNWUhCUmdsUmhWT1JXV3AzS3lUdk5KdEtL?=
 =?utf-8?B?Z05YSzNaL1E4a05zcGJjRUM4NEFlS3piUmMzaW40UldReXZVQVAwb29JaWpY?=
 =?utf-8?B?bFlSMXJTTjVrVGZNVEtaRzd1dGFLUzVpSzNZWS9NRjdHSlpyM1piV3hSTElu?=
 =?utf-8?B?clFXemN0UkNNQ2NKUENOOE1UMmZQY21JQk51RGprYXUwOFlDN09Ob1RmK3k1?=
 =?utf-8?B?cUJHQk1Jc1BwRkZ0Q3RNWXdpZlJvbXl1OTdRRlk3UXc0cCttSEVLbklLUVVI?=
 =?utf-8?B?RnNIa2k1VVBYTXFTdmYyZnF0K0k0M1MzMmFxbU5Fdy9FNHd0M1FMNmxndjA5?=
 =?utf-8?B?Y0ZoaUNxakwybGY0dHJzNkVYd3JFaEFWY1RObWxyeENobWE0UzEwQi9QVHBK?=
 =?utf-8?B?YVlhUE8zL1V0YmZBcGFzdXBqNjl6L3lNV3k1aFRUWEF5eHZ5N1lUcGw3WVVp?=
 =?utf-8?B?cTUrb0kraU1ZN2p3aXg2MmxZTU12b0FvQUt1NzZmcFVldk82a2RNOTFSKzFX?=
 =?utf-8?B?a2dqeHM2M0lRNkp0YldoWXBUc2crbkNycTJGb1pmTjdvL2N0OFd1VXpkWlNy?=
 =?utf-8?B?Wjk3N3lETytmZ0Q0NTFKQmVqY292cHNkYlUwU0twTDRuY0VJNm9NL1lOOWRi?=
 =?utf-8?B?ODFoZE5nUjhkdjFzMTVYdkZ3UGl5SWUzQ2NOdDRmS1M3WkxDZ1RmelI1bjBS?=
 =?utf-8?B?UVFqNEdUWUpvNDhJRHp4Nks0cnVZdzgzOFdSdE0wM2Y0VWtEWGw5dWYxaU5L?=
 =?utf-8?B?NlpMUzd0TURlWFo4TGdsWk5rN1RoTFl6VTAxRjgvRXN0WjFDakUrY0diTWRq?=
 =?utf-8?B?UUc3ekRvZkhPSGQ2WkVWVVczQmFvLzNWYU0ydXZOYXR2U2hZaHJCVVBnUVRL?=
 =?utf-8?B?bzZmM2RxeHBZTGpITHRHc2NZNFYzVlZ0Y01DaU4wMElmdUNnSVhJd1VCaUZq?=
 =?utf-8?B?NERnVFlKdTlWNEgvdjZFUnRFZ2tYV0RacW5tYTBsU3R2dWxnMGpGdGtDS3FS?=
 =?utf-8?B?dTFia0pDeGtIVDFsWnZMM2JzaDQyVUZHVy9WSHBrMTVialFmWFRsRThsa3ZS?=
 =?utf-8?B?UVFYb2ZtNzhZQnRiZ21sSnJjbnY0amFpVnVrL0kwaGV1b1hieW5DUUZlWFNn?=
 =?utf-8?B?ckUvb0pTNHJBQzhSeTRoU2JIUy9WWk5RV3RuYTZ1dFp0ekVydVcyL2NKQW9D?=
 =?utf-8?B?U0YxUHpVUjdoSGZNcnVUUmdVME8rS0p1T2N0MU5tQzJnYzYrUkpkakV2WjVw?=
 =?utf-8?B?Ky85bURuYlhBOWlTSm9NMXk4N2Q2ZkJwRkJ5RmFBcE1tdFM1Z0RZRkFpcHdw?=
 =?utf-8?B?TWYwL1A2VUFqNy8wYVRleU9IWUsyOXBTczVYY1ByQ1FOVlZzcDI3TlhuTCsy?=
 =?utf-8?B?NURkYXIvbXloRmUvTzlobjNCUVkwSmRKZ3RvVnNIK3IwUlFTWVVoRkJMVUNi?=
 =?utf-8?B?a1l6Mlc0VHZiaWc5WGRzcHJRNnVKeXU1cUpmdHJUYlNsT1RvbDFjNUQrcDdD?=
 =?utf-8?B?aURXOWR4dEtWWFByMTBUR2t3TkhVM3h5cFRVTVhmcHgyOHBZdVJ5OHcvSUtN?=
 =?utf-8?B?V3F4TG1FdEkxdUtEY05vSWkwdWo5aTYrZEZzMHB0bUE5NkNXWGcwNkcvaVkz?=
 =?utf-8?B?a0d4OEJ5aDRab1pqeHpNOEFFNDVFVS95K2hSVTJub0k5d0F3clNwU3V3bnRJ?=
 =?utf-8?B?Sk1neGIxemoyWUFHNjVGaVdwUmYwRjUzc0haVDRqM2ZsMDhBS0UvVDRrZGo2?=
 =?utf-8?B?cXVWbGVxTC9HOVVNUEw5aEx1bnRaRlJkT3FocDRZQ0drUzB6Ymp0MU82bUdQ?=
 =?utf-8?B?K0I5Q2pRbWFhSmV6TXFzVUg4VEJXa3QyMzEwT09HUkI3dmZwQytwOGFmL1c1?=
 =?utf-8?B?VWZ0OUxEUkdJb0FjUmk5NGpTMXByZnZkYWxIRnp3ZCtCS3dJZ05aekUxNHBi?=
 =?utf-8?Q?vjXHsOsRzJC2lU+fMdIJFx3ye1FGRM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(52116014)(19092799006)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NGVJR2pYSmNML1pkREJ0MVZGMllxdGxLUldPQUtGVk1NRFJlcFFDS2FLYVNY?=
 =?utf-8?B?ZTQxMjN0Tzg5MC9nZnJpVVhybWdldlU3YzRpbFhuaDdVY2pSZkFYV0sweWkv?=
 =?utf-8?B?Y3RkcWFhUTgwdXRpakZUNlVVM1J0ZzdsQnhUSFpYYytCOFNQOHA3Z0VDR1Rn?=
 =?utf-8?B?WFpQV0FNbVV6UTh6ZEVjQ1FtMnhQVGNwNzhORU9PQXYvYnpmUXFwWDlLVHBz?=
 =?utf-8?B?VDNacjRDdFV5V2Y4RG9wWjFaOUJkZFdmakVLVWdIZmFNWkZXRklMMFFNM0hl?=
 =?utf-8?B?d0lYbGh4UlBsR01OMGhhbGVVM2xFeWh2NXQ5QXBkdDdRdG02VjVjV29TblpJ?=
 =?utf-8?B?eU5GVXd0Q3lDZ1o0cHdGT1BWemhNMThrdGg0U0ZiTi9IdUhtUkw2Lzk4YnND?=
 =?utf-8?B?Y2RTKzE3ckhob21DM0J6RlNyWDNaRVY2WURTbkViUGw3V0h5TFhuTmsvSHk2?=
 =?utf-8?B?QUxIM1U2UUhmbFQ5TlpPQWpJVzlLZVZrcDczMlRDNnhXOHZOU2hkQUNSdkJw?=
 =?utf-8?B?bXR5bktWNCtUTGE0Rll0NVJiMnZzOC9BY21WNnkrTlZnM1pQVmZHSTNRSVNn?=
 =?utf-8?B?Z0pTUWZTM0xKcFd5Mk9nSmpLWVcxTEN5Yi9mb3J6dVlUSDlTWEFOYjdYY0hR?=
 =?utf-8?B?OXdwdWErUW1mdTZxcG1sUGFaMndXaFUxekpoUGZPK3VldUNZQ3F3azQvY2dw?=
 =?utf-8?B?WVArNmZabC9MVlJIMGJOQXJjUXFwS3hqcUl5cmk0T0tiZlNsQ0pFWGdvdHZM?=
 =?utf-8?B?OG9SVkZGWHoyNXRFN3dwNGtqaHZBM1pUSEcwV1JjbFpqYmZMNmIweENSVDV6?=
 =?utf-8?B?Zmx0cFR6VHdBa015RDhLcUNZVVpaWjVhNmx1b3RaZy9iL0dmdjVhS0FoRm1D?=
 =?utf-8?B?bkhkcEdWeHh6WTNBS1NkVytKNkdxTVZCajFWTU5saU1YTDNaUGJGNlpsNk5N?=
 =?utf-8?B?TTlXNUZLdE5WR05tbFV2VEQ4eUZUZHRBL2ZlRUJlQ2NNRlZsSXlBdGtuTTFI?=
 =?utf-8?B?MENtTHphOXI3ckxFL2hoNThlb3haaGd2WnRSUFdzT1Fyd2c4YXBLbHR1VXFT?=
 =?utf-8?B?VzlLMi9hbnl2UC9OdUtEeTZLSjNZcXRaaXhEMC9mVHZBNUhYQ3BGbjErVEhL?=
 =?utf-8?B?Nzl2OWZ4ZjRJNkNJaTlJVzJ1M2lLMWhhM3dQdStCZkRacE1nZmNMbzRZUUU1?=
 =?utf-8?B?QmVVK1lDOXVKYzhDb3BieFF2WEwzNGppK3ZwQ000eUYzdFNxZ1V4bHdUSHB2?=
 =?utf-8?B?Rk52UUJyVjh6MjhOdWdzRWdHbDgyQjBTV0tqdWs2WGh2c2dyMEFQejg1cS9u?=
 =?utf-8?B?ZG5zTDU2cGlZQlF4TVFIVUNka3RNcjFGSytqNUVWOTR0VUkzMXY1WkxZVmlF?=
 =?utf-8?B?M2hucW96RFMzWHVkbGlKR2llQ0dXMXlJYnp3Z3QvOUhGMGV0MzZrSHhlSjRw?=
 =?utf-8?B?QW9KNnBKSEV2YjFabnpxWldHUG9XQ0Y3dVE4dWZKZ1FLQlJ6cEVxQzQrWHFU?=
 =?utf-8?B?ZG4vdDRnQnNTNWtFdnF0eWhFbTVsd3JQTUJJUTh3V1ZKc1BhdGFHTkNJL3h5?=
 =?utf-8?B?M1VhY210Y2kzYm1YTWVUZm5hRjRudGNObzFnSjdYSStJUU4xVE10bXBFa3Jq?=
 =?utf-8?B?ZEpPSlFQUmdQb0hselZQMmxtOURrRzVrbHcyMmZSdWkrL0pKVGVYeXJQWU85?=
 =?utf-8?B?cTZDVXBoNkRmdzZSMmoxcDU5S0ZlMEsyS3c5RHJjMmZhOEE5VU5KR3ZsQnFU?=
 =?utf-8?B?dXEwci9HSEdVYjEwUzNwWUliYWZaaTBTNmxoQ0I2SDJzMFd6ei9ISmtiRHR3?=
 =?utf-8?B?Mm1zS003cXJOTmVORTFHVkRpSnFtU2hLQllKdWlvYzZ2Sk5vb2FCY3BzTnNO?=
 =?utf-8?B?azlERGNCa2ZrK1o4NUZabG5yTkJjZ0NJMk1GNkVscUFBUldoeGNvS0Qrenlx?=
 =?utf-8?B?NStXVlpCc08rYTA4TzZjaUJzOTlXOFp5ZkdrL2ROSmcyTGpvTWc0Y3F6QjdZ?=
 =?utf-8?B?TjVhYmxEc0JTQTFjY0dlK2ZHbk5PcitKaXhzTjRqUmFkRkFINGJWM0dNZE1F?=
 =?utf-8?B?SkgzYlZMQTFRUHhZSmwvaWo0THBRWElraGFzUEc3eFgyQWRZZERDbEJCREd4?=
 =?utf-8?Q?dXzAyvnjRdG0PG4LIJH+Mu40b?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b8ebb90-8996-4d9f-2476-08dde1312e26
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 04:05:50.2489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ULBiq5CFzT2dh9AM76I0S5b5Y88gcGa9eF0OtrkgtE1sOYCz/jbpb3SNPM9L9u6D7TiKxI1PzwD/vYu9h4C+4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10569

TJA1048 is a Dual channel can transceiver with Sleep mode supported.
TJA1051 is a Single Channel can transceiver with Sleep mode supported.

To support them:
patch 1: add binding doc
patch 2: support tja1051
patch 3: To support dual channel,
   - Introduce new flag CAN_TRANSCEIVER_DUAL_CH to indicate the phy
     has two channels.
   - Introduce can_transceiver_priv as a higher level encapsulation for
     phy, mux_state, num_ch.
   - Alloc a phy for each channel
patch 4,5,6: Update dts to use phys

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
---
Peng Fan (6):
      dt-bindings: phy: ti,tcan104x-can: Document NXP TJA1051/1048
      phy: phy-can-transceiver: Add support for NXP TJA1051
      phy: phy-can-transceiver: Add dual channel support for TJA1048
      arm64: dts: imx95-15x15-evk: Use phys to replace xceiver-supply
      arm64: dts: imx8mp-evk: Use phys to replace xceiver-supply
      arm64: dts: imx93-11x11-evk: Use phys to replace xceiver-supply

 .../devicetree/bindings/phy/ti,tcan104x-can.yaml   |  29 ++++-
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts       |  43 +++-----
 arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts  |  17 ++-
 arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts  |  13 +--
 drivers/phy/phy-can-transceiver.c                  | 121 +++++++++++++++------
 5 files changed, 140 insertions(+), 83 deletions(-)
---
base-commit: 5303936d609e09665deda94eaedf26a0e5c3a087
change-id: 20250821-can-c832cb4f0323

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


