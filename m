Return-Path: <linux-can+bounces-4538-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A15B4A15C
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 07:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0013C16C2EB
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 05:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD173019D6;
	Tue,  9 Sep 2025 05:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="knbmYZCr"
X-Original-To: linux-can@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012001.outbound.protection.outlook.com [52.101.66.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70753019C4;
	Tue,  9 Sep 2025 05:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757396478; cv=fail; b=RLirFRmz1WeUwo4ukyBLJR6cU4Le+9nmeIX+c5Ez/5OhJJ8myx1PI0oJho4LVMyrLAfrwiwYC6VLBCrApREKZsd5G5ZP0lxo0gYHMV5C6GgLUAWAqlGVUa1u+nuZRQLT9Lpz+YcPgCOCAbCYfzjqK+9QK9NPLVQQPSAnCjVn2W0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757396478; c=relaxed/simple;
	bh=gCIkVJ5687w4JC/iXH2zdfPKdy1y9n7kFucnRZ0EZx0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=hkM1s1Upg72p9Mkjtzl2iDKfDVfTL3c5M7JFdGhV8BtxjDr9zB3Pi9RX7u6RZwq4y9AG66E4fSw2FeYCdcOQnYRz6RCoB7cwc8qkYdVj4sZTzLxJRP+TKXppJQXg33FLWCFM/MWk6MsJhOkRvj+zcG3jD9lfyV+/TYGvUjfR9pk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=knbmYZCr; arc=fail smtp.client-ip=52.101.66.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DO/iKURT1Uh9W8OaTg70MlwdzthehxkHYDRyZTGrBP85VA1SEeg6mSvdxi43Y5vmHL7fnb3sdK6iI50TaIXozmDg3kNGn9zzmyXeMPhmyQ9S8nfYMc/e02eRwUAmkyYlN7HD7u7f80y2Nc0xPMRDJ9SKPcQ3OwsbVcoEIRDcnDKEKspw4I1PL2QVLU+Uy8XeKeXr4F7RwvoZn9K9YvaSC+YvmCFFHrEi436KNQR/4aLilBf+Y5PW8hp8XnYMITxYTD4+qvtvuaHZURZ9km64GWgMSjIEIn0wyix6e3sd7yG/jT58fu1lNsveByRE3m83NLG+MPVYZ1v6KkHZ/7RPAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b4LrV5039zmXiZB4R2+yiz3v81A0BrqjClljoXVA8DA=;
 b=koxCeUejiSWEIa63XEFDbUjDAwMx3YA+iLbbjImDJMiFdH1yMukRxOJGAlD/rgdRE0j8gz1Cw4dYLJvzjMp6+9dDshQy1+T8ht8duCtbUnxH/I9JpbMjIA/8QakVKdn4btfiaGdQtectZkIskSeVTQBa/7azC10FFSruiSBJ6OtBGYA0wUSCztKJqBVSUhfnkWdpRMfKPvc4pP1O2IRU/hLhjY5Lj+13spL5fdg+G2O3gtqEo8ingt5Zwze2/8+1hZAzq90YIc41OlEi4hOrgiva5Y2liNzOBMQgV05pPZAGHyGrg3oGUV4bjVX8idi61GCVyZp7h++ZIRmaO9bkGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b4LrV5039zmXiZB4R2+yiz3v81A0BrqjClljoXVA8DA=;
 b=knbmYZCrG/aF8Bc9Afm38+LgobCJ57pBHDnrLQMz7tkX6CmvLMH6aBcsVNihXHrxXuyapxqjqC33vIgW4p4jlxuJDvX7EDFXOOkYOMJ3BAy8oaAmqYr3eP9y7azrcUQ2RFxIkLNrbT2/21J9+HqMqRUG+Z8NTA2KgHVKixXaac1WyCE77ZJWuYrD2D3OPaXNdBMQ92AwiV1v8Lxs5TDl8DJJnmACSli/onDIQQatS5aLWN4cKtFIAAjP6Y9hVxQ/QYaCaYxZQb0G+B11ga8hnjB9JKErHgYwz9Vftmkbc1s3yu92Ajw2w61bwxkri8gHsDryLFZrf6qVCwx7TjeTBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AMDPR04MB11583.eurprd04.prod.outlook.com (2603:10a6:20b:718::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.14; Tue, 9 Sep
 2025 05:41:14 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9115.010; Tue, 9 Sep 2025
 05:41:14 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Tue, 09 Sep 2025 13:40:17 +0800
Subject: [PATCH v6 7/9] arm64: dts: imx95-15x15-evk: Use phys to replace
 xceiver-supply
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-can-v6-7-1cc30715224c@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757396425; l=1466;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=gCIkVJ5687w4JC/iXH2zdfPKdy1y9n7kFucnRZ0EZx0=;
 b=q+ZNKQzRnoZIEH8M1CRQ2hakv8ryixQNdYlqXtRqbRnqIgeFgaSQLC55MvhkRkuWl/3G0SHyK
 nwQENhtRqDKCAj8rOn1ylt/TR+nKnnBtbxLdwZuvIRh9i8z5q0FaLct
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
X-MS-Office365-Filtering-Correlation-Id: e907d59f-f730-46ac-29e4-08ddef637d9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZjJGTDlrcmpKekNIVG8wazlPa1BIcTRjK3U4ZC8zMmhRcnVyZEpZNS95N1JV?=
 =?utf-8?B?ZVZnTHlvN1JYKzVEcUY1Vnphd0xucUVSTG80NUhnWE44T1JyS2J5RzNieGxY?=
 =?utf-8?B?V1NGdC9QMWFaTnBRb0pZVi9aU1BDTXlSb2U5MlRhUDV2emRoTlNwLzRMRGtR?=
 =?utf-8?B?TENMeVhkWUU0Zk03aHZHT00wY083UldnOVE0c2tVb1BpMDI0RURrSk1zSXdw?=
 =?utf-8?B?cHNjSUdlZ1RLcDB1cThueE9YR0p3UndvSUcyeEtONkdIUlZXNGp0SU1Kd2hR?=
 =?utf-8?B?Zy9GVXg2azR1ZlFsWTg3eHMwMFBOZmxiMFNTaUt5ZWNPYWlhTHlaczVzR0kr?=
 =?utf-8?B?dXEzZWtaM29uSVpFaVM5cFIyMHJTa3I5VVRFN2h1b0JXU0ZDSm1uYVBSKy9y?=
 =?utf-8?B?dUxpUW8wWTZ2Zy8zelJkdnEycjM4MmlETXArd3hjOXZjME8wSEZxeTZ5VFYr?=
 =?utf-8?B?N1lJbklXN21sQUY0bXFoeXF1aWFGamNoVHNFV0sxTHBucTRrOGhES0xLUVVG?=
 =?utf-8?B?NkVLWkhCbGRzaU1nTWdkR3FwdkJwMDBxdHUzdkxvdmJXd1UzUzZ4bHFZdXNi?=
 =?utf-8?B?dDJLTCtnbjZzUmlBZEFLcy95LzM3SGk3M3lXenBYUTJiV3FreXZrK3VVaXlp?=
 =?utf-8?B?UmhkL2gzQWtGbW5sV2cyWW5LRytaOUN1UGR5SWN6cE0zQ0UrdkdPL1hWR1Z0?=
 =?utf-8?B?SjFLdS9GUDNmRmttWnZZM09Ea2ZjdjJtY3NJWDd0ODRwU3NxdVhrOXVCN2k1?=
 =?utf-8?B?cjN6UFl5NmZjbGRNOVpxWHhoejI2MmttK3dwazZnc2JZeVBtTm5NRHVrWVhO?=
 =?utf-8?B?enBRMFdyeHQwMWh5VXR0TU1Zbm5DRHdVZnVQU21lUklTcndsN2Vadk51SXpB?=
 =?utf-8?B?anNGbkhCd0daemJDOHFYU2szQWdsN3BPb3REbHdqTTAwejRadnlUajhIWTIz?=
 =?utf-8?B?emZJemJoM2IvOVcrdHhZZ1Z1aEZmSGFmY2Q4R0tPUHl2eTF0aTBDVGdHSE5t?=
 =?utf-8?B?QXFCdDAvZDlKVW1vL3RtT1VlaW80OWV3VkRnZ0h2enoyYnE4eG9ZZnEvU3RS?=
 =?utf-8?B?eTZwT2ZUVTF3U1FjSlF3UHREMXJHditrV0IwTUt6L25kL2ViaXI3UXFEaXRH?=
 =?utf-8?B?Tm5qVTFXZDJpb1VueUFFLzVPSXpsQWJPbW5ERHpoTldqRkF6eEVYYTN5b2Nu?=
 =?utf-8?B?N1lOZTBqdGs2NDBYRUZpZ21Ga2RTaGVmbTI3SjVPV2h3WFBYVkd4ZnhIMDFC?=
 =?utf-8?B?TlhTYkJJSU5EOFYyRE55Nms5UktoOERNenpJbWlldXp1dll1WXNoTC8wSEoz?=
 =?utf-8?B?dXp5M25XVVBrZVY4OE02N2R3bEUyQWo4L05pOE1BekVpbGdDWkd0Sm9GSUNM?=
 =?utf-8?B?Rjg1M3FBNzhtMjJWWERsRjVnZ2NjUCtmNlo0dEV4a0lHMFpIclRCTDhKbjI5?=
 =?utf-8?B?R0w5RU1rZExwaFcxZXRWRkpZR3pjRzhkelo2MENGYWhsaHRMYVc0bjBjSnNS?=
 =?utf-8?B?dmFxb3lTdnZRbnhERk1yQW1GRGtyOHRLUHVJdGdoTGxFd0lKZGpKbi9yR0xw?=
 =?utf-8?B?enRKeE91NUZ5WnNjVzQzVjZPUUlPUER3UnJlRWdmYlJWcUlseTZYYXE2N2Nt?=
 =?utf-8?B?YW1tR0JxZTBoRWtJbmp1dDl0TEFyOThoMHhLMFpPQWJmQ1hDdCt6NklaM0d1?=
 =?utf-8?B?RUZVTExoSm5aUGlmZTgrcjg0N3R4cjkvQjk4RVZBZWQvZi9vVEhsc0o2em5t?=
 =?utf-8?B?SnVmOXFQaXBSckZqNHB6ZVZ0RkJWekdpdHRmdHFwRkhkaFVTYkFOaVdPN3pt?=
 =?utf-8?B?Z3dXNHB5SGdPRklRbmk0MWx0NjlQUnNmaDlMSHFnSkFpL1l5SFVVSHdPc0JZ?=
 =?utf-8?B?TnN6YjJxR1FjSG1peTlOQTNTUllzclpqQ2JacG8zL2NTNU92TVZ2YmJ0c3RQ?=
 =?utf-8?B?WTRtNjY4ZWp1c3k5QlZUYmloWHNJM2FveUUxdDIwcVZPRmlUZVhIT2VPWXJt?=
 =?utf-8?Q?OvVfXFvyR3VTtcZcdvOmMTMZiMLl/U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bXBBZmxSVjBEbmpLand0cFBCVGpRemdxRFBwdVVUTHZrVG5xaVhWYlBsVmZB?=
 =?utf-8?B?UkxkNkhjL2VPZmJQS1ZDUkloNmxuSkRzaHNvS1F4OGdJOEpFcFYwd0ZURUkw?=
 =?utf-8?B?ZkIwSG1SSis3NXo4dSt4ZEZMRmxvQVNmRlE5TjlWVjMyV2k1TC9ETDJXRVlG?=
 =?utf-8?B?K3RsV0c0cCs3VHpITzE2eVg2S01QZ3FadlNoL0RMQ01uK1JFeXFkYWc3T2w1?=
 =?utf-8?B?VW14WnFXNml5RzBpZWJOSlVUdWhDaDNoeFhETHRyaWlUTFNPL3FNYVcxcjBF?=
 =?utf-8?B?M0JldU15NDF2THNLTjNRNXd3Q0dPNndFMkIzdmU0YnJReTl4ajFFZytGN3pU?=
 =?utf-8?B?M2pMbjRkMFdHaWswOVJVNXJEcXIwNlMveHhDdHpBSXdHRnc4QXdkaGkrU1lR?=
 =?utf-8?B?R3ZlRngyTGd2RUV3ZkRjcmdlTEVvRXRIb2dKV0Z6T1VqRmp6anlLMHVtKzU0?=
 =?utf-8?B?TFRmNVdjQmdzbG51cG9tc3g5MEwrVnpHbGFvcWU3SU5PVGo3b2xnUURHYzN5?=
 =?utf-8?B?RUt0YnNNaWY0YzhUM2M3bzYvakFVRjVSWVBseWtuMDk3MDFmbHdMMFhGaHR5?=
 =?utf-8?B?MGE0SHdzUGt0VU04V3JaWlUrdmxPTzMrNDk4ZlFWellmcXhkY09vUyt5Q2JP?=
 =?utf-8?B?YXBUM1lwZlRVd1BiRGU4dEwzL3hvck5hOHdPdHJRSmp4Y2VmV1hTcG5FM2VQ?=
 =?utf-8?B?YkFsWkNwR2VZRXpNT053di81cTA3TjIvSi9uN3Z2OXZoSmlaL2ladzdJTHNs?=
 =?utf-8?B?dlZnZENsd0dJQUN5MG5Nd2c2NDFiTkg1YlR4WTRIeVhVT0kzSHpFM0RtRDZD?=
 =?utf-8?B?WERTR2hrT2hWSEZZc2J0Y0tWZ2FoRFdpSERmZ04ybFRsSjdOTWZwb3NKQlVy?=
 =?utf-8?B?VTJnRnVzNmhjN2gyZGUzcGxrTFRhdnZleW1BRWpYbFp3c01OcGF6d0ZmeW1v?=
 =?utf-8?B?TTBwYlU1NE13V01EZmFDRm5CYzlCWk85WE1nTWxPc1NuTDRnajZCZXRlZFEx?=
 =?utf-8?B?c3dEUzZia3ZCTzB2aXhTTytJWk9nRFpsR3ZqdjVncm9YL0VHSHRjaGdCZ1dF?=
 =?utf-8?B?eGt0U3Q2ZGZtTDBqT0pPNG1ySDBPbTBYSmxBUzJtcENCVFIzY29TSFVGZFFy?=
 =?utf-8?B?MzBNWHdmYitTSElKdTk2RU5IRk5MOEp5cGpVZ3RPZzVWdHl5Y0tCQzZWRTMx?=
 =?utf-8?B?Rlg3RjFNUXROdXVWWVBNajM0Nnl6WjBLa1ZjNGo2djdCQm9CRXE1MUFqcmRL?=
 =?utf-8?B?Y2tDR2FOK0xBZzQ2SXFNTHl1d1VOZDhpR0U4RzJLcXVuUE1KTk04WDU0ajhx?=
 =?utf-8?B?MmRleGxzVUdKcGllUWhJVTFMejdoNHJBUVhjUGhSWndRU29tdGZNMXRhekhO?=
 =?utf-8?B?WVgwSy9TYVp5aWdiRzlxa3hmaTMyYXJoZnNUa2pvT29MUHFhODRyL0Vxdjl3?=
 =?utf-8?B?RE8wbmRnK1gxSlpocGZ3TkczaW1VeFhKT0dGZ0NCckIwdGduVWdDeWhwSVgw?=
 =?utf-8?B?VlJHRVZWcXpLNUcrSGVYMFpaZ0JjS0Y0VXVjU1Fua1orcnJqRHhOaVJUS25m?=
 =?utf-8?B?QzZtTTdOM3Q4MjcvaFA0V0VFVHUxRmllTURTTU5WOU5oK0pQRjc0QVc2UE5J?=
 =?utf-8?B?TlBaMWRWYzVYZnErRXJLUUpud3graVFsYkp6dE5pU25RSDFwakxGOTdjUzh5?=
 =?utf-8?B?QXBnT3RQWVRkT2t3L3lRYXBkellJdlFQUGFoSGM2Z0FKOVQ3RGJTa2phdkRT?=
 =?utf-8?B?Zmxsd0d6QnFxRUVnWjg4TVFIajcvZXU3anFRdUgvYnZIUnk2MEFXTExIdmp4?=
 =?utf-8?B?UUJFd3B3MGNLK1Y4Rjk4M2lMUzdEM29oM3Z3K0RNT0p0M2xmM3pPd2dEVzNu?=
 =?utf-8?B?NW5hdFRTdnlmdWtwTUZWQ0luS3J4L09lUjNBS1YxTkNMV0ZQUzYzSkF0dkFC?=
 =?utf-8?B?dFpiVVBiTlRUV0piaHlXZFhWbmgyNFRlUEVzeUxIQjE3Z2wxem90V09OUFR5?=
 =?utf-8?B?Y1hVTUxEVWtjcUpvVUJOWnlWSG1MMGQ5dVg1STdXeE9MbnpQQXNjeTloTTRH?=
 =?utf-8?B?U00veWUrR1VmMm5BZmZDMktBclJYQjg1aFoxTTVRZUdVWXBUV0ZlekpSZEg2?=
 =?utf-8?Q?HGdjuXo0nNAG4ZCXkCwGZzNHQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e907d59f-f730-46ac-29e4-08ddef637d9f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 05:41:14.6389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HwF/Eedp9tWBKPcs50+WgPkHL6CjPqcr4nJNIp2zqq4bwpi+B9kToA7WvF7N9FaYHFMmnwxvQLNltOnRjmxyjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR04MB11583

The TJA1051T/3 used on i.MX95-15x15-EVK is actually high-speed CAN
transceiver, not a regulator supply. So use phys to reflect the truth.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts b/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
index 148243470dd4ab03afdae949c8316f31467d1377..a15f021498869918945405cc7f34ea7e27ae6aea 100644
--- a/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
@@ -106,12 +106,11 @@ reg_audio_switch1: regulator-audio-switch1 {
 		gpio = <&pcal6524 0 GPIO_ACTIVE_LOW>;
 	};
 
-	reg_can2_stby: regulator-can2-stby {
-		compatible = "regulator-fixed";
-		regulator-max-microvolt = <3300000>;
-		regulator-min-microvolt = <3300000>;
-		regulator-name = "can2-stby";
-		gpio = <&pcal6524 14 GPIO_ACTIVE_LOW>;
+	flexcan2_phy: can-phy {
+		compatible = "nxp,tja1051";
+		#phy-cells = <0>;
+		max-bitrate = <5000000>;
+		silent-gpios = <&pcal6524 14 GPIO_ACTIVE_HIGH>;
 	};
 
 	reg_m2_pwr: regulator-m2-pwr {
@@ -317,7 +316,7 @@ &enetc_port1 {
 &flexcan2 {
 	pinctrl-0 = <&pinctrl_flexcan2>;
 	pinctrl-names = "default";
-	xceiver-supply = <&reg_can2_stby>;
+	phys = <&flexcan2_phy>;
 	status = "okay";
 };
 

-- 
2.37.1


