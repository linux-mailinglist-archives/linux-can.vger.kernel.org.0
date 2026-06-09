Return-Path: <linux-can+bounces-7777-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zbV5OgQlKGoY/AIAu9opvQ
	(envelope-from <linux-can+bounces-7777-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 09 Jun 2026 16:36:52 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 917A966132C
	for <lists+linux-can@lfdr.de>; Tue, 09 Jun 2026 16:36:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=MjXeUila;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7777-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-can+bounces-7777-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EEAAC303CD43
	for <lists+linux-can@lfdr.de>; Tue,  9 Jun 2026 14:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61B7342C93;
	Tue,  9 Jun 2026 14:30:06 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010008.outbound.protection.outlook.com [52.101.84.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524B833EAEC;
	Tue,  9 Jun 2026 14:30:04 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781015406; cv=fail; b=qTYgaQfiAQvTBxLPCHVJDjLapQGFavlTzs8+ZNfOxixWz5xyLj+VNkcQYkI4kjGGntRSZ9mG+iqGeSQ2JiqbB/M4baiFMw2KFeQCr4m3USiE8wkfK5TaaJ82EXDJZbbqhy3GL6RhEcO+yfgL213bytK9fHJIuupDPvL68K0Eo70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781015406; c=relaxed/simple;
	bh=dJpWs2gRETGdQIhmX+y27i91wNGExK7OTMvLZbotmGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TkjtkPQxmO3dnnCbhNtcHKIYu1AE/NUC5VdPXlsZiDlsylGBfjFtzD0CKBOrKPOluAkzJ+AQ+rSXDqVUNO5jOmAY9naiMyNWCN0d8D/1G8zgxCiw6e2ZuQJmBIYLGambNxyIO4UaE/giBS9vwetcxb6M3iNEafQtP00QYNO7+ok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=MjXeUila; arc=fail smtp.client-ip=52.101.84.8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qc63pvzNU8A6t55P2moCXgh6Kabnt/iXOetk3S6dZj8TX9k+pVEfdu9iBwWcmo05MvioCuAUZ+8nC7KvZ4+LNdfO8g9jLF+Ij5rZi6vgNfgC1DM1y7ni4/4e5PYDKBi7GrXqwknzXqk8X8lr14tS4M3pmvhKNeJOumD5Cpk2Mg3HEVzmI8Apw708FNvHCEjptj+vkl5Zwj19+9mRwLd0qb2GpdnkAIUA0xRZPwHxRo+ap9zcjMhN9EyIUBph3OKmt9OsXQZuTzACehfbD9cUHGD7flu9y5uKj5s7Yvchn0qXYtO761SzwHsqOD4H/u5HfUZCg6rMUplGrYNSqSuD5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sovek11lEjjqCTBCFA/gs88c8O7YhpX9vtTEKIWKL7M=;
 b=V74FYE/FYwPvb3g1kk12JXO/GgoBpbtX8m29xldGpMvyBP94lQ0l2ZdJ2rhf6VlcqBCygp+LUWy4dXlsFkDiFqxq0BqwRONdpsdTygx0EjE45nVxmOFcvCOytpbkAov0Ll5l8sYGp1+jPOBZxpj4Mz0C9GJHO13KAP5o4waerFrdsUr4QWk9gxbfrbUyuel7HzGBF6KSN1pCRciiCKmjKw22OMgPJ1dDEP/xhRWojifu5Gm+4BuXbjwrK5CcYfX9PQAHNPQhcNPnpYYq+SeZMNIgxWypDA7RrfirIKlq3bvzLogLRWaUCmW6dkpo0JeHELRHWkvc1JxWBJ0VRrkv5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sovek11lEjjqCTBCFA/gs88c8O7YhpX9vtTEKIWKL7M=;
 b=MjXeUilaGowJlFJIheOGjE4pvJf9GraVvuywUzX2El6nmdfOXEHOpOVzp4+a2fCkh14OFAFDBZKUpN4I5BXZ3gybcW3rMWSf/cuENcC6ZmRz+IawtHbrPUIDXkYjQKvONvfR0FfSnLp2ugv89drBsXPf0RIgrKNO4G8d7Fucroqxf2zEkHhPqTuy3mcojQETAMwG4VKERXkjI+WszGeuG3CaT8f4D4H9PTjXNIygnzoGQen5LoLFu/NkzQXPfWUJrnwXNTX+DPP5alNDUcK5tPgwflXbdakoyZ88zOkWTlHdyjRlzgwW7biUtCCNCfXGmtnXlL6qA+rTs8jSFD0qYw==
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com (2603:10a6:208:132::23)
 by DU4PR04MB10911.eurprd04.prod.outlook.com (2603:10a6:10:58c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Tue, 9 Jun 2026
 14:29:59 +0000
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6]) by AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6%4]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 14:29:59 +0000
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
	Haibo Chen <haibo.chen@nxp.com>
