Return-Path: <linux-can+bounces-7738-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oFG1A7DUH2psqgAAu9opvQ
	(envelope-from <linux-can+bounces-7738-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 03 Jun 2026 09:16:00 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A725635138
	for <lists+linux-can@lfdr.de>; Wed, 03 Jun 2026 09:15:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=QJSPSwrV;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7738-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7738-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F3E903055952
	for <lists+linux-can@lfdr.de>; Wed,  3 Jun 2026 07:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81DF39AD25;
	Wed,  3 Jun 2026 07:13:51 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013042.outbound.protection.outlook.com [40.107.159.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548B9399CE6;
	Wed,  3 Jun 2026 07:13:50 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780470831; cv=fail; b=hF3R1FpnRYzRwbEOzOSTLSm3ESWx/ynhff3R8KsBerF5R911DAmi/ls2kbvCNBl1xsFX1LuxoQLzHw1ziP9LW6GQ53C5dP21fildahkK7LvCW/t6M6YvfbyNFQe+e0UUily9MN/sL4o3ifTKmCoxCoWcMQPvZQda7SXVj/7H4Ak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780470831; c=relaxed/simple;
	bh=VlaV463z9LAC1wNALjkbRCbO3hKIHhq6Xil8Uqyaj98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cvIG80XkFWCmGtEnkH/JwjsWQTqeE4Ui1dj2dD8vZBz1NhwBmPLalsw9uVq6HbquffOoZ/lO49qQ13/67KGHRRzwxY9deSv7+2EqHvee1AxgJ10onDkg07sk19f/GUXa1iC0KkuqxyTRqITdUzxLh/DmhrRPobuUBtALCUrus4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=QJSPSwrV; arc=fail smtp.client-ip=40.107.159.42
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lem3YaTpNApEnT7EytUJP6/q2HOgn1LD7JlCKAnrUr6xvFLR8z8LCLU8oSpqVuATwn3P0VR09IAPTCUNu+1oCCUl5+kDd6bFME6yqXDuCnbLIPEZSn6G0yPYmmXc7ZdnaWku2B30FIynb0CAFVohryq1h3RB7I5//hGlAk+6HiPjhRCl4Df8fsiJSC2bI27ONUj2rf60f/O5kWwBhQ9R2ccFCedlVu912hDLAsMPaXcX42TYPaN/Y090jW4G5zRXs0wif85z2YfKpZSrT3eAMlFmFnou1VXVKXw+Dr69pTjdL1CL8PIT5aLOY5klztGIId5b+QMVgXdHxl+nSwoLmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jXj4YTgfkV97oBYFc/OQX7btN0RSqrP0NjNGEYWi1+c=;
 b=OIChm+orKHWGw5M0gtYHIaZNPdoLPaXYUpJDYoxQNRiKSpmdDuJLgoBjaHksTf3dhfzA415eq/RGSBQJUZSUXuez11O5rWBV+fPpmsg3+yXKthZ4gmaUvxZR8ByC1OZkBDlaGjn3IoniBKOGztCWNhdk8FSZ3GuQAcT3hJ706DuEWtej7c0MAuFpizTwqKip9XlzzHiyLT2dIUGg7+bBCmx1PuJGChnjKPQVB+L/jbdoHTsVWTj+LiLFka1r+RKThMGl86JTGqah05c9Zjb2YZQ6wp+V1qjiPrAjN0M6j5lb2EVlzE0stx3DwpQBe9FswqNtnB+XXRaIiePlNpnpZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jXj4YTgfkV97oBYFc/OQX7btN0RSqrP0NjNGEYWi1+c=;
 b=QJSPSwrV/34c7WE9rNF7a/ZvR6x0PXqfxowcI/2pO9lBdAUdyPEMtip+i4r0Es8RQey77DEbY4zGdF0TQp3hqeW2t21gi6QIZrrtp8FupAyPu1VLbgPDhSEFfbRS1+FnWo/t0qJVtDdZTANJS6678fUK+20m5/bAooj8Y5Wt5jgniuU3vqtTac77UPwtaWGLTXcLASsxs3pywqc7sbOSCTDWQKCg2L5CENkVGH4/j9DhAUSjEYEZOvk1dN0WyT3UX+f6IYT+kPu/kig85ZHYVH6shdAKzIc/olOnzVUEneeEW+hSJSKWx2U2a3tHjyg06LZN2HcPRiz6yMj1VaABoA==
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com (2603:10a6:208:132::23)
 by PA1PR04MB11406.eurprd04.prod.outlook.com (2603:10a6:102:4f1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 07:13:46 +0000
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6]) by AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6%4]) with mapi id 15.21.0071.011; Wed, 3 Jun 2026
 07:13:46 +0000
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
Subject: [PATCH RESEND v4 1/8] can: flexcan: use dedicated IRQ handlers for multi-IRQ platforms
Date: Wed,  3 Jun 2026 09:13:35 +0200
Message-ID: <20260603071342.641874-2-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603071342.641874-1-ciprianmarian.costea@oss.nxp.com>
References: <20260603071342.641874-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0268.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::13) To AM0PR04MB5858.eurprd04.prod.outlook.com
 (2603:10a6:208:132::23)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5858:EE_|PA1PR04MB11406:EE_
