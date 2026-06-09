Return-Path: <linux-can+bounces-7781-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BsqQAA8oKGru/AIAu9opvQ
	(envelope-from <linux-can+bounces-7781-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 09 Jun 2026 16:49:51 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F4366155D
	for <lists+linux-can@lfdr.de>; Tue, 09 Jun 2026 16:49:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=bMbXnVdZ;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7781-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7781-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95AD931261A2
	for <lists+linux-can@lfdr.de>; Tue,  9 Jun 2026 14:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35423352C34;
	Tue,  9 Jun 2026 14:30:14 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010008.outbound.protection.outlook.com [52.101.84.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7465E3438A5;
	Tue,  9 Jun 2026 14:30:12 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781015414; cv=fail; b=Bo6QISJdFRP3wW2/JB08TtFghdZralyXov+CChtaagN79uJ89qNwGfWfa4tczze2fLW8SM7ZoiwCohNkM22UfIU27Bntvgs7cyVglcCnNav2FN/W7Pa6uv2X6JKAMLwpcIZ/mhp+Hh4ObBCT7LrTTK76ISrf3jlMBf0oRbbZ8sM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781015414; c=relaxed/simple;
	bh=yqjm9e/jVtzaaVkfdCjpMcISauiXj4hSc4y/l8UOCps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N7vF6/iLuioLmKgT7J63e46RY+6ajXCl3C8oWHa215TQ5Y89AX0AdKUxDQKvyAWDsbp3V/o9MPjtF6HFPK9gZgtK57nmySoNMzH+dz7VZkjbg7GNF2THr19I1g2jczSfbY+17yjB30MVej9HPUPx9iot2dJNt7eLIyydaGBYwr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=bMbXnVdZ; arc=fail smtp.client-ip=52.101.84.8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mqXiQnD+UbL/YpWMz133PsowoSWMq7HjNEeOnAuTAM6QLAKCqiHhfcyymOCtbn54OPP7j/auDj0iBjycIg0tMKCb2joW+ywe3L0kuW3Y5Lwt2nBS/W2MdsiWfweodI6gVkjMRsSq5s0EGp/IOJUYaGJS/aen60LSPFiyEZ0Y+eRfiA+usDJMLHzQNCgd3K2xm6Ka24JI7Tye8v15JuPlnzZcOdvdrQDfyxpvOFExCnysM1TRe8cVy5WbVFb3QgCIqI/OY/cmg2L6GjOELksw/bBgtL6sqqncVmgdYLBFl8wD+vVrHK/g0Xae4LwMI5i1P4gYjdphmbIfkSjYjJugtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pOGCgEvHOsx8MBKASuwngqErL/RwRCkPDHD2cKebZ2I=;
 b=QIDhdzSfpxvfnUXGDWap5MVTY/BGmBlW6KBVEjwYfZWFAj/Z6Vt/1PxLMJzqoecpyIkM7slV9xsxppRepZygs3EAZvnv2BRrr9cggdfWTLJjjEndlYqzsKBqZItSN55UO3GK9hFkUIP8JJzhWBZQv6a9yhwiqcDAFyeGfVd4zudkJu6cLrCS+f2P8kmjJ3h0svLGwNUSpANsiRY6DhsMOfSe5ZgWfZXQalXJftzZqvhR1AHCVIgwxapR8rLjr0k9jGqpmWdYrZnmPppvJ53ejvF8/YfdA/UscpclEU6PKDzvKBiO5ChwFUOTcFLWZ2VjJCqpigLr6Z/JswzQniq/Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pOGCgEvHOsx8MBKASuwngqErL/RwRCkPDHD2cKebZ2I=;
 b=bMbXnVdZNr5lBS3St0Ytxc3nxaI0A2TOQOJpt5tGfpBsoXIJsKd6coKbPrM6XHt0ncQIZvkqfoj1PNHcyonihZdg8ymbE0WydX9TS4ZOeY1YkiOMQuMdLvbt7g9xh2EIebkHqjsTsms0wk3b4SVIG2f8LwTFWI65GxYHSp5iRXTzXw0qLeMzN0Mu9qVrzmXFcSjNoOcyiLiE/ZbfL6EeHY4xAOYoTNycKZK6eU/dD8qYeRXWGMxbIxwbrLhUUANtWjJ24qJLhkZAXNqFhmo3spI9nDNOD7CJA0k93SzbYh5AFT5dLUPj+X3rTAswGAa8/zNtz0Wcgh9fkjUhWY3AAg==
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com (2603:10a6:208:132::23)
 by DU4PR04MB10911.eurprd04.prod.outlook.com (2603:10a6:10:58c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Tue, 9 Jun 2026
 14:30:04 +0000
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6]) by AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6%4]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 14:30:04 +0000
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
	Larisa Grigore <larisa.grigore@nxp.com>,
	Haibo Chen <haibo.chen@nxp.com>
