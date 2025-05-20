Return-Path: <linux-can+bounces-3600-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B3CABD73B
	for <lists+linux-can@lfdr.de>; Tue, 20 May 2025 13:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B1C14A3875
	for <lists+linux-can@lfdr.de>; Tue, 20 May 2025 11:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C828013635C;
	Tue, 20 May 2025 11:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="k5HHtQzH"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2120.outbound.protection.outlook.com [40.107.105.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE7321D3F9
	for <linux-can@vger.kernel.org>; Tue, 20 May 2025 11:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747741555; cv=fail; b=uz/GN9tgF2kmZf4ldwkfGwQL4X5v8+IH4CUN8oaAMO0kLggZ4oD80EBQTF+zjSHdcqZ7ogXq0e2wRXFZu4Q3YANW4pS4z4k3YhmIqWwsl9uBS5kaM+0k+dnAK/Ta6Yu4WOWibzqNzDK/7zH3an6uAPXmQzK7K0/MwFXbFY406FM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747741555; c=relaxed/simple;
	bh=QLsmcRxb/wOYQLaPDnJa2xbLen+CUA2s9EKCzG80FBw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=RyLxs9e1cMqaFf+UtQng+61c4smQ6gUaDNVAJy24GFvcTJftFcG+T8x21OLauQS/V3NCh0czRRbc8ckwfW0UfNN9Ek94szsjAnAmYudTAHRyYuBqFJ08aUKUWknCPr/mJ3AM4oqIwSGACdN6oD+9GLn8NKS9+xdn/ZvoiIuO30s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=k5HHtQzH; arc=fail smtp.client-ip=40.107.105.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SyE9FHyHWZwUD0WDbg2ec8zH9p//p9GCUDxk31iN5MiW15LUeFDLQj+Ck00jzGc49E3T6Ug0W0aZD+LSOJIQeFXNNFSKOV2srTPIs8DY3Y1tbw8L2VQHUEksG/FzMFIuWxY+ZFOE87sHrhjEbGCfqO54BhjWHpfq+eStijhpNj4NHFDw9oTSR2E0M4nU4VJh+4M4LX1pbXqTzAmaruInlWS1q6sow6h9b/QuWkTvX49kwjftPqSSznRC6FubBpCGijD2B97JXyal8g5+pWolMJYTr56jg3sxtqNnZ5mEOgR98ucSDC63fb7bquiTeGJntmw9C+QFZr8X31NKipOKeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QLsmcRxb/wOYQLaPDnJa2xbLen+CUA2s9EKCzG80FBw=;
 b=ZIcpRCefW40T84LErk36Ai7MxO2p816tAobtmIpiOf8yZm/6ZbYKrCOUmLMfkQ0wp3W1ToaERbkMyW08+T3zvLWYmffp98M2Y0LtNhR+uCjX7EzCcME6AWOzuKw1Nis0i0rFsMiFjD4QEeUnMQhVzFWstiGqT8fx+FM71XaWYCU1jkIUyfSw8h4YIFv5Waj3iDW50cwLtj26zLhuGhQzTf+XWd/1kbqRj0q9SduQMVc1hiSqtSv8mL/ZraQm9oCNHr8xzxtOWMwfsJC3DoHMik3w7nFEfNZ8j12BgnKroyUK2ElBO2STTxl+ltpPS47hPPuT99Ilcf04DstvinrpMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QLsmcRxb/wOYQLaPDnJa2xbLen+CUA2s9EKCzG80FBw=;
 b=k5HHtQzHe2Htd3D45ZLB5Bcw6pLQF4a6fqEuUp2haeFNAJd+2mGQpP3EcOhLW4/viSUVNqoyxxmTH2E0UJGgWR/ij/z9I5mEtzN3g2MrJlHSTSJkfaBsOz4qwDCWiU1iOMLsF/V66Jy8pKfIC3K7CsdzyCpOi6ELK0v+rFt3S48=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AM9P193MB1652.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:3ed::14)
 by GV1P193MB2088.EURP193.PROD.OUTLOOK.COM (2603:10a6:150:2b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Tue, 20 May
 2025 11:45:48 +0000
Received: from AM9P193MB1652.EURP193.PROD.OUTLOOK.COM
 ([fe80::e973:de09:5df2:4e18]) by AM9P193MB1652.EURP193.PROD.OUTLOOK.COM
 ([fe80::e973:de09:5df2:4e18%7]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 11:45:48 +0000
From: Axel Forsman <axfo@kvaser.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, mailhol.vincent@wanadoo.fr
Subject: Re: [PATCH v2 0/3] can: kvaser_pciefd: Fix ISR race conditions
In-Reply-To: <20250519-magic-fat-cow-ba6fa0-mkl@pengutronix.de>
References: <20250513150939.61319-1-axfo@kvaser.com>
 <20250519-magic-fat-cow-ba6fa0-mkl@pengutronix.de>
Date: Tue, 20 May 2025 13:45:46 +0200
Message-ID: <87r00ja4k5.fsf@kvaser.com>
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0040.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::11) To AM9P193MB1652.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:3ed::14)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9P193MB1652:EE_|GV1P193MB2088:EE_
X-MS-Office365-Filtering-Correlation-Id: f4bf8d3f-52b5-469a-5a38-08dd9793dd41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xNbVjXOeSqe5zlkw9ZlxFGYyf2OAS9U4XTEn6kY78HfMQS7ob12WnFWsR+IF?=
 =?us-ascii?Q?PDjf8Deo+0Y4OlnXgD9IKesTPc8Y8XnelLDDWWr8vFQ9zKWgw1h3GxKW9Qgo?=
 =?us-ascii?Q?8nGJ5NOWKq1KTqyNGtZjyZYI/uTkMj0Li7fTw75pY57EKiqIbP92kB/9ecmT?=
 =?us-ascii?Q?IvsVZc+7bmSCaGtxqNYTfG+nuArEGDXs5jqOs6c45PZdGBlDiYbALlLvDBGd?=
 =?us-ascii?Q?eq9EjGfBfz5jhPR3C/5qjAkIpRXPxl2/g8LOWD97UfqI92SJVLMG5KvwpdK3?=
 =?us-ascii?Q?bXuPqsGPOEUKUkr6Dc23SdPUKKZONnUXSIkDyKqEp7hHuZoeP9lsYZv3ppTq?=
 =?us-ascii?Q?71t1ThybVkOSluaep0TrmVk1pbCyaRbchIJXPp7QreMc5ky6AJPXe1pOGldk?=
 =?us-ascii?Q?1Hb/JmUQaX4MwsX06kZlw6fyDxDaBYnRNmfull0tZ1yZ02Dv7QLX2SG3/dbS?=
 =?us-ascii?Q?PmSbWPJCnwHDIa4SELeoYaXX40wVPV1y3cL98B9qBOyk2ZxA+wtSQrPBKnH2?=
 =?us-ascii?Q?4495cLKVclnHz4ucWPFf+j3w50pn0vtZCfYqStcyn119Nd3WT3q2acVuGJux?=
 =?us-ascii?Q?cvaYb94yrBf/BVvJlxAXlPXiIgRJfAFJ5WqtTedcYeB+sGbSAtbWGOBVav+X?=
 =?us-ascii?Q?e+HfNLWoUWRXcAieZIzQmWgNuW8qirDn27JOIATHVzaJHdSlKDrjkxa0xF7n?=
 =?us-ascii?Q?xx0s1nMwwOqyFaaQq+D/U4LKunBatM8uwREUsMVs1nEHBzOMQORpxYuhIG48?=
 =?us-ascii?Q?BwBpmUqtSkkEOHlj9ehmVtV/0wAax9um/0fGJAFiJGV7xiWJAsJ3f4QJ/RW/?=
 =?us-ascii?Q?JQbwo4FpwW2E0KK+ozDaNAJwca3hXkoK9GTG56/XxLq4ezzt11jHOOdfQyEX?=
 =?us-ascii?Q?LP+1Jh6IT4a1b0oT+7YPcJcLnmiGYTmkjaGM1pl385PNv+iuxJ3MniRtZXKo?=
 =?us-ascii?Q?98G5VRDuzR7NQ625V1+jl3pdeq/3sFllVW+WM2Csny/CXGFnB0hrWHKBCdnn?=
 =?us-ascii?Q?jXGtxBGJkO/QxKuGBrixpPkis4tpFWJbYgFZYjH5Jadwwk3kBwxfY0VhJ4N9?=
 =?us-ascii?Q?jmyotedgDUVI2ZBs9jvbTeoSKrBJCWcS4b3MjKq1zy4rzyWv0uAlTTJMN5jp?=
 =?us-ascii?Q?AFOY0GK/2pRBkiAXCHHuwnCDn6Njxio+/28091USQLqzeEq5FC1Y3VkJubNi?=
 =?us-ascii?Q?eodm5ChZlZJ3ZTh5ElF+7xbu/jlLujahYN97aEk+Ip2HVqLhP8R3G1ELDtD7?=
 =?us-ascii?Q?ngPiwkJjToJujHy7AMD4pGvHWaGNVNdxp6PDxKKbqhz6Zu7BHGAtppbTTvOZ?=
 =?us-ascii?Q?V1wHHKK/Oa0zRHmJjI22va06mfuz07wDZ7c40j2f67LIs/8CSApGBG5BCNap?=
 =?us-ascii?Q?ZexvwjG9fVjf3GEmvBQQWlzOTvF8aiuG22ZhCjEaheg+xXtde3PPTqgFlcWi?=
 =?us-ascii?Q?deDGYlcWfVM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P193MB1652.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dD4oz6CMOmlRAhNUjoNcoWL+r93fJnRWxAd6fPe8mREnNbFQCXhBakVMGtnd?=
 =?us-ascii?Q?vdcFM5pTMojBR3YlfZ+ovrEI17ntBasfthyFJvhqCBEF9B+mZOXRokjJjegP?=
 =?us-ascii?Q?Kq/So2bO5CuwcK7zDYJls7pjNHX2cF39AtihI+dFL3p3tHKvhBx0fP0qC6dz?=
 =?us-ascii?Q?2nZHank0E7fSEDWVArlf12H3BRyapIQC9ctb+iltdLjnNyvJe08ukzh3Jqe1?=
 =?us-ascii?Q?tMkDJN86N60U7f3kt+U2rj8Q0QlDB7YnBq4gvN4+9VbZcJBCxecG/UNCQIBj?=
 =?us-ascii?Q?Y1IpKNaCtmHwbG9a1ovMdHUwBnx68CBBIb9KvErvp3Z0+wpNI64vv7CcgRLw?=
 =?us-ascii?Q?IWn2OPbxugY2UQNAkn7wd+I/DX5e47GP/0Yc8R215t2psEQiNmwJqfyMvRa8?=
 =?us-ascii?Q?odx8y7/qTcWe50Mi7MBcb3dr9FsRI8GfuAA8jO47s8yCw4WHgFHGfvvFqw1y?=
 =?us-ascii?Q?5Zr1AedYjPg53Facz0MFOcZCb4ZQrUzbNTwSS8cAZHhTyJYkH++t3IlHvWeW?=
 =?us-ascii?Q?HtNcfgx3+seHBls9BYbsrC1+TVMQX60yC2Qwp7YbDS2GqHBlKJ3qzcOXxsdV?=
 =?us-ascii?Q?BtQQLX46i79KnlTVrLMBKb3X8RcErDqggzjyN1Luo2VmXqA7Oh/+mPygKPrm?=
 =?us-ascii?Q?xrz1AsRu8eE+lc2xIravOED7NoIbiwhcBx/t/yBlQYtgLK6cWJ7ulB/+nEUC?=
 =?us-ascii?Q?WrGRnClSOisILirbY5Cj5VYeYkpuLjfcTlVB5MuDcp8N7fCyUD2r47Jx7i3L?=
 =?us-ascii?Q?4sTlBAr0hvpTxoBOOIcrib9acfMNUiXW9nTp684oJDNAZXzvq0ed+/3pyiW9?=
 =?us-ascii?Q?/KUzBGWECDhKt8Dew7Ym4M5TT0w1+4oHiX/NuYn4zzk849t59nXdyZ9EkzEq?=
 =?us-ascii?Q?IaKQS9daTP2/ZSmvXGD2f0peZVxKQDBRXQezXOhgcRdzydrGpohxM2kP/49/?=
 =?us-ascii?Q?AxoTEvw/GPTYwjpamo0isUzWvIYsb4C9ydYu+MzMYz2SvkNkeB4Fp0J2Bl4w?=
 =?us-ascii?Q?Dc7+6lVrzdxYh4uu/fG6NthCrfNAYEiFgBPJq4INWkEDFuM8gDNpKRgz52Cz?=
 =?us-ascii?Q?ZQ0i+uf/zc+YzZGZiTLQRMbSol7fo72oHvYrXRxaIQLOJFjaUHZqiTmaW2zW?=
 =?us-ascii?Q?mK2PkHjgZ4QAAia4J/97RKVprzoQWHaL2ghhxgp+s2fiBbbX8IlVXA/bH5GF?=
 =?us-ascii?Q?hHhD/NZNBZoNen5dasriLvEXHhhyXlTg7rBGEMw+sqXd8wUrxFoLRBStcurI?=
 =?us-ascii?Q?/LQ/ceBF73ajlAem5t7Dd4BI737Alo0KOXBdP9m5Hxzz/OYYJFw184zkwxtX?=
 =?us-ascii?Q?N94+WNZzk4oGssr9OZq/xN2nggly3z+dxN4Z18pu1/zsoJ3NGtWeBHPS5m62?=
 =?us-ascii?Q?zbM9zzdPSPhsvh8Ce43/pK7bGQLumYxcKEnxORKDIMxLOB1ypFwTEjhfVggG?=
 =?us-ascii?Q?BF/wX0czECIFSxHWPuXmwL/zRgltHRnqckEiU+kdQbnPF62AdG346qMtwzsO?=
 =?us-ascii?Q?n4YMV8SVxtLy7bTiz8KRReeqNpuuaaAblSCURMCOvd01yzIZgaq34//Fn1Q9?=
 =?us-ascii?Q?R5pUAwALF0vAHqsQjTQBDeg+8pwQXCYnd6Ilu5Lt?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4bf8d3f-52b5-469a-5a38-08dd9793dd41
X-MS-Exchange-CrossTenant-AuthSource: AM9P193MB1652.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 11:45:48.5423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lPKyvxMNDDO/XGyUsW3n1qcfreHs3QceJgAc2hCoOcmjeXUyCH3Mxrh2lWH1PUTw+xfaEPpmrcB+6Cm0IeoreA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P193MB2088

Marc Kleine-Budde <mkl@pengutronix.de> writes:

> On 13.05.2025 17:09:36, Axel Forsman wrote:
>> This patch series fixes a couple of race conditions in the
>> kvaser_pciefd driver surfaced by enabling MSI interrupts and the new
>> Kvaser PCIe 8xCAN.
>
> Which tree does this series apply to?

v6.14, but please see v3 of the series which I have rebased onto
linux-can/main.


/Axel

