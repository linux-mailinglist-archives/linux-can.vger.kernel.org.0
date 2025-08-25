Return-Path: <linux-can+bounces-4345-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6B7B33997
	for <lists+linux-can@lfdr.de>; Mon, 25 Aug 2025 10:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 239B63AAAF8
	for <lists+linux-can@lfdr.de>; Mon, 25 Aug 2025 08:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67102BEFE3;
	Mon, 25 Aug 2025 08:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jRlp8oTV"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013003.outbound.protection.outlook.com [52.101.72.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E99E2BEC2A;
	Mon, 25 Aug 2025 08:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756111030; cv=fail; b=shxxmgj1quqZeYq4cCwtaYQGVCDjRxPQysXfo9+36b4W80gAs75WkH0eLE1RLsOBkEBlCili2h9WaOpM2+9n08398bT0CIeBVtj7KlW40HvY69i4/wU9KsO56EA6dDVHGYMc0LzfEWOgLkZOqKRMyRILwQ9sejMlsxZIZ52Nvvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756111030; c=relaxed/simple;
	bh=pxJdAmvLwJSPirUPFGPYGjecGHyjH4E+3FlJ9B37KHM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ZtQhX0d3Rz/C/xfdXY9x4LOxxO1y1eo9tGshtAfx7I68eGNAOyf+o6Kp25+/aEUyLQoH02gUvDJTeBBtiUqgcTMC6pkEdCu6m0gwdUTmmRkQHc4/6cjLSEqfnMQzB+mdMq/30DbRMJTf6Q0GMHuWSVESQ3tO2N8FBDqDUVCCrQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jRlp8oTV; arc=fail smtp.client-ip=52.101.72.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j0N97Y5Tj/829apjtJGS4apDMh+EG6Ra2JnPFoAsP7kEUwV7E9AJJSYIWHP4uzdk9Nx+X+mg4w7YaSonl0bB/XRt5cbv2u1MAOfxmQk+q0GbzR3h9+SoY0NbT0ZYnkr7vRE/JlJHCw/F5H3jzIJMUDJwqoCoPHA+4p5lihcau3RV9O55v5EohmkJMT7UzzVui6GEcEh0LO2rALja4tSPGoFZuhBMv2bgF8XKDg3I+mE3Qu5IVinh2Hhaukw7eAANO2eR6ErT4emlao04BgtnFvRP4nJHW6tDMPExakqOaErbxG8l/ez5hue7gHDo79/cPFvbnwff6g+AYn+PSh4fMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DX1rRz5sms17GjZV32Qidfzh6iybFIbbonIZWvyu4R0=;
 b=iqCS5HuWGQ7b6p216ezN6cs5V76mHDUWO+xJIjMAcCftSHNO+F1VkFgesD/hXT2QWFjOw3y4hPqhBUI5p+0YgxqhKMmPEViPiUMWP7elqwUFfXlNt5RYgnWC1gs5Or3srJ/3C0YqF3aufjHlqOd0FNFAuChuKqSQuB3jPhkIGlEtp9a2Jw/2x+h1UjSb6RhVdEJ1n8TCx9qYr81/MWWaagoOiAPmEGpZkMuoeZqBo4dZmPlqCAXvGmnlJ9BI9q3daw6h1BH4dzdAI6h6TeYQM/StEXm5oxYHkiPecYuptAbzO5U2+XGuBl3lkW1SBKk7oiscjFhcflxkWFel1YtFeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DX1rRz5sms17GjZV32Qidfzh6iybFIbbonIZWvyu4R0=;
 b=jRlp8oTVxe1p++5nLdnPRL8Noob2b5zuJTobTKEi4eD05aSBxze+WOE3AlYWdHzxp4l5s2tHXvtyu1wrn4SkWaUXmBh8Y5dcRTXVnLK86NW2GVVDxk0VnBRd+FtXpx23L3GxibqMIBLI56xquYP6vPeqUIi32lIxCqwNg4Vib/qQc8DtnzcEA/ys0UaNIvB1S6rUq4Slhl8NIscR1pNJSx5mZq1G3ItQSdNtRXTRqvb3RYdzx+ylO8hFYZGHI0EIUDheief0Nu3aLm5qEDEFheDDOCUakeVmGIsRjqxglSmVAghXVu8seoO6XAGbik0ujxoEb7K4Fc83alqxWsQVmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB8240.eurprd04.prod.outlook.com (2603:10a6:102:1c5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.12; Mon, 25 Aug
 2025 08:37:06 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9073.009; Mon, 25 Aug 2025
 08:37:06 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Mon, 25 Aug 2025 16:36:42 +0800
Subject: [PATCH v2 1/5] dt-bindings: phy: ti,tcan104x-can: Document NXP
 TJA1051/1048
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-can-v2-1-c461e9fcbc14@nxp.com>
References: <20250825-can-v2-0-c461e9fcbc14@nxp.com>
In-Reply-To: <20250825-can-v2-0-c461e9fcbc14@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756111013; l=2135;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=pxJdAmvLwJSPirUPFGPYGjecGHyjH4E+3FlJ9B37KHM=;
 b=2axhh7uKT/Xg78Bn5ilXHqSE7AztEnazEZ63esjorhL3x61n5voIf+X6C2+F0wkuXYXwPAj0Q
 7V4ldxKYCV3AWjKlLN/3+BIxlS8MlPjuKLDgKCSAd5Se+YQkAKFll49
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SGBP274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::26)
 To PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAXPR04MB8240:EE_