Subject: [PATCH v5 1/8] can: flexcan: use dedicated IRQ handlers for multi-IRQ platforms
Date: Tue,  9 Jun 2026 16:29:47 +0200
Message-ID: <20260609142954.1807421-2-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609142954.1807421-1-ciprianmarian.costea@oss.nxp.com>
References: <20260609142954.1807421-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0146.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::7) To AM0PR04MB5858.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: f46146e6-ebd1-45ca-5642-08dec63395c5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|19092799006|7416014|376014|1800799024|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 NYzeG4WOaVzw2Wl4Rhm1OIdxUQlkh7hlRg06aqnTnI8aLEPg9/ohiTWex5H43J9q8z5/o5x7zJt9nLyHJMmwUvbUeqG7knXe5kcOOL0mCmZx32E8+QKYv8MYMLoq0wWUfvcC6ZpKutchoB1Vaoe6lTRv42pyLj/2q/4ArHy06iPJU8GOFNw56tcmVQCR3uKeTAN+9Q+jhErAs6u+jdI83PTB7a3hKRKc6KL1prvwRwn7bqQthqhroRjzim0ijMrYHR6rDFvZRcPkPj1k/6iHQH00uHenrhGeiZdFsU7/eq2Hce0szJV86qk/A2jyU/9V5sO/G7cKPm5K726YCfKHKzXFkJ5LHqeiqn8DqGaeY1I7zz24pjBmfbvcsvkDRxD31y2G9a/eBgmF+ODprdOlY3zBJ3DaJJGXlaZzuZCF3kfQp0TvHDfY8Tzks7H8UzMTLRsESyrScRdwZaGlQ1OXJyg7h74kvjO9FOtGbHbHhX9RVvgPBiHhvoohRTIYxk3bvqNbzhHani1OdohmH+QmSkY69eZoaN2JfInKx3cdIEUxEb/kNUD58S0nrMoK09Km8apBfET6eQPBahy8gfPp0iAeJ4mLuelFFR6LzdrTrKbIsXmn25E1tKUrRlOAi0ckqQzhxL85S72lBIGQ+9qEUGR27UCSsVyKtJrIQcNtXoYn6/eCgsjTOZs9q/x9/S4m
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(376014)(1800799024)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?dVpFQjNMbGVBdmsvdDJVc0Z6SUI0eGU5VWxqN1ZqR1FVa3JHeXg1R2MvQWdp?=
 =?utf-8?B?dWlPZ2tNQnZHbEdiTlA1V0V4OEZCRFhwL3dUS3FaR2hZYmFmM3VWWG9GUXpW?=
 =?utf-8?B?OVBrUWRiQVFSaWxQKzUwYThjUzNNcjA0L0dxbUxrMTBKYUhLVmJnODdZMUM3?=
 =?utf-8?B?cS8yaEc0c2t2Ykh3b3JxaVYwTVZBOWV1WVJyUWVzdm5na1JIeDVZeUFjekps?=
 =?utf-8?B?ZEc5Vkg3RXFxUGxmL1RtWWQ1S3FZMlprS3dWTi9KQ1dGK29Ta2J0dUZxaFd6?=
 =?utf-8?B?VS9SQ2hGOGg4aUZ2clV1c1ZZTU11NWEyUHpscXd3WHBVWFVLUzFrOHJ1NDFo?=
 =?utf-8?B?NVc5VXp1akZ2Yy9BanRScDMvdnozeDV4OEYzNk56YXIwVUUxUEdVbHpXeEM0?=
 =?utf-8?B?SDBCTnF1bnhZWHBpQTlyZHZhakRwVS96TUt6Y1VlUmcwWGIvN05iQm1INGtW?=
 =?utf-8?B?QTlDc3RWcmp2Z1RvYzhuZFVKZ2Qrd2VMTStHS05xUjQwRXVEWGxYTStjZWU4?=
 =?utf-8?B?KzJSZVVHZ0JCOEtiQUN2WU0rTVAwcm1wdUd3UUw5L1Y5aXUvRGNsLzNzdU5H?=
 =?utf-8?B?UHRhc3dZYk9DK1prYXQxKzNGQjh5dkZWVDRzT3ZVa2paMElVSkRQT2ZZN3NN?=
 =?utf-8?B?SWFrYTg5TlplalpjMk5SR2lPdldZc3E4b1o3eVpTRmFQMEtVeVZQVktuM3VL?=
 =?utf-8?B?ZmVTOWRkQjRTRHNXK0k3dzg3UFdvM0FBU3RaRGNTczJoR3orRmpLRUxSbVNO?=
 =?utf-8?B?U3Nwd2xxK1ViZ2dsOW4yT21WMWFzZFJ1Wk1KdTB0UDNDVlpKa3ZNaFFIU3pt?=
 =?utf-8?B?bTl6R1RaemlzUXBVUWozMGtPR0lGRkUrVlkzc05LVzlFSjJ5cmI3SnFvY2Ft?=
 =?utf-8?B?U00zVlpGWWlNYTY3ZU9MNE5jU3U3NFZQWGNqbHcvWnMzT3Bpc25ZR1JnSkhR?=
 =?utf-8?B?a3QxRFRrSjB2VzhkSU1VY1phQUlYaVYxYWdHdFJQR0tuck8zT3cra1J3Q2No?=
 =?utf-8?B?MjdIODJtQjB4MHZsTEYwVXVPS3NEaXp5eUI2WGZhWGttNnJnaE1XdDl6VmtV?=
 =?utf-8?B?SGlPMm9YVVYreVZZOG1pK2ExVjQ4aG1zdlRlT0x5bzhnQVpuOWxqbkFRcEw3?=
 =?utf-8?B?L0dvZmk5aTZCRjNDRnpYQWYzSzFxcjAxSVdGeGxJY1hGUzBVbGc0ZVI5bVE4?=
 =?utf-8?B?aFlpNXVkMThxeC9WYWh3emU5cnhzY1BHQVVBeUt6TC9UN09QMCtNN1E4TlQy?=
 =?utf-8?B?S042akFEY0wzNnFXcVQyWjFkSlRneElyMFZBTHZ2NkpaMk80YmpFZERIZVJJ?=
 =?utf-8?B?YlFuQUJTQWNucTF1MXd0cWV4dnZJMk5la21EOHJZYmpHd3VhMEhRaDl2S0xX?=
 =?utf-8?B?NFBZR2d1azdsdVptbzVVcmk0WTUvSmxQcGcvQk42T0dMQ29BcHlibXBicGt1?=
 =?utf-8?B?YnhMaVhtYWx3a2hGbFhZMzNYcUFBSDZxQ3NOVTE3c2RvVGwrYTNWR3h6RDg3?=
 =?utf-8?B?LzlieTR3QnJKYTZ1cUpzY25EemRCVkRIeG11b01qa1c0R01oTkZ0eW85YTNq?=
 =?utf-8?B?NGRFaEJrR0VWT29CVkpnc1M3WXRmQ2RpMzdFNGxCSklCc2s4MXE1WERFQmlM?=
 =?utf-8?B?VnF5T0t6MzIrU2dEaFFRWkVVenNsS1A5ZE9nUVZObE9EMzFNRnBmSnlFUTlU?=
 =?utf-8?B?RVY1Z1k4MzdielVCZUZrSFc3di9WZzNhOVVpSzhMVFpQc09TakxMT3YwNXI5?=
 =?utf-8?B?bEJpWHI3VVZTYTVVMDVySFcraFhCUGw1eTlzcE84c3VQb3pEVEFVMklIb203?=
 =?utf-8?B?MmFoRFRrU0Yrdmxpa3dZMnRHZk9ZYXoxdmRFZXE5Q0IvQ3FZUUYwL2dBSkxW?=
 =?utf-8?B?ZFNucUZJWVJCSjI2Y25VbWlNYjdJMVprYkhBZmpKRWVRaHFwbXVNWnNmZ05x?=
 =?utf-8?B?cFRjUlZFVGduK28wY2t4QUNUSXk4a3pNaGZMT1RwMFpjZVZ5VlBJcUpVNllV?=
 =?utf-8?B?MkRkcEVwUzE5RCtKUm1mSklYYjZqR1ptVjl1QmM0VHRTMEpTL0VVSjF0TEF3?=
 =?utf-8?B?QzV5STg1OGxvTmltenlNcVV4ZzNWazhtL0hEYVFyTWFEd21kUnNCT3Uxa0k4?=
 =?utf-8?B?Qjljck02azdZOGdUdW9aYUxEZ25DMjdmZ0NXRjh3NVlrRWhjV3NzSUl5Y2l0?=
 =?utf-8?B?MVI3U2lSbmhBV2RIeGViWHhrTFltdUc1WmpNZmNUK1REUy9wMmFuMjc4NDVt?=
 =?utf-8?B?b2hMSW5ub2xSd1ExYTdkc3Y5V21WcnU0RkZvZGtKR0N1Zk5qMWxsaHhBRll6?=
 =?utf-8?B?U1UvelN5RHZvZFpKRENWS1NzelFQd0xzR1l2b3JQMXBwUzRKUXNCbE1uY3ds?=
 =?utf-8?Q?cU4v3zupMw3mkIrw=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f46146e6-ebd1-45ca-5642-08dec63395c5
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 14:29:59.3036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8sYSOgnUnSJ1SNP4yVoFjmrorSdnnQr5Hl+QJFGwdTDjql/smyZDvLOiJO4ifaav4HN5n2ua2COAKt9g95iXY1qyYMCRJcVlECWOYrnMl0U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10911
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7777-lists,linux-can=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mkl@pengutronix.de,m:mailhol@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:Frank.Li@nxp.com,m:s.hauer@pengutronix.de,m:festevam@gmail.com,m:kernel@pengutronix.de,m:linux-can@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:imx@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:s32@nxp.com,m:clizzi@redhat.com,m:aruizrui@redhat.com,m:eballetb@redhat.com,m:echanude@redhat.com,m:ciprianmarian.costea@oss.nxp.com,m:haibo.chen@nxp.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.nxp.com:mid,oss.nxp.com:from_mime,nxp.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,NXP1.onmicrosoft.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 917A966132C

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