Subject: [PATCH v5 5/8] can: flexcan: add FLEXCAN_QUIRK_IRQ_BERR quirk
Date: Tue,  9 Jun 2026 16:29:51 +0200
Message-ID: <20260609142954.1807421-6-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609142954.1807421-1-ciprianmarian.costea@oss.nxp.com>
References: <20260609142954.1807421-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0142.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::8) To AM0PR04MB5858.eurprd04.prod.outlook.com
 (2603:10a6:208:132::23)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5858:EE_|DU4PR04MB10911:EE_
X-MS-Office365-Filtering-Correlation-Id: 258f558c-9efd-4702-2705-08dec63398e1
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|19092799006|7416014|376014|1800799024|56012099006|11063799006|10063799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 eWQPDMpDpL2L2Tn70nARYaHPPEKHKF6JfbubUiF7Z/vAgCYKNESk96+rURZDcPMl4jDUb8JjP4CfA6mqFD7b+yhNEuXsN+MnhHK14ZNSQ85ZHmBGT4W2ilxqgmoqVqSmSJvg1ZMdKNayvzZ67Wkz3Ct1hxAHk+k9Sdiy/RAu+ETbFE+9g3T5NuNceU1h5Esm/0PDbZRWKwwMqm5DYU6UOIGIA87Ae04GIWdMNwlU5ldF7/vkqJu/QuyOJ3YUAznncr3QSZzqI+YzgUPkqjMJ1D8J/n43ARi4rGoTLLi7WGUiLbBPnKyWsebQlbBoKSRyLx3HB8+r483qlTJQomrDnrFhRSzmmHbOQWGyDO+e0Y4GHrgUh++Num9aQnEiXH6Jlr3uLgYnTktpkNwIqMob0Y3lwNIxaR6LsZJN/dVai+MmwYoLx0vIZvvpi7A8eQQoydsYrbfYRe+AWGEEXL+ezNiDIzhnPYj//K/6rCnVcngxxtH3HjAg77QnU3hL++ywXRnbUsrb+STR0nzaH6YtV8hQ13r1dBF7//G6QebwUQqgaY4xsixG6BQwQOUKOCIUI4A0h1HD7WzCktQILlk8UeCWG5px77L53JCqVp9q7p+TtiyeuHYgE4PP+qOhD/EgeTXiD/7FVldTlbiBmQV9Qp+oOpjqAnXpGy4AIbpTs08YSkxL8ym3Osn6w/FGlLEH
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(376014)(1800799024)(56012099006)(11063799006)(10063799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?THlwYVdoYVd2ck5GeHdtTStMVXFxZkkzL2xoNm9YN1NqbVFnM21iYzRnOHFn?=
 =?utf-8?B?OXRTLzRLS1hxeU5aVy9Jdm5peUVXWmlBT0s2bHBYcjhZZ2FMQzdGRHNGOUZa?=
 =?utf-8?B?Z0ZzUUw1RlN4anRZalQ4VzErREZ6WjQ0S1Y0d2ZhZFoyU0o2WmwvTU9hWkZO?=
 =?utf-8?B?TWNMZkJEcUtUczlua3BvRU5POWh2aDZtaTU5enN1KzJRM0xxUlBsR3NzeG5u?=
 =?utf-8?B?cjJFbkpxOEFhWWQ2TFRpczBoSkp1TWdTZ3VKdnlOUDZEUmlLclVkeUl4bjFr?=
 =?utf-8?B?d0xUNjZhcExBbXBYWi9RWFZDSG9GZFV2MjI5Q1hIN0laZjVDUHc5OFgzcjMz?=
 =?utf-8?B?MElNWEJUcERRaExsRjFzT1hhNi83L1YzTUd2U1FaanQxSDZ3OThkZEtSbnkv?=
 =?utf-8?B?dElwcUdEVTlSakNScXlZUTZ3VHltdDZER2tDME4ySmIyeS94enhMckFmV3Fk?=
 =?utf-8?B?OWJyM2ZGL0ZYQnpOeGlpZWRCNUFXbE1VdDN5S0JYRzhiRmFBQWFqbUxBSnZk?=
 =?utf-8?B?THVVVWtOS2tpNU1xcThXbFcwd0xJV0FIZkFqbWJ1bmg1TE13SVJaZ2pUQ20z?=
 =?utf-8?B?RHNRdEVYVWszT3hnSmRrOFlkQVRqUHp1OHVFZ3BhL0FHQ0VGRG5EQ2kzVjdy?=
 =?utf-8?B?RnFkUWZ5SHlpYnRPZXMwQVNIL2pvNG96alZnMTc5RGtwaGZtOVUyRmdYMUtq?=
 =?utf-8?B?dnphTHFZMUl5NGJtaVlvcVgzdSticTI5WmhlbEp0M0pyYjNLc0dWTi9BZFZr?=
 =?utf-8?B?VjVJNE4ybTdmRlZGSUFYQWlEV0xjZW9mMU41Y1dPYUxIam5TdEJKeWV2Zlps?=
 =?utf-8?B?d09USFQ4bTErcUNva1Fhb0JVWWNVeDFuTXhOZGpNQkh2d3A3MW1mR2V2WE1w?=
 =?utf-8?B?czJ4SkhwR0lxQk80RWNMemV0RTBXQXpQMUE2RWhieGZ0OWFpN1VENDV1M09L?=
 =?utf-8?B?SjN3TW1XUTByNWYySjl1dFVqUDh1T1lDR0JMeU9QVzUwTllUVG5vbzlINjA0?=
 =?utf-8?B?NWJHWElYeFFYWllFQ2JSZXFGNWZ2enNqZFZ5Um1RSXVpY3k4RUJBbC8vMXNZ?=
 =?utf-8?B?dElXK0U0V1FIRXhidU1PSEQxdmtreDVLQjFabkVvWHJsZWxmVDEzYVlGaFdL?=
 =?utf-8?B?eWhuYWE5bVVyKzFkR3hZVjB6cGl6VXozWWVCUzNScUxwWTNMMXYya1B2WnNa?=
 =?utf-8?B?WEVGV05RZEF4ZW9RaEZmQTAyak9PN3AwUk1HTFJpNnJQRjhhMmxEZ0hCd0NV?=
 =?utf-8?B?b3pDeGZFYkdzNVpoa1BQOTZaWlRBdFRLMTlsMkVuZEE5M29vL283YllmSEFm?=
 =?utf-8?B?QzVHMTA2b095RENPdiszaGtIa0RrV0prWDJjKzQxUmIyT1JhY1VLN3JCTkgy?=
 =?utf-8?B?Qm5CeEowRDJ6R0VoVU5TSzVTVjFUeHIyYUVaUWtZSHY1L1JOQ2drWGZtaito?=
 =?utf-8?B?Y1RhaFZTTnY4MUJxRlNJNWJCUm8wNnNxTkNlQ0hVclpIcG5qbkgyNkFqK0Nw?=
 =?utf-8?B?MDdoelBnTTRpY042bHdTQjArTXFhQkF6b05uTW81ekM1TVQyVkZzTmltcy9Y?=
 =?utf-8?B?NnNHUDJaMTNrK2hiQUNxb1dzS2sxNGxGbng2c3J1bi9FVCtIV29uL1FHcDlV?=
 =?utf-8?B?alJ4dVVQS0NrRzRYS1JQbnlockVxdmIyU2wzVjUrcXVpSnJ6Y1JQTVNZWXRM?=
 =?utf-8?B?Qko3TjJwZncyNWRQaUo4dktlaERZUFNsV29NaGZpNVIva1lSRTI4S0x4MHhy?=
 =?utf-8?B?TzZ1THZoZkNvaFk0dXpUYmlycm5xdG9JdDlaY2NGWmNEQ2sxdXdpd0h1dXY0?=
 =?utf-8?B?U0tkaDV1d1ByUDFrRm53elhCMXlVTHdrWlJmR1lSZ2VCbDg1OWk2UXYxVHJI?=
 =?utf-8?B?OSsrc1ZNcThMdkp0ZnkvUzdzS2gvM1VmU0JIZDBFa2xzME5JV2YyYkp0TFAx?=
 =?utf-8?B?MmZtSFFPVmE0MEVWcnVrVnpyMjMzWDVUWi84TDg5U2szS2s1V1g4aVlYd1dz?=
 =?utf-8?B?cUNTRXZGNTJueW9qTUNvaDc3eS9hdkNERi9ydGFUaVJSTGM1dXFNVitKTkhp?=
 =?utf-8?B?QWFzVitNM0pLQVRWTStiV3FFYlgva1FGWlhFREtYZTFkNjVlelpkTlFFWnQx?=
 =?utf-8?B?ckpONWsyVXQ0UXZESlVwVGRVSzZua3dxcEovKzZUa0M4SkNGMno1ZU1GT3Rp?=
 =?utf-8?B?eW56VEVOMlk3ZTA0aEZhaTZobGk0UGRMbThmaHZkZ09EemNOMzVWK1JGaklV?=
 =?utf-8?B?Y3FMMURlQzNicGJmTWJOaGpNK0ZLbzJXRUQ4TndwakdaWVJzbWtpNUZZd09J?=
 =?utf-8?B?ejlEMVRoSVZ1SGc2OENzNEhPa0RqMDJBeHNacmlmVEgwR0pHMU4zRldvdzV3?=
 =?utf-8?Q?tzb7AqqKpT3UC+eM=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 258f558c-9efd-4702-2705-08dec63398e1
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 14:30:04.4925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bNcg3Q2iLxrgvo/wil15gJj82hIaS2e/zl9RmNVdHTjREGkpudF1ynCu7SB5Bs4s0BYPJigA41rVfdHePU8VUvdIw2cyMfcK0P4G+YDFEQU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10911
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7781-lists,linux-can=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mkl@pengutronix.de,m:mailhol@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:Frank.Li@nxp.com,m:s.hauer@pengutronix.de,m:festevam@gmail.com,m:kernel@pengutronix.de,m:linux-can@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:imx@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:s32@nxp.com,m:clizzi@redhat.com,m:aruizrui@redhat.com,m:eballetb@redhat.com,m:echanude@redhat.com,m:ciprianmarian.costea@oss.nxp.com,m:larisa.grigore@nxp.com,m:haibo.chen@nxp.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[ciprianmarian.costea@oss.nxp.com,linux-can@vger.kernel.org];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,nxp.com,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ciprianmarian.costea@oss.nxp.com,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[NXP1.onmicrosoft.com:dkim,vger.kernel.org:from_smtp,oss.nxp.com:mid,oss.nxp.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nxp.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 50F4366155D

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Introduce FLEXCAN_QUIRK_IRQ_BERR quirk to handle hardware integration
where the FlexCAN module has a dedicated interrupt line for signaling
bus errors and device state changes.

This adds the flexcan_irq_esr() handler which composes
flexcan_do_state() and flexcan_do_berr() to handle platforms where
these events share a single IRQ line.

Also extend flexcan_chip_interrupts_enable() to disable/enable the
new IRQ line during IMASK register writes.

This is required for NXP S32N79 SoC support.

Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Reviewed-and-tested-by: Haibo Chen <haibo.chen@nxp.com>
Tested-by: Enric Balletbo i Serra <eballetb@redhat.com>
---
 drivers/net/can/flexcan/flexcan-core.c | 54 +++++++++++++++++++++-----
 drivers/net/can/flexcan/flexcan.h      |  2 +
 2 files changed, 47 insertions(+), 9 deletions(-)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index 0ed838f0719a..adf3af57fb0a 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -1300,6 +1300,22 @@ static irqreturn_t flexcan_irq_boff(int irq, void *dev_id)
 	return handled;
 }
 
+/* Combined bus error and state change IRQ handler */
+static irqreturn_t flexcan_irq_esr(int irq, void *dev_id)
+{
+	struct net_device *dev = dev_id;
+	struct flexcan_priv *priv = netdev_priv(dev);
+	irqreturn_t handled;
+
+	handled = flexcan_do_state(dev);
+	handled |= flexcan_do_berr(dev);
+
+	if (handled)
+		can_rx_offload_irq_finish(&priv->offload);
+
+	return handled;
+}
+
 static void flexcan_set_bittiming_ctrl(const struct net_device *dev)
 {
 	const struct flexcan_priv *priv = netdev_priv(dev);
@@ -1540,10 +1556,10 @@ static void flexcan_chip_interrupts_enable(const struct net_device *dev)
 	u64 reg_imask;
 
 	disable_irq(dev->irq);
-	if (quirks & FLEXCAN_QUIRK_NR_IRQ_3) {
+	if (quirks & FLEXCAN_QUIRK_NR_IRQ_3)
 		disable_irq(priv->irq_boff);
+	if (quirks & (FLEXCAN_QUIRK_NR_IRQ_3 | FLEXCAN_QUIRK_IRQ_BERR))
 		disable_irq(priv->irq_err);
-	}
 	if (quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ)
 		disable_irq(priv->irq_secondary_mb);
 
@@ -1554,10 +1570,10 @@ static void flexcan_chip_interrupts_enable(const struct net_device *dev)
 	enable_irq(dev->irq);
 	if (quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ)
 		enable_irq(priv->irq_secondary_mb);
-	if (quirks & FLEXCAN_QUIRK_NR_IRQ_3) {
-		enable_irq(priv->irq_boff);
+	if (quirks & (FLEXCAN_QUIRK_NR_IRQ_3 | FLEXCAN_QUIRK_IRQ_BERR))
 		enable_irq(priv->irq_err);
-	}
+	if (quirks & FLEXCAN_QUIRK_NR_IRQ_3)
+		enable_irq(priv->irq_boff);
 }
 
 static void flexcan_chip_interrupts_disable(const struct net_device *dev)
@@ -1881,7 +1897,8 @@ static int flexcan_open(struct net_device *dev)
 
 	can_rx_offload_enable(&priv->offload);
 
-	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3)
+	if (priv->devtype_data.quirks &
+			(FLEXCAN_QUIRK_NR_IRQ_3 | FLEXCAN_QUIRK_IRQ_BERR))
 		err = request_irq(dev->irq, flexcan_irq_mb,
 				  IRQF_SHARED, dev->name, dev);
 	else
