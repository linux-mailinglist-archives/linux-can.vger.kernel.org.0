Return-Path: <linux-can+bounces-1096-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3486C9439D1
	for <lists+linux-can@lfdr.de>; Thu,  1 Aug 2024 02:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56FAC1C20FC1
	for <lists+linux-can@lfdr.de>; Thu,  1 Aug 2024 00:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003E83EA7B;
	Thu,  1 Aug 2024 00:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EbisK8wK"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010012.outbound.protection.outlook.com [52.101.69.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90861BC4E;
	Thu,  1 Aug 2024 00:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722470442; cv=fail; b=paChZ57wngMKb+df4DsMrguLaxNUcRbOOb4FmJlubWOWjhgK0qKXMOUcQBkZZ+CU8dqnrPDwSLkTR0Fjr3gkCZTL0iwkrno4J0OELLKhilHa8i8b1QbmRK0xkJul0kUviWTUn8VnIFF5Omcbfpn99XmDlq8GRYfJCfqkYyH6XB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722470442; c=relaxed/simple;
	bh=ov3A7XzH+6rkr0oeR1eUaodBbvJgOOpAc4ZRVGBhX/Y=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=qTvavDOtT7I8qRzwSp0IucOMXI14lZB5+ZC55pGE4iHCudpA2itlJJmzkXBpWsr0nNHBYXF6Y6zXCB7/axFSGIZnI5lw+qzXNpp4bH7f/4F4lAxjw1uUG4c/HDgEvubw6YheNPaxNoSWjAzi+X7nWtPmpOKaxXheVgAoS8Ql9QA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EbisK8wK; arc=fail smtp.client-ip=52.101.69.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yksjaqRSYBDgdWoTAC7AdJWwTFt7PtbWD8z80pIPBYQADpajzF9qHFVmppfYJ4RISyqPuTDolBzPc1rrMI1W0R16IR+qeHoQBbxpSQ7m/kc6Ag9Yd5xihw3wpjpAb5qwjntGNg398fXwpy8g/gn5VN9koC+FjEEApZEY8eBEbl3RQq3FmdKMxi6OOyv4124d1II4A56HZ+yYPBZ6haFKBvKAz+fs1D60bQiizGeQcNC1t9s6HPn7cEeJ5UynfM7QkU5sTDorqBublcuHyIS6/5qQP0qnzn1/Uzz+L2x250G6YpvoArxaHnlcYncNVMkmPdh+D0T3Dap++wtj9Adr8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BU4IoqoqdCYAkaOZWk0ZKMIFxHnUVNAgCrY6Tc0Tthw=;
 b=Z1eKbgyj4Q5dLHhCC8osOcGQsdhWKLGB/uTabDyjoM8K42g31rV1hEKEdIn2FAMkUB0q7Fi60CFkmrDjQrgYipxtXPuvwGwnKWyV74CaXY+0/AhOtQ6BBnwYtOFEKBWCvq1DZzkD8VoRKCmD+n6cFo+iSoYihpPJPaCjDtGEI1PJCKarzzWxJCPidXRXMCyiBV5jHeF10+PjxBwTobhrdinMgHsZD7V3qhT5pGKRbU/0U4IyeVIHZs3oNtHmkyWTNngP69QK0r4M5Zxk7p+VaM21rzXxKmb75Z7ClgxrjhKgyU3ffwsYeLDXSUc9YQX91z9Q2cAzTzozkVT1v28Puw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BU4IoqoqdCYAkaOZWk0ZKMIFxHnUVNAgCrY6Tc0Tthw=;
 b=EbisK8wKCANSgU3UAjTTonf+EsPq89FjPeV4fkSw9Ovt/bKWmZd/BsLFglPxP8qcArRrQUs7XKtQwdiO9fQ8FyDndVyF+UZCqQWn6uJtx1RNkP0FSzveh+74xuOFEKxzqvIg/g7ZIiyfmmnKRavOiOh/kBqESP3T9v1BFiGJsVzwVW9kw0iIY4VzNlmdUEFom3SaONmrcnH3ING/doccejKfrRYyQJ99bxHwdhu9k1lqe68oCOvfkKonyvvBwDnpHnVn8TDuTTmTnoervB4MsZwYvqFk0suZ9APS4lGUaB6dA9TiFeJfPEC12Sxud6OQnyYqi/SN+QuKNKvXDEN9OA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB10406.eurprd04.prod.outlook.com (2603:10a6:150:1e3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Thu, 1 Aug
 2024 00:00:37 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7807.026; Thu, 1 Aug 2024
 00:00:37 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v4 0/2] can: fsl,flexcan: add imx95 wakeup
