Return-Path: <linux-can+bounces-8356-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XEBLBoCnVGqMowMAu9opvQ
	(envelope-from <linux-can+bounces-8356-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 13 Jul 2026 10:53:20 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0C4748F67
	for <lists+linux-can@lfdr.de>; Mon, 13 Jul 2026 10:53:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=dajSxE8H;
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8356-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-can+bounces-8356-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 174EB300BB84
	for <lists+linux-can@lfdr.de>; Mon, 13 Jul 2026 08:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B043D2FF7;
	Mon, 13 Jul 2026 08:53:16 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011038.outbound.protection.outlook.com [52.101.70.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87163D0BED;
	Mon, 13 Jul 2026 08:53:14 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783932796; cv=fail; b=Kni0ORYv+tlqDzIWl7z9cHqYwWX2PmPJzbaTUHIC+teIbj8mdCegvS2nUldq5pXzWRbhqVtzyecSvInbaXuIA7gxH8g1mEv3KMfkoMZkl899bzT9XSqCDgZzOqLv2TiQPLmebrU/Gww9txe0SNFWxU00qLrQCwoY94BKydcXwSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783932796; c=relaxed/simple;
	bh=DfXNhZ2zkjoGK0kdAkKUEnkuIstiAu+TrU03SpuGKkg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=tTpQH/OHj9FqDD+mt6pQ1/FpLdaEcVVUPUp5R6tvSr7KoA2NVdiMFOetHS8kQIWdiEBX/iVw3bhCdL4dcrXnEuTGSizOpai8TTyHIBhjyFAGP/k2p9HsNh9K03+Lnty3vHrlzGYHqC74SD/1/gakYMd43NDYoRTzlXe1Hw0ejCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=dajSxE8H; arc=fail smtp.client-ip=52.101.70.38
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QHgbCiV6y0WyFQ/iTKPWJ6AGHJK4j+loZtmssOcsjCth0q8opaCEPyq9Rj5vhWFCKn9P3CpVuunV56Sc4hw2dNRbVZSpTQZfjddHNpC8soYmUiNHZnRGxtb0fWIZZt/IZrED+y8/FvsHFSs18KnNDDG0uaMoXGVwiRfDmMdy92nU/xqyCZc/veYfOrbRqpFcjnzpfltS3lp/Sj73cRfGdsIbeZWHV5fv6ed4Dr9er1kJqkvBkQYfFeM3UZPN4PjDbMPjvn9LackL1ONIwH5GSerw5Utza/7MMRjW2jsZ2Tv37i+CQnP16JTqaF8UIf96jFlqXfuXS6Om8/KEcno3QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O4neAEEIbvpAYMNKWZSF6baUKapACCKwEZLEBy6ijEA=;
 b=tA2VdJ1bXViR9cvRzKOsTYMMgExPYizd5cWl1y2soDk6BaRTDMXMzXA9lvb6jYqRwBl5/qys+ls7ZBRfVcrZTck9jkMAGg1OX+xfiDyBy2/QnLSfBfjPasaSoPPclFsOgREyIaARWL5/28YmPZqiH1AlgULOTIJ7Bli9MMBnrzfF5ZqkvGD3MECKz9qN9II4EeUn5MvnS2LfrFCaQQfoE2SGNnp0XFomaHQNZ1j7biwkJx13P9hxh0WTUl+AMkCtVQJkeZewtqLhAMHcM5r4P6b3VXRfIIyDJUEVLXa80FgFwgPXj6CqIDbjnJoD3j7wkmBoF6bV8I1qOiq9ER/Edg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O4neAEEIbvpAYMNKWZSF6baUKapACCKwEZLEBy6ijEA=;
 b=dajSxE8HF4OxsDl6N0WaxbZ25kLLbXiU8e6gTIpqVyBBQTqgxSjw6+w/jAqerMrDYiCKxrNQjMZjsBv3G4v7+3uOE1BpqoO9FtC7KAWeyy6ywud/aKkofAth6axKSYbB7R8uJ9zAy9nDWrldKZ66vZpbRzhLS/D34U4KQO/AN/XGb3r+q2RmTUc+KK3LwbIYma7K49c38tP2SLs83wZgLNoMD7JRXN+OQXF7l7SdnCB8M4QJx2v/BDPC/DXFdK1AAp9Egqf6GdbwZmQTgWzXpgx/ttbxISJpjzUzCfb4v88fjDbK+0syPwpS7bE5lwek+DK6YhQSG7WWbiQ8bB66Dg==
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com (2603:10a6:208:132::23)
 by PAXPR04MB9139.eurprd04.prod.outlook.com (2603:10a6:102:22e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 08:53:10 +0000
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6]) by AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6%4]) with mapi id 15.21.0181.017; Mon, 13 Jul 2026
 08:53:09 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Angelo Dureghello <angelo@kernel-space.org>
