Return-Path: <linux-can+bounces-7107-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Lr5H4rfuWnNOwIAu9opvQ
	(envelope-from <linux-can+bounces-7107-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 18 Mar 2026 00:11:06 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 016352B3D10
	for <lists+linux-can@lfdr.de>; Wed, 18 Mar 2026 00:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F84631C760A
	for <lists+linux-can@lfdr.de>; Tue, 17 Mar 2026 23:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5F83F6619;
	Tue, 17 Mar 2026 23:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mLc7Xza/"
X-Original-To: linux-can@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013056.outbound.protection.outlook.com [40.107.159.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F0E3F65FC;
	Tue, 17 Mar 2026 23:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773788748; cv=fail; b=LzeqEiPEZ+GodOkAux/u4G4M/lcrjSjr2qqNi5oniS4lnCAs9iLkfNkzoOa9/IC3Iz04oI6+0MP2PsqUKoHApTdAHD3aK/tQESQAQkms1tpi8+la5f7GmGq80N7uUjGeRtgOFIqcD1t6Wg/MH6uroEmjkB1l14o5fcqnBZfGkn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773788748; c=relaxed/simple;
	bh=9hi8hX4Vz31MYoONedVZoCi8UVxB9qFpLtVC5wGCJ6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tOUjTln6WcVLfeA6sSvstd+ypIs3gleBWPatAya7+Kte4sNM/YdoKGEcqHtBlQofkoZC/mPxqNC/93/znmUQO6k7XxZOTaDcvUVG0dmvfKUE7ZCoEOdIAuiXNmIm5DSSQTMkp7iY2x+zvbzoWa6hZdyPoItnrlzP40uHvepXSdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mLc7Xza/; arc=fail smtp.client-ip=40.107.159.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wrwVERnyGcpZazYCH/svInMCzhx2VsYlhlF9hqL+hbMdet1YRJ1iDNDJRptgt5x2pIf+NMNuGU3q53I88koCrXHB1SaUlDFR/us2y1xTdXW6PSxnxOk9vfpCfZIW+C5OaXgAzWs+gMQ2cqzD1q2n4A3Y0EpRgWc3Sw7VbjwKUnbk3YGiKI15HM8eJ2wv4YS8QKmFzmKAGR1A8kojm12vvoLZgpU8dhJmuO9MtXT6IaYGV0eWlGHTX0fBkG78L0TIVgpdWPTgQdOkzS5x/xquKkucZx7Re7jVM6kWO8y2O0QDZ5OBbnAdwsqwj4w1wsBVO3Ajl7GMb55fS08W4CfzKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RNymz2ero7En3sIVyesf+8sVX3P7/u+K2B58KDwDJQc=;
 b=a4cSHfock3zNTMO4Old4gUELrEJIB1fY5QpeQVoouXBy7z/B7etJYCUljzXZpvLRdpvGRMJPAciD4QNIIANgsiwT5fpygkzLGkN+PDDYFgK0kxyDOU7MjN0PhVFHwNpTCc4GnFPWwMWKk70n8a0/9hdg39dElgLp9MPa64u7UOdBBZwZA/H3LYRP7HNHiJpdOgrKIr8ouKOjP53iwQD3jTuZ7RGQkCtlNfDocV7KQQkyxpkk5718nF8sOR9sGex0WR3SdVR6OOXcCFe5355HR156jDT3Y5wWHVyw3XTn66RQhKqqdfv1uDuUgpqHKqh3WeRkHcMVTdiyD4VkTnmRqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNymz2ero7En3sIVyesf+8sVX3P7/u+K2B58KDwDJQc=;
 b=mLc7Xza/HddSPaOTA0XlOwhbidSGdfAsp7mhtnpMKPSXi3FkaimguTwTlURus9devYgpppQrUoY4c9dVDIfVuoS3vsML+nXsgzinuz2BsDk7+ttXMxxwb0tWmeTN7OEMxX32ZfrqJlPqfuTrbMIGYZ932nk0vMJgJuoogLcbtgt/9SRcBjWcZZx+iDzirDlRVyj94SWTDYE637mqCqW4NFp1m8egrfE1k6c4OO++yYP+04gdttcZpaDHaIdCmWdx9WwJkwQ0hq9bgXskIsWyr3f9tV3XmFgmGjyGATfTKhAl3h0VYRkHi/s82afbOo0YNy+9kEMIT+U2Y2P74VlXlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by VI0PR04MB12032.eurprd04.prod.outlook.com (2603:10a6:800:311::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.27; Tue, 17 Mar
 2026 23:05:24 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9700.022; Tue, 17 Mar 2026
 23:05:21 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-can@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	spacemit@lists.linux.dev,
	UNGLinuxDriver@microchip.com,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	=?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v4 phy-next 05/24] phy: add <linux/pm_runtime.h> where missing
Date: Wed, 18 Mar 2026 01:04:41 +0200
Message-ID: <20260317230500.2056077-6-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317230500.2056077-1-vladimir.oltean@nxp.com>
References: <20260317230500.2056077-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR08CA0209.eurprd08.prod.outlook.com
 (2603:10a6:802:15::18) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|VI0PR04MB12032:EE_
X-MS-Office365-Filtering-Correlation-Id: bb6aa55f-4c92-46d7-273e-08de8479a9e5
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|376014|19092799006|7416014|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 yfY+z3uaxNxJ2/aDGbGKBTManrogTUXbZiO/DyRWP5mRE9tdGRgAFddwP2Az3g3sIqaZLu8n1iyCOKz9hqEZCk4UJKGyWJVnltHI0PkgutdgMkWh3kxzB7P5kw3595YdsevNJnZU+zvt3BN5UOJDLBtkbet+lgA1QgTAi041Si4/26Q5gX10JU8hOuUs4UDYoYn2esOKhSQOSVgwMHId2hnwlbv/9RtSppMMBQkD1mZkDvqCBSr9J3fUlVw6oxSeHkoRcHCQjlrDY2rag1SZlKnMBCFJCok7catuIyCdS0qWWWNRHXQQOoBaeBzacNGSxYqMWOYGOsXGaGIKs1nbZjrxBoe4t4nJTqZwE5UcjvjsJ/sjevj+wwan+OSr9vSEhcylT0A7SbPhdq549PPMmZDzG7kLtaJiudaYbLpDRH48kkQjZoVwIMJnwEjSQAFFJsJbaXpoH75CwR6q8Eqe1hc8P8DECCCT/iHmMw/43aPKSDUXlhj4bE3stz/9LviunHFGjsDqSOtzslhFQ3X8DAOQTs+usH/iKyDS7yeXpobUp7DiZZBuBgiNwUYilC00OWDz/Aux4Mn4wqu6lu0n+TdPda81jV+owxqcuiT1DzOoaB6gz6hTmV7xVK9fh2ALOeyCWhOsPVumGmHzIMYaHguxsRC6JOKQF8bCh4y+gTUxBWlQujuXlXInjE2vrCAS71A+X7IjX+mSEDHeisMP402glhSZP2wYdoDXdyiBB9k=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(19092799006)(7416014)(366016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?cktFSVJMZkMvUDJpUnpER3cxeGM3N1FpUlNRd1VMWFVGaFpNNTU0bVNmeFNC?=
 =?utf-8?B?YU9nRFZNQndZc0ZWMGZveVFZMk1EZVFQaFlobmQ5WVpOczgvTWIwc3VRNlJE?=
 =?utf-8?B?ZFpEeGNkM2hER2pLS2l5cDZKSWpvK3NKWjhUZ3RxMW5lSTIwaWErZGFkb1BC?=
 =?utf-8?B?N2pGSW1acXBtVUttcllaSThKU1RrSDc3d1MxM0U2ekUxYUEveFBlLzhkY1cx?=
 =?utf-8?B?a1ZtaXd0Nm5CQ3QvRnNQdndnT2s0WEQ3Q0hiM1NDQlRpOHExUTVXZzhBZkEz?=
 =?utf-8?B?YmpoN0wrTjZhSnFmK2VOWEo1TlMwbWN5bm1uMkhMZU5mdGZnaGpJSFlQRU1J?=
 =?utf-8?B?UE84UzRtRkRCeXdNdGpYUjVtV3RlTGVxTlgwYkYzV1NvTVpsdm5PME42aFZF?=
 =?utf-8?B?VXo1Si80TTdFK0Q0VVV1TlNQeUdKVmxDWU5BMVM1bDV0VXRycjFqS0xaQzdQ?=
 =?utf-8?B?dDhnVjdNUm1kOGtiOXZjakcxdXNDNmF0NWVrSGIzSkNOMytibDM2VWRaY2o4?=
 =?utf-8?B?cHgxMzhFNEtjV3hNaGJIUE9zVjdIdW5WYVdoQnFyYjE5eE5CQXZ4RDIrQ0xO?=
 =?utf-8?B?eXZyb0hRaUJHaFFhdU1tSCtIRTdWMmpiaHVKcW95Yjg2bktFMXZFZmpPQkJW?=
 =?utf-8?B?bTVFYlVWN3JRV1NLYXpCT29UZ1NWa3lvUHZKVnUwbVdKUHVFeXBhMEJqZ0Rv?=
 =?utf-8?B?cnczNHluc1c5VHRCWnZuM1hHWnVhZzFiMGZuRTBLbVNmeE1oRk5LN0wrSjVw?=
 =?utf-8?B?Zmg3cG5iWUV6SlBmbE04VlJmYmtwaXU0MTJaQUZ5STNYZnhYaXJFbGl3SFcz?=
 =?utf-8?B?M1dtSkVaQldxQ1dWdUc0MVJ6WDFuUk1WVmZuM2xBYmpONnk0WEl3cGd4RDJY?=
 =?utf-8?B?bStHN2p0dTd0eENZc3BzTWxWWXVYSTNzeXBXZVJTL29mUDMrSUlBeWtsTi9X?=
 =?utf-8?B?V3JTNHZmUmhOSHBQZ1VNNVAzN3R1WjZjQytEUVdIV3R3aG5Qc2Y3TktScFpZ?=
 =?utf-8?B?V1c5ZlZ5NzNQNVdwdUdHcDJIaVFFWTRobGZsdTZJT1E4eERwTE1lUi9IeG5N?=
 =?utf-8?B?QU4zZ0tZVW5JVGoyV1BEZlEydG1FVDBOMFlqbklOcC9EV1ByQWVLWGVsV1lN?=
 =?utf-8?B?WmxydXdmV2FGcUxKYm16SkhFVkFuYzdUR2FUR2JYZjBPZngwaEpiV3NJRUlD?=
 =?utf-8?B?ZGlaSFR3WGpNcDJ4YmFNM2FnVENxVDJ1TFQxbjJvelIwRE9nZDJPY3A0c0FZ?=
 =?utf-8?B?YUxPUDhWd2FZNHZjRmFFZTJQMkRMSFdTY1pHUEFtZHUrNzAxYk42U3JYNU10?=
 =?utf-8?B?QmxYY0loanp4bUgwaUMzQmVGUE5vWFUyMXVlYTg3KzROTERqM2diNWx1MURJ?=
 =?utf-8?B?K3p1M2V4L2FqOXBmWlhWc0N3N3RZU0tTSnYxYlpXWUxBRXl4ZCswL25zSVNV?=
 =?utf-8?B?M1ZsTFp6NjcxSDVFN0NjQUI2cEx3ZXlUbzVaU0QwU0JZWE5iM3p4THc5MkpB?=
 =?utf-8?B?eDJIK2k0ZUdGZURFQnBSaGtNVTUyWmxzOWlYZkNwRjhmR1FFQjNMaEEzeEJP?=
 =?utf-8?B?bHI0aHVpVUpMUWNVTTR3RnBFRjQ4V0pkVThmM0pFQXdzQWpYYVhVQ01hS3RZ?=
 =?utf-8?B?ZEVpVldVMUVua21HbmFBSVlMR3Z5QlhIQ2VUdUtFZk1HakJBcFAweC9WNjlB?=
 =?utf-8?B?eU4xaExLdFdXOTNGbDYyZkU0T0I0U2hqS2NSVnR2ZDdCMW53R0JXKzkrMlJN?=
 =?utf-8?B?SXNNdkNMOEp0YUlCdzFiQkpZRXpMSzQ3aVRpSGVTNGRnRi82YTlkVWJnbmVP?=
 =?utf-8?B?aGtJUmZJTDdKUk9lWHJBblRob3lDYjNiaVBhY0RyQzF0aVhKSTdTWk9JRGJF?=
 =?utf-8?B?eWJQZ2Jlc002Ui8wZzdaMVFuVndVVEtRU2tFcDRRQk8reVRwdW56VE9mU1M0?=
 =?utf-8?B?QUJsSkxhSmRPS1FpcmZ6c3BJcHk4c2tzZVFQSVNTa3haZG84dVE1OGNmVlA2?=
 =?utf-8?B?V3ZBZkljaW5lN09MTVI5VzhEcWpGSUJHbENBajJLTVJTREJSSHp4TTFUUldC?=
 =?utf-8?B?a2FXWjVxb3cvemJCMlZDTzFWTUU4Yyt3RkVUVDBHMXlFQWI0YXkzSXNnVzdm?=
 =?utf-8?B?T3BiaDRCbHltbG1hMXBtTlZ6YmRQaEJ4N2RiOFl4eGlndnhBL0wrSzlLeWRp?=
 =?utf-8?B?cU9sMTRxVmM1Kzk2MHl3a3g5RnExRTFzcW1DNDhQRm4zV1NvK3p5TWU0VGx4?=
 =?utf-8?B?MzNuTjJIM3hrMkR4OUMzYkQxTDJ0SVdqSUJIejNQcUdNNDFieVVkVElINCt5?=
 =?utf-8?B?ZGFyL3RqZGxhT2gvWEQrUzFvTlNVcHZ2cFlNTDZNaXl1Z1Z0eG93ZTR4c0FE?=
 =?utf-8?Q?/r7R4AXLuYdTIiXmAfGFeZlxxmwE0fjEHLxADOSBaH9Dc?=
X-MS-Exchange-AntiSpam-MessageData-1: vcbr5AmI2Nt8bl1dHP/cMq6jrq2jQcugNKk=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb6aa55f-4c92-46d7-273e-08de8479a9e5
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 23:05:21.1223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wh1uR0JS2Kn4AOmMNkynjPUDm5iiukA6M6SvkKuM+E9bfytiWpwWtmruX/3NMM3u5wokrts5ApSGQtr3/Y0CGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12032
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7107-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org,lists.linux.dev,microchip.com,glider.be,gmail.com,sntech.de];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can,renesas];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[glider.be:email,sntech.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:email,nxp.com:mid,linaro.org:email]
X-Rspamd-Queue-Id: 016352B3D10
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

It appears that the phy-mapphone-mdm6600, phy-qcom-snps-femto-v2,
phy-rcar-gen3-pcie, r8a779f0-ether-serdes and phy-rockchip-typec drivers
call runtime PM operations without including the proper header.

This was provided by <linux/phy/phy.h> but no function exported by this
header directly needs it. So we need to drop it from there, and fix up
drivers that used to depend on that.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be> # renesas
Reviewed-by: André Draszik <andre.draszik@linaro.org> # google
---
Cc: Peter Griffin <peter.griffin@linaro.org>
Cc: "André Draszik" <andre.draszik@linaro.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>

v2->v4: none
v1->v2: collect tags
---
 drivers/phy/motorola/phy-mapphone-mdm6600.c    | 1 +
 drivers/phy/phy-google-usb.c                   | 1 +
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c      | 1 +
 drivers/phy/qualcomm/phy-qcom-qmp-usb-legacy.c | 1 +
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c        | 1 +
 drivers/phy/qualcomm/phy-qcom-qmp-usbc.c       | 1 +
 drivers/phy/qualcomm/phy-qcom-qusb2.c          | 1 +
 drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c  | 1 +
 drivers/phy/renesas/phy-rcar-gen3-pcie.c       | 1 +
 drivers/phy/renesas/r8a779f0-ether-serdes.c    | 1 +
 drivers/phy/rockchip/phy-rockchip-typec.c      | 1 +
 drivers/phy/ti/phy-tusb1210.c                  | 1 +
 12 files changed, 12 insertions(+)

diff --git a/drivers/phy/motorola/phy-mapphone-mdm6600.c b/drivers/phy/motorola/phy-mapphone-mdm6600.c
index fd0e0cd1c1cf..ce1dad8c438d 100644
--- a/drivers/phy/motorola/phy-mapphone-mdm6600.c
+++ b/drivers/phy/motorola/phy-mapphone-mdm6600.c
@@ -17,6 +17,7 @@
 #include <linux/of_platform.h>
 #include <linux/phy/phy.h>
 #include <linux/pinctrl/consumer.h>
+#include <linux/pm_runtime.h>
 
 #define PHY_MDM6600_PHY_DELAY_MS	4000	/* PHY enable 2.2s to 3.5s */
 #define PHY_MDM6600_ENABLED_DELAY_MS	8000	/* 8s more total for MDM6600 */
diff --git a/drivers/phy/phy-google-usb.c b/drivers/phy/phy-google-usb.c
index ab20bc20f19e..48cfa2e28347 100644
--- a/drivers/phy/phy-google-usb.c
+++ b/drivers/phy/phy-google-usb.c
@@ -16,6 +16,7 @@
 #include <linux/of.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
 #include <linux/usb/typec_mux.h>
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index 93f1aa10d400..b9ea7d058e93 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -16,6 +16,7 @@
 #include <linux/of_graph.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usb-legacy.c b/drivers/phy/qualcomm/phy-qcom-qmp-usb-legacy.c
index 8bf951b0490c..2bd5862c5ba8 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usb-legacy.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usb-legacy.c
@@ -16,6 +16,7 @@
 #include <linux/of_address.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
index b0ecd5ba2464..d88b8a415e85 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
@@ -15,6 +15,7 @@
 #include <linux/of_address.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
index c342479a3798..f62e1f6ecc07 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
@@ -16,6 +16,7 @@
 #include <linux/of_address.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
diff --git a/drivers/phy/qualcomm/phy-qcom-qusb2.c b/drivers/phy/qualcomm/phy-qcom-qusb2.c
index eb93015be841..191040f6d60f 100644
--- a/drivers/phy/qualcomm/phy-qcom-qusb2.c
+++ b/drivers/phy/qualcomm/phy-qcom-qusb2.c
@@ -14,6 +14,7 @@
 #include <linux/of.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
diff --git a/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c b/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
index eb0b0f61d98e..8915fa250e81 100644
--- a/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
+++ b/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
@@ -12,6 +12,7 @@
 #include <linux/of.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
diff --git a/drivers/phy/renesas/phy-rcar-gen3-pcie.c b/drivers/phy/renesas/phy-rcar-gen3-pcie.c
index c0e5a4ac82de..3e2cf59ad480 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-pcie.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-pcie.c
@@ -11,6 +11,7 @@
 #include <linux/of.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/spinlock.h>
 
 #define PHY_CTRL		0x4000		/* R8A77980 only */
diff --git a/drivers/phy/renesas/r8a779f0-ether-serdes.c b/drivers/phy/renesas/r8a779f0-ether-serdes.c
index 8a6b6f366fe3..c34427ac4fdb 100644
--- a/drivers/phy/renesas/r8a779f0-ether-serdes.c
+++ b/drivers/phy/renesas/r8a779f0-ether-serdes.c
@@ -12,6 +12,7 @@
 #include <linux/phy.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/reset.h>
 
 #define R8A779F0_ETH_SERDES_NUM			3
diff --git a/drivers/phy/rockchip/phy-rockchip-typec.c b/drivers/phy/rockchip/phy-rockchip-typec.c
index d9701b6106d5..0a318ccf1bbf 100644
--- a/drivers/phy/rockchip/phy-rockchip-typec.c
+++ b/drivers/phy/rockchip/phy-rockchip-typec.c
@@ -49,6 +49,7 @@
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
 
diff --git a/drivers/phy/ti/phy-tusb1210.c b/drivers/phy/ti/phy-tusb1210.c
index c3ae9d7948d7..b7080403e649 100644
--- a/drivers/phy/ti/phy-tusb1210.c
+++ b/drivers/phy/ti/phy-tusb1210.c
@@ -13,6 +13,7 @@
 #include <linux/ulpi/regs.h>
 #include <linux/gpio/consumer.h>
 #include <linux/phy/ulpi_phy.h>
+#include <linux/pm_runtime.h>
 #include <linux/power_supply.h>
 #include <linux/property.h>
 #include <linux/workqueue.h>
-- 
2.43.0