@@ -1902,6 +1919,13 @@ static int flexcan_open(struct net_device *dev)
 			goto out_free_irq_boff;
 	}
 
+	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_IRQ_BERR) {
+		err = request_irq(priv->irq_err,
+				  flexcan_irq_esr, IRQF_SHARED, dev->name, dev);
+		if (err)
+			goto out_free_irq_boff;
+	}
+
 	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ) {
 		err = request_irq(priv->irq_secondary_mb,
 				  flexcan_irq_mb, IRQF_SHARED, dev->name, dev);
@@ -1916,7 +1940,8 @@ static int flexcan_open(struct net_device *dev)
 	return 0;
 
  out_free_irq_err:
-	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3)
+	if (priv->devtype_data.quirks &
+			(FLEXCAN_QUIRK_IRQ_BERR | FLEXCAN_QUIRK_NR_IRQ_3))
 		free_irq(priv->irq_err, dev);
  out_free_irq_boff:
 	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3)
@@ -1948,10 +1973,12 @@ static int flexcan_close(struct net_device *dev)
 	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ)
 		free_irq(priv->irq_secondary_mb, dev);
 
-	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3) {
+	if (priv->devtype_data.quirks &
+			(FLEXCAN_QUIRK_IRQ_BERR | FLEXCAN_QUIRK_NR_IRQ_3))
 		free_irq(priv->irq_err, dev);
+
+	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3)
 		free_irq(priv->irq_boff, dev);
