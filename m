Return-Path: <linux-can+bounces-7259-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mD9DDZo8xWn/8AQAu9opvQ
	(envelope-from <linux-can+bounces-7259-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 26 Mar 2026 15:03:06 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5D433677F
	for <lists+linux-can@lfdr.de>; Thu, 26 Mar 2026 15:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E665E3087635
	for <lists+linux-can@lfdr.de>; Thu, 26 Mar 2026 13:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF9E32E121;
	Thu, 26 Mar 2026 13:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="nomP3nlP"
X-Original-To: linux-can@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013067.outbound.protection.outlook.com [40.107.162.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B3C3254BB;
	Thu, 26 Mar 2026 13:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774533528; cv=fail; b=aFO27Qz4X95NGaAQ65Sjb8gEzOMBxZgCK95b1H7HddbsdZTInfiCdNFRUma6HjqEgEiLwNENbkh0RuH7bAC+cy/pMfRrwZvMVXYUT3WHb3SbspRk62UaMxpVGH6/KKHssS1hylXZ0gLBDF2iVwDVEvR1voVmF3uci8iOs9mqW00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774533528; c=relaxed/simple;
	bh=dvqlA/+PsJJlEzncLWa+oyUQ9lH5CrO9L1+Eu35xP4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EdtFtJnQPOyX/FDb633PmLNo/Q0Q2AxRZVDLn/GHBIeQS+dp/6vzgud/Xpw/wvAPAVubZZBEEx4N5SDYbwzN6PpEYOZeqLMNzZEroqysZpgxQjCAmZGHo+quVEK9Hl6UOuy+pGEwG90GmQLfBHt2+tnwVGa89dHyZpIC0hjc348=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=nomP3nlP; arc=fail smtp.client-ip=40.107.162.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QlfYBK/cqsOofBVTYsIR9Ssw0fqtDVwBK4u379TfbRCYJchDiQRba8W1Po9+Fy9G8Si7mnGTF6wGB28LzE3h7sPuGSUiCUIVDZQEpui212MBrIx412glSMx6+7i/k22x+lNTdSXDHQOpSnpaKu6rdLQAUi3GtGzXtLZ1ojrn8U/n8vKJweMXSyG/oN6Lb62wjqMx9zDCoChyWDmsOUpIfaqKkZY8mVUxpV4QEUk/9/jLqHu0U+Jzfkm11rWWhq+ZlcBVVop5Ts0md4ZjuEODwjyrftsB+uu/tSXATOplPQVpV51p6vy8CV0P3kFeUsN9PG2mC94+iPxr7r4DrI4ZjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DuI02eGgTMohLDcKqbUKOD9e9B5e6+jwjve8/2Av1iA=;
 b=SHPV14/7TYTW/2hEHNeQEONFOhTNhhXQIYSTdkMz/Me2Wzi9MLUrcXxrtoasAnSwbjAR6mwQUh/QEPOc9TdhfHXxhCNRIENjYyNoAZIur0fPePJqjIftWMZ7Lw8iA0bBI3GFqr3fuS1SURI9tn2vG5u+Qy76ykD4nJnW1Sbw3WexHGVN5rAY/a0q0/G1WVX+BWZJBVxouRQ5ARmVGf+542EKg9Y+j+6Aos/82Xd2eOgRaQwANlNMliReD2uInBah1KXNo4bcWnwQc2YWqE38p/Q0ewaK+NQKicQGsqEyPWr6WzXyacNQO7kWKOudLqPCJgTD/EUvNukghSKqnCxrjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DuI02eGgTMohLDcKqbUKOD9e9B5e6+jwjve8/2Av1iA=;
 b=nomP3nlPqZMR8yNm4UZaCnwjmaQPx+aQjCrfga3J0wE5HF4oEBPN4cmTCXdkuL8tH/SJlRHHXJ8GPSZhWOu/ryTb+Hyi/DMbQkO68BJF4qxEVDyF68tXDeUsI+KMEHUUm2OC62ahHyRFSTxK16w/1mALEJcZHBfp+i2YCtlazQjBLiF3DGPZ0j4XVv+ZTw4NwpqEcrEO3fyxrkBaa1SkGGlNeb3HGMR971kRTiXhUdj8MI8C8DfWOaJm/78A1NS3UdsDYCw6VA+vHxZc8EfGO9PmyVHuJUlDY45a4Kr+c/YND2L11/Fgu8a4EiEghPsLBQ73WGgj7+vgzJHzv2VoIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by PA1PR04MB11261.eurprd04.prod.outlook.com (2603:10a6:102:4eb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 13:58:37 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9745.022; Thu, 26 Mar 2026
 13:58:37 +0000
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
Subject: [PATCH v4 6/8] can: flexcan: add NXP S32N79 SoC support
Date: Thu, 26 Mar 2026 14:58:23 +0100
Message-ID: <20260326135825.3428856-7-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260326135825.3428856-1-ciprianmarian.costea@oss.nxp.com>
References: <20260326135825.3428856-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6P192CA0068.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:82::45) To DU0PR04MB9251.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 04787cc2-3a65-4f4d-f139-08de8b3fc747
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|19092799006|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	k7L623Q8mOvuj0/MgMVVFrBbK5gBoZbTgDrZLYNqaDPoAYmx7DF+g63yH/KIQTHEWAVZFyp0xnLcTQW7T2c/nZbLrZ0lA3pexv7d2ocM42pyBsDsit/zCpJ8w3+Ztsu2OBGSOe+dcFLtwkOfgcRzgUr36FfXoyxb4a4zijVxJYesP6mZlpre0Dp930vxKnj9DrTYXDBQvQRglqegDwtQmOVQwScozGTGVKuOybPiht5lFGv+uHJPrDwN+oghyD3ph+b5ROX9tes5ipFY8a7iwbuVBHdVV3NhMboQY54z0LFOLXoDECrGGleI5pZ6Eq0lKP0N/Ez+5igWlyna0ZeVYDUGrIxKM6l6+ROaB+W1e31LeVjviBW+pLPT12CZsAbWpflp44l7+gmFVNS51YJ64L4touDk9HPTqm99oMrh+dTCl2VQW0QbN5xjJh/E+F9ekBw3WY2m3QQatK1ix/AP5UZgyzgoO06FrkVVyXvU5FamOmJKUxdpiU7SNSlQWibks60TH8PAbrelMm4RbDRvipybraoyXx93k1elny4z1Z2m7qg+2d0QP373aIETwYeLMcJQzg91OnOztZ+vA5504G0MnMmmAz52147iQGW5m++zlG7lWdh6mqEHsbKMRzJSbixWkGhhFc44ydFDNIiValjTR5kSh6NrXM+izg6qEzVxtO0rM5oeSbRwxf0GThlDyANr/Yr3IE7cXxqCsJCcAiQ4uxc+TRl01VyhQcERX3Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(19092799006)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U05kM0xDcE5hK2tYblVRWmVmUUNCeXFpcDZGelZheTZ4U1lkWnJUNHZBRDV2?=
 =?utf-8?B?eDUxRThPS2FSNkw5akw3M3lLSkZwQ2h1bXdCYzY5Nm0rK2JDUVlaMytobEhC?=
 =?utf-8?B?Z29ydU1OUHNVSW9MSmxNNmN5dkpUai9Rb2tCWDFXSi94M3p5UVJMT0RyUTB1?=
 =?utf-8?B?RW1oZTcyY0NYRktOb3UwMzI3cmp6bHNZaFVtbnJIbWxCRTVieU9tNHJJRk15?=
 =?utf-8?B?VUdxelQwL0pKTU5RTFhJTmdqeGlYWjhlQnBJeEJ6eWRGdnZxOGJmQ09rWE1Z?=
 =?utf-8?B?Z2lMTTdJcEtOOEcycXM5VVNqeDRhaHRYRGM3aGpJZ2s3ckQ1akRkTWgrM3Ey?=
 =?utf-8?B?VnBIYm45KzVxd2tTY0ozRE8zaGRWKzI4YVVTeXM5YjJSRDJVQjhqTEtLNTlk?=
 =?utf-8?B?NXZmNURGYnFXekdUYWtHS1JJMmY0T3lqcXZEZjJ1bS9oN3FJejJlS0NWb3ox?=
 =?utf-8?B?VjFzZ2V5VC95cW9oWURWYVZZNnpyWGg2N2JFNDFCK0xOUTVDdFVmNnlib2pT?=
 =?utf-8?B?NFdrNXFBWUdMZm13a0tEVlc0M05qakx5THhFa2FPb2dua2RuUDBkMSsyQUtH?=
 =?utf-8?B?UzBhZG1YbE0vNzZwQ3NxVDhnMnVYeUFpTzdaT2lmQm16U0Fad1lZV1FWeFZG?=
 =?utf-8?B?T29Wa1orYzRERUpTdE5vTktUVGdPbndacElJY1BkSWJISDJRbDkzbVp4YmdC?=
 =?utf-8?B?UkNlcVp3UXpVcCs4NGdvYlRHclhCazlPYWdFVSsvMmFOWHBTaVNMbkVvWGVH?=
 =?utf-8?B?WlQ2MGJHTjlZY291c3dzWkhnejkyeTFTNGhzejJLNlBzeUxjdkc0SVMwbDBL?=
 =?utf-8?B?OXdMVnR4WkVWMHVLeXBKekJpc3lvcjlzZVZRVENYQW01UDZUOWNaME9Ic1pq?=
 =?utf-8?B?dFJsTmRPUW9qcWtoM1ZqVFI4TU8vaUlzTVhpYlVabnRoWmIrSGg4TW5YTWN6?=
 =?utf-8?B?YlJoWERuTnlTRDhBaFhhbG9WOFRUdVBSQzVybll2T1BsYmtsQ1gxSGozclVj?=
 =?utf-8?B?cEc2blFLdkZUanZ6Y0JlQTdVbVB1MnBzQ0RVNDF0MXc5RnhrMmJuOGdsNDFU?=
 =?utf-8?B?Yit2ZlJGLzZEZk5PY29ieDNQQjVBNngwYmg4KytDQjc3MVJSN1huWHNmN3dZ?=
 =?utf-8?B?eUo1ZWFXZ1d1YlVyT29GUkRVbUErTlFsbG1rQW9sRWhadEhnNTNDMGE2NXpm?=
 =?utf-8?B?V25sQzYyczEyemxjU3dnT0VCYm5iVHVOZzFwT0dkWlc2ejNzb1RRSnUxM2pE?=
 =?utf-8?B?K1hxOHZ0V2VyZ0JzVXMvRjBoRkRseUVWelRWVEMzV2Y4N1dzNUJid1NnaFky?=
 =?utf-8?B?VHVBNmFEWTRDd3NPSWl1RkhPdlVnN0JqOVVMb3lqaHJBTm9uRklwa0lLV0pi?=
 =?utf-8?B?b25sVmhST0lEQ3RSWkhLZ0ozUk8xME5PakJPelNiVUUxU29Ba3JSaHRVekV0?=
 =?utf-8?B?OUxTTGx3eDZBZVFFNWVnSDhabi8yMWE5YlFtcG1Ea1dyYVo3WTBURm5TSHpn?=
 =?utf-8?B?c1oyRDIyaHVQSkdiM1JZOHBpK3FodzBYWk5YcWRYMm5sNm9EaU54ZElaQzFl?=
 =?utf-8?B?NGtXeTM2NStoaW9QQ29xbWVsMjl5OUZNVE05Q3VmdDlrRDNEQkhtVG1ZbEZP?=
 =?utf-8?B?YSsxYW1TUHNNRjRLRXZvL241YzVBNmZ2ODk4YUU4bm1IWVdpWmh4eTgvZmJz?=
 =?utf-8?B?cjUxWjluK1Y4L0l1RUhGZ21iVFdUL3N4cWFvWVJMa3p0YU9JS25zZXZhdTFz?=
 =?utf-8?B?dWYzWUhQeXoyTW1uenFVaHJrcUhCclRPMW85MGlqNk9GcEV4dVpXMjMrd1Nn?=
 =?utf-8?B?cU12TENJRzZ2YVV4VGFWdTRZazlDelZhRGhaUzAzc2k3THA0d0VIWkY4aU9y?=
 =?utf-8?B?MTZ6QlgrdGgyWDRoMlZkQTlhY2JYZHY1RGJ0YU1ZUzNCTVNBQnB3MHNERmQx?=
 =?utf-8?B?U2kxWlkwLzhiV0V4aE5QdU9LY2RSRU8xNUVrZWtKeEtlTXpKdU5QT2lSczlK?=
 =?utf-8?B?djJuZHVOUlkvVUhva1oxTWNXUGNUdlcxWW4rNTNrUUt3a0lDVEhlaDdJaXhL?=
 =?utf-8?B?cC9QUmtiWTVpOXRHZDlrdXdDME91bUFkUk5ZRStWcTl3T1VRR0lKWWFNOGhq?=
 =?utf-8?B?RFNPUjZnN3N4THp6TDRWdmZUY1NOd1VXcmJRbmZVWTg0RFVia0lCeHlwR3k1?=
 =?utf-8?B?UVR5TjhvVFZnemUrMFFJaUNWcnhmS0RWcjNYMUlqTGJqUEh1QzNiQnFDakdV?=
 =?utf-8?B?Qnp6RXdkem1QRG1NalluNXpxeG9mZlJRYUtQa1ZiREtPUXBBSmF3aFFJZFdK?=
 =?utf-8?B?M0tDbGhLR2JvUlRVdmpQY0JzLzdJMTUyVkFwQ3BVZXFUQkR3VE8rSkV4blhK?=
 =?utf-8?Q?wQm+CObKJYVIX8FA=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04787cc2-3a65-4f4d-f139-08de8b3fc747
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 13:58:37.7392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zDt8x+nDdrot0R8+ayec2WSlTfZzfzlHh73eVFK0MsRHNaOpVuZCxC15ezbPS4cF13GADr1rqkDlUaPLsf9WTvPqKc8adp2R7QkHz1crtiU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11261
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
	TAGGED_FROM(0.00)[bounces-7259-lists,linux-can=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,nxp.com,gmail.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MAILSPIKE_FAIL(0.00)[2600:3c09:e001:a7::12fc:5321:query timed out];
	FROM_NEQ_ENVFROM(0.00)[ciprianmarian.costea@oss.nxp.com,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,oss.nxp.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,NXP1.onmicrosoft.com:dkim]
X-Rspamd-Queue-Id: 1D5D433677F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Add device data and compatible string for NXP S32N79 SoC.

FlexCAN IP integration on S32N79 SoC uses two interrupts:
- one for mailboxes 0-127
- one for signaling bus errors and device state changes

Co-developed-by: Andra-Teodora Ilie <andra.ilie@nxp.com>
Signed-off-by: Andra-Teodora Ilie <andra.ilie@nxp.com>
Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
---
 drivers/net/can/flexcan/flexcan-core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index 23ddf7910641..9ae0d9eb4ccc 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -397,6 +397,15 @@ static const struct flexcan_devtype_data nxp_s32g2_devtype_data = {
 		FLEXCAN_QUIRK_SECONDARY_MB_IRQ,
 };
 
+static const struct flexcan_devtype_data nxp_s32n_devtype_data = {
+	.quirks = FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
+		FLEXCAN_QUIRK_DISABLE_MECR | FLEXCAN_QUIRK_USE_RX_MAILBOX |
+		FLEXCAN_QUIRK_BROKEN_PERR_STATE | FLEXCAN_QUIRK_SUPPORT_FD |
+		FLEXCAN_QUIRK_SUPPORT_ECC | FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX |
+		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR |
+		FLEXCAN_QUIRK_IRQ_BERR,
+};
+
 static const struct can_bittiming_const flexcan_bittiming_const = {
 	.name = DRV_NAME,
 	.tseg1_min = 4,
@@ -2232,6 +2241,7 @@ static const struct of_device_id flexcan_of_match[] = {
 	{ .compatible = "fsl,ls1021ar2-flexcan", .data = &fsl_ls1021a_r2_devtype_data, },
 	{ .compatible = "fsl,lx2160ar1-flexcan", .data = &fsl_lx2160a_r1_devtype_data, },
 	{ .compatible = "nxp,s32g2-flexcan", .data = &nxp_s32g2_devtype_data, },
+	{ .compatible = "nxp,s32n79-flexcan", .data = &nxp_s32n_devtype_data, },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, flexcan_of_match);
-- 
2.43.0


