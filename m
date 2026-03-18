Return-Path: <linux-can+bounces-7130-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OcoGDZxumnRWQIAu9opvQ
	(envelope-from <linux-can+bounces-7130-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 18 Mar 2026 10:32:38 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 010682B9188
	for <lists+linux-can@lfdr.de>; Wed, 18 Mar 2026 10:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C3C7330B99A2
	for <lists+linux-can@lfdr.de>; Wed, 18 Mar 2026 09:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245EA3AA1BA;
	Wed, 18 Mar 2026 09:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="nYYGgeBS"
X-Original-To: linux-can@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011034.outbound.protection.outlook.com [40.107.130.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CCB3AA197;
	Wed, 18 Mar 2026 09:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773825751; cv=fail; b=W4cpA4EAg0wwMspZWOSfeUNx1DATJRsHsRl2lp+YGUOv+sgTS0wPM9WE0EouvJi8XX1pa5h3W+ZKthR2i3EC67HehNOa4INrjBu2H5Y/5xc5OWV2/pLRRNanET5q5RPhlK14my6xYH/h4hC1o7+xV4tJtA2XipR6dGlUkvFuTwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773825751; c=relaxed/simple;
	bh=OiAkZhZVBWb9wIA6XZDuMkP7uCiTcbbRI8p0pJKLV/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SY9cJKVaKNAZ90+GEdI2qtWO1YzDjkL8F4xl6QOlNgSnMCf3TdNqOvS38AqAlhCOZRcnIGgcNfyprNKqHKWynlMpMQf8MaBciSotVwh8/YMHgJ6EHH+ZlM62Wl0VW0YaIWTc3RkTosxj+9kHU1UlN0XA7ODFoApvZUEozhuSDpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=nYYGgeBS; arc=fail smtp.client-ip=40.107.130.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aGKr8ZqrCKzPx9kbD+nxqteqPkwJ0iOHXFsHS5hgSig4tpZCoAaqMeznEarFGD3Ib9bX5zxMFUxFqduJwAclRAAOVdcYpMu8JJ+TMeDuQwmOUsEarHYeJ04An3KA+76BilNXyZngXzfiz5eKzJ8RQxYB/wuGDWEEZsBPQj+/IGDFgQ/81yDFnfd0k6iS1FP+VjhPHa+vByMkjn2NtMQMMn+1av2AjLHlYLyuQmIUe4CCh1lPCTZzcT+zoOdvwtynUEplfNonyhcseE14Sn0p4Siz3+1RGXRwciFcr4X8pe3zK9xSftXEnFExi90MxZ5qmHuwa+TvcLHs00ZuDPUHog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vNmC1QQQPL/Tn9o+6uaXE3BNJ9UFMcs+abPdcDk4sV8=;
 b=NVhohc2rl/uOhvZ0CTobEJCks7ZXYiK1ivN/pTWCJO/LCWYaGdakGrnHdrRaXAYuprT5iEWU5cOHzMoyyOTXmnh5kmTJMQlxpir7O+fmCz1bNRmVZA9R836ERmNa5t4/Vs9ACooYmT2KG+jWf5Uc7S3D3SrMzZft257MZjIgyBiM0o37XeNnV3Qc9pkfxZMxW6ETvZGIjsmDMfWk7SwGihuCdjMwEIJqHh9mKu6b9ofdlhumD326xOgfgzLBLxMMig1quSz6mUNfCuf1LyML+PAdC2YopUngjxxuDrsbluXyDt097usQ611nrcQF01dpMqYgRmc3I1cgWWPF4omsAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vNmC1QQQPL/Tn9o+6uaXE3BNJ9UFMcs+abPdcDk4sV8=;
 b=nYYGgeBSyTRkEHYlcuaUAHN1awqg08Cma9Cy74Qj/+t8DqnaPt5rJpWA9K0sVvo2oRPZECGPnxHUobZyJKFp4qDpgQxe7fzLl0ea05/73fyGBex6I13MwZrdnE/RXDMFYYCMRzwYovbvdvYZg9A7amEYglenAwu9DqasuDvtA4Zcr/6smFE4irb6qaFKymJsNZgQxQTApqX4P6CtPsyUEPtXnW0rdj781NKk299W+UHKs9UkYlwEAr+KRbKzZpIDTZTGatpnn5+LMRKv5X/wy51L0R5VeRiRRsDhTFp2N8xAJKuZo4lpCASK0Zmu819jnNmw12dw2B9v6P2FgK2O6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by PAXPR04MB9708.eurprd04.prod.outlook.com (2603:10a6:102:24e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.27; Wed, 18 Mar
 2026 09:22:23 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 09:22:22 +0000
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
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>,
	Andra-Teodora Ilie <andra.ilie@nxp.com>,
	Larisa Grigore <larisa.grigore@nxp.com>
Subject: [PATCH 3/5] can: flexcan: add NXP S32N79 SoC support
Date: Wed, 18 Mar 2026 10:22:13 +0100
Message-ID: <20260318092215.23505-4-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260318092215.23505-1-ciprianmarian.costea@oss.nxp.com>
References: <20260318092215.23505-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM8P191CA0004.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::9) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|PAXPR04MB9708:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f59e54c-56f8-4a29-c0f9-08de84cfdc73
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|19092799006|7416014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	6M26agsvEQJvTUyxwUX5g5Nc+I9IZ+0WivXQS2CxENa+SFWV3ETg55oP0UMsxBqh6N+9mKllD/EWW5OaaCxmSUxoYS40oV2dhE+MruRI7xUFlp1VJr9dfOtujVaiK0Y9WVYxEbMKOaT6vC6DoYwz/WX/5jZ1CmE3Wr8yn8VZzBmE+WxpKwMQgpapX+aOBcngRBXevjeTYOtvM4AD24+H3LNINaX1CsHCLDCZMrDGU6GnM7xI7GeWJU1kq3hS8lOwuDe2a1UP+6Q7RPZxBu0aCsoRUg0Yk/4d7hjbonLG8TJLFMWwBd2gs0AvXSMGO6WY15I6czHUfO7B911te++dMk+pai0mOCCAQ/mErrBO7m/NOepes29l+FHacQzgrDPRugz2dmpKVz0+d9K584uTtuMjRqz10GEKaa6eaD4pLvAIXE1XrgaY+hw/5jMWM/GdzixhB2WyrjvhnaxYlUoLupywq905mkSu3YpTZ4t/HJqMXrtmWHfz7lhlkdmJlpUOTTlR8G+Ck3HSZo2vNQo4wQqOboCD041E9SesjG11DA+VjCkyJw7knRIJAHQ1zFVD4AWAU06duuq5QW1NDYMbc4fw2zuy3nim6TbPDO+Yisa1CjBC3RKbBXi4cfJSM7eLYDXFoJR35A04p8gwHYgaE8Jsau6PUQCuSA+zFtzLsMioMiLLHejmG29fNm4AnExjpu9w+uh5vW0C7ph/eg5AiGCst7T6ywdmJ4PCzPuFCV4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(7416014)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZGJ6VTYzWVlvR3FQOFZZUGxPdVBLK09WOG1yTkZmemZ4dW5DTTNDdlp5Vk16?=
 =?utf-8?B?UkNNY0RnYW1iTy95RWdEdStkTEJMdWhQM1NnTDhMUGpVVFczck9uN3M4M1gr?=
 =?utf-8?B?My9tSENLTHlLeEpWYUhjdDRObHB1OGxMUU15UzgzWEZjd2lCaHFKK2oxTmRi?=
 =?utf-8?B?dGR0dXNXcG9LTERSUUN0U3lOZ3k2MDFtejhNdTR0bDNVbWhjbitRckF5bFpi?=
 =?utf-8?B?dStLazhRMk5OKzNWOUtrNHNQYjkrOGVqY250MWY4ZUpGRVZmcWdaVmJQL2Q3?=
 =?utf-8?B?U0V4TG00TXl6LzhJbCtyUFpObno1elppUEhoTG5rb1M2aUdFWTIvN3ZEbExP?=
 =?utf-8?B?aGY2Qi9oQVd4U0JpdkNoOWhQMmpZYi9XUUVLOFIvN0xPV2xpUGxBQkhVWUVn?=
 =?utf-8?B?Z3lhS1hvY1BWQ2xwQWcxWkxJeExHdjdlRDJKUDU4NEJIM2NCaGlnbjc0WW15?=
 =?utf-8?B?MW5naElRUTB5dW5FSlFIQWxkd0ROM2pkRzNKeTdkWStHbW5LLzlEc2lZMzlH?=
 =?utf-8?B?T3BrRjgxd2xMeUUwNkRmMEpwUnBwMTE1UGQ2VVdycWpyUUdieG11aFZJUSt3?=
 =?utf-8?B?Q0NXZEVUSTFUWEkyU0JNR3p1RzFreGhheHlCV3VpdCt4RHk2N0FnQXQxTDlQ?=
 =?utf-8?B?aVBrajUzdVYxS0VSckdsUDZhR0ljY2xCVEZJTmgxRjlqMlRXS3Z0dUhvZFp1?=
 =?utf-8?B?YmRNT0wyZ0lyWjAxYm9yb0w5TGVheml1eFhSczVJUE9ONVNFbEE5aXpPcjd1?=
 =?utf-8?B?Mnk5bUZLVVRROExRUG1LaE5ncGN3V1F1Y0xMRzJzODBGZ3JQSHNjYXZabFBD?=
 =?utf-8?B?dmZ5cCt1dkN6Uk9aOFR1ZHhCenRpcERUcnJJd1dsczZuK1NmZnpoKzZuM29a?=
 =?utf-8?B?bUVmaHc4SlRDSnhzQTdycmwxWi9UNlNZb21Dd2s2TFE3YzJzRDMrVWpUaVR3?=
 =?utf-8?B?OUNFRS9qT0lzSVNvYWVJa29zZ1ZVOHFOWTd0dXlsREZPc3VtbWpkcnY3S2dh?=
 =?utf-8?B?MmJsSnZuV3hkVGxHR3FmNzdwUjZTaVRYYUxXMTNOMkxVN2drTVgxZHJqMjlE?=
 =?utf-8?B?Qk53UTUyUkZyb0NOa2F4cm9OSGVEMjNRdFVFbWY2dWU0M1ora201cnpPRVZp?=
 =?utf-8?B?TWpuOU9ZWnBBejlUbWpIWG5mN2x0T2ZLUzY1TmFEL3dZSkoxbkRqd0lYUWdD?=
 =?utf-8?B?cWhzd2pGS0RhcEY2NmJiM0F1UWgrdUxCckdPOVZnajdOSWJSelIzOG1qcTRO?=
 =?utf-8?B?QWlDdS9aVmc4c3JvNCswaDdVZGVQaWo0eHhhZGNoK3NXZVdzamtaMFBvVk5Y?=
 =?utf-8?B?VER3dUZGZlNVMUltUzV6aDBNS0dua0tuMXNRSFNreEpGalNsenA1dUFtWTI5?=
 =?utf-8?B?ejBTNndaU1RDN2tNMGR0ekY3WnZ2SkRaU3h5SVZzSU1zTmgrRlI3SmloTkRQ?=
 =?utf-8?B?QnlDVGJMQmM1TjAvbjFNMmMrZXVWbzRERzJWNXBXMFZnbUNZTzBMVEY3TjIz?=
 =?utf-8?B?TzlFaW00UWx0Y09GMGw3NGQrcW9JNjhDMlViNHNUS0xleW5DUXpzdVVWWUc2?=
 =?utf-8?B?a2owMHA3YS9QTWhaanovZVNIMVV5NkdWaHpLdU1EVWR5c0czd2p3Q3daS0xm?=
 =?utf-8?B?T1VuaG1VTmlHWFpDcEJIdFlHTFZ6cyswa0Vkd09mNWl6MjN0WE9Pbm9oZnJP?=
 =?utf-8?B?b2dibG1DejYyL3RlaWRJRytwOU1xRHQ5OVE5WERnMHNQUlBpSlg5QzkxTEpP?=
 =?utf-8?B?Z0NuWC8zd1hrK3pOc2ZPNTlqNlZXQzlvdXhLRHpKczFUSFBLVldoaEhFN3Ir?=
 =?utf-8?B?M2FIckF5WXlMdVU0eVR5eUo1aEIvTVVVZDFXTzB0YVl3cmJjMXdGanhZRVNr?=
 =?utf-8?B?d3pRZjNqSFErQzlqZ2F4aFpQU0VHajAvMEdyem5JUjZRbmtrZVBpL1hqUWZR?=
 =?utf-8?B?d2JTK2R1dnhrYk5LWElPTjIvSytFSlVib2o2YUVXTEhxenY1MFZrbmVFTXM4?=
 =?utf-8?B?LzE3RkhBemFibkljeUErQVpDOFNFS2VlRENrNU5zVzNHVWJid0RHVHpQRTNz?=
 =?utf-8?B?NWIrWmxkQm5HaVdIRlIyaXF6UHVVb1hUVmhGbzhHWmROZVdqMUIzNEZWWmx3?=
 =?utf-8?B?WHNITUVLM05SaG9JYVZhRWp4Y1Vtb01tNVViS2pFdkkvaUV0a3V3RnN3bHo1?=
 =?utf-8?B?U2RUS2d2TmhBSzI1V2U4alU2STY2amgxcWg4cG53TEl0ZEVPOWpUbGJkR0Nk?=
 =?utf-8?B?aFUwb0ppdmF6UkJ1VU1SNXd1cVdyOE9kN0wyNWpRWHhvMGVNRE55cmpRTnNr?=
 =?utf-8?B?UGVmOUNaVE9VMytuL09MUEQxUENJRy9QdERVNmd6N2dDSnd0RjhuTStUYjNa?=
 =?utf-8?Q?468T0QZgqLxwXjw8=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f59e54c-56f8-4a29-c0f9-08de84cfdc73
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 09:22:22.6457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8W/oq8bq0qmTnY8YkBkS26GnZmP7jjeuSV0op+0XOTSzkg5p+nyxHkLBM4BGrWnyOmxFktcDBuTLbq40oK9qic912LvMPkE2cP85ol92hts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9708
X-Spamd-Result: default: False [2.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7130-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,nxp.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ciprianmarian.costea@oss.nxp.com,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:email,NXP1.onmicrosoft.com:dkim,oss.nxp.com:mid]
X-Rspamd-Queue-Id: 010682B9188
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Add device data and compatible string for NXP S32N79 SoC.

FlexCAN IP integration on S32N79 SoC uses two interrupts:
- one for signaling error and bus state changes
- one for mailboxes 0-127

Co-developed-by: Andra-Teodora Ilie <andra.ilie@nxp.com>
Signed-off-by: Andra-Teodora Ilie <andra.ilie@nxp.com>
Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
---
 drivers/net/can/flexcan/flexcan-core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index a6b15496853c..1fc7540c8b52 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -397,6 +397,15 @@ static const struct flexcan_devtype_data nxp_s32g2_devtype_data = {
 		FLEXCAN_QUIRK_SECONDARY_MB_IRQ,
 };
 
+static const struct flexcan_devtype_data nxp_s32n_devtype_data = {
+	.quirks = FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
+		FLEXCAN_QUIRK_DISABLE_MECR | FLEXCAN_QUIRK_BROKEN_PERR_STATE |
+		FLEXCAN_QUIRK_USE_RX_MAILBOX | FLEXCAN_QUIRK_SUPPORT_FD |
+		FLEXCAN_QUIRK_SUPPORT_ECC | FLEXCAN_QUIRK_NR_IRQ_2 |
+		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX |
+		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR,
+};
+
 static const struct can_bittiming_const flexcan_bittiming_const = {
 	.name = DRV_NAME,
 	.tseg1_min = 4,
@@ -2076,6 +2085,7 @@ static const struct of_device_id flexcan_of_match[] = {
 	{ .compatible = "fsl,ls1021ar2-flexcan", .data = &fsl_ls1021a_r2_devtype_data, },
 	{ .compatible = "fsl,lx2160ar1-flexcan", .data = &fsl_lx2160a_r1_devtype_data, },
 	{ .compatible = "nxp,s32g2-flexcan", .data = &nxp_s32g2_devtype_data, },
+	{ .compatible = "nxp,s32n79-flexcan", .data = &nxp_s32n_devtype_data, },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, flexcan_of_match);
-- 
2.43.0


