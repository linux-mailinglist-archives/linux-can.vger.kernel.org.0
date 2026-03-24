Return-Path: <linux-can+bounces-7244-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPp/G0aFwmkAegQAu9opvQ
	(envelope-from <linux-can+bounces-7244-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 24 Mar 2026 13:36:22 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7543085D8
	for <lists+linux-can@lfdr.de>; Tue, 24 Mar 2026 13:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D1CAF3051370
	for <lists+linux-can@lfdr.de>; Tue, 24 Mar 2026 12:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5B33F9F41;
	Tue, 24 Mar 2026 12:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="OH92FgkA"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013040.outbound.protection.outlook.com [52.101.72.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADFE3F9F31;
	Tue, 24 Mar 2026 12:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774355462; cv=fail; b=cDLYbqp3uX/a89a32KyhFi2yyGiGDJoKDqOmERGhE+GYcwHz0lEqwXstw49P+YIXkAP3DQ27aBJmVsP8OJqdaO1VkEmI4G1t9+MdpXZ2w4jh60VEvzrB5eX19TsLW5RCiM1MHAGHZX9RFYRIk/1tM099BG4Q2pErXxygscsRd/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774355462; c=relaxed/simple;
	bh=Wo5Gjg6la3D6qo9EiBGnV9+AjAX70IIbUypJuuiHqZg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hDE6a5+06vc6koxOcH5EIMDxSV0VcTWpzzCFZi68vxuudIsS1UVnZKeLUrlH+PP56GJY3d8SSIrTEMT7XqQB591OtXYQPXtdM3FtmaR2A3SN+BYIkrZHIoYCTcyYYwxYuYGMQqY7tHc4fDQNwDTolqgLESYl4rQb20sCAlW6hzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=OH92FgkA; arc=fail smtp.client-ip=52.101.72.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w3H9FLpmQY9XHUoazfd7m3F0PHyXMYxG2m2NDuSK/uo9B9jWX5dQfbBaZrRtOPWpBD3VmWODmyTeJ+9tC5WWjEvS9nhA1er7JOJvGFIpDU/p2irFOzPf2WLJqCZGJTuf5Y6IU2Va/97hREct2BO1wDp2Rfrhq1A6Em+DBjjspvSe5o18f/CfnkFM/GssBLTRVhsjvh7I9raFRP6BzeXEPfSk9GAQ2r9dmQSALGRXG7w8T7bwNGALVhIZHd44HCbCdzEG+X6+187WG1q/zxbnY07JD92hFJ4iWOVaH+eRLf9AlcnOsCaA8pNYcY9UD3JMwPof+PXEda+NArMvXyQSFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oJ4qX7h3dL5N7XLV6evw3VvuGLbfkzRRW5fwrqJzRvw=;
 b=hbVCcejqWLqAKw3l+fCGd77F7kBIVC0CF5PnhhuvePab8lvtDG4DIYm0/bWKyMA2cQIjOdkxIiHCRCXgXAB2QEuwnnEKTckJtrRtZjfgAm5kcc2yY8IM67XpzD2wk2V4jWtgYt8l/m67YzKcECcL8nyKngbxWveMQSopq3vQv8q3TNKSvETdlDVWVzQUPe/1kGERe+CRDw3KZcCnVwZpy0EdNJPx+CHtQ6ZSxa/U+ymjTt98Sqfzdtl/moBAtyvKw+1pvgl/jqEczUeTJ+vzwJBZ/wUxkY6UgrK8TQ5folPVgGWW2dtUmL/sSDaApUEN6GSfAVkXKLXsjOTXP6SLjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJ4qX7h3dL5N7XLV6evw3VvuGLbfkzRRW5fwrqJzRvw=;
 b=OH92FgkA78CGeFhHo+QC0yzncoFwi34KPn/QP6zo6d4Owgh5Za+qkw+NEFOtrdHbt9kKLNUOp5QjJ+MddTYXlYWlnHtaxLN/GTQbZdHRuDobY3TwcOLK1mpy1gkG4FW4HX9U6JmOjTDmpSZNYSUMFBYkxa5/YE60Q7nyOcF1foh3p7+/f+Yi0xruKepqKjahoP7Vkcx9UjhCPvyMzjEvjGCCtqoW/DldngqHosnaqGCzylRn+eEmCzPx2QJgc39/U/WUfnCtyb5dYM3tSl0h4kM29oWpYBpyyF4CkOGknsI/RTrtd8hqd5jNYFxN3spTrlH9WKrI/BL0FEt4nvuexQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by VI1PR04MB7103.eurprd04.prod.outlook.com (2603:10a6:800:123::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 12:30:38 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 12:30:43 +0000
Message-ID: <024316c6-aa33-4561-889c-abd9eeb9d83f@oss.nxp.com>
Date: Tue, 24 Mar 2026 14:30:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] can: flexcan: use dedicated IRQ handlers for
 multi-IRQ platforms
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, linux-can@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 NXP S32 Linux Team <s32@nxp.com>, Christophe Lizzi <clizzi@redhat.com>,
 Alberto Ruiz <aruizrui@redhat.com>, Enric Balletbo <eballetb@redhat.com>,
 Eric Chanudet <echanude@redhat.com>
References: <20260323135827.2129371-1-ciprianmarian.costea@oss.nxp.com>
 <20260323135827.2129371-2-ciprianmarian.costea@oss.nxp.com>
 <20260324-psychedelic-idealistic-dormouse-95b03c-mkl@pengutronix.de>
Content-Language: en-US
From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <20260324-psychedelic-idealistic-dormouse-95b03c-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0080.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::15) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|VI1PR04MB7103:EE_
X-MS-Office365-Filtering-Correlation-Id: 40835019-979e-495d-b7b0-08de89a12ad4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|366016|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	HfUROxeAbhQl4r6QXapmVN4tltG8OJ3pYLX064kolj/2wm7FiZLVrIa90WtsZfjoCHItlU7LIuppbs4wchNgzH2peBzenw85bV6KcI+NEUPbkdnhQs4Dvm5HxzbJLpBsc/25iU+VRKFqmNeRYIGPh0a3cfgeQHbMEZkXLt5xmNRs9aqfaplmRxG3WiIGVo2mb4+flIHaxGcc3sfaP9LcZ6p3D4ldfCroEUD6QoPNQ56TERgUE95moYYPcRMl2egNkl7HQlKIjeS7zLPCkc3BaSrQkpxRfix3EN6PdV3NG4o2/00b72S05kWCak2Dm9MXxWEnf2MLDNGJVWvpUl3gg3sIQgAH6VvyiUQ8ZhKg4bBRrwSW9NijaDDu4Fj9ZVwyC5SVcIAE32BSQVGuBAoCz14DHSkhEgMiLU4SCp4I0VfA3V7x5ZEENcgPvqkMUm4L8XtI3erIhH6ckZ6ooF2oJJuqYLjOcldtSNatDYf9432kPtaZbyKShajQ6PMA6m2z8SEmP3xIq7VJZSRVFMb1uBYzd5NcCm0hdbzSYrJgMLqSOiop7S3siQLjeLSrFpUq/OZfs9qCSDaCYGYR/7mc29Jl3GNBZ4VzIKY5PilDMDr/KV12l89fOS2fr1p9fuoyT7Y2hkvtBXVaSVf3SWLluxFO54qWhiROUsC/ZV6G1LTbifyku3bTdMGUEBpkDbb3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(366016)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RFp3dzBDemlMQzFYN0VUYzJvYzBvR1RaSVRrU2IyQWpCek9pN1U4OHZJeG8y?=
 =?utf-8?B?bVczR3VJYnBRbU4vOEMzenpMaHFXUHFxbUY0ZWNQaXBJaGxDNXo2ajZOYzAr?=
 =?utf-8?B?ckNSdHJkeU5YWUhmM3hFMURzclUvMllXUzg0QVg4NTV3NEJvbjJSZ0M3bXFl?=
 =?utf-8?B?bmtuVS81TnZWZU1CSDhyNDZHc0dFdEJkNElTZUZReHM1Y0xoN0lEb1pHVW9o?=
 =?utf-8?B?SCt1Q2ZjSFhEQ043clFtMktscmdyS0k3Z0RObDhXM1U0azY4QmxZQnFxcGJL?=
 =?utf-8?B?WEFNQS9xeEJHY3pGdFFLQzZyVTA1ZGxQdCtrZ2lna0lFL3E1MEJBaXhoUGpy?=
 =?utf-8?B?TCs2dUtEdldyWVFDbHRMUytVTWZXOEMxS2RDOXVsUW53NzkzM016Qm0zQkFh?=
 =?utf-8?B?Z1BtNzU4M2I3QTdDdVZuenFNQnVFSlR2U1BWWVQxUTBZL2UvZ0lkdlR2SjRn?=
 =?utf-8?B?THpUYjIxcmVrTzFHWHpNdlhTK21xbHNuV20rMVQzK1kvZFVBNlZQYUFnQVNC?=
 =?utf-8?B?NEdwblNiNHoycXR3SGxCWUlyekJwRjZRWWQ3dlZieTlpVnVxTFkyWTNjMDNv?=
 =?utf-8?B?SHNpTlh5Tm1FYThvSG1ualgyQWhhUXJHVU80bUx4bGYvaW1jUnZkeUgrUnJy?=
 =?utf-8?B?eEgzYjNkbk1rSHlJQUZ6RjNjSVN4Z2R4eVpldi9ockovdTlCYWlwcVJVcVQ3?=
 =?utf-8?B?QnJQTVU1eDJhQnNNcjBGRG9KTDN5L3R1cUJUZWpDSHJ4Nm1FUEhQYmJoUlZw?=
 =?utf-8?B?aDlrdzJpZGdLOGZZcEt1Rk9GMTdvUWw5MHM1amcvcjVReGM4c3RhT0ZFMzBN?=
 =?utf-8?B?QkV2RFFqM2E0SG1HYzZJWmxCZEtPVjUvdnFUdVMxWU8vV2ZTejkzS3hOYU9t?=
 =?utf-8?B?NGs4dUVSaG5tbnIyaFR0SE55MGZPdDdjczRvWFNIZk5UNGQ5eU1VMFhxMXpX?=
 =?utf-8?B?Qko1M05FbDE1U01FQ2tEbU9YU0creTdvWUQ3NzArOEwvOG52dCtrTXRWR2Js?=
 =?utf-8?B?b0l3ZnU3MkpqQlVZTnVhdW91M2phbHZYRVR1TTZtTHpDK0EvRzNsL3JzelhI?=
 =?utf-8?B?NzR5eGoxVldLcTJlMWdpY25LdmJCWmdSeHN2Qi9WS282bDJORFBsSXc3Rk85?=
 =?utf-8?B?WXArdWorMUkyUTJQb1hiNmJDM0c4Q3BLb2VkM0pPUkQvaHI3ZG5rYmdiQTBD?=
 =?utf-8?B?NVUxTWRhdEpXMDhXNXF3SGR2d21VMTRmSVdic09TRnR1OVRQR0VsSTdxbTB3?=
 =?utf-8?B?L3lnQkZnRVlWMS9LOEdJbXBvTXlYOU5aWGlHYXU4ZDh3V3RjS2R1RjFCMW9E?=
 =?utf-8?B?UkxZOEJDUTBFMXNZUWUrcENENm03NVVJeDNQQ1ZWUmQ3cmdKWmk5RDBzeWFm?=
 =?utf-8?B?OGZaOFU4MmVHYzJkejQ3eSt3cEljUytPelhkSnc1R3paOTBpV0hiM3RNa2o5?=
 =?utf-8?B?QmVLdFE5cko4MW5CVFcreXk2Vlo2VmJOSjhndTZhY2hLWmJOU3ZiVFVobkpa?=
 =?utf-8?B?ZjE3REFLSENtdE4xeVlhZzNyeXIvUDZCV3pITWhwSTg4bE9qTEYxQ1RrODQz?=
 =?utf-8?B?UDJ2NjZWelE2WmZTdWpyTWp5MlVKZlorMUttS0JZM1cxRXNIUDJuL3RMYUxJ?=
 =?utf-8?B?Z1NCTmxwN0haRXZrTU41Mm1uNno2U1FxaDRBTlNrZE5uS1FlbmdqVkFiZjRl?=
 =?utf-8?B?eDlaa21WcnN0NjZzTllnejdncC9UY2R1SWdPaCs5dmlzeG8wQ25YWVZBZnc1?=
 =?utf-8?B?QndiaXh1M3h0ejY3UVVKemR2UFBXZC9WTkJ5cFJjKzBwKzE5b01TY09uazNR?=
 =?utf-8?B?OWkvR0FGaDByVUxjQWtmZENLV0w5TytvVUVzSzZJbTFUUlQ2Zk0vMTB3WUVx?=
 =?utf-8?B?MTZsZVpQMHMrNVRhdXUxbml5MUZnRWFNVFpVR1dhNXcwWlZQcXVubXdLR0dM?=
 =?utf-8?B?OFZuQjlIVUZrRmR4c0pCMm5wb1cySDhEa1BXNXFob2JieWZ5M3RkcEdmMzZ6?=
 =?utf-8?B?T3dLeTBtalRqaUJhNnVWS1U1dUQ0Rk5aNVZwZjAvVlExU0NpR1JzV29LS3VQ?=
 =?utf-8?B?WGYvQjI2aHpGZUpsVmhQL1gvZWpjU3RZQ2hOUXhMTEJrSzJFMlM0M1lSOFJP?=
 =?utf-8?B?bXZQRytCa0FnU1ZnZlh2Q3d4Vy9ES1l0cjgyNTRoRmtheGZhUklVYzhBVnBZ?=
 =?utf-8?B?Nm9KRS93OXNYOFBmT1BpS2VIVTdTUmx6ZjlqeVArbUxlMUVmOHdPRkpod2xh?=
 =?utf-8?B?RVJjZk9vcm94OHBxSHhmZmZ0RGdBSnF0WXZia2NSeUVOYVpicWxQQkVrb3Nx?=
 =?utf-8?B?M0d3THZHUHpBTDRvSkZiazZDZ3dPbnZTZWxkMm1PQXhDWHdsd05vemh0SXBw?=
 =?utf-8?Q?sAkbGvKcw5m/N3f/uyN+UnoVXbhnFKgxB919/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40835019-979e-495d-b7b0-08de89a12ad4
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 12:30:43.6493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LC4mXdOjgbVJ4gS/wgKY8fVjv18BFLflzbtl9UjkU2WR6TbhgCI6qK1MwT3zCWbXKTJbu6z/Wh1boXon9eOYzoQZkq/UZjJS7Qn7bVDHgnI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7103
X-Spamd-Result: default: False [1.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7244-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[kernel.org,nxp.com,pengutronix.de,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org,redhat.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ciprianmarian.costea@oss.nxp.com,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[NXP1.onmicrosoft.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,pengutronix.de:url,nxp.com:email,oss.nxp.com:mid]
X-Rspamd-Queue-Id: 0C7543085D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/24/2026 1:56 PM, Marc Kleine-Budde wrote:
> On 23.03.2026 14:58:22, Ciprian Costea wrote:
>> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>>
>> On platforms with multiple IRQ lines (S32G2, MCF5441X), all lines are
>> registered to the same flexcan_irq() handler. Since these are distinct IRQ
>> numbers, they can be dispatched concurrently on different CPUs. Both
>> instances then read the same iflag and ESR registers unconditionally,
>> leading to duplicate frame processing.
>>
>> Fix this by splitting the monolithic handler into focused parts:
>> - flexcan_do_mb(): processes mailbox events
>> - flexcan_do_state(): processes device state change events
>> - flexcan_do_berr(): processes bus error events
>>
>> Introduce dedicated IRQ handlers for multi-IRQ platforms:
>> - flexcan_irq_mb(): mailbox-only, used for mb-0, mb-1 IRQ lines
>> - flexcan_irq_boff(): state-change-only, used for boff/state IRQ line
>> - flexcan_irq_berr(): bus-error-only, used for berr IRQ line
>>
>> The combined flexcan_irq() handler is preserved for single-IRQ
>> platforms with no functional change.
> 
> Thanks for implementing this.
> 
> Can you take care of the S32G2 which has 2 mailbox IRQs, too? Please in
> a separate patch.
> 
> My idea was to take the "irq" argument of the IRQ handler and the quirks
> and figure out if you are the first or second mailbox IRQ handler.
> 
> Convert these
> 
> | struct flexcan_priv {
> | [...]
> | 	u64 rx_mask;
> | 	u64 tx_mask;
> | [...]
> | }
> 
> into a struct and put an array of 2 of these structs into "struct
> flexcan_priv". Use correct mask array depending on IRQ handler.
> 
> regards,
> Marc
> 
> --
> Pengutronix e.K.                 | Marc Kleine-Budde          |
> Embedded Linux                   | https://www.pengutronix.de |
> Vertretung Nürnberg              | Phone: +49-5121-206917-129 |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

Hello Marc,

Thanks for your review.
I'll add a separate patch implementing per-MB-IRQ mask handling (needed
by S32G2) in V4. And thanks for the implementation suggestion. I'll take
it into account.

Now, unrelated to the per-MB-IRQ refactor, one thing I noticed during 
the IRQ handlers split: dev->stats counters (e.g. rx_fifo_errors) can
be incremented concurrently from different IRQ handlers on different CPUs.

That said, these are just diagnostic counters and lost increments
should be benign. Do you think this warrants any synchronization/locking 
mechanism, or is the current behavior acceptable?

Regards,
Ciprian