On platforms with multiple IRQ lines (S32G2, MCF5441X), all lines are
registered to the same flexcan_irq() handler. Since these are distinct IRQ
numbers, they can be dispatched concurrently on different CPUs. Both
instances then read the same iflag and ESR registers unconditionally,
leading to duplicate frame processing.

Fix this by splitting the monolithic handler into focused parts:
- flexcan_do_mb(): processes mailbox events
- flexcan_do_state(): processes device state change events
- flexcan_do_berr(): processes bus error events

Introduce dedicated IRQ handlers for multi-IRQ platforms:
- flexcan_irq_mb(): mailbox-only, used for mb-0, mb-1 IRQ lines
- flexcan_irq_boff(): state-change-only, used for boff/state IRQ line
- flexcan_irq_berr(): bus-error-only, used for berr IRQ line

The combined flexcan_irq() handler is preserved for single-IRQ
platforms with no functional change.

Fixes: d9cead75b1c6 ("can: flexcan: add mcf5441x support")
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Reviewed-and-tested-by: Haibo Chen <haibo.chen@nxp.com>
Tested-by: Enric Balletbo i Serra <eballetb@redhat.com>
---
 drivers/net/can/flexcan/flexcan-core.c | 128 +++++++++++++++++++++----
 1 file changed, 111 insertions(+), 17 deletions(-)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index f5d22c61503f..f73ff442d530 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -1070,16 +1070,14 @@ static struct sk_buff *flexcan_mailbox_read(struct can_rx_offload *offload,
 	return skb;
 }
 