Date: Wed, 31 Jul 2024 20:00:24 -0400
Message-Id: <20240731-flexcan-v4-0-82ece66e5a76@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABjQqmYC/1XMTQ6CMBCG4auQrq2Z/gl15T2MizK00kSBtKbBE
 O5uIUZw+U3meScSbfA2knMxkWCTj77v8pCHgmBrurulvsmbcOASStDUPeyIpqNYKnTWcYO1Jvl
 7CNb5cS1db3m3Pr768F7DiS3Xb4OxXyMxCrRRnIFFMELWl24cjtg/yVJIfK/UpnhWvCoFMIlKK
 /OvxE5xsSmRFVQS1IkxbbDa1DzPH4sxxfoIAQAA
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 haibo.chen@nxp.com, imx@lists.linux.dev, han.xu@nxp.com, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722470433; l=1707;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=ov3A7XzH+6rkr0oeR1eUaodBbvJgOOpAc4ZRVGBhX/Y=;
 b=qIX1pAYgeBg4ax/R/YHhnxMY3hZ1UtPHJyBsT8XIQZkN/IGLE+vO5JvsT8aq2Z298DT4PYlmo
 JgCRVu2zda5B6MWcUDnjYCK4P2ePSwWmKeRjLiRekdkQk/zKgP/As5+
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR06CA0040.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::17) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB10406:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a3209db-df54-4fc6-f640-08dcb1bcf94f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M2hTbzJoelhRb044MjZwL2Y4ZGtwd1VPdnp0TjdjMm04QzMyVDl4SkpzWUZ6?=
 =?utf-8?B?a0pJOERWd0FUU0RodnRDTFI3cXltZEFRUjY3UVlxM01kdG55d2MxTGU2MVhF?=
 =?utf-8?B?d0JvcXpBQmZMKzNpandYdkUzMStqT3ByNHRRUEVVRmlncWhLTjhXVTNHQjhH?=
 =?utf-8?B?WENudHBLamlqTzBtelFydkkvSkMyUWZaU0FBUnB6bk5JYkZYTjJDa3VGTXRo?=
 =?utf-8?B?b3UyNS9FL1hVSUdNQUxhZ3ZjZExWVkxFWHcrSGtrSHQ0Y2tpUHN3NFluU3JR?=
 =?utf-8?B?eUwvNXBHOUY0d3RuU1lDeW55TndVdlB4NnZ5RU9jWHFUZzdta1Bya3VuS1k3?=
 =?utf-8?B?WFRYZXVGOHRrd2NtT1hyWm5IQzY2QjZHRWsyS2JlZ0ppOW1Cd0pNTHRCN1Ix?=
 =?utf-8?B?MGl6QnpHS3RLYlBUZnNWbVp2OUNDRnhEZFhCVEg4YjIzbkdacXNMMHZwN2ha?=
 =?utf-8?B?QUhoT2hwc2J3anBuTGdXSUdTamV3UnJjVlgrRDR5RnRLbGVPcTFldTNnQnhn?=
 =?utf-8?B?WUdreHoydlhpOTA3SkpDMXlJWVV2OFhuL1E0RUJZVFpjV2FNQnN2MERmZlB5?=
 =?utf-8?B?cnBmc2N3Q1NNTzRiajBCUzFjVnJNZlAyTGlZMHBXY3Nsa2I2UU9YV2orYSta?=
 =?utf-8?B?emtGUERoMXM0S01YY0V2ZWpBYURqNUxvRk5MTkoxVHd1aG5OazlpVW5EcnJQ?=
 =?utf-8?B?TVJvaStsK3lVOGxYa2dQVGZubEY2VEFZQmYvNnlXVUkycTBYRVBQc1ZuQm9k?=
 =?utf-8?B?SFZibVZkL2wyeEZnV0lqOEF3U0NKRVRGUTl2Mk9Saks1ai9jeHdvNmdqdm9E?=
 =?utf-8?B?MGRxMVNVNXBVYzAzc0tTa3MzcXFGUnJaQXVvejhIRTRGaDFHTDBFMXR2UCtu?=
 =?utf-8?B?UFM5aEw4ck9PMHQyZ3hsS1VxcTUvU1N2UW9QcHM2NlF1UXFxK0EwUi95ZnRk?=
 =?utf-8?B?a2I3V1hCRDN0cXFoanZYV2ExUDI0VzVpOW1UelJUUlY1aDdqVDByTTBsU29r?=
 =?utf-8?B?dmkzNVhHK2RTakN1UDVEdjRMN1M3QUlHRmxaUDBTbzkrTXAxOWRudFpybkpn?=
 =?utf-8?B?RlE4c0RqQjU1b2hzVEMxQjl6YlZqZ0RzSXAzOG5kR3FDN0RYWE5FQ2cwYWI2?=
 =?utf-8?B?VkhsOTIrdS9DeEZLWk91cWZma1RpMEhiVk9LOE9kNXRaR3dscGZtOTA5c1lR?=
 =?utf-8?B?VmF3Z1BISHFHRWpqeUZ6WW9hbE1qZklZZ2Z5TFU4U1NxQ1pzTk5IdXBGY0Zy?=
 =?utf-8?B?a2JySExUZEUwMXBQdytpUi9ta3FWby9KdUc2RXA1TjZWQ2xPckNsNEZkaGJV?=
 =?utf-8?B?QnFsTytCUHlQS1RQSnY5T2I1NCtZZjBvZWZLMjdXVUgzR0VaU1dHTzNBdHlJ?=
 =?utf-8?B?M1lyVWYzTUJQc3NLU1gyRGJXeXljeFRZRVM1aHRVdnVqU0xXNWEvUTdTcFF4?=
 =?utf-8?B?K0dqeDhsU2hvVk9QN055OUY4VHVYMW1DWXNyM2I2b2hoZkRidko0ZXdrYjBy?=
 =?utf-8?B?a2ZydlBDdk1Qa3JpU29BUW80ZStXb2Nrc21MMitYRUg3ZkxHaC9pMFQ0ZzdU?=
 =?utf-8?B?Mll2UjVmQmUzMzlwTjlZU0VUcENrZm4xYUFMRTJQbndyMmFOQjZrLzFNTUEv?=
 =?utf-8?B?MDlJU09IblowbGdVd2RReUZTbWRsdytYdWhuTU5RYmpweDlNMVJiV3FXUnJi?=
 =?utf-8?B?Wko2cnJvaTVLMWxyZkp2eUI2cFJ2WnpMM0JTc3RlWmpxWWJvNExKSkR3aktD?=
 =?utf-8?B?S0hRWjZNQmtZbkVxQ0JlTkwyemRBQlBqZkUzcEtWVCt3TDZqdTZKSThialRv?=
 =?utf-8?Q?BxZ23eKy0yW2NTZSXiZ+B/j6pUZjKHHH3wDGg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SXBDa2dqSTgrUk5JWnlxcStOMDFta05DKzhXZWJteG10ZWw1VGVMemUxcDdS?=
 =?utf-8?B?QXNTemdUSGxOWi9GaUpuSHdrbTBpb0xmcTNyaWJIQlV5Z20xZktwSEpITC8w?=
 =?utf-8?B?eHZ2anBFRG9YeUxxVFZYRDZkdUNXVEV6YnJRd2U2ZTIvSFN5Mk4wMHZUWVdv?=
 =?utf-8?B?dmhWOFI1UFRnZGg1NFdkbXNCZ3RRYmUrMFk4VVR2REVNM1FGakpTek0rVDI5?=
 =?utf-8?B?dDRCeHhOcnNCTGEvMjNPYlRWZFh5MHBvNTZDd0ZUTG9hOTNpU1YzK1VNT3BP?=
 =?utf-8?B?RG9mdis2L3BmTFFldnRqTnhzWExDeURYa0JUYThwdndQZE9rQXlZYmp4NDJr?=
 =?utf-8?B?Mk9XYlppVDdQSkdzWVVTT0x1MEs3Q28rdWovY3RvRzNOYUw3L1dZZ1hHZm8x?=
 =?utf-8?B?NTFPK1liR0tSTGxlU1dUbkhYdjRITC8zeGxWYXk5VC9RQitZZjhkZitVa25I?=
 =?utf-8?B?aTRQQVhWUzltR2tDbll3bnB6UDhVOU5tam9YK2xvK1NpOFFGK1pISDZ0U2Nx?=
 =?utf-8?B?VjF3K0RQUHE4Q0FPaEEveVNZcGs4Ym5FRGxkdExpczBSTWI2b0crSE5VREpN?=
 =?utf-8?B?ZjhQOURSNkVMaExmNzhKR0hhVlhuQXFyQzdKRURIQmFBc1E1WjZsQlIxYTB5?=
 =?utf-8?B?ak5TeElmVUNiR0lBTkNQUWdWZlh2bkxwQ2JWa0lZRjZOQ2pDSm1tMXNuK2R3?=
 =?utf-8?B?c2VuUjhEQjFFT25ZUFVjYjAxWFBOUlpOeE9iYUxkOENuQzBwcFErUmJEUndi?=
 =?utf-8?B?SXNuV3VsdXNVRGtwUzZrU241aFoyQWoraFhmMFhXK3FpdzRYSEhmUGQvZk1P?=
 =?utf-8?B?aHAzd2hHMXU0aW9YR3JGUDRHODZWVEdUWXhrdEk2UUVjdVVwRTh0ejJzcmlt?=
 =?utf-8?B?T204VUJJNDZrNmNIRkgzMXNPZDNXbFcxUm4zaElrNFFKRUZNK05BK3ZGSjZp?=
 =?utf-8?B?QmVSeXhpYXRPTCs0VmFtdFlCSjRWZWVoVjZEREtqTXdTR1ZhR1paMVZvMjVI?=
 =?utf-8?B?NGwvOVhUaVJmMWsrZ0lGTktIZDAzQ1JMelZZNFRjQlpyRjBnd1pZb21YQXBk?=
 =?utf-8?B?UElpWTNvK3lIb1RORTlvNERoTmx0TXNISGhvUXp6blM3MDJ0Zi9nN2N5eVpr?=
 =?utf-8?B?eGpFNGYvK3I2THJEY3Z4Z01leWxxc0NGc3hhOFJaaTk3SUVMQ1BYSmFKVExi?=
 =?utf-8?B?WEVuSnJUa2x5cWd0Y0hVc3RDV1VaeW9JU0M2VGVQa2Y0VDJhRkZrd2dDSE5R?=
 =?utf-8?B?a2RqZklrMnFmVll5OGVNVVhDazJoUGd6UGVrbU1wem52WGQzNEtGUVI5Nitt?=
 =?utf-8?B?SXdFVlV0UjRoZXlobDBrRUdDazl4T0cwVUkxa2VzZTR0b2JsdlNSc3lBaWlZ?=
 =?utf-8?B?S0E5VEJJbThUUWxHS1NtQ3N0Zmx3dWVKTUdIZG95V1Z3NitwN2lIZW9HMzZl?=
 =?utf-8?B?RGY5VVNNZDV5UDk2amVCUi9UdjJjQ2l6b2pPSDVwZFdkanAvUGlZNDlwTlJV?=
 =?utf-8?B?Z0Ryc2RSL01wdFdnNUIzZjd0b2xIamlEUFZ6ZGV0Vjk1N241b01yNlY3aTBU?=
 =?utf-8?B?TjVnbCs1RDdPekI4SkhhekpSNU1FOFJQTjF2NjlPVkJRS3FSL1JJVU53WFV2?=
 =?utf-8?B?SzFpbHdrcHQrd3FNSmRWaXBGVzc5RjYxbkcxN09kM2x0bTdEYWdiRjNhWm4v?=
 =?utf-8?B?aXhrcnRGc1JxQnR6aWFSSWZnUVhZV2FmQkcwRlpsUUxVU1NLdXIzMEZkTlpl?=
 =?utf-8?B?Lyt1QXFCYzVLb1Ftdm5ReGZhQ295bGZRVGxsTjhhY01pUnRHSW9TT0NLUFR0?=
 =?utf-8?B?NUZWYzZ1L3ZHNWltV0hqNHRqS3ZLRjZHaWlsTmxhNzNiZGcyY3BGK1VmU3Bj?=
 =?utf-8?B?bjE3NzVQVTI5S0UxTUxLWHRSYVdYWjUxSnJ3b3Q5OFlESU5tTFJDWVc3YlM4?=
 =?utf-8?B?S1pUV3p5OHNoM0tWWWpCVUdERmxsTEZBL29kc1RUdUVFU3pWeFU4dnllbjJD?=
 =?utf-8?B?cnpzbVNPK2ZGcUxsY1crcUlHMmI3aDFYOTI3bVdZQ1REV3VpN3FHdUZvMm53?=
 =?utf-8?B?UlJjZUp0LzZJM0NuVll4V29CTWVmY3dIWXkzdUVFMzJVb25rd3o5KzNoMWUw?=
 =?utf-8?Q?H+FyKY6kHgrHrA5ZOwwxjIjIH?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a3209db-df54-4fc6-f640-08dcb1bcf94f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 00:00:37.5407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J51tSbHPACU0FReGM/LtQrsozG/NkFcjFk4Oyvdufhbb9hrTySsuyNoV9Kd5KcplvlrRfVs9jA1RPRuHJS0Ydg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10406