Cc: linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	NXP S32 Linux Team <s32@nxp.com>,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Eric Chanudet <echanude@redhat.com>,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Subject: [PATCH v6 0/6] can: flexcan: Add NXP S32N79 SoC support
Date: Mon, 13 Jul 2026 10:53:00 +0200
Message-ID: <20260713085306.2643794-1-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4PR10CA0020.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d8::10) To AM0PR04MB5858.eurprd04.prod.outlook.com
 (2603:10a6:208:132::23)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5858:EE_|PAXPR04MB9139:EE_
X-MS-Office365-Filtering-Correlation-Id: 21306e6a-55e1-4279-228a-08dee0bc2a0f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|23010399003|376014|19092799006|366016|1800799024|56012099006|11063799006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
 MAHu9GZ/3198XEhBPNr26r7jDQa3+D08JxCAKzrVZbHGKt+AYBSJiqllwo0fD165btqpEbwGZvBBHLpawwBZQcZpz1huMRIK+52faZbIBsZMIhJZNVJJO7UuzR0wCNXR67Nc0Qqj0kOG/GlW4zpKBqnD5BqrflnKbnq4Vf+lrQh5hVynXg3Khzsudi4SeEWInJn8oMU/1kaARWfS2RKxUDdYdJ34MmTZo0WXvgl8f8Aq7w+tJ+KGL92rjPpUq1NcxXO9TM7B1Mq2hB24GtZLZ7vPOeZS7jmyad1LoI8aq6Blr7hTSU1eFzDBNizNEzsUV9CBgizjrhI9dbscAqgnD9I3DhN74qpZY1v+PPsXN5PVCk7ahFzVNZXb3P/emMIVOVFtpJ4DT9c5iQldCXuiPSDxRFAAfAr3x9YK2pKP9MazzkP4dEHB/F960jFg9g+voJv6CTE9CbCudjQpTQ7V6nDgn4zIKTSgpQ2+OtBSehsfyqV4QYZWbGLc43S7AvO4foFfNrdF0woUH0XYSCVOG6+cWfOGy+rYb5jAWX5nRFK4Hw6cwRmFgs0S5pe1tdafMrOgLSAW4dzBUprkuoM78VwNSuN+FUUccHvGblAaFe467XEcyDNOI1eFWCIvmoILIIqoJ3DndWiSfG/LyiXU8kc6hiXXcdu2HspPEljm8rQ=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(19092799006)(366016)(1800799024)(56012099006)(11063799006)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?VlNiOE5Cc2JIWmtzOFozaHAxbzJyS0c4NS9VN3RjVXJxYmUra3FpTTc1UVkz?=
 =?utf-8?B?UmxYYTRFZi9ZYnUweXVqb0xLa0ZyQllvSWRobXpPbzlpZElBU2kwalpPYy9u?=
 =?utf-8?B?cWdwZjdyMStaRUxTRGxGb3pRL2ErU05HWE9VampFWk5mOGQydzIraVNGVXhi?=
 =?utf-8?B?Qm5kTXY1VWZ4N3RHSzVwc3lUWFMxbkRrdXM4VUUwT2dSaDRTQkJPZlJzTThE?=
 =?utf-8?B?WC9rMFFXWFFFSTN0R0xUNGpHTjhWaVRnWU9lTFVNUnF0bXRLT1R1bVJjYlFv?=
 =?utf-8?B?b1ZvWkRLbWl0UWt0eGNFWjgraE5KUDc0Zi85ek90Q2Y4K0tNSXBuNkd3elE1?=
 =?utf-8?B?Q00wbUF0azkwMjJHOVV2eXkvcjdxNWNrdWRMUDloN2VReVFqMGxqUWFXVlly?=
 =?utf-8?B?MGtFQ2VNWWk0ZzlKeW8wai85NXRyeGRaZkZLNHJWNGxYOVB3dTJlSVlxNlZZ?=
 =?utf-8?B?ckdOMEZqOUJQdnhzU1Z3bUpBSzZXeVUwYitmZCtzQWRZQWtZbzVIdndwQmhM?=
 =?utf-8?B?Wm10K1hydU5GWUNmdlJTQlV6OFd5YS9OMlNIWE1EOXVUdVpubDFNcWlYa2F4?=
 =?utf-8?B?Z3NtVUhDVGdhWHFvdU11b0l4dnVzanFweEx3UHFyZzdYbDJKekszY0NtN3lK?=
 =?utf-8?B?eTdLTERXekExWUV5ak43V1FlSFg3dGJ1V3ZrOWhKVlNMTVFYNGxHTSt3ckFj?=
 =?utf-8?B?VkVNYlh0Tm1WWjI4Z2h2MGtRdXJoTVZJcXRCeW1sY0loQ1AxZzkxWHRmaTNr?=
 =?utf-8?B?bnBLekZkMVhnUmVNbzJmSVd0M1hpemtGSmFCNE9DbjZFZmk0bWpBeTFqV0NF?=
 =?utf-8?B?ZHFRVGpPTXB2aFB4d0R1UmJkc3NwNlVVNFZweDdkaFpxSzBnSDZ2Z2R3dVNH?=
 =?utf-8?B?WmZUNGRDU0hKWGZLZHRPdEROMFZvZGp4STUvWjVSdlowWUg5eHRnRkVyakJ4?=
 =?utf-8?B?aW83VGNaWUVxV1B2cnp2Uy9zam00N0YzTW1RTjJHL0lTS1VEZkdZelcyWXFE?=
 =?utf-8?B?V0Z5ODJvMlgrMFJoM0Fzd0svdzhXc1dSYiszUEZ4NHlabHNyU3RLVWZyL1ZX?=
 =?utf-8?B?VEpEMVk3WnUzMnIwaldadVBFWVFRY0ZSUTRFaUdqRC9QWXJ1RWdqN1BrSWQ2?=
 =?utf-8?B?NnVtdnF0SDY2bXpyNUx5NTBIR2pvdk1DUlJiRXhpbHJVQWlGWmY2dHpuK2N0?=
 =?utf-8?B?WEZKZEFHNTR0bUdZMnpTMit0UG1GaExRekFPVTZIYWJYMTBvU2dlbWZxTHoz?=
 =?utf-8?B?VHdxd0xzSk53a1pCcklFNkdVdWM4TGdMU1UzY25lQXY1d3V6RUtheGxlZWlF?=
 =?utf-8?B?NUtwZEdEUEJRTlExS3ZYZDhDVjFVeWZpb1ZKc1VOb2VqeTRvQ0NvUE1MMXZ2?=
 =?utf-8?B?YlE1eWcwUmFHZkQxaEE4dWRkMUc4dk1QcGd6NmVPajdVTElSRkgwcVJnVGM2?=
 =?utf-8?B?TTZXZ1pleU1VejAvdTNlaWtaZHJoRHJJN2pIdkZud0tUenlhSWFGMlUyQ2dD?=
 =?utf-8?B?ZU9GRDRKU1lqWmt0cjBERFVRMElTcnczdE8rR2RqMUt3V29uRlFrM0hYdjFa?=
 =?utf-8?B?d3RjVEI5ZHdvQW4vL2Zic2prZFlrd21DamFILzZELzhERHRDS056cXh6WFhj?=
 =?utf-8?B?dS8zeFQrYURiendiMHFObUUxUnQ4cFExeER4TmxWV3QyT3FXYlZKKzFpdnF1?=
 =?utf-8?B?SUVuSGg1SGdhM2Vock1wTVc1eWFHVkNEQ1ovTmZGdmVkSVNROUVCNklMOGVj?=
 =?utf-8?B?RzB5WU1GY09IRklNdm92THZjM01xYW56dStvQndEMzNQR0dVM3pCeWNwWWJP?=
 =?utf-8?B?Z2xXQ09FeHUwTUU0ZnhYRWU3MkoydU5oK2ZKZSszait6L1VRQ3l6V0dndlF1?=
 =?utf-8?B?MVJyeGtxdUlKOTlyN015SGw0SUY3SlFqdmVsMlRQUE54OS9RajUyMUprWE1j?=
 =?utf-8?B?WnY1SWJSWFpPRE5zbUtvSzYyMGU0VVI0L0hGcVU1UTNSZGZwMnRobWdwd3px?=
 =?utf-8?B?Y1Q0TjM1WFgwUnpsVGgwaS80UzZSeWdhZnF3bkxYWTEyNTBRQnFuVTZhVHA2?=
 =?utf-8?B?c3Z5bUlSSGE3T0ZteXp4b2gzWVhCUUUyS3hjazFsVXk0TW1lV2NmZlQ1T3Zw?=
 =?utf-8?B?MkVqLzJCODR1VFpRM1FGYWdaYmYvK0xjZ3ZWTkEzWnJoV25NanZKZkY5Q3px?=
 =?utf-8?B?Ukcyb1lHM1hCYjdiMkZORmR1TXhrZE4rOS9CM1g2MEltQ1ZZTXhFQVBIbzdD?=
 =?utf-8?B?TW5jcjR6SEoveURjbkpnY2R2NGMraGpLeUs4WlpMdXlOTGllaHlmdVEvMm4y?=
 =?utf-8?B?OTBFWGpmUWZhbFFoek4vcURubDFpZytFaW1YdVdHNG03MllZQU5LdzE0UW50?=
 =?utf-8?Q?GYia6KU1nZ0XTuQY=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21306e6a-55e1-4279-228a-08dee0bc2a0f
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 08:53:09.8633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: niuvqReoHbZm97gxkMUhewcocLh5GtJQZqCTe9pUXEoD9EzE971wgFGTkkPFHKUrV6yCI/ORL+Z6WWjCIDAs/BZJSzznj1Miyfu3LzEXDO0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9139
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8356-lists,linux-can=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mkl@pengutronix.de,m:mailhol@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:angelo@kernel-space.org,m:linux-can@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:imx@lists.linux.dev,m:s32@nxp.com,m:clizzi@redhat.com,m:aruizrui@redhat.com,m:eballetb@redhat.com,m:echanude@redhat.com,m:ciprianmarian.costea@oss.nxp.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[ciprianmarian.costea@oss.nxp.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ciprianmarian.costea@oss.nxp.com,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-can,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,nxp.com:email,NXP1.onmicrosoft.com:dkim,oss.nxp.com:mid,oss.nxp.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9C0C4748F67

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

v6 -> v5
- Addressed a couple of cosmetic issues on patches 3 and 5 .
- Removed dts related changes as they should be sent on different review
list

v5 -> v4
- Simplified splitting rx/tx masks per mailbox IRQ line

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

Ciprian Marian Costea (6):
  can: flexcan: use dedicated IRQ handlers for multi-IRQ platforms
  can: flexcan: disable all IRQ lines in
    flexcan_chip_interrupts_enable()
  can: flexcan: split rx/tx masks per mailbox IRQ line
  dt-bindings: can: fsl,flexcan: add NXP S32N79 SoC support
  can: flexcan: add FLEXCAN_QUIRK_IRQ_BERR quirk
  can: flexcan: add NXP S32N79 SoC support

 .../bindings/net/can/fsl,flexcan.yaml         |  30 ++-
 drivers/net/can/flexcan/flexcan-core.c        | 226 +++++++++++++++---
 drivers/net/can/flexcan/flexcan.h             |   2 +
 3 files changed, 229 insertions(+), 29 deletions(-)

-- 
2.43.0


