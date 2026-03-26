Return-Path: <linux-can+bounces-7261-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eIxDIUc+xWn88gQAu9opvQ
	(envelope-from <linux-can+bounces-7261-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 26 Mar 2026 15:10:15 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB78B33698B
	for <lists+linux-can@lfdr.de>; Thu, 26 Mar 2026 15:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86789311C73E
	for <lists+linux-can@lfdr.de>; Thu, 26 Mar 2026 13:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0D133AD81;
	Thu, 26 Mar 2026 13:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="pgGKIVXw"
X-Original-To: linux-can@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013067.outbound.protection.outlook.com [40.107.162.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AA2334C3D;
	Thu, 26 Mar 2026 13:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774533532; cv=fail; b=faz4BQ2bdI2uy+SS9q3wDAp/6+MSSvpKYnUg0W+eXa81xjxVAQSE6XcJbjcKfivxJzhkPPQsDRrIqdR4it9L2MZTZXNINXqYPgSAqNLPftYXjz+5LIgZVaZMU7rGwzOxDpvvjHLwS16SBA94o4A7pIkIKEuAXkVd43Av5dxwN4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774533532; c=relaxed/simple;
	bh=NjkkmEQvIhu/ukpc3rYoo+G4FDElFzZoJ0lqkJdSKiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V6jW/ON1/IzgEZtntq4mJdgTt76wC0I35PXRimdxJJ8yPH+VyFmNtkGkAYhcAXmA++NW05N7j8EliW2PEUR0wgE/Lqslxlr6zwIMixXvHthu0cbO9l0l0AMWpFMpoR9gWdOPTjuiyW0eBEEAMnEg3c2QkMYl3I7nPPclW5UpRVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=pgGKIVXw; arc=fail smtp.client-ip=40.107.162.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bm6SsY0KWm/chYaQnSrbJsuTcsteCv/GNQvNuD/nxN3e/ueJtexT7OIzpRaK3SO0AJj8Y2mHcFyHPd+27TfAZyhi7XFh3NSQiT8GIMCT8ZLW/B108k91umhncdaA3DZrov1sZPsHfq8fRC7p6BSeaYNPLpUe5K7cASc0gmKBDWR8UKRTkpCIuGBmuNHqYkjcJRjORIAZKtCBz6i9Oy90ICwNykekkvXUInUGSQD8Zst1K6xaL8wmZIEuEMTBthv3PTcdYiWRa9ztUEMJiuuJoyAgKW0Xjml1r/VpWzzShLbJWSLTCS3M2ITrIIlB52uViOtgWqZN/7/Mekew0otMUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GRQouUAtAoFM2r1Ht6OLIZn6BKh+s2A174EICOx9dcE=;
 b=jDQL7zGNH+wzzOsiS2zfeQTmqUqpKUiGIWC1TASRdm7DOdeBXGELBXr6jbMiusY4WIRp6wb6j80b2j/TuQnrQKh9b0ws91hW74QfAOw4AtIiQvo4oODVYr9ow8udgjZGefMg072XUPCn4vl5wE4pMblctxy1S+dBA3d2ONle5Hf57wzKpsXYRGJLTGwEP+pHv8b6cn3fLSIgFB5BIWJxToV3JCOptv8tBBtFZebUsmF7OGEYBWvWcde28SpnVShlr6jni+wd2HI5s4a/paz8B4trLC98nve9oPPSRIIA8oWlDo9SU/gFXeLcrZCOogtZyr2oFkEJAwrm95qwIhyD7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GRQouUAtAoFM2r1Ht6OLIZn6BKh+s2A174EICOx9dcE=;
 b=pgGKIVXw5IVYZOLjXofiDCJ9t9Wkor1louzgSzfkQCP80O26K30Jj2h+M4GEfhqxDKeyBICJqNxeArtC6pPu9mGK6kQWrhMmKZMlzAXkwOGp9JipUzmydUbviDxelonB8Iga7WkqE0m3UrBHW+OdtKRApdQSk8tCqhP+u/7s/DCZLgw4wbcdvB0u1FslO+gPkYsiR5YP8pOdZfiNmQe40ZPm39e0SL0t+f5GX5sANmrHTk3q1xMKr6bXpv6PK+j61Co6F8B2B9qz3NGpwiORL/lo3JrqArVzHcYgPxVN4piMW/7FFPwsTWp3iwYpxZOmH5QOB3295LtBnnAYmsRAxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by PA1PR04MB11261.eurprd04.prod.outlook.com (2603:10a6:102:4eb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 13:58:40 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9745.022; Thu, 26 Mar 2026
 13:58:40 +0000
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
Subject: [PATCH v4 8/8] arm64: dts: s32n79: enable FlexCAN devices
Date: Thu, 26 Mar 2026 14:58:25 +0100
Message-ID: <20260326135825.3428856-9-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260326135825.3428856-1-ciprianmarian.costea@oss.nxp.com>
References: <20260326135825.3428856-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6P192CA0070.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:82::47) To DU0PR04MB9251.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: b1c09476-ddcf-41ae-8144-08de8b3fc907
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|19092799006|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	NtM3oPQl+9cMV517834xwDGkmo2syytAGugu7O5Ly6ETQaYhoOZRXKG9ED8QhufDty1aAFstKt0vJbN/3ERmywJyW5+I5W0qtyAhSXoIc1TyzumClJcQUtSMs8XOuiZ2M8m1IHbofW+PeG61WKy+0WKw3n3VaEWNlYl9tqDUDFUSsqFsp0ZrjPcu5HfLMUfje41yP4aww3h8Jmarbrvr3rek0aEn0Ue/v7INwHvmw8Hgj6fJ0+Lgl4TJEPuwfXya8+tZ4AW2j7RuY5AtEsusRGnYvbCf+5Xg4zVaNvuTpcgoQcg5W/dEQhPW7uwemeGH/Ttw0Doy65lmtSXd/TTW2llTgRcJudqUZk/rJUQx/5JoD24R+Wbg7RviwUMymkPRNHEI78WovXpkq30t3rP73lH0ebZULEBmQQnzisqDRMJEhU81RjuFMLTeyqmdAE5UjY4tuB3wiCgaSNeP9W5hd9QuugBUqN3oTJUmqMeo8ttgD5zddqNGN6Ex0674fvNCqtc7OFZTHxh0RY01jud2pKZmOZr01QoMfZEXK3/ph/dsjoF5nOi8WHE9i9DhKupj9bT7qYJgQrLSVJSXh7oXL7vwXaMTqCvPInKYGBsjAJeb3qa0uY0bYl5MsKUm9KKfWAqT3FEn2qdErwhceCxrgLWy52iG9QxxRuozvGL97Ohi/1YAnYKj10kFHYNNkCbjuQ86KJSCgxsOANbgD3jZo6kNkKRAgue+OudjDi38HlQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(19092799006)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UzFDSS9PY3duRnJubUNDejRVRlMyQVhUdUlxbHBCTGZKOHV0NXZYOFNJbDVw?=
 =?utf-8?B?WVNRN1J1SlBLbjQ1ZnZaa1ZuSGgrNnpudHlCSjBqWVdGRk9ZVWRaVEdhSHhl?=
 =?utf-8?B?UEVlN3owRWcwbU5KWC9qWmpReFkrN3oxaFJEczNEdldTdW1uMXFUaUMwRWJp?=
 =?utf-8?B?N1VRaE5wa3FDbnB1Nzd0UVVRbGhlV3RJMm5kMEo3TWVHaVFScmw2UEt5K0FH?=
 =?utf-8?B?T3cxTWdKdlJMZmNkVzRCdU96SG5QV1ArWGc2WGgvQkI2UGk2bW9KUWdPdlFr?=
 =?utf-8?B?WHlweU15STh5Y2U2MnNydzJpY1NSL2V1NUFEVlEvZ01ZZmF6WCsyRnV3dmVx?=
 =?utf-8?B?S2gwUGFJMU8zV2FIcnFIM053Lzl6TkVQNGZwTEVjMlF0VnArU2l5dVV1d29C?=
 =?utf-8?B?RmVncHdyT3JwZ3hyaGUwcWhTQXltcFlVdUJJeUxnOC9JYzRXSDRPMWt4SFE1?=
 =?utf-8?B?dlFzb1pVT1F0Vm04ZmFMekRQL1c2WnJuelc5cndxQ2tEeHBvMkRHK2lmYVFV?=
 =?utf-8?B?WUdpc3JvYjZUblhHQ3Q5VG53blBaaHVjVmVSMHhuZm1BZ1B0YmIzR0JOYXpO?=
 =?utf-8?B?NHh4TW5LbUhPNmVRZ3d2S1NETFpNSkUwMkpQK2Rxb1FKVTVrekJxeDRVSlNX?=
 =?utf-8?B?T01uaGdXYWI4YmdlR2hmM3NhUGErNmZVbHFhd2VaMU55RU9kOWs4cTd4azU4?=
 =?utf-8?B?TFZGNXBSNXl4anVaWC9pMVUzUnpveGJYanZoZGZDVzJsTUJoSG81b0Q3K2s2?=
 =?utf-8?B?NTl2UzU2RzY2SzdkOUl0QkhZU2RnV1gvMytPVXJudElMWDBRcjVGVGxIZjVM?=
 =?utf-8?B?ajR2cWdWTVNGVnY1c01XZnlURkc0ZVJZOWVFM09XQ3V1WnNlQWFleUNoVnh1?=
 =?utf-8?B?Wkk0ek9pbXB5L2dRN3FjQTI0WXlka04yNFZVRTRhNVZtWkl0Mko5QUVwMXpL?=
 =?utf-8?B?NkZKRjhZalE5djVZRnRzSElubHBsZWZzdThzcWpWNVA5VENtTk5JeEI4bGVq?=
 =?utf-8?B?VU1YVTB3WFFUQnZKeUY4VmpHY3cwWTBhTVlMeHJaU0YvaXpUeHkrLzhHZzVL?=
 =?utf-8?B?V1FvcGxZWEc1TUZFRktoTk0xSGVWOWZ5Y0JDZ0hoTTIrRmZIMWxnUDFSZmV1?=
 =?utf-8?B?cnVqazZtek1GRUhmRGVaTEJZVjlPaTVmQzR0akh4MnBONldyUnhrYmVZamps?=
 =?utf-8?B?eDY4OTl0NGg1SXRFRERnWlB2UVBBc2FmdWsya3E3N3hnU0xZNmJVekFlbmpP?=
 =?utf-8?B?bTl6bCtwZC9XbkFPdnNtUnp0TU9wK0JCdHMybUViVWx6eHpPZG9tWEp3MHJw?=
 =?utf-8?B?SERYSkVucmV3T1FRM0xMQzJWM3Q5aTJRV0JnQTJWeTRBU2QyNDl3dTU1WXlN?=
 =?utf-8?B?TUlkc1hxMWVURzRDZDlDNzAvWWtsS0cvTTkrQjgxeXZnbGxvQk1jR2ZKT2pX?=
 =?utf-8?B?cnpoVnpXMjJsaldWbGQwS3lqbXh0TUdDS1JxeW5ETUhla0tvMFo0QWNGZkxz?=
 =?utf-8?B?MVVjUzljY3hHV29WNENxNEtYZ2dnQ0pUOHlaUEx1dkF1ajFoS0hEdCtZZlhv?=
 =?utf-8?B?Snc0QzkrUVBIV0plZ1Buc3FYMmlPUmZobXZaVU1GeDZZZWNNckp3YklhWDB2?=
 =?utf-8?B?UnFDeWNnMEczVzJqZkFpcnp2cWU1eVpxSHF6YlV0Rk4xbnMyQ3BUVFEzeEo5?=
 =?utf-8?B?cWFrM0E4aTAyaTVsQVZyT0k3Qmg4THF4SHM4M1Q4dHNHWEdqY21MUDlrdG9S?=
 =?utf-8?B?aDdXZFdjUUQwcGdJRWoxT1MrMXpnRXRSdnF6YnBFYVMrZUVqWjZGQU4vYXo3?=
 =?utf-8?B?TUM2dVVLVm5oVWN4bnc4dk9nYmd2RmZudVZEaHM2VkZRNmNQRXVFYlpOaFlz?=
 =?utf-8?B?WEFhdWtjWEIwSGV6KzRScUhXcHozOFM0VUQwSXlzVFdNWjlZcytmVThicGhk?=
 =?utf-8?B?T09DK3hOSWNGTGlHTmZPTkJBVFNTK2xMRXpoS0FMWG9wQWNNR2FMeFN1L09m?=
 =?utf-8?B?M2dwRVIraDV3Mkk4RGtPbUdkUTJvK3pqSURkRkdRbTY4dnJxb3M5dCt3WXp2?=
 =?utf-8?B?OFpQempRUVNERUw5ZmtjLzBLaytPcDRZMkprOXd2ZzQzV3Ztc1EvSTByZno0?=
 =?utf-8?B?ZW8rRXk5YmI2Qi9oeHFlZFc1NlJKbXpqQW5sL1ovbjU4MDFjdW9YWmhML1pY?=
 =?utf-8?B?VHlrMlMrdFZwUjc5NkR4YS9zOUlSV01ENVliSXJsWWFETWx2dTk3dndjeVU1?=
 =?utf-8?B?OUIzNEJjUzVCaUI2RXRRQ0xsbi94RzloVW1lWXNSZTk4RHl5YUgvNkE1Z3d3?=
 =?utf-8?B?cG5aS2N6UGZGVzEzQjczb0JOV0hhSm5Mb0pzbnQva2V1cmFVZEhxZFpPakN0?=
 =?utf-8?Q?AQsXpVVKRkK79rQc=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1c09476-ddcf-41ae-8144-08de8b3fc907
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 13:58:40.6791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XgedKXLCWGWWkBLjywDy1nASnWzWYnnePk79FsdyDGuZtxAMZbi6PXE4bsie8vc5f7rc3HmYLV1fOSCw99+H2bRfFbGY5wGk2pn4550uo14=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11261
X-Spamd-Result: default: False [2.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7261-lists,linux-can=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.nxp.com:mid,NXP1.onmicrosoft.com:dkim,nxp.com:email]
X-Rspamd-Queue-Id: DB78B33698B
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


