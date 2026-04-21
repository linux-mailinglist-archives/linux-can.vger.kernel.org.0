Return-Path: <linux-can+bounces-7381-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QI1XJuVQ52lW6QEAu9opvQ
	(envelope-from <linux-can+bounces-7381-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 21 Apr 2026 12:26:45 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2280D439794
	for <lists+linux-can@lfdr.de>; Tue, 21 Apr 2026 12:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5F6453014B9A
	for <lists+linux-can@lfdr.de>; Tue, 21 Apr 2026 10:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858F33B3C0C;
	Tue, 21 Apr 2026 10:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Dt6JTKWu"
X-Original-To: linux-can@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012071.outbound.protection.outlook.com [52.101.66.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEC639FCAC;
	Tue, 21 Apr 2026 10:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776767174; cv=fail; b=Gf1Mu+6+8+iKKd3ZigoODB66xn+pTHW8v5CU1TQ3M/iNn7bxy/ltVLR+DNkBxqDDeKdKBrKmeu4w9QPeb8JEuZ3kiBF3+DY13Qs/m+0Rri8IloyVlSRuPcaNfXHErs5O5P2NtBgcxfPmhe1sG16JsrI2B1qf1E8sFXgBirLkDl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776767174; c=relaxed/simple;
	bh=Zm3ptvpQhDE782aiCSoVyFyVihJlbDFrV5ltrpuZJiE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=P98dx4BPK3DZU3jHAcy+h5DMfTCHWPwYe7JsnUgIVUEK0GYIg9+CM/V6hVYrY34HzmQaKy+QdaNztxg19rqkhtmWo/MCQC+78dPNLu6+xjoN7RIVjxMSTJay9qGKjHPcERlSCDxVlT5ewKfNkQNgAJZZRIub/jOi7CaU6CYjTDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Dt6JTKWu; arc=fail smtp.client-ip=52.101.66.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W2HvpaduGgE5TYXGrbmlGs8L8fxuaaeqbtrEh28YG+VWKnVn8UM1IdtAxeL6fOmI+0mKwLC44u9Go7uYOAaqAA2YUC4LlxNG0+SDgA08kw3TCwS56LPjKd88yJqEjLztBd7/VkrUtb98yQ5HceHtMSOowJ+b5v8NpAK+JqsDpsjM0jVR7q/8Thv0rhEqOaU+mnFE4ZE46IzLWuRf0//GK3eQgdqdciWsyVyacMTzYPhVQZR/7aXh4ahVxClsU3gU6AZ12YZ6YCie/q59vN6R5e02rH8JAKyfh6C4ClBKdTluZi4Cv7I0llKsMHur87X/ie1vs1upXL7Bi3EO8vbmgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mrc9KkrT2cLU62y0xbay03DEnmjCaXnOa+oNEqr+A8Y=;
 b=N+iW/57C+Lo1STqF2ryHDLESO047MZ2pfoi0o0VE4Rh29RQvTkD4kbFNA+44AyymQ2wSXX/eGt/bfK1X5PiOB1kEl6yLYzdlx/63I+TgDvaRGcRa6QyyTUB/EqO+vt7PNwmbdiqRHLkk1C91TaaOvIHVv8VEHSZyhm9WY+9iPJbKyShesMgDwWIPx6AOy/K87HRP53/YnCOdAJzVY9NEl039AI8z+M3NMhSEOePJ8mudalQRQRcKZYWzT0DRICgAm10z2OgVBvh/v2IHMylzf/Jx03XZe+B65LU5COlqofdX6tEpQq680za+8GAAYWs/NXzvMlN/W/SRNNOJ5Ya1uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mrc9KkrT2cLU62y0xbay03DEnmjCaXnOa+oNEqr+A8Y=;
 b=Dt6JTKWuWjH3C7WQboclXS+n7VcQacz6vKs9RJ47MOO6nAb8EDaBMYx6qmZRcYqtL0vRxnJ38j7G9oCU0GrnXXUVRiQicXAx1nOvpnZkjUDDcdgQlGOTnINkrX1nkxXO3ifc+DbXn0Pbp1VMjoc2WVvuoWWf/a4YUqBt6kaYClncZ6tYaErrsSLobtto+K8xnaFOuOIkLLEAV4CIVm2tlQEF86iIECHie7mQaIWRd3ALdUiPcEeab6lBhTf0f5HW0r1Jr+vdd3SurvJW9mdbVsVKHziaSNnw5NrfhYRGtPNMnmY8yOxEFCSNs32xdSqz0341WwLMibcrrL8pmlD96g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by GVXPR04MB10111.eurprd04.prod.outlook.com (2603:10a6:150:1b1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 10:26:06 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 10:26:06 +0000
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
Subject: [PATCH RESEND v4 0/8] can: flexcan: Add NXP S32N79 SoC support
Date: Tue, 21 Apr 2026 12:25:55 +0200
Message-ID: <20260421102603.4122332-1-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P190CA0038.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::17) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|GVXPR04MB10111:EE_
X-MS-Office365-Filtering-Correlation-Id: a87ebd81-a082-44fa-3587-08de9f906589
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|19092799006|366016|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 BVGDdCUntAHr/yoAIISVsPaKkk3nIgLs5BJFaK2Dgn3RLiGB+QBpzETSErKKWAY+NhG5AbL9d1Q3hkfbDpjOW1LiYBN2RtCBTvg/tsF9Ux7+KqiuthxHX6UdeyCH+7Sl5y8S2Hb8XQExd156AX5I6fd7N8SWwUPT3ZczA5uFnUVjlNhRFKMC4krsnJToSfTNwIKW6/lop7Dt0oC0rXCbhT92eEnteWlcuWZyZY5FBc3gZW1K1eZYA09KxFG9tz6nc7lNyyrrqms9wqiO7k0yrzJt7yVwMYdcVWMGMyDoPr8/iC7eyTTOj8IpDoetv/unaoFIDXcdtPFAWrdPW3SReotI6WcPcuVR+klGEuPfuslDddC3In7pBOPFZvIAngilmYk2xalz4GM8Mqkj6vmcR5avPVQgA1rudUOZZFG8lbZ92CTeLTVp28odCsqqYjMUSFT9SdfT4fvZxs9/CQZLMYjuBNoseuCymlC3FYudCBl5K2Y+u99blU35dAI2ZcK7oiZiJrPMDfu4CMgVWZAyM3zrfDj87D9cMPlvXueddzcDxxdtjQOQL1NRvyosmS1ZcUTYaou+eS8GjVtyQYnLksZSfbdJf3NfxpaN/g1nQG8KOrkMNZb0GXWxSClc1ckfTi5KSrA+spnssxd623kFlDtn8N69GvaZD2bQr8dePvauzjv0vUmI/sKI9RH1m9DbmhF13tVDfTa5ShcIwDjCMl8Ww7mcgX5i6iGYd8A1cfo=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(19092799006)(366016)(1800799024)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?L3N1VXM5M2ZOYk5jS3N6Uk96NVNvOGp3UjBOYzFmaUg5dHI2YkJEZW00VHVj?=
 =?utf-8?B?VTlLS2t3OC9DSkh6UU04R3BRMkxsSGIwR3M5QjNXWnEyTlpnUnBTcHZJWTJt?=
 =?utf-8?B?SHhCaWJNN29DZXU4dHAwNEdSeTBLRGFreEFyN2poNkVONURKMGs1b1ZlUU5D?=
 =?utf-8?B?WVVSQ2s3QkxDUjZtdDN3VnI2azBLYXZTV3U4Wk5yRkxIK1ZNd0lmWUZJemdZ?=
 =?utf-8?B?ZTdTb2pYZE1nUGNWU1M0Q3dFTmNQL3d6QkxKU005ZkJiZ25SRDhsL2t3T0pk?=
 =?utf-8?B?ckFKS0w5ZjA5Z04rbWNtL3ZOdFYxeG8vazFQTGlBVDl5QXlsVUc4bXNFWTg3?=
 =?utf-8?B?K041RThsUTB3Q09raldBZ1pLZzZrVkNwRFhqbFF6TTEyM3RtWmlSZHM5YTB6?=
 =?utf-8?B?YkJOMDh3VkwxazZkVVF0bHY1ZmptRUp3SzhUN2N4dWcxeHF0QUFoRWlLV3hD?=
 =?utf-8?B?cEVBOTVYZG9hRUdMWHZXRmtOZlRwRnpBNlYybGI1M0xsckhSeG11Rjdhd3c0?=
 =?utf-8?B?eUlRR01tUjBrZmFZYjVVYktWNEZkZDRLS1l4bjNMZUNHNjdKTDdINHB3MFFM?=
 =?utf-8?B?eXBPaE9GNEJDS0s5Q2lmdThJaW52dStBQ2thWThOcXhza1FaUkpoR1lHbXd2?=
 =?utf-8?B?NjZVVEJFTmpYY21TZW1NSUdnV3owWWd5SWNIZ3JVbk9JdkM4ZFpWU3RWbFNt?=
 =?utf-8?B?Q2d5TnR0cytmUGFZYW1mTWVaZlFsemRMN0hUQW5zSjJKcWlOaUw0VEZYa095?=
 =?utf-8?B?TUozV3BsOXpCVy9lRGdZT0puUmZoN2VMZ25ZVS81d1BDemlsMjBWblZ0QlQ3?=
 =?utf-8?B?YWliUWVjdWJDbjdrdEVVL09NTEE2QmF2NFJKZnJPMUhKVzVaaDZ6VHJXQTRZ?=
 =?utf-8?B?WGpnTk5mZmVGUVAycy9nZzk4eGRZcGlRaXlic0JqcFBiRitXL3k0cUtwdDNu?=
 =?utf-8?B?NTZ6UnJXaFNKWEpSQy9odlowRzlqVGNaL3U1aC9aL2dzbmF0bGQ3cXNDdHFn?=
 =?utf-8?B?ZjlYSHZIU0FUbHdLYUtHV1RKL3JIZGdkeGdaTi92Lzcwa3dvOGh0VFNVOXJa?=
 =?utf-8?B?UXRPM1pTQ1dRenFhdlJmYmw0RGhzaHJoRlRxcXNXQVliSDJrWG8yUVpmZklK?=
 =?utf-8?B?eWNQTDhrRXZnai9nOURHUE8wdlI2N2YzdGcyR0IvV21RampsYjB5WDdaZXN0?=
 =?utf-8?B?TnFBUG16dmoxdC92UTRZTEtBRVZhekdFMXkzRXIyVzJkUkFLcHZPZkdGS0Jv?=
 =?utf-8?B?eU9MeG03RVVGMUlUYTR2YWUxS2dHTDRnY2NZamtaVXZFeS9EajN5aW5GOW54?=
 =?utf-8?B?MlNRQVVOVFFwbVhKMm5NZHJHcjYzUGY4d21wSnFENFkzUGVpb3VHcm51RE8w?=
 =?utf-8?B?Vkhmc3JwT3ptWklxaFI0ZklENHM1OTEvZGIwUGZaa2xIZU85VnJ4cGxqZU44?=
 =?utf-8?B?ZlRKOFM3QzV2TVlVNDUxNDRxRDBMcDBwTjZuUEliaWRpVUxuaTA2VHA5cTVZ?=
 =?utf-8?B?dzBKT2xiVjU3VkFnVE5XSWR4TUlnUmZqUjBSYVpjN1E0RG8wd2NKVmQxUXll?=
 =?utf-8?B?QjBGQTQwb21MVWVBMHBJcDhaaVh0elQzM2ZyQmgvQXVrNjloRG5LamdNZHpz?=
 =?utf-8?B?R0Y2bjJUMmVibGl1WVBLNWlTV3dKY1l5UHpQSTBWTzVJS1E4TERYblRYRmRy?=
 =?utf-8?B?cjZpMXl3ZnptMEp2MG5lekdjYlhKZ3JCVkI1dU9vTnlGRXRnSTM3YWc4aGJs?=
 =?utf-8?B?K3hGK2wxMnA1Z2VKd2xPT0Z1Z1dKb3gxMDRyVlE1Mi9lcXRHMEtJNGNxR05L?=
 =?utf-8?B?Z3Z6T29veHQzelhCNDNpZ1pjUmhRODY3V1dEWGlkUkM4dS9qazV2SGk1OTBh?=
 =?utf-8?B?Sk5RdzRWbnBOT0xLTjRheG15TVJMTzQ0SVpCVWRBUXJPYzhhOE85RndOd0NY?=
 =?utf-8?B?MklUN3p1REpJS3RIdXFVMEE0b2RzdHNRVUwvRDQzSEM5bXNFN0gyQTIydU9j?=
 =?utf-8?B?UUU5TjR2V0gvRXJ2cTBSeUZSR3V1bW5nbUJnUkJkMXBIWW9WaUpQcTYxVFpj?=
 =?utf-8?B?ekdRcUFsTmtja3B1Zm1qYWg2Y2dUcDZwZjJTN2loUU1LWklGSVovbHBlU2pF?=
 =?utf-8?B?aHdKZnRpcWpxZ1A0aG5CS2lDTDVrU2JWRUc0OERBcUdKWEVOdzhwS3JwWG5n?=
 =?utf-8?B?anBrbC9BT1dlNGgvd0xRa3UxQkdzMkFvdzFlaTFaKzR4dm11SUw4SU1LaXFS?=
 =?utf-8?B?NzNJaGxSNkUxNUNDWERLdmNvb0dmbWVibS9wVXhtWFVkak5rTmdrbjR2YVIy?=
 =?utf-8?B?LytLQTQ4bVpaaW5Idk1KZzJNbXAvbzN1TVcvOGJ0OXptTW5CZGJmZlNjQTRa?=
 =?utf-8?Q?XSkSSCEg9f0n9q80=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a87ebd81-a082-44fa-3587-08de9f906589
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 10:26:06.2268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ctG+DWYdGEo0KYOvsyprgAOxKMMKwxatRqVrLq2R99NWF7R5tBngKW4oVSE0HYncgQlerOIXiGilswU7IhkUJwtXv4AKMjVlnBi0VP11oXk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10111
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
	TAGGED_FROM(0.00)[bounces-7381-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,nxp.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,NXP1.onmicrosoft.com:dkim,oss.nxp.com:mid]
X-Rspamd-Queue-Id: 2280D439794
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

This patch series adds FlexCAN support for the NXP S32N79 SoC.

The S32N79 is an automotive-grade processor from NXP with multiple
FlexCAN instances. The FlexCAN IP integration on S32N79 differs from
other SoCs in the interrupt routing - it uses two separate interrupt
lines:
  - one interrupt for mailboxes 0-127
  - one interrupt for bus error detection and device state changes

The CAN controllers are connected through an irqsteer interrupt
controller in the RCU (Resource Control Unit) domain.

This series:
  1. Splits flexcan_irq() into dedicated handlers for multi-IRQ platforms
  2. Adds dt-bindings documentation for S32N79 FlexCAN
  3. Introduces FLEXCAN_QUIRK_IRQ_BERR to handle the two-interrupt
     configuration
  4. Adds S32N79 device data and compatible string to the driver
  5. Adds FlexCAN device tree nodes for S32N79 SoC
  6. Enables FlexCAN devices on the S32N79-RDB board

Tested on S32N79-RDB board with CAN and CAN FD communication.

This is a resend of v4 with no changes.

v4 -> v3
- flexcan_chip_interrupts_enable(): disable/enable all IRQ lines
  (not just dev->irq) during IMASK register writes
- Split rx/tx masks per mailbox IRQ line (struct flexcan_mb_irq) so
  each handler on S32G2 only processes its own MB range
- Added received Acked-by tag on DT bindings patch

v3 -> v2
- Split flexcan_irq() into dedicated handlers (flexcan_irq_mb,
  flexcan_irq_boff, flexcan_irq_berr) to fix duplicate event
  processing when multiple IRQ lines run concurrently (new patch).
- Added flexcan_irq_esr() handler composing state + berr for S32N79
- Ordered quirks used by s32n devtype data by value.

v2 -> v1
- Renamed FLEXCAN_QUIRK_NR_IRQ_2 to FLEXCAN_QUIRK_IRQ_BERR to better
describe the actual hardware feature
- Appended new quirk at the end
- Switched from platform_get_irq to platform_get_irq_byname usage
- Updated interrupt description in dt-bindings

Ciprian Marian Costea (8):
  can: flexcan: use dedicated IRQ handlers for multi-IRQ platforms
  can: flexcan: disable all IRQ lines in
    flexcan_chip_interrupts_enable()
  can: flexcan: split rx/tx masks per mailbox IRQ line
  dt-bindings: can: fsl,flexcan: add NXP S32N79 SoC support
  can: flexcan: add FLEXCAN_QUIRK_IRQ_BERR quirk
  can: flexcan: add NXP S32N79 SoC support
  arm64: dts: s32n79: add FlexCAN nodes
  arm64: dts: s32n79: enable FlexCAN devices

 .../bindings/net/can/fsl,flexcan.yaml         |  30 ++-
 arch/arm64/boot/dts/freescale/s32n79-rdb.dts  |  12 +
 arch/arm64/boot/dts/freescale/s32n79.dtsi     |  50 ++++
 drivers/net/can/flexcan/flexcan-core.c        | 249 +++++++++++++++---
 drivers/net/can/flexcan/flexcan.h             |  12 +-
 5 files changed, 316 insertions(+), 37 deletions(-)

-- 
2.43.0