-static irqreturn_t flexcan_irq(int irq, void *dev_id)
+/* Process mailbox (RX + TX) events */
+static irqreturn_t flexcan_do_mb(struct net_device *dev)
 {
-	struct net_device *dev = dev_id;
 	struct net_device_stats *stats = &dev->stats;
 	struct flexcan_priv *priv = netdev_priv(dev);
 	struct flexcan_regs __iomem *regs = priv->regs;
 	irqreturn_t handled = IRQ_NONE;
 	u64 reg_iflag_tx;
-	u32 reg_esr;
-	enum can_state last_state = priv->can.state;
 
 	/* reception interrupt */
 	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_USE_RX_MAILBOX) {
@@ -1131,25 +1129,57 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 		netif_wake_queue(dev);
 	}
 
+	return handled;
+}
+
+/* Process bus error events */
+static irqreturn_t flexcan_do_berr(struct net_device *dev)
+{
+	struct flexcan_priv *priv = netdev_priv(dev);
+	struct flexcan_regs __iomem *regs = priv->regs;
+	irqreturn_t handled = IRQ_NONE;
+	u32 reg_esr;
+
 	reg_esr = priv->read(&regs->esr);
 
-	/* ACK all bus error, state change and wake IRQ sources */
-	if (reg_esr & (FLEXCAN_ESR_ALL_INT | FLEXCAN_ESR_WAK_INT)) {
+	/* ACK bus error interrupt source */
+	if (reg_esr & FLEXCAN_ESR_ERR_INT) {
 		handled = IRQ_HANDLED;
-		priv->write(reg_esr & (FLEXCAN_ESR_ALL_INT | FLEXCAN_ESR_WAK_INT), &regs->esr);
+		priv->write(FLEXCAN_ESR_ERR_INT, &regs->esr);
 	}
 
-	/* state change interrupt or broken error state quirk fix is enabled */
-	if ((reg_esr & FLEXCAN_ESR_ERR_STATE) ||
-	    (priv->devtype_data.quirks & (FLEXCAN_QUIRK_BROKEN_WERR_STATE |
-					   FLEXCAN_QUIRK_BROKEN_PERR_STATE)))
-		flexcan_irq_state(dev, reg_esr);
-
 	/* bus error IRQ - handle if bus error reporting is activated */
 	if ((reg_esr & FLEXCAN_ESR_ERR_BUS) &&
 	    (priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING))
 		flexcan_irq_bus_err(dev, reg_esr);
 
+	return handled;
+}
+
+/* Process device state change events */
+static irqreturn_t flexcan_do_state(struct net_device *dev)
+{
+	struct flexcan_priv *priv = netdev_priv(dev);
+	struct flexcan_regs __iomem *regs = priv->regs;
+	irqreturn_t handled = IRQ_NONE;
+	u32 reg_esr;
+	enum can_state last_state = priv->can.state;
+
+	reg_esr = priv->read(&regs->esr);
+
+	/* ACK state change and wake IRQ sources */
+	if (reg_esr & (FLEXCAN_ESR_ERR_STATE | FLEXCAN_ESR_WAK_INT)) {
+		handled = IRQ_HANDLED;
+		priv->write(reg_esr & (FLEXCAN_ESR_ERR_STATE | FLEXCAN_ESR_WAK_INT),
+				&regs->esr);
+	}
+
+	/* state change interrupt or broken error state quirk fix is enabled */
+	if ((reg_esr & FLEXCAN_ESR_ERR_STATE) ||
+	    (priv->devtype_data.quirks &
+	    (FLEXCAN_QUIRK_BROKEN_WERR_STATE | FLEXCAN_QUIRK_BROKEN_PERR_STATE)))
+		flexcan_irq_state(dev, reg_esr);
+
 	/* availability of error interrupt among state transitions in case
 	 * bus error reporting is de-activated and
 	 * FLEXCAN_QUIRK_BROKEN_PERR_STATE is enabled:
@@ -1188,6 +1218,65 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 		}
 	}
 
+	return handled;
+}
+
+/* Combined IRQ handler for single-IRQ platforms */
+static irqreturn_t flexcan_irq(int irq, void *dev_id)
+{
+	struct net_device *dev = dev_id;
+	struct flexcan_priv *priv = netdev_priv(dev);
+	irqreturn_t handled;
+
+	handled = flexcan_do_mb(dev);
+	handled |= flexcan_do_state(dev);
+	handled |= flexcan_do_berr(dev);
+
+	if (handled)
+		can_rx_offload_irq_finish(&priv->offload);
+
+	return handled;
+}
+
+/* Mailbox IRQ handler for multi-IRQ platforms */
+static irqreturn_t flexcan_irq_mb(int irq, void *dev_id)
+{
+	struct net_device *dev = dev_id;
+	struct flexcan_priv *priv = netdev_priv(dev);
+	irqreturn_t handled;
+
+	handled = flexcan_do_mb(dev);
+
+	if (handled)
+		can_rx_offload_irq_finish(&priv->offload);
+
+	return handled;
+}
+
+/* Bus error IRQ handler for multi-IRQ platforms */
+static irqreturn_t flexcan_irq_berr(int irq, void *dev_id)
+{
+	struct net_device *dev = dev_id;
+	struct flexcan_priv *priv = netdev_priv(dev);
+	irqreturn_t handled;
+
+	handled = flexcan_do_berr(dev);
+
+	if (handled)
+		can_rx_offload_irq_finish(&priv->offload);
+
+	return handled;
+}
+
+/* Device state change IRQ handler for multi-IRQ platforms */
+static irqreturn_t flexcan_irq_boff(int irq, void *dev_id)
+{
+	struct net_device *dev = dev_id;
+	struct flexcan_priv *priv = netdev_priv(dev);
+	irqreturn_t handled;
+
+	handled = flexcan_do_state(dev);
+
 	if (handled)
 		can_rx_offload_irq_finish(&priv->offload);
 
@@ -1761,25 +1850,30 @@ static int flexcan_open(struct net_device *dev)
 
 	can_rx_offload_enable(&priv->offload);
 
-	err = request_irq(dev->irq, flexcan_irq, IRQF_SHARED, dev->name, dev);
+	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3)
+		err = request_irq(dev->irq, flexcan_irq_mb,
+				  IRQF_SHARED, dev->name, dev);
+	else
+		err = request_irq(dev->irq, flexcan_irq,
+				  IRQF_SHARED, dev->name, dev);
 	if (err)
 		goto out_can_rx_offload_disable;
 
 	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3) {
 		err = request_irq(priv->irq_boff,
-				  flexcan_irq, IRQF_SHARED, dev->name, dev);
+				  flexcan_irq_boff, IRQF_SHARED, dev->name, dev);
 		if (err)
 			goto out_free_irq;
 
 		err = request_irq(priv->irq_err,
-				  flexcan_irq, IRQF_SHARED, dev->name, dev);
+				  flexcan_irq_berr, IRQF_SHARED, dev->name, dev);
 		if (err)
 			goto out_free_irq_boff;
 	}
 
 	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ) {
 		err = request_irq(priv->irq_secondary_mb,
-				  flexcan_irq, IRQF_SHARED, dev->name, dev);
+				  flexcan_irq_mb, IRQF_SHARED, dev->name, dev);
 		if (err)
 			goto out_free_irq_err;
 	}
-- 
2.43.0


