Return-Path: <linux-can+bounces-4294-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2F0B30D55
	for <lists+linux-can@lfdr.de>; Fri, 22 Aug 2025 06:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A458169A04
	for <lists+linux-can@lfdr.de>; Fri, 22 Aug 2025 04:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5F92949E0;
	Fri, 22 Aug 2025 04:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZH1EpNt1"
X-Original-To: linux-can@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011071.outbound.protection.outlook.com [52.101.65.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20CE28D830;
	Fri, 22 Aug 2025 04:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755835579; cv=fail; b=TDoe+EdEfFEhf+QHVtp0e5CWdckz/9K1dXI0L9G9c1yeUQOAul9/fZaaw2cgJmJeYeJKTpWwRxM8u542cDiMgreNX8wF0o1vJdq6O8piP0uqKUa8WBFcRCgAPGIf5aGn2bbEt+S7e93Gr0QoK9IZcAKA/OJqXz+l/nXGlp4ecn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755835579; c=relaxed/simple;
	bh=XPqTu04zFGccIED4ZckPZZpsHPgGBH9CaOZ/cTuZG3A=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=sscW6ksMNm+BGbCTS1QusXirqV4rW8r5JQP0C831wFH3ZOwoqVQp5mhcWICB7pVyQxA5JiYwYJqBLSQzVipf5jEaBrNdgsABpwg/cT89pDgDpg7Jy0CQSW9Il6JDasd1yu0CZhmxeGIC0/uRlrMK7NvQXPjBjltTDVWtFrckKIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZH1EpNt1; arc=fail smtp.client-ip=52.101.65.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cXK4+eeyMon8IBKdyu2fiajkQkDLgX3gpFD9fTJK4Vahq3RFNLHvKMPxSCl1xWYb6lob7vT8A4TV6Uq0u+TxVRnhoXTi+P/gJ/aEh6d2nLuZgU9h80/QkmZcJC5lATixvzTAAWOG4cYnku2M1g2AcuJ3+3+61K+SwVgJpx9K2H5dkmHw20MJL1bsnGgpmMvXGLfMWxF1iK+nl1evGnskZgMoy+qZQSKd3tV7sTQuTP6Zi/xnxKHZV3SQ493n6uDUeoP65y6G1JBXHxhDK+yha+B2/b8oHGNedCbQq8vPtbRw9wUcejA7HpV/WQkl54ZRx35ABgKkm6HQ/YAcDmk8Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jpWylB88VwkJesavYBJWZySnMrfftJ37fL6ptcUYm4A=;
 b=HU5cE0mF/45EZUpFDT0R7l5gRblarx4Y9zUZLlGAX7FsjxjVMLkqraiJjT50NRhZZ3GCkHooKO9fiD52gVYqKMRylyiePABQAgIqPcJZPDKYNXjgDi2tN9iNndsZxT870XeT0BCA2P+ZJKTPFhEyy9LFLyi61qSohpIjk8o6LpHnCGasK+0Ica2Sqv1rXCGdT3wk1gzFu29nnlg3yWPzF7GbnkZ79t49CcI+5SEa9+To65ypd9cuzXxZWj3RL2KL3OmY+98xhvfZyJ4x47CjygR38vl1jhgJD46j15leAuAAXzKoXExgDKOT1cW/mSTBGDG2T/BFrfHZ2ZM7c88I7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jpWylB88VwkJesavYBJWZySnMrfftJ37fL6ptcUYm4A=;
 b=ZH1EpNt1QC9DfTA/7b8r9aNpe0gxW7A27GMSydceoD8AhHlYIi7VMJpHT8cVYTL7vxi5MVS4/rpkLIy5OJsd9lkn2Y7GXgTwtORbcWetW150SsK3lQuZszetv/GDs9OCNRuQ2WzHy+NdDt7Scc6rxh3Zv/XOz3KGYADQgtyYHTYlWIJRF7g4GuQxRXI0QiqALF90iYESk0Tsa3bi/tTPq6mUzf5Wrs/dbhvWItXmemSW+ra6+sPWF3yVxJkINYeX9HdXlntLxTNsHWUiRRga4GHUjZDkGsoyQ6UGLpgZPc+TpkfN1bQwEkDTWL1YGOY16CfEEQXCpG2xT3spmzEe0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI2PR04MB10569.eurprd04.prod.outlook.com (2603:10a6:800:273::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Fri, 22 Aug
 2025 04:06:13 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 04:06:13 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Fri, 22 Aug 2025 12:05:31 +0800
Subject: [PATCH 4/6] arm64: dts: imx95-15x15-evk: Use phys to replace
 xceiver-supply
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-can-v1-4-c075f702adea@nxp.com>
References: <20250822-can-v1-0-c075f702adea@nxp.com>
In-Reply-To: <20250822-can-v1-0-c075f702adea@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755835544; l=1438;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=XPqTu04zFGccIED4ZckPZZpsHPgGBH9CaOZ/cTuZG3A=;
 b=VqgHnn0j1+vxNz4BC8MDzW+2dksy2bUXxwoN3CxptzLXdBxkdCyJ5qFmcCPTqGcaquCR1h7a7
 +vBNTHceE8KDn1IHPxZAXsSQEj4uh7RarPAXa1FoR0nBCN63iECw4Pr
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
X-MS-Office365-Filtering-Correlation-Id: 7dd5111f-08a9-47ab-1d6b-08dde1313be9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|52116014|19092799006|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?djVoMFhKc0VZdDcvUHppc0xDZk9SR0hnaSs2cmh0aGRCT3Z4NGJ6aGNtVVJG?=
 =?utf-8?B?dUphOEFkWVJZbHJCWlFPSnJHdGhaWEJGOU9lWUxlaEw1MXB6b0d6WFN5UFo2?=
 =?utf-8?B?c3VKVW9Wd0lXcVZtMmN6YWtwTlpIcmZXazU0SHR6U0h3dUI0eGVNMVZ6c0dH?=
 =?utf-8?B?RHpzRHRwVmF5Q0hkR05BNHo5QkRscjdGaXFxSGErZlNleGwwUUh5djB3aHUy?=
 =?utf-8?B?Zi9ENk5OZmJ0TTNySHNPcUtKbzUvaGl0ajFBcFcyQmdoZE9QbHZPK3Mwalpz?=
 =?utf-8?B?UzVmN0taL0pUY1I2RVpuNGJ6UmhmSWFiTWJmaHJBMU14SXRaQTJCVkJqSWdV?=
 =?utf-8?B?aXB5SzVNYUJkR3V3QWRHLzFBYUhJcy84SzNvT2E2bTI2RXBqOE42Q21IbFBv?=
 =?utf-8?B?ZWY2QVVHUm9QZkdWVnkrUVZJb0Q2Z3liUWFiNUVMNGxSSUdKdDJDTTNXbWRi?=
 =?utf-8?B?cjdUUVFEYitDbTROcmZDT2FTaUx1cUtCZTdzQ0R4Z2VPbEJwNFhjUkJxQ0p1?=
 =?utf-8?B?Wk5VM1hPNHBlcUhTclRvRjZxb1psbFJuMktQOEh1Z3pwTnh2eXJ0Y1NrYWRN?=
 =?utf-8?B?RmZRWG0vWlJWN1JQV2pjM3IxYUxkaURIT1JpVjZmNS93bEFTcndidDBtZGx5?=
 =?utf-8?B?MUhOWjlheW1RVDBEbDh3eU5CSFhTQWZIUkZ6UXRaYkViQisxemZ3VWJyeHZD?=
 =?utf-8?B?bHNPbWRMYzVHTmRIc0phQzlhTEI1QVROdmV2eXM3K0twZC94K3Y5R2xTUU9m?=
 =?utf-8?B?dStJY3hWeVJiMXdSNFBBbi9PMWJmRFZWVWhnajIrbFJLU1o5QlhzL2JGRW53?=
 =?utf-8?B?aCs3dnNzNks4bkYrTXhORDhZcTFIeDJ0RDBmV0ZHNHIxL1EveHBxako3Z2F4?=
 =?utf-8?B?SXRHREREMmFNNVJEK2YyTkdwNEx5aGpQWWtCcTN0VUJ2RTFSYTArVE52d3pL?=
 =?utf-8?B?VnVlWTU3U1pMekp1ZHZGY0hvMEExZms0SytMTXZTUjY4VjRrRS93YWpJR2pr?=
 =?utf-8?B?cUFBSHVXUnhOSEc0RjlGQ1BCbm54T3hhbmFobDk5b09uVlNzVE9NbmtTN2h2?=
 =?utf-8?B?UkVBaEgwZUFaMGVQV2o1Y1hlaVFBTm1MOGt5bmtHbHRDbGtidlJON0kvNHNK?=
 =?utf-8?B?RUhiRDUySjlBY2I2ZXRLWVpJdHJCcE1YOXpTRHV6dzhPZDZKUWZPbTVLWEYx?=
 =?utf-8?B?eWYreERDTmNpOTg5VGk3NlJjakNydFVoV3JOYXFVVXp0bHpsWG1xMUJWczE4?=
 =?utf-8?B?dGRuRkp1Nk9SWERmT3VmZXpiUlVYRXJtYVljbzV2VkFsVHlCbkFVanZuUG8r?=
 =?utf-8?B?aDZmS3lNUVRMeUo5V1FlZ0lnQXFVLzVhSzlMaGIyUVhNUlBLVDdFYm5pMDhM?=
 =?utf-8?B?OXJZN0FFZHg0d0c0NkQxWGxxREEwNTVaNEJnVzZndUM3M1JONjYyakNIajZH?=
 =?utf-8?B?aHRwWUw3UXFoWUJnUUpQV3BYQThxNHFOWmt0b2Q4VTFMNCtWd3NraEN5MjFS?=
 =?utf-8?B?blJFMFFwVUVwWmpibzJjK2pwcUtNVjg0cm90UVNYc3hTMVlQVnZpcTFLN1I3?=
 =?utf-8?B?WnpyWkoyTlhyNWJZZ2pYNXU4Zm1hRVJySytoeWlyUmgzSmRpRjJQQStJT3lj?=
 =?utf-8?B?dGFtbWU5VWVUSzY5NWJrNU5WVjZqenpDK2VScExhc0tXY1cvd1hlWncwUkVp?=
 =?utf-8?B?NUFpdDZvVm9RMWVyZUZMdG5oREN6c2VkU0tpeThXVVdhZkE0Mi9WM1M1UVRx?=
 =?utf-8?B?Y2R0SzArbnVBVGlzdGdnaHEwTDlQVnUyazg4c2pRTVpmcTRRZkZyMTBuOGk4?=
 =?utf-8?B?Z3ByN2dWdGlpUDNKMllicGRFUUFlVHdOUFQxckxMREpRNUdGTDFLTUdtWGYz?=
 =?utf-8?B?RjRaeXYyVGVGb0tFelR0OHB5UU9icEhLWWhVVE5xZklUdXlFYXdwbGRpdDNj?=
 =?utf-8?B?V2ZRdCtWZVExYzMwSWp2VC9rdkJTQzVVVUs5Z253dVJnVVo4TU0rMzBSc3RG?=
 =?utf-8?Q?iwGYouFbAkniovlFR3lNZazc4XfvJE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(52116014)(19092799006)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZXpkSE9MM2NHTXpWa0JVY1BNRmdGckhhUDVYZTBvTXdBUmJBQW5vcXlwKzRI?=
 =?utf-8?B?ZXE3cHo3SkR5Vk5yWElWUWZlUVR5Q1BnL2tDMGp0N2lDTi8yelZuZXlGZUVO?=
 =?utf-8?B?c0hUYTVzUGFKanYzS2dOSmdrVTVFTG5MSGZobzROaUZ3eVRBUzNKUHI2aTQx?=
 =?utf-8?B?M3JxN3BKT1dwZ2RYNjkyOUVSY1BjVmtycnBjY01Gd0hjSVo5MDJDcG1scjN1?=
 =?utf-8?B?Q0pxeDdadFhmcWMwaXJDV0FPQ1YyMy8rbklCYVlWT2ZUTDNzZXFsNzFCd3Q5?=
 =?utf-8?B?aG5YRUY2Z0FIWVJ2YnBYamV6ZGNjSEM3MkY4MlpFREtSQWtnT2VZUGxHdUpp?=
 =?utf-8?B?bWJORjI4NzlQYXZMRUpjL0IxdkJhTEpNUkhXL3V2eDNJYm1Rd2JwNUZ5SHRF?=
 =?utf-8?B?czdIdE5JeHdydFZQMDFBVCsyYjBUNGZOVXZWVHJXM1JmeFp2VmVQc2pjREQz?=
 =?utf-8?B?b2pqamRTZlMycWxEd0FmczBidllXUUJ3U21veXZ0eVFxZ0gwZDd5TU9hQUpB?=
 =?utf-8?B?RzBUVGFvY2kwdUFIVWd6UGxwd2w5NjlZYWtZMVNYN1NwcGtnMzBoWnoyQmxC?=
 =?utf-8?B?SlgrUjVaTEFiY2g5Sk96Mjh3dVk1dXNoM09QUnJoRXZrZ3MrRzFmNG1WbmVP?=
 =?utf-8?B?WUJTaXRkU0QxOE44WS8xc2trNytDTnJnTWlmckpDeTNlT1AxUUx2V3pOclJX?=
 =?utf-8?B?ekRTUWpqcVNoYjk1WkxaazBNSjZ4SlArVUtTMy9mbkNGeTJLKzVDblNHenRC?=
 =?utf-8?B?N1hvdXBRUlZJeGFuQlQ0S0FrVlVjOXYzYjIrTno5ak9hVEV5a3M5cjlJakJG?=
 =?utf-8?B?RGxTb0I3VWRBSmkreEw3VEc3Q2RmSitKZ3dmeDNBc3BDd0N5QjBESVg1cTF1?=
 =?utf-8?B?ejNKdllReHFjVkxhV2Nad3ZKUzFRK1QxUnF2RHA2ejVndXlYbHNtWkpJTHZL?=
 =?utf-8?B?L1VsZXNheHdHUUExdWhYQmRlWkR2aXFTeDRycTU3L0d3QkZjaVo4M3lGeVQw?=
 =?utf-8?B?ZitJUUJBNkFDRnhQQlJtd1MwTTlIclI2T3JMU2JLWjdEL1d6NzUyNU5ZVGR6?=
 =?utf-8?B?alB5NDFHeUJCTElyVDlCYzFpUndnSWt4ajRiM1FaRWFuVTNyOTBQZFVVcmI5?=
 =?utf-8?B?dFlmZlFCSm5GRnF0ZHVlRjZvWXJBWGNXMDBhYkJhbWpBMm8wejZHMkNDeURK?=
 =?utf-8?B?dmJYdENCcTl4ZDdORmNiV1NzcmhtekMyYUdPbXlGZnJMcDAxTWZ3M0ZxMlNh?=
 =?utf-8?B?ODZiQ0tKamR6a3BycGZQTU9KWWxhOEpFN0hkT2NuUnhsZmdSWS9IQlg3d3lW?=
 =?utf-8?B?MU01N1hoM0dWV2ovNUhlZURnUHlMWDBTN3E1Y3F1U1pUMi82eVFRSFJtUzYx?=
 =?utf-8?B?VDZLUkVpcEN2YU44NUVwRWE4K3puSjVDNGQwczZlajE1eDRXSlZKdGJTYXlj?=
 =?utf-8?B?RXZ2Q3JibTlyTVBkNUhyYmlsdjlTM2ZaUHF4S0NwalVST1RjRWJDRjViNzRC?=
 =?utf-8?B?VW9aMHIrd2x4WG9lY3Jxek0zU1lSWWxxK0ZSekRhTHd0SlJTdXBleHUxazQx?=
 =?utf-8?B?K2tmeVlta1lPZ2U5K2RDeGV0OEhydTFCNzZzRGI2Tjk2QXhlRVI2czkxWlhD?=
 =?utf-8?B?Wm5wUmdrOVcvNnRVVGQ0Q1pqekF4UlhRWjFVd2xRRlF0dUgwNXA0bHR1cU9V?=
 =?utf-8?B?L1ZhZWc3T21LKzR5MitkN2ZleEpvZUU5MStoMk9ZZ2ZlU2s0OU54cXF0MkZm?=
 =?utf-8?B?RUg1NzRpeXcxdUI1bEYzZWNuRGlQYnpVKzE2S1d5Z1FKeFlqdVNxOG9QK1hG?=
 =?utf-8?B?czRrYU5TKysrT0NLaDUzcEhycFJ6WVhOK1ZKMXBlWU85TVo5bnBlcHZ6d3Ft?=
 =?utf-8?B?d0gzWEtYaWlJZHF1a0lKUGxncDNBV2pYMHZtcm5RN1Z6VXhnTmd3bkJmOEY5?=
 =?utf-8?B?Slc4RnNib3BsSFFsM2JhakZML1F1UVA1Nmo5dVZ2aUpnSTBxVEFFR1dVTkh6?=
 =?utf-8?B?UFNVeU9NazNPSXRaUk5CNEZMUVd4YmFMek9pSWwzMzBsam5ZN0Q0OU1XMXU2?=
 =?utf-8?B?Zjk4VjZDazBCTzBHaDBqeTVORWpPZW4wanJGaSs0b1JrcWJEZ0MyQnlxMjZZ?=
 =?utf-8?Q?1vRIyU16ThWiRi07mfkKuELCv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dd5111f-08a9-47ab-1d6b-08dde1313be9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 04:06:13.3771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8eZKUNwY2x+vUFyEWsTRkhhgMk2vI2AJmapY4e6gQMoqZFkAU0l4v/z5RpBTf9uFAeiSUiIBFwDaqWRtY1kPmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10569

The TJA1051T/3 used on i.MX95-15x15-EVK is actually high-speed CAN
transceiver, not a regulator supply. So use phys to reflect the truth.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts b/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
index 46f6e0fbf2b09106e6e726ff8b61522d1359cfa4..f6197ba356d49b97bf7287c3f0f86ef84f89bac9 100644
--- a/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
@@ -89,12 +89,11 @@ reg_audio_switch1: regulator-audio-switch1 {
 		gpio = <&pcal6524 0 GPIO_ACTIVE_LOW>;
 	};
 
-	reg_can2_stby: regulator-can2-stby {
-		compatible = "regulator-fixed";
-		regulator-max-microvolt = <3300000>;
-		regulator-min-microvolt = <3300000>;
-		regulator-name = "can2-stby";
-		gpio = <&pcal6524 14 GPIO_ACTIVE_LOW>;
+	flexcan2_phy: can-phy {
+		compatible = "nxp,tja1051", "ti,tcan1043";
+		#phy-cells = <0>;
+		max-bitrate = <1000000>;
+		standby-gpios = <&pcal6524 14 GPIO_ACTIVE_HIGH>;
 	};
 
 	reg_m2_pwr: regulator-m2-pwr {
@@ -300,7 +299,7 @@ &enetc_port1 {
 &flexcan2 {
 	pinctrl-0 = <&pinctrl_flexcan2>;
 	pinctrl-names = "default";
-	xceiver-supply = <&reg_can2_stby>;
+	phys = <&flexcan2_phy>;
 	status = "okay";
 };
 

-- 
2.37.1