X-MS-Office365-Filtering-Correlation-Id: af15ab3c-f6fe-4f7a-d9b5-08dec13fa71c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
 G5fcSd0s25Pmtek90um017XRjbe3E0fscL4EVjPTRq6ILjtSaIXsX+LX1Yt/GLY6SVFwTdSfYzMDI+pNswbYR3KPfWb8OtuJ7ElPCn3NC8wClWB4xuEaotkt/mBvbM7VEVnQkgxUKnZELP80OrrWjqwiNuh7k3c/md4eQ3v5IVDQ3tp00iYXTNrGMxbkDaUCgLmQ9753btG2gFUaH86kkh+NwRY9+DldowTZi1iG6axwZ5VUmSLbkKdDSp9h2oLTTCrudgkw+cYsT/4NmXGHPKF2wvNJV7vlAeGWn8p6GyfOzRhNS+it0NIITLgb+yVWbF3q0oEdJtH9WlhXcGT2dQa1Yfovbvs+eOZ10XEyf3IBlsgA5nx7QyF0hfcC0iyIobDWR9gP4nF0Gu/eABXnByx/aoP3uSeYEhxRrO0RHb2CSzzM+/dho6Lnemu++vt4ItxjxeaqdmEGl04f+WzLvZ4S19vZBgskhND1+VUCL9uG/lSvVxp1TvAgb84uIdnsJHkM7N+bOqYJjP9vDwl2tM2iRjc23Vzd+6WDwpN3xEiE3xF4XdtOLgpqz/WKQ/ctsQrp0xO37ACYBtD0rMkvfo+qUgpCVH7C/x7HguF2+iqw8sH9ewGO6QcHJZhpECAzbcj4dstu0k2rQ3t0xKmEQNy1gd+uNG3dBnOp9fWgXjdzpBTA/Kl9MQUb3i/WDdSd
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?aGdmUHYvbDVKUTJBcnBxa3BrQ0U0NXp3YmQ3NHYvdWdCUUQ1cHN4elBYdmJ5?=
 =?utf-8?B?WW1haGlmc1FyYXVFWVZMSDlnN1NVeUZISDFRZGsvZ05jdTh5UlN5SDliREhC?=
 =?utf-8?B?VTlBeGJPeERsUFFoakNzeFZtL3JtL1MwYisvNGtUOGNOaGNObjAwd3ZGaFhL?=
 =?utf-8?B?S0NBUWhzV0daK1B6V0liajBUejVJUzFMejhwZmVwYWZpZGl1aEo4NXZIa09K?=
 =?utf-8?B?d0Rsc28wUVZrNG9DemcyRVRyYU8vcFBJYnBYRjdTYzJkbXpiZmI1UVQwd3Nh?=
 =?utf-8?B?Tlpyb1dBeFJuZU9YRUNLcnFRbG5FOTBRb3dpUGRSZkh3dGFLdGc4UldDL3Yr?=
 =?utf-8?B?dTFqSC9hc05mZ05LMHJqRW1BNE1iYW1KQ0RTWm4yNGR3TDAxR1BiYWV3Sk9i?=
 =?utf-8?B?ejVBQXZucGNYOTNGbStiaXdQYjZTQjJScUZEZHVLQ3doRjRYRUt6ekdCbjh0?=
 =?utf-8?B?K1NlcmtxckNTMTBmaHoyZVIvU1VmL3pXZjFSRk9hUjNNanp6OWUwMTFmQUhl?=
 =?utf-8?B?WVBPNnMyVndSV1FZNVU1ZDFKTThZWWZ4d282K01hVHdINTI5TGYzTnRkT2hk?=
 =?utf-8?B?UW81UHorQkdBQ2svTXBNd0M1M2QrOGhKYUVBVmlaR2thSHdIaFBnQUtCamg3?=
 =?utf-8?B?dGNucDZrL3JNa3pNbFNZQUxmU0xFS0QzUTVrVnlXYmExTmVNdEFabTVyRzBj?=
 =?utf-8?B?NGNlWk45UkprZ21WVDh5dm82RTh4VERvN0JrdUNKeEQ3N2UvdHQ1S005RSt3?=
 =?utf-8?B?ZFhXY1pjL1dGMi9ubGFKZUk1TGlGcjJrTUpxWUo0R2xMYmh2K2dqVTh3SXJW?=
 =?utf-8?B?by9zbkJNSzQwV2Z1QTloQ1MwMDlpR28yVlNuQmhMRmI1bDdKdVFCUzJNbG5Q?=
 =?utf-8?B?N3E2K20yaE1JU3lSYjA1bXFvM0p5N25NdTRBUjQyaEdoZm5pTHAydkNCaUht?=
 =?utf-8?B?OGZzOGVkY25vOHIyeWFCUTd2RXM1WGEvSExXVldHOHAvQ3ZweUM0YW9ONVV4?=
 =?utf-8?B?UkFJaGZQNlFXUHJZcDJiRS9rUlJGd2RCTmg5QWVJRFZGS2hMajZ6N21ycG9W?=
 =?utf-8?B?UE9ISE9tN0ExeXUyaU5mRkxjSWVkZ2prZ1R2bW81MHJORXo5UWMvYmJNcGxV?=
 =?utf-8?B?WG83dFdWR2tURlo5U3FTOXJhWjMvU0JTUG9pYUVRUks3UzhqR2doRWJyTWI4?=
 =?utf-8?B?YTU3MzE1Ujl4alNRQWJWLzk2R1JJK0xMSy84cGV5ZGhRWTl4SnhSZS9UdXFZ?=
 =?utf-8?B?TS96WXNSdmEvRVJYcmplTStOUDBFSnE2bkhWZVErQ3l1ZkF4Ym1tY2lCSUZo?=
 =?utf-8?B?OVZneSszZzg1VDRWWk96d0xqNlltbmtoRXRjbERWSzN1RzBWNXF6UFhGeWtY?=
 =?utf-8?B?SUl4UUxvREFOOXZ4aGh3Y0lvc2JmMERBMVhLdjNFb0lFU2Q2cXNBY2gxYW00?=
 =?utf-8?B?VVRJdkJnOUNnRnBEU2hHSm9kbk1Oa0lFa3BqQlE2MXFpd1RQY3J0bkJDMXJi?=
 =?utf-8?B?VVkrQ0QvcytVbHJzSlVTc3Q1N1VjQlNlSmR6SzB5V0hyem1YSkpkalpWQytN?=
 =?utf-8?B?ek1SZGRUY3FJNVQ4OTc3S2w3a2Y3V2FzS0NTTzJEWnhCU1B6aDNhUDFRM0RN?=
 =?utf-8?B?S1NnSmZCUzhKaE1HcmhHSDhuM0wwTkRhRGYrSmZuK0FHdnFXc2FyZHB5b0R3?=
 =?utf-8?B?NWNKQmpTVjNoREFsb1dLTEVVUEY0YnFxTWJoR0c3QU5WWUlCYW5VMGlCamQx?=
 =?utf-8?B?aGw3bTFqbTJEV2N0Y1JydnNxamhYc3FFWlNzRFc3MWJZNkhSYnRvMmFTUWJQ?=
 =?utf-8?B?c3NMNTJMYWNQUy85SXJNcmUrcXJzaktraE5mZjhNR0I5c3llUU92ZlAyR1Vr?=
 =?utf-8?B?WS9OSnZnNHR6RGtVUzNFa0Q4Mlg5cVdHOFBPazJFTS9LTlJXNTVxTjlXdlVH?=
 =?utf-8?B?OGg4K2tZaUlJUGhTYTI4YkFNcUVNZEYzcGZTalZHQ0d2dEY0WHR1cUFqdDdo?=
 =?utf-8?B?cVc3empocmpSeWc3NmgvYzRkR3BjeXlEck9LeDIwTVpCcm45M1p0aHh6dm44?=
 =?utf-8?B?cVUzYWxhY09CdURGUTBTbXZxSHhsMk9YU0JLb2FWR3llMzUvNkx4Mm8ya3dX?=
 =?utf-8?B?c24ra0xuWEhLSFNlSm13Uk5sUFRoMkFXNlRkQXpMbXgwb0VOWkYvZEx0VUt3?=
 =?utf-8?B?cSs0R20vbVBOaFl4djVkZDVQVnpLTHByMkxOVUcyOW1rNVVJZURqaFprb2NS?=
 =?utf-8?B?ZkxkaWFCUFBCT05KMjlPOXlMUXprdk9WdVcwbjFJUmlGVFFxbmg4QnU3Q3E3?=
 =?utf-8?B?Zkk1YzdzNmh5LzlCTG9aNnZjZ3ZWQmo0dkJCSEhPd2h1eEl6eGpEMzVucm1E?=
 =?utf-8?Q?X2C4tmQvsBvp3Ms8=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af15ab3c-f6fe-4f7a-d9b5-08dec13fa71c
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 07:13:46.6566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AiSPhmX2uyyJelxMvbCgPBAk19rvo62ayDJXq1Eri1FXdJb99Nk/emDMq0eIqkM7wTIkvUvT+3AQHflbzvVv7haM3LnTcz4lFei3jfMnBGs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11406
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7738-lists,linux-can=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mkl@pengutronix.de,m:mailhol@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:Frank.Li@nxp.com,m:s.hauer@pengutronix.de,m:festevam@gmail.com,m:kernel@pengutronix.de,m:linux-can@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:imx@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:s32@nxp.com,m:clizzi@redhat.com,m:aruizrui@redhat.com,m:eballetb@redhat.com,m:echanude@redhat.com,m:ciprianmarian.costea@oss.nxp.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oss.nxp.com:from_mime,oss.nxp.com:mid,NXP1.onmicrosoft.com:dkim,vger.kernel.org:from_smtp,nxp.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9A725635138

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


