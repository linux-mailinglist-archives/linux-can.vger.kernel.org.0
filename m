Return-Path: <linux-can+bounces-7143-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFwoDYPLu2leoQIAu9opvQ
	(envelope-from <linux-can+bounces-7143-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 11:10:11 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8912C9441
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 11:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7F508313AD05
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 09:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540413BC69E;
	Thu, 19 Mar 2026 09:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="RR21pHAk"
X-Original-To: linux-can@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013028.outbound.protection.outlook.com [40.107.162.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2494A3BAD96;
	Thu, 19 Mar 2026 09:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773913247; cv=fail; b=URkhhHy8YIMj0WCcwnGrqds4wLtNBsXt3opGDkha/OXH6bXxVTDoLta7VHnS5aCVZUb72UebioMEF6N3+lBMVR3NnTUPDOe9eFUK62pZTD727tialH9HKFnUxRYM6U5pxfv2U+Y2yz3efpMhiK1COpAvySlRkiSY6EGMhcKWKbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773913247; c=relaxed/simple;
	bh=Ixd3ZArKJes2BLvGe89izuKPTWlGJnPBfH7ssojGe0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z9xk6lYTz0eRhTc7msc8yNw9aLYaWZ5EzD8FXLCdGUjkp0ntLo7voU4g2nfdnWuCacRKLAbPDiPcyk/0MoQ3x62iGFCeKXO7nfjXDEXyabo/eSid7mV+27zYYZB5jPZCl2eiM9fa+EN0kQizkYExYnnUjv2zHENn4sNYwPD+vrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=RR21pHAk; arc=fail smtp.client-ip=40.107.162.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QEV1sxxDUGEaL/AgfFB+23OEPqAen6hs8JDywi65g85aaXlXe3W1+52yRlkuKA+Eh+I5cStpT/8MY9CFt3I9TDlQRbSZc+RtezJ+3t3CvGV+Oxy748GpwUnpoNB/rJhC6BhCPLkGNjNl4SoBPsvTOSYOMwxyNtcu+5AuOpiII7pkfm7vcq7KDnxc3P7YkgQPNjFj7GfRNplvgNdjy0uHMLJg1fHQ9hUya6OR5t1m6X98LDKzfctXDfjl9V0klh8llTgkiGzdw33RjrgMsTdHxuKBurej+BUrtS07cqzT9w+2fFeH3gk8c4W20D5Zv/0IXdfEfAwXe+jbdsN9W4UXZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bZoXHuJNKwCtZJr6ZrwT+WGCkQtR46G9TkAJqNljI+U=;
 b=wPDhY8scbe3CQWBZzn3ZFqNCHMiGxk3dIeh1DlePcddHQTkUz3ZZV1oQcocLLrLRDarLAtlAPHbQZgtaezS2f0kUk1K36bXyIGcmZNVZEvR2jgWFB0mR8U2HG0dSmVim+jTGE5XwSJaXFgHHZTCK/Xy97JtpZnPtuX5v/wEshNAzt7u5k/R5g1jVZXTNj2WZ3FXmB29rjv6qKER0XwopRjn64HUxfly8mDWWZgb0YKIJCcnP3yFqOaK5NtIcaSinfhm+OCGdmaXER5iYAU015AoADVpQJaQZyvxIrmh0rX79tHY3YrmP04BkR8yeQFjQrhsWnNPiXtsYqL1XX/5RMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bZoXHuJNKwCtZJr6ZrwT+WGCkQtR46G9TkAJqNljI+U=;
 b=RR21pHAkI1PLoa1USkblCwnsX3kgCp9tqKmtriCm+Bg3nr5Xs4g0EDWTZrFJQV7I6pMuRRMFGCF4n+DZSkDDov6kfrtqFJyt8geTSl/zMO6P2AtfTKDBbjEDcMUjFWVJsEFguLHpYmweJIJJDanXnMbLuUKlbU72RYf/NK4saTuNQ5WGCuxlHnkqUpFpUhrJOlXlOlT51o+UujyNo0rZZa9oeblJCGL5u4nWppsJsF1nUGoPDhgVtZ+Mk6oGdqp84bcpF2bFPRnFLYrRNNHKtlbiNWuBZLNpJTOJMsCHKkEomEHMW714tmxSU9qTln8HNzfdbqPHJSXyViBjiZHWBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by DBBPR04MB8012.eurprd04.prod.outlook.com (2603:10a6:10:1e6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 09:40:34 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 09:40:37 +0000
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
Subject: [PATCH v2 2/5] can: flexcan: add FLEXCAN_QUIRK_IRQ_BERR quirk
Date: Thu, 19 Mar 2026 10:40:29 +0100
Message-ID: <20260319094032.427697-3-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260319094032.427697-1-ciprianmarian.costea@oss.nxp.com>
References: <20260319094032.427697-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0154.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::7) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|DBBPR04MB8012:EE_
X-MS-Office365-Filtering-Correlation-Id: f04fee42-84bf-4d60-283d-08de859b934d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|7416014|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	yv8nSoz87pCRJozkK1R3EC7LFI6hcUVlLfpdeSj9CixA5WujaKhiZMkvT5ZzxJA0+/+QrmC5HBYq2p+Zv8QChdAeBAa1EvOqUTDBwEtEflkqszcP8OMRb/aN2C1wcyNXdoO3SxdrHH1haDtGyhs+lAxAsjdiTRvmoOTHoamJvd/Io5y+1lQVpB8hV0p9AfWbVDBI8rl5S0YpAnqJz0vbXkDXC//rnb1/xn3mtUYUieMONNsnR/H47B5sU+7OZ889Qw1UVeRQovHQJnSLZXt/cRqjCTfPWV/ehMrwfIi2QROchRP4MgLAYreutnoWJ3La4Y8nwLK/dTrX5pc6P+FYRhlX8PHgULbRQQZElexu6ZkCLeuqDwOslYAs3v9WKkUmgMtTGWGMrTSLlItBsqQSWJFJ1oocfsiPVeeL4ZwAU+4y7sQfLtz7U3v3CLEm/WvFGqIl16lNFfaQsoxp/XThdx+EArkwzi68LXEi9XFr0+eN7tpnvrqA/esB/VmWO/z3/Vck5lrjXsFvFiCvjstqfq54ahjd9S3WVTkyuoxxZ50LX5ZYzFpQZeQna0reH4VQhiKxizJwsA8xBj9yQOYkGVbtwqdbHIZ8AHYGtAaEg9PDGHM/bnYu8wVnH7HPbIbyrtOKoFNZJlPD4F/hd1/cgBpioLu8vGgcHJCTZWV1Yr9VB5xaU5NTNpG0AyDHSbQmoNN1QQ9QpWGbNev29LbjIDbVmP0saW/5/Sm98qtR8Uw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(7416014)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T1BvUStKc2p4bG4vRlJNQjBSS0pXSDdCbFdGa09qa09FTG1IL1ZVMFZHN3JJ?=
 =?utf-8?B?V2s2MTY3QTRmdmE3ZWtSbWREUkRvR3FmZkZkemZsdkQ5ejZMQVpsb2ZHU0t3?=
 =?utf-8?B?MzZpNHdBMDVhU2huTkVqb3lnMjRJS0ViakNpVmxudFZNbHAwUldpaHlrZ0tK?=
 =?utf-8?B?WVdqMGt5bGRlMHVnditOTi94MGptQUZFWlFzUk5vN1gzajBJSWhiUStXSFha?=
 =?utf-8?B?WDF0eTFDVnZERzZNZllHb3RVVzd1eGpOVnI0bjgwUGR5N3hDVmtEZHFKWW9C?=
 =?utf-8?B?TC9UZjJqWmlUZWtGNHJsdFJnZ0RKK1ZLdE9VUjAvNkI3dnFVamwySGEzTVhM?=
 =?utf-8?B?Zmk1OUZFS2Uxb2lRYlJlaGNDL0dENlBWTDUvbDY4a2RvRncwRE1OZEhDQ2pI?=
 =?utf-8?B?Nk5LR0hpdVlacG9HTGo0d09iejczWCtTNWFLR2hUUitGYi84ZUhFeVd0bXl0?=
 =?utf-8?B?MjlHZTZJd0dCLzM5QjJZNXZ0RkgzeDFtcTNWRlhrY1hQcS8zbnJiY0p2RExR?=
 =?utf-8?B?NjIrK1p2TlVHZW5GRWxneU13ZFM4RjB5RkpSTE9IV2UzY1BBTmJNU2RnTWQz?=
 =?utf-8?B?RXlyQmpROFVWc3ZUb3ZtZlRGSmVTaUx4YzZBTDNicTViODg3OElkNHk0bVJu?=
 =?utf-8?B?Ym9WVWdGeGVPbjlMNDljTDhVQ2ZoK3ZiT0l2RkxvMDJhVW1wdHptcTBQQjNF?=
 =?utf-8?B?Um5xaTRJbWlaWTRHcnhCZXZoL2pWa3hJRnltZ2hRL2xuUGdWV1FjZE5jMDR1?=
 =?utf-8?B?NTFkcVlpWE12SENRMUVKcTg4bmZuVHZFNjYyaFp6eTRxMmJWQ09BWHBWOHhD?=
 =?utf-8?B?M1FQSFk1TGh5eUExRkhkbkdtTmlTY3pjdm9CaTBzMGVmZVFOR1lQNWRtZkww?=
 =?utf-8?B?Qm1MaWtrQWxwOVF1b1J1R2RVZHdKaUs0SFB2YmVLVDlOd3FySEZDYnl1ZE9y?=
 =?utf-8?B?Q0Z4bW0yTE1PYnJFK3FoYXdQck9Lb0RYWHRQNXFsWkFSVG9uYW00VDlsY2JK?=
 =?utf-8?B?L1NZUCsrTlkrUDJhVXpPWnhpNG5ONytreWR5V3FuY3V5NlpNQVRHQVgvbGRZ?=
 =?utf-8?B?LzB0UUluV3p1U1h0TjlOa293eUpwSzJJcmkzMFBYUGlHZ0ExNEhjekhiMVpP?=
 =?utf-8?B?d3ZoRFhUZUp0a1I4UWFhVENLUHJ0bVE5OHhZU2szdVZWajhLUDdna2MzeFEx?=
 =?utf-8?B?NlpwbmUrdmFQSnVScmRMSHh5UlloWmprNTRrS2FZOHU4Q0ZuYnBsZ2Jrd3FE?=
 =?utf-8?B?QXVqOUVaZHRoWXFWaU1BSzZYdkUzclZJR3JHem9yMEdUTTNLSGJvR2llZlU2?=
 =?utf-8?B?Y0tPM05ZbEpxOTRDVkdaVWZpWEZtQ282aXVldlpIU21UV3NISEJtV3dLMk1k?=
 =?utf-8?B?YUg4OFRoU3dTZ29wT0lQS3BYWHVxWFJ3bmJaSDBuM1FkVjRmc2wvcTFzM0kz?=
 =?utf-8?B?aTFEZDNyRE1jOWtlbDk5dWRISTBrZVpPcTFwUmh1Qi9KYy9GNXE3SU9sYTJ5?=
 =?utf-8?B?dHU3QnYyd1JvWkphN1ZhRlY1QmxCdURxSXBPZ1Q1ZDlnMDhwTFdpY1dqMlRP?=
 =?utf-8?B?aEJJZFdVZm9GRWxTQnVlL3o3VnRUaHJ2NTF3MkJnbTFsZjgvcGgvOURDdVlV?=
 =?utf-8?B?QkQxenBjQjJWK1Jjem9VakVGb1VmZUxNaXIzVlBuZmYyYWgyWFJMNk83OVFt?=
 =?utf-8?B?YUlXems4Q2NwZWF5UEZmc2tIdzlwYk5JUnpUcE9Gdm9uVDQ0M21FaHhPNUZ5?=
 =?utf-8?B?eGFKcWtuM25sMzJvOW01emtkS0JPVThuNDFsQTcxSFBuU3Y4SEFHWGRxKzhX?=
 =?utf-8?B?c2JIcUJRWHR2R3gxQUpJck4yTjJuM1NLNWxUK2psWXR6Q0JDQ2R4bzNWbWJp?=
 =?utf-8?B?bnE1Q1dIYlNvK0cwRFp4Z0p3WG1uYXpZUlBnNHd1c096TXk4MklPRmlNQ1NU?=
 =?utf-8?B?cVltQTdpWkdOUUR2blF4WWpuUE9UQWk3eDRjZjBxS01hQmhlZjNRaXpsWUlW?=
 =?utf-8?B?dEFoUlZFQllpNjB1ckhSSFNnZ1lDZFh5TlpmNlhuVXV6ODA4Nm5JRWJwdHZv?=
 =?utf-8?B?ZytlUktnTVdJNGJpeTZYWkJmZTBzOXpVYjY5dTZiYXE3Zk1kbEdZZDd3R2NT?=
 =?utf-8?B?cUZtcGU0T2x5WkpwNFNFWW5SZy9rcVIzQ21LWElCaWtCTHJPQ3FBVE5PNG9X?=
 =?utf-8?B?VDJuK3pWZTh0VGtOdXEwd1Fqbm8rMkZxcmQwVkxndXZobGs4LzREZW9hQWRU?=
 =?utf-8?B?dDFQclU0SEdITG9XV0xMSFFMa2k5TDBEeDdFL0VsWWNOaWNaMDB4MnpOcm5h?=
 =?utf-8?B?K2NxSzV1dnJQOHB3bzB2U2grYjQ0TW5XY0JtVzU1MnVpbDNTVC95TkhnK2d6?=
 =?utf-8?Q?ZoadxSD9q1JoaE/8=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f04fee42-84bf-4d60-283d-08de859b934d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 09:40:37.2954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P+Jn5BF4S6WBsyDcrGk+607Ck5FWXMpvm59IdfJsZGN0hZHBWZLkZcrrUFQ6fFYfafVhuMmGCY/pPksuow2g0WMPTsoUXErGAFHwR32aXYA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8012
X-Spamd-Result: default: False [2.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7143-lists,linux-can=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oss.nxp.com:mid,NXP1.onmicrosoft.com:dkim,nxp.com:email]
X-Rspamd-Queue-Id: 5D8912C9441
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Introduce FLEXCAN_QUIRK_IRQ_BERR quirk to handle hardware integration
where the FlexCAN module has a dedicated interrupt line for signaling bus
errors and device state changes

This is required for NXP S32N79 SoC support.

Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
---
 drivers/net/can/flexcan/flexcan-core.c | 21 ++++++++++++++++++---
 drivers/net/can/flexcan/flexcan.h      |  2 ++
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index f5d22c61503f..1d5879510adc 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -1770,7 +1770,10 @@ static int flexcan_open(struct net_device *dev)
 				  flexcan_irq, IRQF_SHARED, dev->name, dev);
 		if (err)
 			goto out_free_irq;
+	}
 
+	if (priv->devtype_data.quirks &
+			(FLEXCAN_QUIRK_IRQ_BERR | FLEXCAN_QUIRK_NR_IRQ_3)) {
 		err = request_irq(priv->irq_err,
 				  flexcan_irq, IRQF_SHARED, dev->name, dev);
 		if (err)
@@ -1791,7 +1794,8 @@ static int flexcan_open(struct net_device *dev)
 	return 0;
 
  out_free_irq_err:
-	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3)
+	if (priv->devtype_data.quirks &
+			(FLEXCAN_QUIRK_IRQ_BERR | FLEXCAN_QUIRK_NR_IRQ_3))
 		free_irq(priv->irq_err, dev);
  out_free_irq_boff:
 	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3)
@@ -1823,10 +1827,12 @@ static int flexcan_close(struct net_device *dev)
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
@@ -2213,12 +2219,21 @@ static int flexcan_probe(struct platform_device *pdev)
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


