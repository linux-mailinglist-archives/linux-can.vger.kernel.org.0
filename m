Return-Path: <linux-can+bounces-4533-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 047BBB4A14C
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 07:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE54F4474B8
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 05:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF4C2FABFE;
	Tue,  9 Sep 2025 05:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Vm6209m+"
X-Original-To: linux-can@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010033.outbound.protection.outlook.com [52.101.84.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856EC2FDC4F;
	Tue,  9 Sep 2025 05:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757396450; cv=fail; b=SewXilWKcamL9STJ/fvmPrbfTmjSLsE5JHW86uPrpXS8UOI5RAMY+b3p2LOY8lmcnX9zFBaq5iJCKeZIkJnxs3y0TvOo48jH88wkJBnBpEVcl8qPMWwExlABJcwsXh49qYoiNgXBHAJwxTa9sbMv0hwrWPM3hXL/oaIoWGWEZ2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757396450; c=relaxed/simple;
	bh=942hzJl0q8NnbYFuqm/+EMPlh6Z3gBMDJ+MMZD0VO9s=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=hyBuL0L6HraWW6lo24wHtfMJs0y3+/1gYbuifI2IU066/QIIv3vx/GonjDcjRORMyUbQJ9lstBwdEknONc37WVb7PKKUADyyaeqNt9PuDXjF7Lgbvd4DZJRBiNmCx3DYYqq/UQgutrFMLTpXEGL3ej0Cx7okkK3XSIIlgmhjGy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Vm6209m+; arc=fail smtp.client-ip=52.101.84.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qdWlMfsje2TXojrzwa9eggWqQn7X0opm5Q31hGSCw9lO1o4gy/ccBXI4i5/9NTGx8T0vLygoT21/YH+jhpyvx29L+GFLJ+lcpHGQluy06JtsiBF0VhJtCjtE8qbN/4pJfd5WmaeufSqSE5SgjiKz3m930ESlviHJB3b0y1ezX1SzyZqDDDBoiPlM+kbc0XH2qB6G5acaQSZXRKJ0APNArE5Q8z/HD49FDzyVHMtXoQTiTMDgfTv1wCmKqlHx0oNTMUi8sRXxqawliyVVMTOYBnU6HV1pwBqSIJbm5owQfFfRkqmyM0r+oszMyjMMIpixeKr3mtmMPxsIl+wss6mdhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v3wv+9uvpjGlvjrlztM6YPk3snEJiLqjXRAhl8sXTl0=;
 b=devUyP+tdHs2ohz4QJK6m0lutoSFTE1nA9DoCEqYEzyTeDf/zFKtN62u1JGdKISUtBVrpjr8KYSzwVEc3FxP0e5H6wnsyuTrPAVQorwByF+1lzn+YXPmGBlQqxNfiCIvS5+RhOGT+gHxRotA48OIerVIbRqiJt3uqr91ktgTC7hpApXnNAr0SPkfuepQG3en/CID34EGVDgNhjJ2pazKMBcsI5Ld3Lx57KFFMdSddvfH54V3sR3a9pfjVnnoPpvcbJ8/ojzY+qIPKtIA0tbRd8zbTpGKkbG4amD6clUXPrck2Ep5H/cFI2zUW1rdE+xPX4Qm3KUJscjtthSPNCjS1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3wv+9uvpjGlvjrlztM6YPk3snEJiLqjXRAhl8sXTl0=;
 b=Vm6209m+iRigr6KjgmBu7N7KYK071ICuuS4Bg29SkI6mnN5vivM3BFGvFTtH2BLMvcDOUXEInpS88R9fMweoet9P4gNV4Jc8bhCcFG7nIPXIZZjonkdvisPKLpJzJofGq3ikzhYoT4BC3uxO7A9cuNzj4Ykc/qCQK3cnsh9YSJCXGj1A4EMcOkiU8SDrZAGV4DDiT3ThZ4uyEhQvJ35Spwm1khBEtDuH2ZODsUSOsL18d7G931cy54BmFa3ocxlRqn4fuwoZ3usH/Bd94RnlOeHq0iY2YmrlmEkLAcs2mfPSB00bcDyi45DuZ+u9vw0IumiH6QQ0DsWL1gnHc3WA8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AMDPR04MB11583.eurprd04.prod.outlook.com (2603:10a6:20b:718::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.14; Tue, 9 Sep
 2025 05:40:44 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9115.010; Tue, 9 Sep 2025
 05:40:44 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Tue, 09 Sep 2025 13:40:12 +0800
Subject: [PATCH v6 2/9] phy: phy-can-transceiver: Introduce
 can_transceiver_priv
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-can-v6-2-1cc30715224c@nxp.com>
References: <20250909-can-v6-0-1cc30715224c@nxp.com>
In-Reply-To: <20250909-can-v6-0-1cc30715224c@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757396425; l=4492;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=942hzJl0q8NnbYFuqm/+EMPlh6Z3gBMDJ+MMZD0VO9s=;
 b=lUHrZbqViAaFZmjR0ysLTh4aCYDhjBE8HPk3JeigC3ApmhD29jk9a7qNDjuXSxslw+MqqZaiO
 Jf96un72BK5CnTJLp0Qe3gwTS2HA/a/hP1GVaoDgGru1ESuRF7U+i44
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR01CA0007.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::11) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AMDPR04MB11583:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d89aed0-9578-41ef-7e05-08ddef636bbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b1l2Rk1oUEhZVmh3dFIxMXE1dzUzQm1ac0RVQk1xRTNkQWgzalFESFcvMHFC?=
 =?utf-8?B?K3pTQlM0Q3B6dllsMkp6RkhvbTZKR3NNSkdWRThxT1B0eWJXNDJKdVFSdHdS?=
 =?utf-8?B?OHlzTWtvcHV0d1hnSjNxbzhUcnc2RjlhWGYzeWx6SEJyZzJ2RW85bWpQME0v?=
 =?utf-8?B?V0VtQy82MGJ6MVUwd2VyVUdMc1A3eVdubG0rSWl3OFlsVXBEZlVvUU1lak5F?=
 =?utf-8?B?NDNzSmp2b09iVGplODY3Um0xK1FJZjFNTzNJdUpEcUNYdWFUVWlRb1hHNkpa?=
 =?utf-8?B?alM0cXZmb3dGemZ1ek1UaXNtNDVFNzVYRFBkVVkwM1QvNGwxQXJUcTZEeDUy?=
 =?utf-8?B?NERhbE9zZnFKSkJ0ZTJaRVJIVERNTi9SUTQ3UExUbkRibStEOXBhVmI5dWJ2?=
 =?utf-8?B?ZFVhMGdibHNBaDh5YXFQUUNBR1Nsa0pHY2RPY3NzVmJHVXY2bTV6UW04bXJD?=
 =?utf-8?B?citZYmNDWEZUQkM0NjFlQ0hCRXZ2S3ptMExEZENSR3FCdWM0YWZhc1RrbDJD?=
 =?utf-8?B?K1VwUmt6UUR0V3BHMmVtd2VCakFQUWkzS0l0eS9Nemdjc0F0cVBkQnpTQndx?=
 =?utf-8?B?OEtYK2oxcTNGZlRkN2NqQ1dCQ2hIZTNkaUVId1RzT2w4aWk0REJvREp1RFlH?=
 =?utf-8?B?YmZBb2xRNCtINnF0Mzh3ZW04OGo4NlZrYzFmTjUvaGRjMElrRG1MTVpoazh6?=
 =?utf-8?B?OGdrcDRFbmRQRWt5K0R0UVB0U1dGR0FJdzB5SlhTTUtRZHhIK1BiRGNXL01G?=
 =?utf-8?B?cjBqWXkvVUUzOWFNcHJXZ3FEd2IvVXVUTXRISmxNUUZOdW1uekYzenFiakRD?=
 =?utf-8?B?WjUwVzVRdnVEMTlXd2g1cU8vTnRIMFNFSWlwYkJSb0RaU08rNTVXRSszZVpM?=
 =?utf-8?B?cXJaVHoxZUtNZ1ZmTWF1SEVmUmxwZEhkSElyK1hFZnAwMzREVjNkV0Ryc0U5?=
 =?utf-8?B?MVUxRlhLRkM2TFZUbERKTFdQdEV2MnNZVlBNcGdnanRIWXBkR2dNeXBNbHY3?=
 =?utf-8?B?S0djOG9Tb3BQbFNRMGx3eVk1SG9YcUZHTlVPSldPOXIvaDFLQkJpSEF2ZFAy?=
 =?utf-8?B?c1p6dlJZKzVndVFKQldJbDE5UHpCUFo1MG5lWHMyMDFBenJkNUZKbHd2WHA3?=
 =?utf-8?B?ZHZ5cDNXY1ZRZG0vK3k4ZldadGJNNlZHSnVOSkpQS0d0dnVzOWcvRUliZTUz?=
 =?utf-8?B?b2hDLzYvYjBKKzRhZEt6dFRHNEQ0TnZGQmM4YnZpd1ZjWXA2dEorZHF6Tmsv?=
 =?utf-8?B?UEszY2FibGNIRE4wSjNvaEhkM3IxbWpERDRoQktFOUZ5UDh2RE1FK1RaN3FI?=
 =?utf-8?B?aGErdXdlL2tPWTJFQnpDS0ZBbXV0SkNJeWhZUzVvU3czNDZvODQ2N1NDaXpR?=
 =?utf-8?B?eHZKek1FSjZPQ25MMUxWUXFnOXBNaXBlUmZWbW1vQXZ2YlQ0eit3c2tIQmI3?=
 =?utf-8?B?NEN6UXZpMEJGUGUveURyNi9aVGtZdHNkMVU2N3dVRE1JOFBVZVhxZWJBRlhQ?=
 =?utf-8?B?bWRPTi90VEVjR1VoemxDVHVTN3ljdFpldmpoTTVDQkdNdkxPZHc0Q0g4aktR?=
 =?utf-8?B?NlpCb0pSS3Naa2hONTE5RDl3SVFYTjFMbXozME1mSFJTcFBVVTNWUkcwRU5h?=
 =?utf-8?B?ZWE3eHZwVGlsc2hVVHlweTloZWcyMUxBaHpCdFZqQ01GRSs0bFNLaFpROG5y?=
 =?utf-8?B?SUZEdVlIelF2R25VZm1JZ3NXM2FGYVdoMThwVWJpalZUNnhPNFZOekI3V3Fl?=
 =?utf-8?B?TTR2WFpFTi84MU96eHAyN1U5TDhCQ3VTTnMxV0o2TnpxMXBFd0NBTm1FeU1l?=
 =?utf-8?B?NWtjVkl5WHBjVTJkd091T3FGVUVvMWRxUjlKdytTN3ZPSnV3eXhId0liRjQz?=
 =?utf-8?B?QytITGt0V3VNa1lVakVhVmtwRW9sWFg5UUdpVEVvdFU1Q2I5MXdCR2d6VUZK?=
 =?utf-8?B?d3JYc3RHckR5bDdaenFCalhQKy9DcXYwRXFlekQrYTJsb2JpQ3hCekxWMlV6?=
 =?utf-8?Q?yaKXM62bYwnNBNEM7C0DPWeptkpBRk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?amF0UkVrMmxKK1I5Q0ljK2NhNjRGS0FndDNwakVnZUJTSUVtTDRVeFZkWFRa?=
 =?utf-8?B?bVhQS2ErZFJPV0VZUkxBOHlKRzVOc3hNcHJZanZsOHZKUWI1ckh1cmZldUlP?=
 =?utf-8?B?SytTMmFibHR5Rmx0aVZSWFEyWmFWaFczQk1TVWxtbFoxTmFkSlcxT2VMVy9S?=
 =?utf-8?B?QjhZS1dWVEVsb3UyTWFjc20wc1h1WXY1VVU4eFQ5Vk03YmtWejNkK0ZzZTRU?=
 =?utf-8?B?VU5OT2JyRUgrTGtJUFEwS2NYSjVNOGxRSE1pL2NZL1R3YWUrbWNhZmRGZlFk?=
 =?utf-8?B?OGdyc1QyQTd3bDZsY3ZlbVhNVTZjdkx5NWFVeDYrMi9KRnBHbHJlVm5iYjZJ?=
 =?utf-8?B?RTc5N3p1ZFUxWFRGZzFsVXRUOFp0ejF4eEM2Zll1TndYeWhtUGRLV0E4dm9L?=
 =?utf-8?B?ZXVUSVZhdFkwakl5T1J1b0tjdHpmcTVTakZOK2FtUzhKZUJQMFYwSXh5RlQ0?=
 =?utf-8?B?b1dweE1WWlhoNFVIZXNWckZqZmNXWm5BeTJocGEwMlREcDhDQzlFSHlyUHdV?=
 =?utf-8?B?b1ZSOWNuQ2ZhN2dnSnptM1hIVDVkbFFJZHc0K215QzBKZDhtRVRYVDl0OGR3?=
 =?utf-8?B?R2pTeVVpT0NSbG1ITW5YNUIzTU1LR2FmSG0ySEdWMjRhbXlYQTJmZHVaSW9w?=
 =?utf-8?B?akFWeGhoMlVFOWpJajRoSnJhNURYNEdVcmhBMjdxYWhYVlpuRXpyMkJ5dXNz?=
 =?utf-8?B?T2srcFBwSWxpejVhVDlLR08rclQySGRDM0VObkx2ckNja3VVSnVIckZwNXVs?=
 =?utf-8?B?TXF4em5lWEV6TU1RSURmUXlsOUFEaFNuN0hSMXNVZWFYV05FbnQ1V1N3WHRT?=
 =?utf-8?B?UWcxeExvVUp2dngybW5ZQ2JWbGYxSkVqeXJyVGVZRlNyM2NVOGNNYldqcFNS?=
 =?utf-8?B?RHNJSjBSVmp5bTFQbGlUeE56SGN0eWJteXFKR3JNRkUvUVVPSUk0Yk1IekF4?=
 =?utf-8?B?RXFGeTFGd0VHeXpYQ3pyRWJEUkRxWE95MGNuM0hldnVxdTZad0YwcWdQaDM1?=
 =?utf-8?B?YURTVFIyemRFR3o5NHBlVkxiSTd6bWdPRUFMWXBpckpFRGdhQ2xCWXY0RkNp?=
 =?utf-8?B?Sjc3Yi9udGxmVXliREZVQ3ZvMDN5Ujg2cFRhZzVyam5oTVhzQzY0OFFXVnFS?=
 =?utf-8?B?NUxvU0VvSDFQL3h5NWx3b2Y1SWpWa01kLys2RW96aWF4MWpubFd2VHM0YmNO?=
 =?utf-8?B?V0drNFFvKzNRb2FJSmVQajNwd2F2OHpqMTNxRElDd3dFWis1azh0OURrcWdu?=
 =?utf-8?B?TlQvTXhKNHdDMEZKRXBtUVFFaVgzZFhBSmM0SnZ3M3JjZlM5Um5VSCtiL0J4?=
 =?utf-8?B?RldJd3p0anZFbWsrUHVDUFowNnBWejNuUU5jelVmb3huN3hXQ093SDNNOTRt?=
 =?utf-8?B?YWt4QXljMkQ5bkpHMEF0bjVnRmU4amkrRFlCOUhwaG81VCtJY3Y5NFVFdHQ1?=
 =?utf-8?B?S3UxdFVVRWs3OVcyUjkyc01TWkorTmdtY2lzSG5QMDljMGhpK0NkaHZ6U2lY?=
 =?utf-8?B?RlJTZDZGUmx1Q05QTmxWQ2s4T2VRQ3RZNWJFVTJZYXZaSi9zYTkybzYyeTVH?=
 =?utf-8?B?ek9XN0kwUGxtdThEOU1PZFh2SVovREpDNUV0b2QwS3psdHhQYWFhMzBBeWtZ?=
 =?utf-8?B?U1ZJaDA4bWt3amxQQzdVMmpxWCtWUXl5UDFZVVBURHFqYXNWRnliRXUwVDN2?=
 =?utf-8?B?RllFNS8xS2FXU0ZmMFJJQXBackpaQUZidkR2REprZjhIQldLajF4aHhCckxr?=
 =?utf-8?B?dFZFaFA3TnRweFRWUU0wQk9zTEZWaDJySkY4ZXdUNzJGYmJIUjNhd2szd3B4?=
 =?utf-8?B?OVpQRFRNbHpjSm1neUtuNjEvcFVocU84bSs1eUdYVUt2d2prUUdOUjV5d2Jw?=
 =?utf-8?B?QXdHTlcxV0l4eXpOdjJXVDVrcThOT2ZlNGRwNHVZL3dDWEFaMEpkQUdRMUcv?=
 =?utf-8?B?T0VlNThqbjBBeENPWU4yZmJoZnJTL0JDbjNtOVFITUphM3lqL0c4WU1Fanpz?=
 =?utf-8?B?RmF6MDg4R0FZYXkvMUNyTlBFS3VYV1psdjJkNkxneVRENEZjeEpoNkhZMGY3?=
 =?utf-8?B?OEhub0pZU0ViZ1RsS1V2MHBtZ2J0YkdLdmdqMUd5eVBVM1ZoOUV3ci9OTUM5?=
 =?utf-8?Q?0HEO61wC/2Pl49wHy5blgmyaX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d89aed0-9578-41ef-7e05-08ddef636bbb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 05:40:44.6077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kVSm/GcuMwa0HGaS+jeCbNrS2+/uMWYY1ECRIzMhhVZGsNZ4fA3NRbfer2ogo37ALi7t6n5W7+S+8f5nD8I93g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR04MB11583

To prepare for dual-channel phy support, introduce can_transceiver_priv as
a higher level encapsulation for phy and mux_state.

No functional changes.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/phy/phy-can-transceiver.c | 41 ++++++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-transceiver.c
index f59caff4b3d4c267feca4220bf1547b6fad08f95..6415c6af0e8414a6cc8d15958a17ee749a3f28e9 100644
--- a/drivers/phy/phy-can-transceiver.c
+++ b/drivers/phy/phy-can-transceiver.c
@@ -23,6 +23,11 @@ struct can_transceiver_phy {
 	struct phy *generic_phy;
 	struct gpio_desc *standby_gpio;
 	struct gpio_desc *enable_gpio;
+	struct can_transceiver_priv *priv;
+};
+
+struct can_transceiver_priv {
+	struct can_transceiver_phy *can_transceiver_phy;
 	struct mux_state *mux_state;
 };
 
@@ -32,8 +37,8 @@ static int can_transceiver_phy_power_on(struct phy *phy)
 	struct can_transceiver_phy *can_transceiver_phy = phy_get_drvdata(phy);
 	int ret;
 
-	if (can_transceiver_phy->mux_state) {
-		ret = mux_state_select(can_transceiver_phy->mux_state);
+	if (can_transceiver_phy->priv->mux_state) {
+		ret = mux_state_select(can_transceiver_phy->priv->mux_state);
 		if (ret) {
 			dev_err(&phy->dev, "Failed to select CAN mux: %d\n", ret);
 			return ret;
@@ -56,8 +61,8 @@ static int can_transceiver_phy_power_off(struct phy *phy)
 		gpiod_set_value_cansleep(can_transceiver_phy->standby_gpio, 1);
 	if (can_transceiver_phy->enable_gpio)
 		gpiod_set_value_cansleep(can_transceiver_phy->enable_gpio, 0);
-	if (can_transceiver_phy->mux_state)
-		mux_state_deselect(can_transceiver_phy->mux_state);
+	if (can_transceiver_phy->priv->mux_state)
+		mux_state_deselect(can_transceiver_phy->priv->mux_state);
 
 	return 0;
 }
@@ -107,7 +112,7 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
 {
 	struct phy_provider *phy_provider;
 	struct device *dev = &pdev->dev;
-	struct can_transceiver_phy *can_transceiver_phy;
+	struct can_transceiver_priv *priv;
 	const struct can_transceiver_data *drvdata;
 	const struct of_device_id *match;
 	struct phy *phy;
@@ -117,18 +122,25 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
 	u32 max_bitrate = 0;
 	int err;
 
-	can_transceiver_phy = devm_kzalloc(dev, sizeof(struct can_transceiver_phy), GFP_KERNEL);
-	if (!can_transceiver_phy)
-		return -ENOMEM;
-
 	match = of_match_node(can_transceiver_phy_ids, pdev->dev.of_node);
 	drvdata = match->data;
 
+	priv = devm_kzalloc(dev, sizeof(struct can_transceiver_priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, priv);
+
+	priv->can_transceiver_phy = devm_kzalloc(dev, sizeof(struct can_transceiver_phy),
+						 GFP_KERNEL);
+	if (!priv->can_transceiver_phy)
+		return -ENOMEM;
+
 	mux_state = devm_mux_state_get_optional(dev, NULL);
 	if (IS_ERR(mux_state))
 		return PTR_ERR(mux_state);
 
-	can_transceiver_phy->mux_state = mux_state;
+	priv->mux_state = mux_state;
 
 	phy = devm_phy_create(dev, dev->of_node,
 			      &can_transceiver_phy_ops);
@@ -142,23 +154,24 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
 		dev_warn(dev, "Invalid value for transceiver max bitrate. Ignoring bitrate limit\n");
 	phy->attrs.max_link_rate = max_bitrate;
 
-	can_transceiver_phy->generic_phy = phy;
+	priv->can_transceiver_phy->generic_phy = phy;
+	priv->can_transceiver_phy->priv = priv;
 
 	if (drvdata->flags & CAN_TRANSCEIVER_STB_PRESENT) {
 		standby_gpio = devm_gpiod_get_optional(dev, "standby", GPIOD_OUT_HIGH);
 		if (IS_ERR(standby_gpio))
 			return PTR_ERR(standby_gpio);
-		can_transceiver_phy->standby_gpio = standby_gpio;
+		priv->can_transceiver_phy->standby_gpio = standby_gpio;
 	}
 
 	if (drvdata->flags & CAN_TRANSCEIVER_EN_PRESENT) {
 		enable_gpio = devm_gpiod_get_optional(dev, "enable", GPIOD_OUT_LOW);
 		if (IS_ERR(enable_gpio))
 			return PTR_ERR(enable_gpio);
-		can_transceiver_phy->enable_gpio = enable_gpio;
+		priv->can_transceiver_phy->enable_gpio = enable_gpio;
 	}
 
-	phy_set_drvdata(can_transceiver_phy->generic_phy, can_transceiver_phy);
+	phy_set_drvdata(priv->can_transceiver_phy->generic_phy, priv->can_transceiver_phy);
 
 	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
 

-- 
2.37.1


