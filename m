Return-Path: <linux-can+bounces-4407-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 972FEB3D72D
	for <lists+linux-can@lfdr.de>; Mon,  1 Sep 2025 05:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 566B6178A91
	for <lists+linux-can@lfdr.de>; Mon,  1 Sep 2025 03:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B3022D7B6;
	Mon,  1 Sep 2025 03:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lcdyE+q/"
X-Original-To: linux-can@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011057.outbound.protection.outlook.com [52.101.70.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517BF20C461;
	Mon,  1 Sep 2025 03:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756696758; cv=fail; b=ev9HhYG3Zp0X6XtnbNBTIsP0RppglKqecC2AIK6VIlSo2D7xnWkv98KJY/m6RQ+zhr/vRL8reAilsukdr9TVt4mwacMKnlPFbNBt126T+hFPrFl+GiM6OnuOvPOUtOWMKDtai5t5kwD6BwBL5tfH3pezxnFXFVjnh//WJYIBVDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756696758; c=relaxed/simple;
	bh=FF/Sens3cc0PEVHdT/RCZs0cRXPdF6RnLl/3HCkZ4pI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=H2tSQeG1ROl4ZDYMV8ItHSHje8Xhaj+lYMWPPMPjbNB2BqPs8vjblKRd6Klb2r3Iqe7AHuvBItGQ7naxqGC4kCcrBR6D4HpWaDQZVbG2QxitY6o7BpD9taSQYQSBZoQ/h9mVWwu9ur39wRdLFqSGTeeWVtLCNVJk8VrjocPzBCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lcdyE+q/; arc=fail smtp.client-ip=52.101.70.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MiApILUMK/sj/gW2CLSdS1C1TcnNYpNj7fQ8VbNg5nT9v1c1REmOlqMKtbm/rV4d9hjrWLjJ+Uyv88BAUJyRqiaA7gOBseC7YspFGWtlqPGCOnmr7uWWw9R8jxwobpmYhD49q1k6o7E4t6IjZd7L2vZgwPYofsVqUYlw1CKYKmV4oEqAzcl2gLpJk4JJLYsdSUCuCqhNHqQkPxh5sMEk/xnGu+4moYyKjN4YntafsvY2p+369ptWDwWoyTNdV8FJWYFLDaSuWrqSSC7d+RkRTKSfhf0pAKe4j3L6yA4+elvHV3VPlA1hnhA9Vcv2jK3UXk1JrYIRLOb30qCe1H17bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JU8JlS3F6cLpGK9EiXcU8CnUhaAF39aTpWz4YEzyq68=;
 b=cokkA+xTZ8cZQIKPa6LWhWfxybu039zSWOMxjIn7618LI9eqIY5TpuO1ovMKUd5hUAPp0GEjkvKVe4NsKEol7e/ilXL1W6b6NL/Eq+4pK0701h0fTapLpQFrYLHEwlpDU72Worx5x7yzxoup5EufKBsXCbvBjsu+98ykfmKFgdcXe3P/+LiucyRseIlldXIk8qe75Shjvy6CFjjq3dcfPEfad+pfk+KkDwt4gVXXobIj/FbQudiqSAEJNnmGQhoFgQIkka1LRapeqTs7S5uQ7HOpT7HajaO45ExtjHaBQNHxyMsaCdMUS7HYGZyfNF6sXHvz2CffORy2WWG11fKjTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JU8JlS3F6cLpGK9EiXcU8CnUhaAF39aTpWz4YEzyq68=;
 b=lcdyE+q/fJQJ4ikzVeq4DUtLVTEutTGqqY6v6p7pKrbpvpDCR7ONdq9mKMIjFvmMlRGs76uUZMGGjzOG/S0f1muKX4jBfRr3OvfIrBo/V5zKiIDT8IOT0G8gS9n8zOi5N/UJNHx12Jt/Xte5d67iC3gbDXvL4hPYUdTDeWb9u3j/NGFzdxP5HZjpXpgmBYxD5Uoo2P18PlvCA81jx53SlghGf7OKC000fnyyvHADBQbl6dUllKSv1bKh4YGb3Op7T2l4K2ylGrKwKgSRhBiEo/m+5RDpmjmX/QIUHVhPPevOeBZaj7gVwXxNptaibqJjSKPI6lx+cbivaQ/mBiAF7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA1PR04MB10321.eurprd04.prod.outlook.com (2603:10a6:102:44f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Mon, 1 Sep
 2025 03:19:14 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9094.015; Mon, 1 Sep 2025
 03:19:14 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Mon, 01 Sep 2025 11:18:16 +0800
Subject: [PATCH v4 6/6] arm64: dts: imx93-11x11-evk: Use phys to replace
 xceiver-supply
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-can-v4-6-e42b5fe2cf9e@nxp.com>
References: <20250901-can-v4-0-e42b5fe2cf9e@nxp.com>
In-Reply-To: <20250901-can-v4-0-e42b5fe2cf9e@nxp.com>
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
 Peng Fan <peng.fan@nxp.com>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756696709; l=1711;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=FF/Sens3cc0PEVHdT/RCZs0cRXPdF6RnLl/3HCkZ4pI=;
 b=O/bdlPKEoEOwwklNwVQJcD1zsScUYYhujpH6OJp+kuysQCr3l16E619okfZLmj4iofZ9pyBlq
 Tzb32jjokU+BigMa5ZgYl0QaLlx8Y7OR58i7dpBTcxOFw9vV1+zWsT0
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG3P274CA0012.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::24)
 To PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA1PR04MB10321:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dbd216c-33b9-4d37-4ab9-08dde9065391
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L2lJcUs4ZWJXbWRmNnBkaHBpUldUWkRqemwxcXMvbUdQRWtsaFk4Z3Q5Mi9v?=
 =?utf-8?B?NmxpczJaYTdmQ1ozeGpGNTNoViswb2FqM3NnWTkvSTVzZGVHdUdGanY2OFlW?=
 =?utf-8?B?WkJhZVAxVDRUWHR4b0tDcFAzSlJlM3JrekpOOTVhWitRRk5RK3EvY2dtTXRZ?=
 =?utf-8?B?Y2FMZEZ1YmNjamEwenVSVWtIZkszR2xVWDhVNXVqNkpLZWxwTlFxWEVCaDBF?=
 =?utf-8?B?MGlVZ2VXc25oTC9TdFEzTjFrUHZSSzgvWWlpWXZ6dFNzY2JBMXFXWmNQbHRC?=
 =?utf-8?B?QVVUVCs4Z2Z4WWdrdUl2UVFJSUNPNG1NMzRReldzdm1reXdIMjlabXh3MmdO?=
 =?utf-8?B?M1pZeTVtSlRSVnRpRU5VbnIxVTN4aE5OQ3VUS0RpcXp5NVB1bks2SUtIK2NY?=
 =?utf-8?B?bmd3azNmQ1d6L0tmcnAvSGR5M3FGSEg3c2dsd3c5Y1dYTzVub3FoUUd4VVdF?=
 =?utf-8?B?ZW9KRVZ3RHpNZHJlSVp0cFhyWXpibW9US2V3b25nZ2p0NmlIN0NIV3RWL0V0?=
 =?utf-8?B?ZmYzRDMrT2FFdmxHekliTmdSOTBZL1Q3V1RJTnFQN0lJcSswLzZDMFZKSTlq?=
 =?utf-8?B?NW93Z0VEbjNKSWNianEwUXJZYzhlOS8vOFd0UllhcmlQU2lqaytzd0k5TW5i?=
 =?utf-8?B?UDZGNzliMUF4a1BuT2JFZGZ5YnJRbjV4cWk4VlEza1Z1R2tNYVYyNE5md2FX?=
 =?utf-8?B?a1k2clhNMnI3OWx4cHREZEtuZmI1WXBYWTRQTkVEMDVzblBQVER5RUFWVFYz?=
 =?utf-8?B?T05PcmxiSXN2clpFVlY2cTZ3MXdod3JrTzVJb3pjWmFGbDUyRjFrYTN0VHVY?=
 =?utf-8?B?eVhkWFVBMXljSXlZTG1qU0Q3MUJpVUxEUHlsNi96TnBTV2dkNGlvelhkLzV5?=
 =?utf-8?B?VGxXV3ZYNm5tU2xvUjhLeVR1VXoxalQrVVJYZDhJUmRKZWYwWk5adVhFM284?=
 =?utf-8?B?S3JEWXlyb29ReXpFWTBCbmkxbTdyN3c4bTFIL0l3Yjc5TmNMaUtQVDNTUDFC?=
 =?utf-8?B?cElSemN2a1BSV2taVHpTTzAybjJxSkh6aEpiMldYK2g1bm92cUtIRHNJdXFU?=
 =?utf-8?B?VXVpYlVnTGY5TVFRUVF2bXNPU0JLOUFEeDdIZ2xMbFBXbnQ1RmpORW9UL0tE?=
 =?utf-8?B?M3NpVUpPclBUM0kwN1JldzNsKzFzV0h0L2kxVEEyRVZWdzBiN3BXREw4c3Vj?=
 =?utf-8?B?aElqL1JwazVoN1p0b2djL2VJL0lEMHpoc0E3YkxRQnBwc01sUnVmdmdRRHRj?=
 =?utf-8?B?K2U5WkFKOXQxcWhuanoyWWxtWnNWOFJjbExSVTYvTGFGYkJJMDRua2FqOFND?=
 =?utf-8?B?a0I2VGk0c1FZTjFLODFzdFdaRjB1WmRSM2F6QXBXaExqUENoREV0bVc2K2pl?=
 =?utf-8?B?USs3bEVnSi9Oc015VitidGZhbnpVcmRvdUUySHQ4SzZ1ZHR6bzN5UXhOT1F3?=
 =?utf-8?B?RWNNSlpnbVluVm5XeWRpSkNIWmxUTUIvZVhJQXQ2d0w3R3FZL2lhMG9ZcGN2?=
 =?utf-8?B?WlMrMHJ0NXUrV3RMMjZsYzUxOVduN0hvK3YzOWdaUjBOQzZiR3gydkU1WjZS?=
 =?utf-8?B?U2JTRTRocUJMaEVLdlVVMERwdGJySnNsbVd5bU8xSVVhV2FRRGhSVW1wZGZY?=
 =?utf-8?B?VXlRcUdXSEhXb2dKNnNEcnFxN0JuWEdqSXBtK3psMnJiTDhuYmJpcEk1ZHY5?=
 =?utf-8?B?OVQwZElVeW5qVkNsTDB2anBzQlYrN3o5THRqZ28yUWtiYzRNbWcwWlBMeXFR?=
 =?utf-8?B?QXlWcmlyM2VuR2tuQlZBbGkwYXBwZHRsNi9VcUdRRGVSMS9sVmxLam05S1d5?=
 =?utf-8?B?Y3ZmM0lPZmVTNjJkVFVqZVloT0xuS3RYbWVZVjFkTkpvRFpIK0s3cFVCSG5l?=
 =?utf-8?B?OGxYQUs3aWxmQThtcDI4WGhkeFMyY0kzMkZXSCtjOHBrekE1eXpqM1A0Zm1a?=
 =?utf-8?B?ek9neHdNNEVqampKcDY1cEtIb1JvNXNTR1QwVkRncm91RStiaGJMT1phU0dn?=
 =?utf-8?Q?77VA0BINBaUWmf3FEafL2YMnD9K5Mk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OEt4OVRjTkNtcUJJRDVPTDI4TWZLSFJVdXRFUjcyeXVyL3RIY2d6cmxOdENE?=
 =?utf-8?B?NTgrMU8wNU1EWFVra0o4OVlxelRDbXFQOGJQUjdMTjcxRmtkbjk1NFRHTnNn?=
 =?utf-8?B?ZVRIV2dJTUxsWnBQV1JJUFJSdDRLVjllaC9heUdtZHpGbVhBWmg3Z09peU1X?=
 =?utf-8?B?S0JCcmtER1FGZWZMNUVZMHgwTW10dkhGTXBzdmZyQ2w3QnZMWE9mQnpzUjZw?=
 =?utf-8?B?dk9RV3RPK01MQUFlZ2doT21sSzV0RkVQS2pwbmMySzZZdEgvbnNwQ200akYv?=
 =?utf-8?B?Sjd4L3hJZkFEMGN1VGx3amR4ajFlL0VaYksvZFN2UUxWS2d1UnpXSzZ1OTZF?=
 =?utf-8?B?UkE1K1krVFo4Y1p1ZDZHSy9HSXk1WG9ETkFyTHYyeG9vckdQU2ZKYm9oOXRy?=
 =?utf-8?B?TC85d1BrYStTbC8wVWNneTZHZjFVVXJBTkFKQjArV1pmTGE2OXBna0p0N25B?=
 =?utf-8?B?L1JTRmRMckVWeU9kdzAybGZIeDJObHVNN2xmUGRCYUVqNkJtUXhrN3lqSDdm?=
 =?utf-8?B?VWgvNEVQQWdmUlFWdTZxcEhKcnVHN2Z4UHFsQVF1REpoOWVXUWRQZm8yQWN0?=
 =?utf-8?B?ditINWpKNEFNdnVQR2lnMnkxS0RUNGpkMHEwTXZmYjhlaHN0ZDBZSTRla2FI?=
 =?utf-8?B?OVNhdUx5SXNNZWR3ME1WSEZoTmtkTXg0bExqaCs5K0tDMXJhZFEyeENTc2pP?=
 =?utf-8?B?NkYwTmNGRGkxM2QrNStZeWVaV01vdDhzU2tMNUtaazQvc0hwbnlrbGkzcEtI?=
 =?utf-8?B?UmJxa3lTaTQwTlhDOGk3WjRwYlpsSU00RmlvTTE3VWVpUkdaaE9ZWlErVlVk?=
 =?utf-8?B?YzlkNzF3MGVDbDJRUDI3azdoNS9qbmtxdDFTUDhwRWkrM2c1U003Y3hsQ1Fi?=
 =?utf-8?B?c3QvVngvRVhuek1vOXRQTWRXMWhlVEo4eTNwZ0VrUmg4VGkzclVVZVhIK1JY?=
 =?utf-8?B?ZnNTL0hIbXpuaWRWVnJYR3FkeWFwUmNTL3dHVVBpM3g4c2dzaWVHVzFmOFBw?=
 =?utf-8?B?d1M3MmNlZ3pGN2NuNHoxNUVzUUJmQnFTYXQrc1IwYjc4VU9YY0xFenMzVUpL?=
 =?utf-8?B?ckdVYzZIOXR5NXRqMW8vdURhODZJOXdkbEp3S0x6dC8yYUtSK0dPRFJTRVg1?=
 =?utf-8?B?SU9DcmpHV3JWZmtHWURsc2RWUGpTeFZJVDVKNkFvbWpOMmsxcXR4VmhLbjVl?=
 =?utf-8?B?cHgyaGNwbFFuY0s3cDNOdTJhRTdFeWJyWG53aVk2WjB4Umx3TkcraU85R0la?=
 =?utf-8?B?ZHUzaTBSR0krNTNwc0pySVY1YXR2MUk3OTJnMDdvWmJzOXZJeDQyMS95b1lQ?=
 =?utf-8?B?SWk1SFpCdFFOTFk1cHhWejcydTdJOUF1dXpuYkNwbVd1NEFNa3BrVnhYeVVv?=
 =?utf-8?B?VnJuWWFGb1EyVDh2V3Q5em5XeWs1N3dTMldRbWJCb1FNUnRkYTd1S1VsZW84?=
 =?utf-8?B?c2JsYm9SanBHTHphZklacmhzQWdDLzVaa245V1FJRDM2UWlsSzFYMHM3K0ky?=
 =?utf-8?B?bCswUU9VQ28xQ3lPOGlzZld5WWFaeGRkWFpmOUJyUzZtK3hJYW1aa0N3RlZr?=
 =?utf-8?B?THh2SkxrVm0zd3FpeWJvbEExYU92VTBkTStyUEd6ekcxT0xaWEVsQ2pOcFFF?=
 =?utf-8?B?OVVaaVdDSmZpNU5lb3hjSFNEZ2VYM3laTUJJbDRSQ2pPaE82SGVuSzFJbk4w?=
 =?utf-8?B?NVlrODVXc1E2M0ZMNEl5MitQRGdQRzFJd1JFN2NuNW40dG1RVmtteHcrUTZv?=
 =?utf-8?B?S2FaUEhiQWpjRnIwSlFYM0tjbSsyNG5oQ0FrTHN1dFl0Z3BUNXJ1MmoxUWhl?=
 =?utf-8?B?akphL0VZSkVUemg0Y1pBNndDQ2FmVmdTTG1URTg3dWJHOUVjeUxNR1dMcjZ3?=
 =?utf-8?B?NHRpWHlCU1RkK2pQUFlBMTMvT1VaVDRWNm96TWVoeFM0S2g1RGpBd0k5YVVO?=
 =?utf-8?B?RmlLbUNtZXp6YlhWdzJQUkt1aTZLS3U3a1JLYmNqOFNOVFY4a3NPbVNRRWQ5?=
 =?utf-8?B?ZDBBU1VWT3RnVEdSdHdIaXhvcVV1U2toeEJjamNXUnBFckZmSkpFK0JnM1RZ?=
 =?utf-8?B?ZG5QMW5YZmYyRmI2SkwzZVh6VEw5N1k0cXdFTVNjejVhSFBqQTJMa3BHdkJK?=
 =?utf-8?Q?VyGZW6Tux/Odt2Lg+wKD6l4Qi?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dbd216c-33b9-4d37-4ab9-08dde9065391
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 03:19:13.9179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nklWVw/RLeI2NNadGq3ANLPF8+tYT2Cyc3BKGzmaqvy4fXspdXsz3zF+m+s4skKZnQdSoUsNjP7cg4PKa11kMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10321

The TJA1057 used on i.MX93 EVK is actually high-speed CAN
transceiver, not a regulator supply. So use phys to reflect the truth.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
index e24e12f04526c3a08c0bdc6134297fb010e6e926..4c52f22bbfac99722184b4d8679f48c4396b557f 100644
--- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
@@ -62,6 +62,13 @@ vdevbuffer: vdevbuffer@a4020000 {
 
 	};
 
+	flexcan_phy: can-phy {
+		compatible = "nxp,tja1057", "ti,tcan1043";
+		#phy-cells = <0>;
+		max-bitrate = <5000000>;
+		standby-gpios = <&adp5585 6 GPIO_ACTIVE_HIGH>;
+	};
+
 	reg_vdd_12v: regulator-vdd-12v {
 		compatible = "regulator-fixed";
 		regulator-name = "VDD_12V";
@@ -87,14 +94,6 @@ reg_audio_pwr: regulator-audio-pwr {
 		enable-active-high;
 	};
 
-	reg_can2_standby: regulator-can2-standby {
-		compatible = "regulator-fixed";
-		regulator-name = "can2-stby";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&adp5585 6 GPIO_ACTIVE_LOW>;
-	};
-
 	reg_m2_pwr: regulator-m2-pwr {
 		compatible = "regulator-fixed";
 		regulator-name = "M.2-power";
@@ -284,7 +283,7 @@ ethphy2: ethernet-phy@2 {
 &flexcan2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_flexcan2>;
-	xceiver-supply = <&reg_can2_standby>;
+	phys = <&flexcan_phy>;
 	status = "okay";
 };
 

-- 
2.37.1


