Return-Path: <linux-can+bounces-6949-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMY3EZR7qWkg8gAAu9opvQ
	(envelope-from <linux-can+bounces-6949-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 05 Mar 2026 13:48:20 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E66EB2120B0
	for <lists+linux-can@lfdr.de>; Thu, 05 Mar 2026 13:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C591A3078E84
	for <lists+linux-can@lfdr.de>; Thu,  5 Mar 2026 12:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DD639E18E;
	Thu,  5 Mar 2026 12:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="U/MJw51t"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010050.outbound.protection.outlook.com [52.101.69.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2150737FF60;
	Thu,  5 Mar 2026 12:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772714844; cv=fail; b=Ot8cL35fEHePv/fjvzSq4QaPrJmoZS6IkxnUOJ+glOhZO4qTKCeruxYPYmpLr4CFsDyDHJr+6nSMAJfv0Oy/5yulUyyWZFJypR12TrVWBkq7VtlMxjnTlzMzuyqFV+ANmcs7lulSI/k+Xgf8Ry3VysiB120HBaIJgfSmrz7wYYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772714844; c=relaxed/simple;
	bh=nJKixJFaGQlHaOlt57JjUrizv6qA1IEFVvDBnjdGG4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qXRIJ6UBS8lATDfIvtjDuK3LONMyTYWZgmIqZgcTxOvzk699aLR32/UbdnzlYgG7nYpd3qNEtYKZHw3oTnM0bVpjNT3qRHtKl298X7QO3O7PBW579iZQhg+VlAw9yfh5FP0TOl3kag9JmOBSQdrnVTt08QQOepgSxQoOZLx7X7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=U/MJw51t; arc=fail smtp.client-ip=52.101.69.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lBdActs3csMpNWQYKfEa0VU6JuRPbGcCUOPe920az6laTU6Qn5z+ObbFd2mhfVuInAf97EtccPHUmCc2Kv2ILs9El2PknmUYG0pxmMlGwcHl28okXAhML02/068BreZ64lxe7rdThCDRe4sHOFJxlOAEBGf8aYy2KCZydESo3diZWwQL8LaS4g2o8yFVPeqEI0dM2MD9sz0r7ehwkLLy/Ck4eRA+9f4hwdkQdke8wS0ogCVgwFZ3IU5yTQEawY6M9xIKWozYZDlf8qN7MsseGy/rtMjYjTEc/SXCuQgqNOzYdjGszCkGAmspdW3F+xK5QgzW/UYSxPnGWpXouP0XuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tl5cbVzjBQ25zWuP9qsr5NvkC2I952uIqY7xV4+c1Dc=;
 b=I0dxL+OJkf2yW60ibvvHFbAxZvveKO6+oW715cCPb2Yttkd8qvER/eLkqMJHHCVcDQTBj4ncACuJca/XO6OPWoAUYwyOnDIiQw3O2kErUazVFPLNKMXKe9Kko89abG+7ayBrO0aFgu5joBxBYNiDk+6ZTuKqIyLFsEjfXDgR0TR6NkqUgVhHx9xdMsSxjcdSah+itw8ZLMKKLANSvIb82K8D+wEKq7OYNRUeJr6l4NCLSgPfM+PzAo7424jizthak5oQMUsBL22+vNB2SIraLKwtSeS9EbWcMsmpn0NoXlfjuT42du8kou4lEUH8swnvVH2B/jXdprp7HQ/NBB1Mmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tl5cbVzjBQ25zWuP9qsr5NvkC2I952uIqY7xV4+c1Dc=;
 b=U/MJw51t4U/3/KqzGgIRzT/DdjnPYdQCQAJSofl1zxeRh4maIAGC4Xdq9ya488vwZQLM/5QBB3X45gH2faVh0pt75+CwbxbWF8DHN6Zjemv4MfRkZtXPHcl7fnE1Ek2BNOeA1o2+XEmolAdxL3N+Mxf8dnx57JY7AfUJF14hYQYb29/tnJJn/xPPIS5MqDRx+YUU824u1sxFBVt9lUox3D7NC/AKUhfVLWpe1OEEX3dLQ4kz1Ol4P0AFl0oEs4QevYZImCKSbKA0/xRYT+TJZLjrgdEOD7xtzR5D76r9WOi5ik6jpcj+tlJLoZyfB6mgXalp8SSbI0FIL7W3qiVYRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by GVXPR04MB9829.eurprd04.prod.outlook.com (2603:10a6:150:116::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Thu, 5 Mar
 2026 12:47:15 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9678.016; Thu, 5 Mar 2026
 12:47:15 +0000
Date: Thu, 5 Mar 2026 14:47:10 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Linus Walleij <linusw@kernel.org>
Cc: linux-phy@lists.infradead.org, Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-can@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, spacemit@lists.linux.dev,
	UNGLinuxDriver@microchip.com,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH phy-next 18/22] pinctrl: tegra-xusb: include PHY provider
 header
Message-ID: <20260305124710.pk5sah3wz3acyvmz@skbuf>
References: <20260304175735.2660419-1-vladimir.oltean@nxp.com>
 <20260304175735.2660419-19-vladimir.oltean@nxp.com>
 <CAD++jLnCtu20rXcg7sMVLBi24EohscJoz0kN46XJaKPJt00O2w@mail.gmail.com>
 <CAD++jL=m+cEcqy1i2H0tdeBa3Sy76myGAR9HdBqrT4u-x5v50A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD++jL=m+cEcqy1i2H0tdeBa3Sy76myGAR9HdBqrT4u-x5v50A@mail.gmail.com>
X-ClientProxiedBy: VI1PR09CA0133.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::17) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|GVXPR04MB9829:EE_
X-MS-Office365-Filtering-Correlation-Id: b0425645-c39b-423b-35ab-08de7ab553f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|376014|10070799003|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	s2/LrZ7A5mDZzEi6zfk1p/04b0qQsDyxyOhGDEfPg4AJrXwrZG/KCrkKG/wnma8eAJNFKmQSyUNoovRSEH7FLLhQKRCjUxoxiMit3ODgfsZu3ZNXOVeK4okGy3SgGwZ7NvSng+AUdIAbp5gscShUFH4nqOnjn8ODurLQD8uU/oTZl/hsg0O9oG3/Ne1BDAbU387OsncbjA1X8IRGKAqFaxg/IigwZBnbUC65xExusogHQhfBrk2vzfRZw7tx2/iinfbul7lIEs7fpAVPTQLipUVQPUN2u2NGRQM/mhnmIt0YPqVU0XxEaCDhTlX5KwBFf2+KhG/Ue5cm3DdN2NJVEhuRZFz6XOH5xPK8x/G3dKUwNqf+DcezthFJgsXdD9SeafnnkaRPDI0xz5N/td3s4extarRjxfSezlN5kFNq4UFSVl7FZ3RU90A3TqgwN3xZnSnyZN6xyFDCmZRMsOAhGHt26E+xTFDLfxC9Qz7dsCTcr5I36enjD7d+5lRhwyjkM2qWF+sJ2Z0ov6bRje9OaymcJi40H6/dHR3j2vT5zNBtKNl3t8iIXnEVjNOvSO8aCuzLoiCBW8LMJwqL4vxhyxJuca6lhDyTa7qiKrjYMFSL56r20gPC7hlylUGBZfLIPXF0o20VNBCJwWywmqxg34+M7h3UqbSQkSRUFUvb2rFGZzOEp9EqvW46PYm0aETTCW8qigV82bVnKWV8Qa/urxaYijMyztfPFfFWF6s+KrY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(376014)(10070799003)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T2hNT1p5K1dzODFXN0ZGM1BBM2xQNC9aUVRDZXhZTEhyYWpmTkdVeVhoc1dB?=
 =?utf-8?B?dXpYUWJyeFVvTm1ReG01NGRMRjZnK2RaNWJxalBuRWUvaVUvTlNrWWZNb1BI?=
 =?utf-8?B?REtVWTBBSFZtVTFFK2RaZUpxanZkNXNBYy9sTXZrcWJKVFliV1ZFVUxMaWRD?=
 =?utf-8?B?M1lqMDlkWFZFUis3SGIvUjJWbW1lbm4xYkxFVWtaSGdXM21pdlRIbnNYMVpm?=
 =?utf-8?B?b0Z4RlhDeDRFazRzU3MrcEZGcG4vc0g3ZWp0UnlPeE15VXg4bFJiWnFkMmM0?=
 =?utf-8?B?RWwxZG1zT2FReGllb3JsUmgzSzJRclpIcVJ5aHAxVlE0SnhuOTV1OU51RmdF?=
 =?utf-8?B?Um9XYWtCYjIyaElVUytwdjBjUDJYSkVvVUlDWW5ZYUZKMjFOUGpQdzBVdWky?=
 =?utf-8?B?MWhuSlhINENxcXRrK2N4bW1XUURsUGlZUnA4RTkxRnkrNzlGL3J6dkdwYjB2?=
 =?utf-8?B?Z1JWOWhmekpxOUVyZFBuUHcySWVBb3pJcEozdnBiOXVKOGllNUExRm96cTNW?=
 =?utf-8?B?QTM4dGJvVGNGcU55QWFtcHA5Qkpqc3dwZzk1TVZpbjEzYzVPUndJM3lXSWRQ?=
 =?utf-8?B?WExTU0ZiL2YrMmZPZGhiN1hHVktwYUt2RnhvQmRGanNhWlBtR0xZYTN3SWdy?=
 =?utf-8?B?eVZxQXVVdExaS0xkYm1jdTJGcUVlYmh5WGg1NE1vaUp1dW1sOEZHbVVUaXc1?=
 =?utf-8?B?U3d6eVIrOEx0MElHZlQyQnVNNUpqUFhaNUhKN1N2N2xyWGRvR2lUeVJEMjQr?=
 =?utf-8?B?WVpUc2VoamlTZkpmWTNqUFVvdW9BMGVTVXoyMkFmRUMzMlkxa2tpSDBIa2sx?=
 =?utf-8?B?STF1RlJsN1pRMW1ERHhkWHUwRmlPZjNzOUhaRHE1VnFnRzF2UDB6MlhSZ3Vs?=
 =?utf-8?B?RTMyTDhvUytCK3A5SHpUZ0IydVJ1akpPZTRGT1FiTWJEWFU2bnVaRy91NnU1?=
 =?utf-8?B?L1pLMXI0MGJvTkxpMDZ0RWlnUnAwQWZ5T08wZVM2QUNhMFlPU20vc3ZOaVpw?=
 =?utf-8?B?VmthQitNTjl5NVhJRlhuNlMxODBDNkxPMFZRVTBwbnRnSWVYT3JBS2s1L0la?=
 =?utf-8?B?Y0dFWGNLL1ljM3JPRnJhOGFUVlptUDVpMkZnbXlPa0hPWUxMZlpjclhUbjRX?=
 =?utf-8?B?cXJERW9uRGNLMXFPTFBVMS9TMk9sZmVtTnFYR00vZ29QR3BRaksranpsMGxO?=
 =?utf-8?B?SlZyL056ODNLbmlKcWVHUFc2cWtGdDZMQVlYUjNQV0Q1aXlMNXNkcXRNVk1T?=
 =?utf-8?B?WkZUZG5IMW9uTXFIV3lPdzEzRW4weEg1NTlEbXF3QWhrYkJqYjVrSUlGQlVw?=
 =?utf-8?B?S1cwN0V0eXFONWtCd1lueXR0VGwyNWtsSFFmS2tzRi9ITXhGQ3VQQzNQcVlx?=
 =?utf-8?B?R3pRRUVoMFBWV283WTVCU3pLYmllVkxhaXpLYTM0QkxFeTFVV2NQSVk4dmk1?=
 =?utf-8?B?czVVNjRhMEtSbzZQUm55Z3RzeGJyOURRVHVhdVpOSWN0eW9wS1RTdG1YanRK?=
 =?utf-8?B?Nmx1QzFzU2xGNkdMaFNRMDhPSFh2MldmbWNheFBiaVRtZjY4M3Jpcks0MWlK?=
 =?utf-8?B?ZzB4OGloUUhWMnViU3BKdVp1UzJWWHhBanhBUWgwUnUrQUhVVDQrTTRhWXUv?=
 =?utf-8?B?WmxzQTZPM0pOQVpOVldCN2FiNktSUE4wcFRQTXdtbTkxME1tOFJyaEZGb29Z?=
 =?utf-8?B?Z3Q5WU5wd3JSenBVYm10Tm8weGRlS25wWXZ5WFBLaWZOZjJZd1BoSXpGcEw2?=
 =?utf-8?B?VitQcmsrLy9talBnZC8rRk5SK2IySEVEUUNSbnB5amg0Yk5aZ3ROQUxRU1Jp?=
 =?utf-8?B?V3RHMjU0ZEJjeW5yaHIvTTJ6RDUwVWhJR05hUEx2QmVZSTJUbHVxWDU2UVRE?=
 =?utf-8?B?NjZkazdxdDZPNUhuanBvbkFHWlM2bk05VEhkYUtzSndyWGRkcTdmUDdoOFA1?=
 =?utf-8?B?Y2IxbzI2azVVc013RTdtcHBVeXhSZDJqbWpPUGJzMjFLelFWTUVhVnZzdkZz?=
 =?utf-8?B?bE1ZcUYwK3JCemppZ081M3kxTW5VZnRQL0Z5ais0eGlqanRhSHduOStnM1Ri?=
 =?utf-8?B?YWNmYjNycm1KZEcwNUxhTGEvTFZpZFAzSlZ0eVpTTXhsVHNFc1hZbG15bWFH?=
 =?utf-8?B?eDQ5bnFVaVJhUTNHWENHRzQrd0FCaTRFOHdtOWJDZnF2azFFNDhKSnRFbWRI?=
 =?utf-8?B?d0hGdmFCM1ViVUg5YXZMbWtoNk9xTStmSjBIaEdNQ3ZEWXZkQXo0bnVjbnov?=
 =?utf-8?B?V0Vwd1A2b2h6bUpNWDZpUmhqZFpVWkJZSDViRmVxZjdLTDhuakJEbEhwWkhp?=
 =?utf-8?B?ZUJkUkN5WCtXb2wyNUlKS0M3YWQ3ZDh4WEI2TDNDNU5hN25qa3ZDOENsZUJj?=
 =?utf-8?Q?23zGrSobP9rRG48uQ6s4aqv7nt9iAMHoJW8JC8nfvLS2O?=
X-MS-Exchange-AntiSpam-MessageData-1: UK65I6fS3Xoj3XOYyYu166ZjCh3OtG1plUs=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0425645-c39b-423b-35ab-08de7ab553f4
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 12:47:15.0513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aoj63ml7r909s4dyCtDrdiGKCwhYxCHgdMjekDfqw+vhi3uk93RIwb1mNeMyGnYVXtQLR2Wrd2X6uemdxAjE3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9829
X-Rspamd-Queue-Id: E66EB2120B0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6949-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FREEMAIL_CC(0.00)[lists.infradead.org,kernel.org,linaro.org,lists.freedesktop.org,vger.kernel.org,lists.linux.dev,microchip.com,gmail.com,nvidia.com,oss.qualcomm.com];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-can];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 01:44:42PM +0100, Linus Walleij wrote:
> On Thu, Mar 5, 2026 at 1:43 PM Linus Walleij <linusw@kernel.org> wrote:
> > On Wed, Mar 4, 2026 at 7:00 PM Vladimir Oltean <vladimir.oltean@nxp.com> wrote:
> >
> > > The tegra-xusb pinctrl driver is also a PHY provider (calls
> > > devm_phy_create() for PCIe and SATA). However, according to Vinod Koul,
> > > having PHY provider drivers outside of drivers/phy/ is discouraged,
> > > although it would be difficult for me to address a proper movement here.
> > >
> > > Include the private provider API header from drivers/phy/, but leave a
> > > FIXME in place. It will have to be moved, eventually.
> > >
> > > Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> >
> > Fair enough, is this a regression so I should merge it for fixes
> > or just a nonurgent fix that I can apply for next?
> 
> Sorry I realized it needs to go in with the series.
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> 
> You can take it from here.

Yeah, the plan is explained in the cover letter. No regression intended
if it's taken through the same tree as the header split itself.

Thanks for the review.