To: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To: David S. Miller <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: haibo.chen@nxp.com
Cc: imx@lists.linux.dev
Cc: han.xu@nxp.com

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v4:
- fixed subject missed dt-
- Link to v3: https://lore.kernel.org/r/20240723-flexcan-v3-0-084056119ac8@nxp.com

Changes in v3:
- Remove s32 part because still not found s32 owner yet.
- Link to v2: https://lore.kernel.org/r/20240715-flexcan-v2-0-2873014c595a@nxp.com

Changes in v2:
- fixed typo an rework commit message for patch 4
- Add rob's review tag
- Add Vincent's review tag
- Add const for fsl_imx95_devtype_data
- Link to v1: https://lore.kernel.org/r/20240711-flexcan-v1-0-d5210ec0a34b@nxp.com

---
Haibo Chen (2):
      dt-bindings: can: fsl,flexcan: move fsl,imx95-flexcan standalone
      can: flexcan: add wakeup support for imx95

 .../devicetree/bindings/net/can/fsl,flexcan.yaml   |  4 +-
 drivers/net/can/flexcan/flexcan-core.c             | 50 +++++++++++++++++++---
 drivers/net/can/flexcan/flexcan.h                  |  2 +
 3 files changed, 46 insertions(+), 10 deletions(-)
---
base-commit: 60338db30855441b23644e319542abbacd449d08
change-id: 20240709-flexcan-c75cfef2acb9

Best regards,
---
Frank Li <Frank.Li@nxp.com>