-	}
 
 	free_irq(dev->irq, dev);
 	can_rx_offload_disable(&priv->offload);
@@ -2338,12 +2365,21 @@ static int flexcan_probe(struct platform_device *pdev)
 	if (transceiver)
 		priv->can.bitrate_max = transceiver->attrs.max_link_rate;
 
+	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_IRQ_BERR) {
+		priv->irq_err = platform_get_irq_byname(pdev, "berr");
+		if (priv->irq_err < 0) {
+			err = priv->irq_err;
+			goto failed_platform_get_irq;
+		}
+	}
+
 	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3) {
 		priv->irq_boff = platform_get_irq(pdev, 1);
 		if (priv->irq_boff < 0) {
 			err = priv->irq_boff;
 			goto failed_platform_get_irq;
 		}
+
 		priv->irq_err = platform_get_irq(pdev, 2);
 		if (priv->irq_err < 0) {
 			err = priv->irq_err;
diff --git a/drivers/net/can/flexcan/flexcan.h b/drivers/net/can/flexcan/flexcan.h
index 16692a2502eb..bbb1a8dd4777 100644
--- a/drivers/net/can/flexcan/flexcan.h
+++ b/drivers/net/can/flexcan/flexcan.h
@@ -74,6 +74,8 @@
  * both need to have an interrupt handler registered.
  */
 #define FLEXCAN_QUIRK_SECONDARY_MB_IRQ	BIT(18)
+/* Setup dedicated bus error and state change IRQ */
+#define FLEXCAN_QUIRK_IRQ_BERR	BIT(19)
 
 struct flexcan_devtype_data {
 	u32 quirks;		/* quirks needed for different IP cores */
-- 
2.43.0


