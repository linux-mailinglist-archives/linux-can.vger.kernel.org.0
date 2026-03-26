Return-Path: <linux-can+bounces-7258-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBCiHCE+xWn88gQAu9opvQ
	(envelope-from <linux-can+bounces-7258-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 26 Mar 2026 15:09:37 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE5F336929
	for <lists+linux-can@lfdr.de>; Thu, 26 Mar 2026 15:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D87430BC414
	for <lists+linux-can@lfdr.de>; Thu, 26 Mar 2026 13:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB42D324B1E;
	Thu, 26 Mar 2026 13:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="hi6QKn9u"
X-Original-To: linux-can@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013067.outbound.protection.outlook.com [40.107.162.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8C230DECB;
	Thu, 26 Mar 2026 13:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774533526; cv=fail; b=WQQRG6yOyyT7l1sf1dc+3yEGdPMuZFGNDHrS4uq92YNKhkj9OB6nb/NlTrzT20tptqDPkihWMTGZRJB38WTVsg/ONsCjlgbHLkyAQlcdLzjRtLiVBsfOdI0ORo6GPGwnFXflbwKHbpp9Gfu7zK/3V7oE8OGeUi80VkUQPYvESEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774533526; c=relaxed/simple;
	bh=qzems42JZDALtZjOyylkBxSamEuZvhtzQ6EdLzhOMsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B1SSHpR+gPqqs4EugHlv8zGVqN2dbv/yzEczPZAcJhtA1w/OpnXRV1SWZeiUhChPuzn8AQ31cjEWiB058f4NlyyeSIvFLvY0zK9VtoLU/k5VVOL8Ralza18Kp1cDQY4ENBV9ebkt5v268WDudiU0AjMxtMqXG7SVcpEKdc5z2Kc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=hi6QKn9u; arc=fail smtp.client-ip=40.107.162.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s7DJGZVvZHv96A3W3rozJyN6tLoe8uvL2JsHvEnh0HVAOupm3sXEVUcV9cNCjP6Z9SVNiNprwPStZTLf3nD5aAPszIVAFVu7poOCw1VrN2ecltEH6dRfbBpAXrnwO9Q2taG351UvUq4spViWmRSENRiGrhjOXu5VIcNOyGAeM2iZpERHsXOvAExVOoYfZ3DjD84lxi2GTAFRyzc7lcT/+3qsc/VjMzD74wKb4yE6thcj5mEgmmgTI8AFnmFUP2QtM9mIezWqLF5r8Q14hCfTREztcHvVl/63EJGwrOV03j/Lh4GX+b06GAQJF3qpg7CjI6eNy+kqeUghVmHD8jU82w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5uss7/Ijtj0jsVvVvdMGWuu3tCDw6dMlREoi5kZ5o+Q=;
 b=WBbyb1CQOunfLK++yZFrEO89xpavi29a6O6Zanzg/ejJCjoh0oAZVaXS3xJXwVzjVJH57FJgRl8BvMMG/EsTD5o2YPFaakNHV7bpJKFgr2ry0T09LGBLxjiLk1JRSOJ2Q+vL/D5nQVwzz+voVsMQAKWK7uQ6Dh85fmr4QMFF4pkRgULzF+KPjWCU4nea0Kpsb2Ris3aEuht8On28NhJd6NQ4aSfJylKsh7oJmdgX77/kW+FMNPoicsOSHekJ5JSNl8gOiZ3hNO3r0N4Ysrc4T0Nnh7gDnM7NDysjB04vQNCwuJ7okSS9uSN3cbTjAWU5jDL/Rw7ZkV44t5pQCnPoew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5uss7/Ijtj0jsVvVvdMGWuu3tCDw6dMlREoi5kZ5o+Q=;
 b=hi6QKn9u4hJKD3OfKez/v/ZfGs9rMruZ1PJ/4+IehRRD2dR1+m2s8LIBRCByz0n6C5oiUnki4wAWNkWxojkKF8kMjIrJ5KXuMMAAZbJVs6M7IZ6Wu25HkLLsl9jLTIAzWE+CR6QU4OUhnxjChF9jYWLtm1hsmG6C0I25vtrqbkHVyEhlzegTcK5Ew35FJvZbSTkgVUYDLGK+VeJ76kDaFhCM5aoQpYn66eJLCB0AL7rSx6M1FzAqKdB9FmNLQUZH96aiEFo1gNik0qQNaDLjj36/+57R6Y7whnOVBEAbpaVwqsGcWPBfXQGbVDWFVI8DQsjURdVQ4A17GOu24t0tGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by PA1PR04MB11261.eurprd04.prod.outlook.com (2603:10a6:102:4eb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 13:58:36 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9745.022; Thu, 26 Mar 2026
 13:58:36 +0000
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
	Larisa Grigore <larisa.grigore@nxp.com>
Subject: [PATCH v4 5/8] can: flexcan: add FLEXCAN_QUIRK_IRQ_BERR quirk
Date: Thu, 26 Mar 2026 14:58:22 +0100
Message-ID: <20260326135825.3428856-6-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260326135825.3428856-1-ciprianmarian.costea@oss.nxp.com>
References: <20260326135825.3428856-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6P192CA0057.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:82::34) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|PA1PR04MB11261:EE_
X-MS-Office365-Filtering-Correlation-Id: 67cbd70f-920a-4c99-267e-08de8b3fc653
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|19092799006|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	glp0B80VCzkpZcTsmCFTutmmJq+5Ky/CzBq+nBq8miZOZ10HprRFbmfSYrsZKI12+IRaPnLI5CL6GspclsS76dL6O+xb5FD+oAlAf62dJOR9QhU/JrdFu5sQaBbQnVUr2JLzE5Rd9PykItATBh4YdhmdXkgJOkE3XKG9t6u7DvgNBCyUt8/8w6fSma98Vmsv2RNf4N699/CHwkztd3KqkB5y4gsGLQ0MbjKMFhqtGzeArqv4uKTbOBQipIO+PTfGgW41Z/uU5qUlGb7Bkxq0jyoqr8Qodq0fAzpEvzXLPH/+uwV5yhRNBTTvNz8OJCBAalut8cOxHE20vWj2iHacuy/cd7e4/EGJ15F2qtxovUAjezP9X/zuI4MGRQVdj4r2luFijUVAeqXrCbM9z+YLnXwnkkFdsAvtMfShsEikKjJ5kSM3tl6fZEV5RZjm8fQuwMG1GGYwsIrkDyvTDZPFYL5A4/ZnYHhE61DOD0ykOYTNTBGSf8+wpLJfR5BMV3m/ICt+0x9hlEpZ4HKQYVJYj5EkayrbgWkVM2NwqN1GayZF4fBg1dsSrPd5Wr++YInczh6fbHmWynq2ta3QTzQZjknRlYDPBnsu2GPVoaWQhettLpokhPEvWxrwh3W4MVd1113NBZEUZGoL+6J2PhXqeh+Q2wsmor6twHRazUfBi7I6qNDs0r2BfU9rtaYkYc8C51nQdAD9N5nYMVq0tNq0D6Tn2spq+mTgfXmADm0zyDg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(19092799006)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QnVTQ1h3ajBMRS9RNGdlNjZVQis4OGRxazFXUkt4cGpHc0p3N09ETzIwNGta?=
 =?utf-8?B?c2Q0RUxLa1dmNnB6czdQZmV5MGR0d216TFNISlNNUHZTUjVKSmt2Si9VeDgw?=
 =?utf-8?B?ZWYrdmM1enZJVDJHU25IVytvZGJLWmpyQm5haXE2T0RHWUpKSVgyMGg4Q3R3?=
 =?utf-8?B?ZWlBS0hzSjEvWEhxd2x6UFNubkhiZVVuV2FLVGRWaXhTMG1heGx3R0JBcEV3?=
 =?utf-8?B?R05Eb2NwVzk5SDlvYUFYeUNReE5BdFM1SWVzWG5sclVBUHFEV2Y5SWRIeGM0?=
 =?utf-8?B?Mkd6cjVMNk0wRUtrWndqaTNHQ3h1M09IclZaZFR2YVpvS01KV3VNbTZyWitB?=
 =?utf-8?B?RDF4d2I3aUFFNS8vNHlkS2MrQzNFdmwyUGRpbDIwZWZUa1pnb1ZGdEE4Snpj?=
 =?utf-8?B?bjB6azdpNW5IcndlWkloL1o3L3hlK24wc2lSbDlFWFdvb1BYcXo4U2VYSVg4?=
 =?utf-8?B?Y1ZuVUQvMnBRZnNzS0xndnBhOXpGS1BXd21uSDVNdWV6bUl1MHh0NFU4dG4x?=
 =?utf-8?B?TVVkaytSNW93L3k4TzlTcXVkU3h2U2JtbWtPSXF2bEZ0czNud1NJWmFpR0pF?=
 =?utf-8?B?ZlE3VGIrVHA3Sndqb0p2MktOdkJFUjlTVWQ2d2lQNVpUejFWZzc3bXdrVXB4?=
 =?utf-8?B?WGpBc2UvMjRZWXJtVHp0anBNLzZZMjFKbjdWb0NUYys2YjlxL2ZqaG5JSHdt?=
 =?utf-8?B?bUtMY0V1U09WUHY4dGxJYStJTDBreDhXMlJHUFZudTJFY2IyY0d4dHU4KytR?=
 =?utf-8?B?UHd3dkxYOUlINHB2eVplSlp2a08wdWJsVHorWUpHM2grRC9QdkVVU3FJQ2N1?=
 =?utf-8?B?T0RnWmkzOU1ydkRhek9GR1Viek1YR01JM1YrdDM3TUFiTkU5SGJIY0N6aDNy?=
 =?utf-8?B?djRXbXA1Mjd3WnlRaC93MXk4V1pQNEwrRkRpaG93NlpseVdIa1Z1cnFBMytt?=
 =?utf-8?B?S0x0cEpsVUhoQkdZZW16U3pNeTlDZWZZMGUwYTJoSzRLU2pLNUZZWnJYck5y?=
 =?utf-8?B?NVZwNGNFeFlaazFsczI3RmorRnprMDNxckhlcmZPQTRKcjFoSGpuWEJOVXBG?=
 =?utf-8?B?YkppaEVhM0pJOEcwbFp3UEZhdEdKL2JrYjdRT0czM2VxQ3JYTHlQNmFqSmlm?=
 =?utf-8?B?dVIvUU5SM0NaRnI3VEk1R0Z1UFZpQmJpcUNXUUZuMFhiSmFtR3lsb0doeEd6?=
 =?utf-8?B?QlNlQmg0SFU0K3doMjQvcG5pRGZKNUVGYTE2bnNGZFdraE1GSmF1Y0V6eEtC?=
 =?utf-8?B?SGxULzZLTWhBY0dCdHBSTjZ2SGltenhZTmdyM1NYaHdKNnRKcm5IbjFBYmI4?=
 =?utf-8?B?cklFMy9tdXlLYkRkNGx4QlR0eTg3N1ViQzRjenIrcWFHWHR5dWUwb1Fsd0tU?=
 =?utf-8?B?MVB5WllFR1Y3S2NVaXF6WlkrcEJGTElnQnQrUGNNeUFIaXBpckFrZFBNaHo1?=
 =?utf-8?B?b1c5S3lPbFQyRGdjZUJHdWg3TEV1c21Dd1FpRFF1VjdkOThsamFUdyt2eHNm?=
 =?utf-8?B?a1MxZUErREdqWW43QVFra2t1UGNGUnhPL0xEZU40QnV0Ty83aFhFcTdYeHp6?=
 =?utf-8?B?TFI5bGlIVzV5UkZobUhmVG9JbCtzVDFjRkI0VVRJaXpLZDFEd3VKZVYycENI?=
 =?utf-8?B?VFk5VGxyTThINnNVMHNCcHFLb1dGSXhYLzBBWjNHQmhlcW5pT0tyb2wzdUFt?=
 =?utf-8?B?UUNUVkM3M3RwZmxSdHM0Vlp1dkQ4TjVZTWJzMlBzZ2Q1ajB3YlhjS01SY09R?=
 =?utf-8?B?RFpOWXc4ak1ZZmw4WlZCS2pONzVINDlFWGhZaEFXY3k4TUMvME5uaVpvL09m?=
 =?utf-8?B?ZDBOU3RPOU5Eekp6WkdPc0VLRG9ndHAvcmJFR0xDNXR0Wm96OU5FTnYyT1VF?=
 =?utf-8?B?ZHRtZ1NoVzRJWUxubHl5MkVnanBrWVcxS2F5eGpLdWFKSkpXaWM1MStNeGJR?=
 =?utf-8?B?RlhHZGhOaDdRdEtKU1NHYllGVmJOcC9BR0Exa2FsUnV0OHcvRjBteFNqcElM?=
 =?utf-8?B?cEJNbGN2WWhUQUR3ZlNYQllRS0p5OHRHZUUvL1B3K1l0eVBxNDJXbzMva0Fm?=
 =?utf-8?B?R0pHNjJxV0R0K3lIQy8xa3dyTEk5b0NxZW1YaXArMUF3clRTblhnL0s5K2g1?=
 =?utf-8?B?NGVnQ0s5c3RnNEF2NHFuQlJJaDh5QlFpMFYwTndBdDhTSWVjZmVXelp1V3ZX?=
 =?utf-8?B?VUxYaFdwQkIrVXlmeVlMU01ka051ajhsTDlGOHIwemh2VE5YckY1SlBYdE1X?=
 =?utf-8?B?bEhLYllHTXlyTUdwTU82TGFYSGtxaGp4TUFabGFaWUNOa2RMaTBVNUt3WWox?=
 =?utf-8?B?S0txSHppWm9yVkVuNjFnb0M4OVBIRVZWUThVaTRxeWducldnMjBtbFRaMUtX?=
 =?utf-8?Q?Pl95vZLmdIuP2OMQ=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67cbd70f-920a-4c99-267e-08de8b3fc653
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 13:58:36.1513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uFg/NpR68xv+IBzvhwnsNA5mM/blbAhKi919rPXjWWSfjK9ekQ05trGyk/69L3VWIanD7On/tM9fmbs0J6TZ9bcPXFADdF5u0l9kunRpMzI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11261
X-Spamd-Result: default: False [2.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7258-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,nxp.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ciprianmarian.costea@oss.nxp.com,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.nxp.com:mid,NXP1.onmicrosoft.com:dkim]
X-Rspamd-Queue-Id: AFE5F336929
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
---
 drivers/net/can/flexcan/flexcan-core.c | 54 +++++++++++++++++++++-----
 drivers/net/can/flexcan/flexcan.h      |  2 +
 2 files changed, 47 insertions(+), 9 deletions(-)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index 32e4d4da00a1..23ddf7910641 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -1293,6 +1293,22 @@ static irqreturn_t flexcan_irq_boff(int irq, void *dev_id)
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
@@ -1549,10 +1565,10 @@ static void flexcan_chip_interrupts_enable(const struct net_device *dev)
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
 
@@ -1564,10 +1580,10 @@ static void flexcan_chip_interrupts_enable(const struct net_device *dev)
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
@@ -1891,7 +1907,8 @@ static int flexcan_open(struct net_device *dev)
 
 	can_rx_offload_enable(&priv->offload);
 
-	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3)
+	if (priv->devtype_data.quirks &
+			(FLEXCAN_QUIRK_NR_IRQ_3 | FLEXCAN_QUIRK_IRQ_BERR))
 		err = request_irq(dev->irq, flexcan_irq_mb,
 				  IRQF_SHARED, dev->name, dev);
 	else
@@ -1912,6 +1929,13 @@ static int flexcan_open(struct net_device *dev)
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
@@ -1926,7 +1950,8 @@ static int flexcan_open(struct net_device *dev)
 	return 0;
 
  out_free_irq_err:
-	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3)
+	if (priv->devtype_data.quirks &
+			(FLEXCAN_QUIRK_IRQ_BERR | FLEXCAN_QUIRK_NR_IRQ_3))
 		free_irq(priv->irq_err, dev);
  out_free_irq_boff:
 	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3)
@@ -1958,10 +1983,12 @@ static int flexcan_close(struct net_device *dev)
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
@@ -2348,12 +2375,21 @@ static int flexcan_probe(struct platform_device *pdev)
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
index 22aa097ec3c0..43d4e0da3779 100644
--- a/drivers/net/can/flexcan/flexcan.h
+++ b/drivers/net/can/flexcan/flexcan.h
@@ -74,6 +74,8 @@
  * both need to have an interrupt handler registered.
  */
 #define FLEXCAN_QUIRK_SECONDARY_MB_IRQ	BIT(18)
+/* Setup dedicated bus error and state change IRQ */
+#define FLEXCAN_QUIRK_IRQ_BERR	BIT(19)
 
 #define FLEXCAN_NR_MB_IRQS	2
 
-- 
2.43.0