X-MS-Office365-Filtering-Correlation-Id: b82ca094-b797-4005-684c-08dde3b2926d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|7416014|52116014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TlNScklwRVpONlNkTDlmaCtYTEtjTUJiWm5NKzFnT01LYnNIWXM5RmY5bVQw?=
 =?utf-8?B?VXhETlBsaTZ3YXJveDdSWTk3Z09JTmYrRnhBcjBRUW9hRGFKck5jVFVpSTRk?=
 =?utf-8?B?YjM0WkZwMHI4dmtFNlQ0K2kxc3FFZEpzZUgvZzNWa05DWUl6Y21kVjJHM0wr?=
 =?utf-8?B?dFdaY3c2U0ROWHAxQ0gzRHFoYjB3bHEvT0VJOFpUQzlXN2VvWENGT09hcWc5?=
 =?utf-8?B?N2NWdEhkT1hzOE0rZ3M1SnpLa3N3U1ZBWTViQzRRZVkwZUoxWDVTUEhBRkNK?=
 =?utf-8?B?WXR2MDU0ci9VYm94VkRrTU5KVDVxVk9qRjUrZmlHcmM3cDRHa0Y0MTFlMTVq?=
 =?utf-8?B?dmFpbDZxekNWREoyeVBKVngzOEhYUzNwQ09kNVNERUR1QVBmWXBxUCtOaUYz?=
 =?utf-8?B?Z29sV3pkb0k1SThjR1FqMTZXamllRTlmK1BhZ0c2bFliUnpHK2RzM1JDUXhq?=
 =?utf-8?B?a3hibmhmZzhtRThZR01MRGZrSWtlcDhsZGR2RUZMYUV6ODlBNnh5Y2txQThG?=
 =?utf-8?B?b3Q4L0tJaEE0S3dHV0xoM1Q3bnRDYlVrRllyQ3FIaWY4Tzl0dUR2K2RTWW5H?=
 =?utf-8?B?aG9DNmIwRFFXOHo3OUx4VFE4NldhTy9wRVlXOTA4NTUrVC8xWmxEZlRaZFJa?=
 =?utf-8?B?aGk5RHdwZFJPU2ZXSWxxbzlWNCtUSkhLREE4Ulp4WnRhK2lMV1BFSUlPeWp6?=
 =?utf-8?B?eDBMbVVLeUdGV3ZvY2NXQ1F3MVJJOVM4MkdnZFE3L3p0bHRIQ0owTndybUoy?=
 =?utf-8?B?VERNcmxsZzlYSXcvRkVia3AxSzFrc1J2d3gxMkdTUk1NYkxETXNhcWk5Z0xQ?=
 =?utf-8?B?NTVkL3ZlRjNlK2pha2pPN1hEaElvdDhGSEdSSHF1WVdYVUZuaXlVT1VmSFpi?=
 =?utf-8?B?YVZtamI0RlJmdGs4RDRRbkFvSko5TEFXVG9PMzRJeWx1NGwyckRWeVlraVRN?=
 =?utf-8?B?aFUzNWhNWm1YZWlVc1J1U0NoZm1yL2NvQTQwd0FWeDBMWkxYRHZ6cGlEalM3?=
 =?utf-8?B?eXFLVUtWb0RaakZRY0xLYloxem9WMkRtTlhmN0RDSmdxOVFOMTY1V0crcUY5?=
 =?utf-8?B?dGlzcGdrOVcyejM0U2RnY1htTEJEejRxTzI0VWxMSUZwc3lQbjJQOCswQ0Yr?=
 =?utf-8?B?cGhlYXFXUWZEdlFqN3o2UU9ua0h6MHFLbnRhT0xrOHd4c0hPSzQyWXhFMnl3?=
 =?utf-8?B?Y1pCZlpLbXlaYlgwNnk2NzVIMnB4NGk3MzNxbXkxcVVjRXo0UWovR2xrbUl4?=
 =?utf-8?B?eEVCeUJaSDBKSlM4WGhzQVR0MjR3bGlqeGNLbC9hLzJOeVBPdGJnTm1wVUFJ?=
 =?utf-8?B?eE9hUmx5SEVJUzlOb09iVW5iVXloMCtkSngzUDZwMmFxMEhob09tdzYxQWYr?=
 =?utf-8?B?RVRrZ2t2RGc0THdMOXpWUkNpRnRtWTVKTFo1d0piQ0I4RFlPdWw0ekxnVC8z?=
 =?utf-8?B?WjA3N3pJRDBRb3hkNjJSSWp2UDJNUVQweFhzSitQZ2NJdHJaRForcitXaEln?=
 =?utf-8?B?cVhoRDhqcHlNOG9ZV0xkc1dIa3lJREc3WDVoQ0UwNjhyL2dQQ3NqSUZvSzZz?=
 =?utf-8?B?V0E1NE1jZjY3c3dzS1BGZGdQWmdtQVNFeFVJRUJENDRDWHdTTjQzdlp5WlpH?=
 =?utf-8?B?SEYrcCttYTZlbWtHc0JiaDMwVmthQmlNZ1VmSGtKaVJRbUJjU3ljb241RXJ3?=
 =?utf-8?B?Skp3M3RjbHdLSnp5WmMyenNidzQ2aURMNDE1T1R6N3JqS29KbjF0dFVxYnFR?=
 =?utf-8?B?TUxtUTB1azM1NWVwdklwSVE1YWZHZHhxd3NFckpFWGhXaVMrNnQwaW1kcTBO?=
 =?utf-8?B?QTF2c3FNaFdkcjhBZ2NEZkUyY295MnZ6b2NKU2lkT3lVVDVCblR4cG1nVEtk?=
 =?utf-8?B?Q0FVRlk4dGZZVnVhSmVLMS9TSUxwWlpVNGxuSFhORlAwbjRUcUZqOHFwTWxY?=
 =?utf-8?B?dzMxZTNKYzBSeE9iQ2tMWnpyYmFOTjJPR2N3ZnRmK3l5WGNFeERxM0xwd081?=
 =?utf-8?Q?Wl2Hn/ymvAEO7b6Y79u7evyoSkmiQ4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(7416014)(52116014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QjByMjlpbGo0cVllZWhERGhXdkpEZVh5S2NVUndUbVM1M0VrTGhId1ErNkhh?=
 =?utf-8?B?SkJJMStzOXl5elNjNVF1L1ZFN0ZEbWhETTYyZ3hoY2hqaDVKbWNzTzdFekIw?=
 =?utf-8?B?SndFTDEzVDJtVUhXTW82cCtTUXBjN2lhb0hDeE9ORWlmWVJpTVZNSW1xVHVK?=
 =?utf-8?B?RnZRVFRUU3Z1alZhYzFxSzQ2NEN1VEVWVU5yY1ZrUVlzK1FWRDRQdGRWa3JB?=
 =?utf-8?B?VFg3YmZkenZqMm1RY3BYckc4cUxOMHE2SVEwOS9RWENNbUJVQXphWW1jVXYx?=
 =?utf-8?B?VHR4Z1FOc0lPWCtTTDBrdjB3cmF5RkZJZ21BUDN4RkZVNThZKzA5cTZIRVlP?=
 =?utf-8?B?em9KcDIvMFRjMjNybDhZVzZYbjlSR09vNXg5UDVoMkRyckh6TVN3SVZjVUVN?=
 =?utf-8?B?VUJPTDNxV29pUEp2UGhjbk9iWWZQSDA2eDVtUEFEYWE1SXpKUFIxZEo1ZEhJ?=
 =?utf-8?B?eEN0bmtuS0JzOUpyaHNlUFZySkgwSkY0d04rRVZ6OTVzaWZjd3c2NkNIdGpu?=
 =?utf-8?B?LzR3eWtDbWdCT0pjbklkVDlXQ0xDaUVDUVlxVmJ0VEwwVEpiZUlkUVNoOStr?=
 =?utf-8?B?VUtJMW43VXBJdEdNcTBvZlFnUURYQzBQeE1NTlh6dDl4SWNCUG1sN1ZiOUUz?=
 =?utf-8?B?Z2RTQmc4b3Eya2tjM0tFOGc5aVFWam0wb0FDUXppYVRuTTd3TTQ3enRaTXJJ?=
 =?utf-8?B?VjZYdXBRMnBxa3crTlQzQVFwQjNXRVUyUEg2T1NKWlo3M045ZVEwYzZrdFNw?=
 =?utf-8?B?L3hqRExUWGtIV2JEYXZ0OGxjeTQzSEQzVjhSM0hEQ2FhNSsvWC9kMm9BbU93?=
 =?utf-8?B?MGNYVTZHeEhtT2lLUFBzc3BqS2o3K3VnemRrT2JHaXV0K05jNXRSV1JReE44?=
 =?utf-8?B?YlRGeWRwQnJ2T1FidjA3OEdkeGZSQkUvWXNNamJ6OW5Jdk5zNUJKaDlyNUJD?=
 =?utf-8?B?WlJHM3hRK3R0OHdGSm4zNnlnM2E2UGpjcEJjbWlxT0YvUzRnbm9oRGVQb2py?=
 =?utf-8?B?RHQ4SmhWbUFEVjNpMFpNUjVhbUdBV1RXS2E1cloybjN5SDdjS1FjaldqRmxM?=
 =?utf-8?B?S0JzaVh3SHZ2eWlUK1JqWDA5VkZmVDQ5OHNndnBjMTI5Tk1hNHZOTUxWbmRQ?=
 =?utf-8?B?ZThNOWJ3TGkrREcxZHVuTEdnTjgxeHFBRlJpK3dFUFc2b1RSNzdKZEgwc1hM?=
 =?utf-8?B?bXZ5cTA2a2RxTmVZdG8xM1IwZFg5Y0JydXVDUWR1VnV2VHRkOU94N09zSWJy?=
 =?utf-8?B?amUzWFAxRUx1Z3l6NHNKNGQ2SjZSRWUwMHVabzgrU04yd0FtejEzODZqRGor?=
 =?utf-8?B?S1dtVmJIVmFzOHkrd2Y2WHkwMkhpTk1Vc25XVERNTHQ5NGlLN2VNK0Z5RDc2?=
 =?utf-8?B?NXE5aGU2dEs2cHlPRUFvSi9QdTJ5Y0d5MmpYU1h0ZFJPMDNmOTg3UWIvQlo2?=
 =?utf-8?B?RE1lTitNY1lxSi95WmRGN0srOVZxZXVPbDlKUStBM3VUbUFPMVUwZGFNay9I?=
 =?utf-8?B?S1pROTNiZVN6YVZXdDZVWjc1Q3NwN3dreTk5di8rbjkrelozRWE2bitqV0RD?=
 =?utf-8?B?T1NYRUVSRVp1ZFlZa0xWRnlrbURJWDREUEFVcm5oYkxXbEoyMFYrNEVHSWNj?=
 =?utf-8?B?TFgweFo2aFErRERFZkNxMXN1UGhGUlNRQUdMa1pEVksvbHRXdWpBalcwZkZ5?=
 =?utf-8?B?YlNEU3B0dm5hQjhCcS9md1V5UGNqZ1cyQ2dxK0ZEekxnVHpucURoK1ZQZWF0?=
 =?utf-8?B?V2FrMG1ESFRwSWFVOHVnQytzWGxzUldsY09nWEo3cHphRUNURGo3M2pTRkhG?=
 =?utf-8?B?SUUwd25KUGNMcVpFMUNuNVl3akNWZkNXTWhaMzVCRHQ0WjJDT1Z4SnNNVC9V?=
 =?utf-8?B?TUdiazMwNExqUWswOWtLbmxwc2J6SDNVYU9UU1FnYTBXUUdHTk0zSXJEU3Mv?=
 =?utf-8?B?aUlxRm9pVlcvYjFhbE5zVUY5dy8xZGtxOWtCQjFZdDU3RkY3d1VabUdFS2R3?=
 =?utf-8?B?Sk93eVlLM1haRE91NDBiR1k2YWU4M0R0RVhQRDVVTUtiRU9oMjg2enZvYWky?=
 =?utf-8?B?dFBkV29HREw2ckNvSkFOUjdIL1BpMkwrYUtYbnJwWG53TGp2N3J0UWxQcksz?=
 =?utf-8?Q?gZWJqAf9WPaSTbRd3aRGgBWjV?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b82ca094-b797-4005-684c-08dde3b2926d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 08:37:05.9785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0/vtl9SGJnZnv/oJUWOf3mZas3hrAoyEnnGQFLPlNVaNb1FZPwM36WAvQDWEcV9ku5hf0DP7un7qX3F+8OXkzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8240

The TJA1051 is a high-speed CAN transceiver which is a pin-compatible
alternative for TI TCAN1043 with Sleep mode supported, and has a compatible
programming model, therefore use ti,tcan1043 as fallback compatible.

The TJA1048 is a dual high-speed CAN transceiver with Sleep mode supported.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/phy/ti,tcan104x-can.yaml   | 33 ++++++++++++++++++++--
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
index 4a8c3829d85d3c4a4963750d03567c1c345beb91..3ae08815225d82b6a09cf8a6deacadbddf781fed 100644
--- a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
+++ b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
@@ -19,18 +19,23 @@ properties:
           - enum:
               - microchip,ata6561
           - const: ti,tcan1042
+      - items:
+          - enum:
+              - nxp,tja1051
+          - const: ti,tcan1043
       - enum:
           - ti,tcan1042
           - ti,tcan1043
+          - nxp,tja1048
           - nxp,tjr1443
 
-  '#phy-cells':
-    const: 0
+  '#phy-cells': true
 
   standby-gpios:
     description:
       gpio node to toggle standby signal on transceiver
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
 
   enable-gpios:
     description:
@@ -53,12 +58,34 @@ required:
   - compatible
   - '#phy-cells'
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: nxp,tja1048
+    then:
+      properties:
+        '#phy-cells':
+          const: 1
+        standby-gpios:
+          minItems: 2
+          maxItems: 2
+    else:
+      properties:
+        '#phy-cells':
+          const: 0
+        standby-gpios:
+          minItems: 1
+          maxItems: 1
+
 additionalProperties: false
 
 examples:
   - |
     #include <dt-bindings/gpio/gpio.h>
 
+
     transceiver1: can-phy {
       compatible = "ti,tcan1043";
       #phy-cells = <0>;

-- 
2.37.1


