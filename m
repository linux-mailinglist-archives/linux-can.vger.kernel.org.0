Return-Path: <linux-can+bounces-7145-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DfKJx7Fu2mYoAIAu9opvQ
	(envelope-from <linux-can+bounces-7145-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 10:42:54 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 419FD2C8E42
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 10:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1C13A3035F79
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 09:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A203B8954;
	Thu, 19 Mar 2026 09:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="KcAA/gI2"
X-Original-To: linux-can@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013063.outbound.protection.outlook.com [52.101.83.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E8E3BC69C;
	Thu, 19 Mar 2026 09:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773913249; cv=fail; b=N3r8A6m7d3jMmdfN5psimsxkRQi8QzX/HlkNZouvV2tkunlVmzwKbLNGKaOYH+2EmXtoI9gXnt8xFt/bqsG/RnNQ3eRmHjfA95pTyrY9vBGjYywavaBtqV6dIi0OPF1/7Glt5IHI6CRwMHijbsUBdYKw+sI4c7hP2w23sWIJa0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773913249; c=relaxed/simple;
	bh=NjkkmEQvIhu/ukpc3rYoo+G4FDElFzZoJ0lqkJdSKiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RoOgIFlnIl49BxFm1td+ITr5j2tQ1QLdPZWtt8KW8IhPfbeMO0OGzrtBXqqhSzWnFnqk6/PJWxzOhqMu15w9b3fdcmsjHSpKkswgqZ0JWTM7lEFMFyaEi8TBvFeGFETrezTdWSOxySTmnwyrBRrHkIffO3Xxz+FZRrFPkLw2MUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=KcAA/gI2; arc=fail smtp.client-ip=52.101.83.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gq8i/VZJ/R/zxUGrdDQBbT6IQpgsUM3DssLZBL45e4zeMVD1TjSitVX0pBaqzf9C3xDnQZUYMxlvS1ijzcNhoBQ9T3kcriK9CvaI9SHDUYfltGu2cmb8ZlXehIx8JxVaHj58osmKrSkl2RvlT7gA9EDjGvu37zuESP3voO++2B+qfjG7tUAoj2I+HxhdMFKdlw9tKdSdT5Dj55J/MtNDQRUMoglD6QN906LEzWqaJJaYkzy/TFZi6vwaDLbOVFSLviM2G0O4GGx0jVD3Mb9DY09cQtOf1EttxxYfpt6qRvNK7R823tShjSwk+lmQN/A231ZFPiisptSzpAbiMu8KQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GRQouUAtAoFM2r1Ht6OLIZn6BKh+s2A174EICOx9dcE=;
 b=OeppwnZnYS4Wbpxyd4RWNePrx1VHUIz6zxW2+anSq2ruqr5qVibW8Ml3vs5NakMAieJNJeSoc/rtAypnwLu8/v8g6cYaAmWZCErUoKSbPWvIuMPS1ipP4mfIZ4k9SJi0wOxJhm6IjbUwumaKxaSVRZKGurLyosouty+9fNR1+7AzvAQTEWEyaH++elkEKyyZKAw2V9JcDBsTBuzwOilxcZWoyNCAHuP8WioM9I7pCVtD+95YqjTjvM2AS2tw1LhpyZNPRlp+vD3zLkBCSDhZXvWgedk9NoZOkL/qAKK098vRzlnmeVedL2/vqeh1RM8/JQgIfupCPH6xhX4Cak5QtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GRQouUAtAoFM2r1Ht6OLIZn6BKh+s2A174EICOx9dcE=;
 b=KcAA/gI27bjRt0IaYLa+YxULuXdRchDaFI4Ey6xzfZcr1SQo5x/fEZVIdItCq+CGbne4WV4BE6v2NQnK9hf5nLRVYzQVxAfFoBmhrzOIwod1qIZ9YeoiyoMYkRye1Go3CBX6Fjnyb2oz02D2VxWQDt0Pw0x+66Tqr0EtT40n9SntHknRbDbQh9UJR9t1egHGbXuu4EqyDCOPWMH0+y0NYmYyVPGzWyckaeDCP4zPhDYAcgp2vKP3u71kPQ0Ta70tizw9u7ah3tZiGwUs13zInOH0DuUZZrrCU2NXelxt4g1sdhC2shH/YwhRrLMmhg7VgsucETMkekUxgZRvmMSV8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by DB9PR04MB9842.eurprd04.prod.outlook.com (2603:10a6:10:4ee::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 09:40:43 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 09:40:42 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	NXP S32 Linux Team <s32@nxp.com>,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Eric Chanudet <echanude@redhat.com>,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Subject: [PATCH v2 5/5] arm64: dts: s32n79: enable FlexCAN devices
Date: Thu, 19 Mar 2026 10:40:32 +0100
Message-ID: <20260319094032.427697-6-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260319094032.427697-1-ciprianmarian.costea@oss.nxp.com>
References: <20260319094032.427697-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0159.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::10) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|DB9PR04MB9842:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f7b9ba4-b34b-485f-871f-08de859b962a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|19092799006|376014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	xRmqFP7pJgKCcfWOBLjbPr4utZobhUAhrfdRKQ8sgcwGoqOwLiMCvmzYOzpjHi00Q0Kk5HCnGPyVbgd0DGs/4i+4GCOVsLTbuLJ72ywawx7jFnVr4un9R5XS7AqfxzzD9j3M405AQbf+R5ilEY7+8DoXsJqrylC2Juw0kb/u863crzG3IGmd8OPRCYDjtC5CFu/5aTiNbxx3et1zZdT4Rvur8vvpDaDHr2JER6jruw1pOCo//sHqjJPcQv/7N49GegyuscCuEQ5urRasTc+9oUjEvKfEDka789GSdOGQQadw8AJgDqCM6QqwzvBgkfp1TQNkVQNAosL9M6NBVj5zf+8gUK48IKHuj5B7bm5qbNrY+bgL/fJoCu6MLmwnCIGTS3/m4nMZOEhzdv69eHGe9UAXXlTsJRngVrce8P1BlTe+usPo8O1ZWcTEMLAoltzYfDLRaEXeMsFW0zyejC6vnFyImww9g2xTuRNeh28Mr9baUm1a6iW2XEHrBKFqbH2LAc+na+ZsHy5R1v3HpsFuP5gQFAWjSjumA/Zduy3kUmdKbcrZh572U9lmTvIdTxkSwypef90XoY3II+bQToQWbi7ogCo4oc02hfDI+Jtz1/sl9sH9GTUQ2/w1XnvzCojKkwlq/TXkBJXJtnLXJQfArLtXYTSrIcyLvYavrh/ltv34ZbJWWCe9qyNeToG4cJN36dWah4/Kvq0sZNWpgI/9JfmJbvYFKiUNXbaBzu0oIW8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(19092799006)(376014)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U1FxbzV4UThzWjNLTTB0NkJqZUU3ckVYR0hOSTJDVWJuZVlyQ0dDR25NMmZj?=
 =?utf-8?B?dE5KbUFnV1gvN0FoVGw4bUF3ZEdwMUxyZzFSdjVhZnRPcVQ1Y0o1U2l1QVhz?=
 =?utf-8?B?K016OUhCWUU5QU1SU1pOTmZRNFlvMjd1eWE2aDk2Zkx3MktGMVJMTFNKY3Rs?=
 =?utf-8?B?ZEN1dUdFeGJIR3NIOHRPOCtOb1hWVk1PTUtpckVsZXBBOHZPWlpReUkvT0E1?=
 =?utf-8?B?T1BpZ0tjNWsyMTd5eCtmTTRxc3JBRjNWWlVFbmJ4d1dmc3RxcWdyUmNKVW1Y?=
 =?utf-8?B?WTR2WXhXM1g5emxwSFNGYldSQXI3L3FFeWdaTEovdTNldVNJWE1EdFpuRDM3?=
 =?utf-8?B?WnZNdEVRMWxTU3Z5SUh1M1A4U2VjMmdxaUNPLzY0L0diL0xla2FQSHZMdTR2?=
 =?utf-8?B?TVVXTUxVcURxRXhpQW4rUCtHK2J3VHoveDFUZk5FNmVsOXd0c0w2aitKM3pF?=
 =?utf-8?B?eUx2Qjc1LzE5T0p4SG1MUWJlVWlsaEtacCtzYkRyUTg0L0ZGbmlsM1c2eW9T?=
 =?utf-8?B?anpFSmJGV0lnUDZ0eWtzU1owYzg1SnY4TGxIUHBVbU1TYkJMNDBCbTVpU0cw?=
 =?utf-8?B?S0NaYzJGeEYwdGxjbHpNbDRJTXNOQU5aTnZiU2FiTlZ2clFqaWVudFBONVZS?=
 =?utf-8?B?LzNhQWsyUldlUWxWS1RnbXpENDhzbDBIbEJNTmdjb1NTRExUVnphSFJsUDRM?=
 =?utf-8?B?OEpKRFc1THBuZ2w0ODRrMnRxTlBTRXljSm5xZmpwQTh4Z1RBSkt2bUYxOFc3?=
 =?utf-8?B?OXNZZGNZcmNYaWpDVUR1NklQZFAzUS9jeTlOT0VrbytNREQ3eTZkKzZsNXR6?=
 =?utf-8?B?bXV1eVdiY0N0N0FQRVQwYkFqZWJ0UFZ0S0tuNkYzdUV0bm9KVFEyWHZNd21v?=
 =?utf-8?B?MEROWlJoNFUzdVgyRWJjR0pjRVcwbFh4T0V4TjdnYTZzNUFKTjVjS0oxY09T?=
 =?utf-8?B?M1p2NCtpQXdVMlpRWCszV2pMakdjbG1ubWEyZXJ2Y2VLK1ZRSENjZ2RMemRU?=
 =?utf-8?B?VCtIL3dzVG1hdUdrNnpiaHY5eXpuKzFROE11WEowSExKU2xpTnIxWnBPT1Z6?=
 =?utf-8?B?MldkWlJGc0hQcS9Rb3F4bWZRZkZnbnBINGJnQ3lIaHBudkFtejZvRm5YNEFU?=
 =?utf-8?B?QmthUWF4d2l1SmN0ZWdzS1pFeWpvc2RIQlAwMnppVGRmS0JJWElCQ2hDaCt4?=
 =?utf-8?B?RWpvakN1a2QrSys5ZjROK3hxaUJDZUVFR09Yelk1VFNJRWVxUGovbWVmQjNK?=
 =?utf-8?B?RHR5RmQ0ZllhY1lPamd3dVFHcDlzTEdnNXBObkNna3o4UmFuTVV0YmxTSURF?=
 =?utf-8?B?NTJ6eE9uWUxuME5TdjAzWVFjWndLZHhJQTJiQW9aYU0yNy9kM1JCcTNSbGw5?=
 =?utf-8?B?Mk83SzRSanhnL0ViTW45Y0hMMzRUTFZMMjJqQ1RIRFBuKysvTlEzWTJZcFBr?=
 =?utf-8?B?NHQzN1NGZG95OXFCZjNsVzBwcC8rM2JWek9vY3JUZzZVcE9KdnpUcUVZSVVh?=
 =?utf-8?B?NGxRUWJhNGZ5UDRHT2pxWVJRb1pLSjIvZ2RsOVVxVCtxeXZnQUg5S0JpK1Jz?=
 =?utf-8?B?OG1mQWloS2RoN0dBMFE5cHo3OGc3ai9wMVlBVHBxTlpwMGpmWmtBZ1AvYjNo?=
 =?utf-8?B?ZHNiSGQ0NzhMa1d1Tldob2VDOXBRdFNMcTE4Z0gzdy9sSnhuYjBkN2VZTW5F?=
 =?utf-8?B?Z1U2VGU0TTMwSm1tOTQ1dnVMRnYzNzUyZ21RWEhOYlJaSWtlOTJDY1FzMS9Z?=
 =?utf-8?B?OUphSFByQmpkRzNjZkFCVHdIemx0aUFEekhwMDF5ak8zVW50VDA1Zkp2cCtu?=
 =?utf-8?B?ZWJpdFBhK3RSR0JzOHpVYjRMYUFOSjI5cGVnMGl0dU05TjZUNDZvWWV2MndP?=
 =?utf-8?B?YktXcC9WWWVqdmxlc0hWdjBUZ2pqdm9uK3V1Znlobkc0RXhycUlIMVZKazZU?=
 =?utf-8?B?QzRkQTFDaktCaWJjNVVMbVVSUFp3MjN2UlhSUVZ6NUFuS1RZTkJZRFpyQXds?=
 =?utf-8?B?aDM3RzVObVlOY3VBNXVLVHBRSmc0TVl6RHJtS3dpbnpTOXhGekNIRDA0VXBW?=
 =?utf-8?B?MHVkZW9BdWRMT2Q4MjhmWTBoa3Y4c296bW5Nck5ZMkxxVjd6OWtqS21tTDJC?=
 =?utf-8?B?ZmtobkVpdE1sekdBSTQ4cnhRaWxnWFFCTy9xUCtnSHAycm1JVDhCQUhnc1JK?=
 =?utf-8?B?djVUYWpFZWRxdUhxdVorZVBKL0tEaDk1ZkRTSVBQWGZPaVZhODRPemlDT0Nm?=
 =?utf-8?B?M0JYU1g3c1Zxbm9CQmpmb1pEdzdNZXpTS21QbUNIc3FMSG1Zd3JaN0JudkM5?=
 =?utf-8?B?RXQzKzBSNCtlTWU5eHlXLzk0UElOTTlOQXpUZFZiam4rSEI5bTdxY0MwRVp1?=
 =?utf-8?Q?EcYDyn5m30KmRaXI=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f7b9ba4-b34b-485f-871f-08de859b962a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 09:40:42.1037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LPQmPajKEJbhNtuZFoduW1PT1Nr4yUoA8Ep82iaVsfTEyghs8xUSNvQPfql721Xsywrf1lDCLs6siRuNzrBfcQRhAHdW3dUI5DQurYyF6bg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9842
X-Spamd-Result: default: False [2.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7145-lists,linux-can=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,nxp.com,gmail.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ciprianmarian.costea@oss.nxp.com,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DBL_PROHIBIT(0.00)[4.196.180.0:email];
	TAGGED_RCPT(0.00)[linux-can,dt];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,NXP1.onmicrosoft.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 419FD2C8E42
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Enable FlexCAN controller instances (can0 and can1) and the required RCU
irqsteer interrupt controller on S32N79-RDB board.

Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
---
 arch/arm64/boot/dts/freescale/s32n79-rdb.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/s32n79-rdb.dts b/arch/arm64/boot/dts/freescale/s32n79-rdb.dts
index 1feccd61258e..65a595d7535f 100644
--- a/arch/arm64/boot/dts/freescale/s32n79-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/s32n79-rdb.dts
@@ -43,10 +43,22 @@ memory@80000000 {
 	};
 };
 
+&can0 {
+	status = "okay";
+};
+
+&can1 {
+	status = "okay";
+};
+
 &irqsteer_coss {
 	status = "okay";
 };
 
+&irqsteer_rcu {
+	status = "okay";
+};
+
 &uart0 {
 	status = "okay";
 };
-- 
2.43.0


