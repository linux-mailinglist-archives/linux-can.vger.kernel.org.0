Return-Path: <linux-can+bounces-7676-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LflCkbVDWrW3wUAu9opvQ
	(envelope-from <linux-can+bounces-7676-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 20 May 2026 17:37:42 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E9165910AB
	for <lists+linux-can@lfdr.de>; Wed, 20 May 2026 17:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A02333CDE10
	for <lists+linux-can@lfdr.de>; Wed, 20 May 2026 15:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB973EFFDB;
	Wed, 20 May 2026 15:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OQRypaQM"
X-Original-To: linux-can@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013064.outbound.protection.outlook.com [40.107.162.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6763E9C1F;
	Wed, 20 May 2026 15:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779290424; cv=fail; b=JSfT5aRb8i2kuQe7jhohE8LL5frip2aLLxgGudYRmFi/7A5RnsFhm/uivRfsJUOh/IyMW4I9Xzj2ngEBpxcEYeVqE3x2MRWrDMb57Rr+JwzWTo5tQQuw11APjVTAoIA31EiBHrvXls6CG2ofyU568LYHXdUSKFJEIurDH8IJ6uI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779290424; c=relaxed/simple;
	bh=l4/qnkjd6bZg1XEV1PAL87hixaCbAhx6wxIELiuPUQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Xc2dTqiG/FWcXIvdz9g5ltHOmtxd/n8caf9XehfMymatDc+FC63rbUIwphY3wMf2RpO4qBCC1KwIfiVpX5NfNGWJdWfCJzY4+MPzrWUOcTOog9Zs2k385625fjUy356DN1DVHgDooQlrwRZtH+FAMD1d0kY1CrKQ1YRT6kFSnqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OQRypaQM; arc=fail smtp.client-ip=40.107.162.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aA+JXsQik2/65dKKvYoYr1R+s8ZSAkh6iypCTHshK+iogywfx6hkYDRX5VM+B4zXupEWK04lHy5FP/BHFapQs7N4aCL5sh38lFY4yJryc0OoTavixnFkV52tRwBok2kg8vgMpEwFq2Qq7lsc0s4aIt0APR5A8Te7rfpe8msFTX1qwMPMjBUPgEwimgjevWsAqWaHJBiB0OycN+GTRT1kbbqPyoiB852AQvix8FqjFL4kh37ACSnNib5uhTCV4QrCz3Ix/I8BvROl2h/5z+jtOQJa8bQf6F9N/2PU8cghT90DuoPFkGxryVPAjC3wRf9KclpkJARKF6hKDh971fQBKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mkW91SkV0pxRKcye1NH7wqUvPh4aFckQs7BkyPzGA48=;
 b=oJRIDflWs9ypVQjuOP1tV2WULzNWrBtenuMMJomTvzQRY+VgMQqLDSG3JJ8qeYp6TV1UCbboOYMsY+O3AxNSU3MwRC9xlz+VcrbeL0y0LzADB0V4WcNsZQOy74ouUuopRt7M4n1y61vqlkv6NKrqvlSEH9gGLkH+Hid1rvRfvQto+kDr5+1dRzNGHHNdOKWAZ/llJDEy7CU5pbKgtsA/x+1HWBZMASur0/bux+i/f75gr2yAxcbWtpe23HQhOZ7PNYhlSlFgHSJdeGPdhxfE92QGvTXrY78gtrw0puRW3OjL2SeMmu74bhvQwiXyMRCXHqU5fpH3Sebwsc32pgSuOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mkW91SkV0pxRKcye1NH7wqUvPh4aFckQs7BkyPzGA48=;
 b=OQRypaQMCjAzSX0eywA8LNtnOT2VZoWmNWA0Nkb3P1YysAG4BffxJM9k7Z3/R+m1slXLZu5rtpxbsTZf0zxLEeYlqKLDwmEvlhbaYZRdExIz/eyfyAUnwaBhPwWSCxVNg16DHKSAFvEwGb22h3o43KBPU27+L35MbR5PFDfQwqoW33EPvUXB84lKq1xf4/4+FbIM/tpiBN9/ySRa/QOfa/VMbfg1CIi7PIb5PMftnKS66iFR/lkBbGK5AySk7KREiuj5AN/aOx/7xZkBuTQnQyRrKMtd2DsOuBiSTY/mzi3vDPC9eNgbDf0Qj7UbJMz2rWpJMMj8/vCyl2TY/vnjYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by VI0PR04MB10808.eurprd04.prod.outlook.com (2603:10a6:800:261::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 15:20:18 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%5]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 15:20:17 +0000
Date: Wed, 20 May 2026 18:20:12 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Heiko Stuebner <heiko@sntech.de>
Cc: linux-phy@lists.infradead.org, Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-can@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	spacemit@lists.linux.dev, UNGLinuxDriver@microchip.com,
	Sandy Huang <hjc@rock-chips.com>,
	Andy Yan <andy.yan@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH v8 phy-next 15/31] drm/rockchip: dw_hdmi: avoid direct
 dereference of phy->dev.of_node
Message-ID: <20260520152012.acf6xpe7hvrdzn2u@skbuf>
References: <20260505100523.1922388-1-vladimir.oltean@nxp.com>
 <20260505100523.1922388-16-vladimir.oltean@nxp.com>
 <3758596.1xdlsreqCQ@phil>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3758596.1xdlsreqCQ@phil>
X-ClientProxiedBy: WA1PEPF00005B93.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d8::631) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|VI0PR04MB10808:EE_
X-MS-Office365-Filtering-Correlation-Id: c385c8c1-b3c8-4655-82ec-08deb6834c8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|19092799006|10070799003|366016|11063799006|5023799004|6133799003|56012099003|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	y6VMH6By2VJoIZ5ieBzCRsombvv6k3m1LLawVi98Fb0P4dpJygu7ekSLtmwIiRHbUJ5TqjcQHt+TfBIXZz4uHqR5IVMruCx7MMkt6zGjL2TZ83RrFa1T+YjUw6Fg4N9GlD3wrmkKOdtbti0rc6X16vdCTLSTd0dNX7ygXO0P9C9vkVimI6+AbXnbSRy0cZUOjbB/aGrUzN82UhgrtYlGFS1o6BbtYTqrFG2cJTO+SLjBstzCoJeR1QQKhujIEWYld3reDZOYZSuft9fl98numemuPhRABZIn/FJHkxu9Tl1q7/+UY6iQjz5oq/Mgf+rwnFDewsmvzrZmYhdUDjT0EUU/tjej8/h+ijOkSno0CtycIARjpbjIGmivdJ0NcORWrNK7nnvOawbqMJMOvhrpgt604+eXjXEg9tIKCReaTZ4g821ZVoVFInj4eLtljkUEj4lLIw5X4odI7zsIxyRJWpjIhA9GTBDxBI000Bmn+xALPDpOD2cQFPb8Rn5ITpufTh+buBJ1meivFtmZyHyDUL6fC17HxMmycZJD304Ke5tdFhLB2xaRckMQtOZpxYcU4A3flvBWamOBbrtHY6kAL0E/0Nu+ZqG0MEM7vCOeTBeu6o14sPf51v2hCwJLpgCXr7sUguoZfh4AsrdpThDo6JNZpMVmK2Sfx89VEFMVMIGN/3qiOdg0xo08pWy/Rw9WM6j0gPfW7iFWsYZNSgX7zA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(19092799006)(10070799003)(366016)(11063799006)(5023799004)(6133799003)(56012099003)(22082099003)(18002099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?w+bzZsFe3eKKjCLyiZMDhiUaw1usTpGN0A/VGIJbnAU/L1jz2NnkRTkuQ1?=
 =?iso-8859-1?Q?SjdVO4XPOp46xKNJy9SxbrSI9zktykp5eHFoLj48iqNmgMU1kvBTKaZ6vB?=
 =?iso-8859-1?Q?7Ji/LWZghZhprNPfJN11bum8PZazaRAey61lyzgFq81RyyTlgmJN6ndjZG?=
 =?iso-8859-1?Q?lnhCcU3ktE/a1YO5XjUxUN9SmJWTIctpKyJToJjKUP/J1wibcRMGDJcq0T?=
 =?iso-8859-1?Q?utmqq3sQKkA1KLJ59UsIeEkpVrlUSJ5+kUL9Mh4DHECvEOHpfmzXs91z6T?=
 =?iso-8859-1?Q?DT9SXcOnS00uSDxbEp2RvjHLlkKvdn6AYeAIRumT6MkQpI9PH3vyO5oIOR?=
 =?iso-8859-1?Q?G79iwJnowCwlPIkNhdawGMCmlVlnMe8ZdMbsnCD4gssgqwYEW/zMOirjf+?=
 =?iso-8859-1?Q?C2IY70OgNKDP7wiPCqw7P4rRiVHTS141vBDt2KD1EBcEUNHiiwgdH9hKRU?=
 =?iso-8859-1?Q?RzRvFPMTwjQUjWMLPoz/CA8W8iI+Q5Ao0VRX/3sgg4KKHc81hgFW8ItliE?=
 =?iso-8859-1?Q?flMuxNs0dW7/j/4hgQ6vTkc7JrDSuACRLyKjAN5WaHlkzj3fVdqRqMoZ19?=
 =?iso-8859-1?Q?KZ0ZLD8a3ktt7DIoys1iQu8ONhAEqiLNgUPDcjbXS7l/TweaFAQqortR8a?=
 =?iso-8859-1?Q?MToSXs3XO5DkzK58HXlm+JSsVj99hN0EhOZaoZA1bq14VbbmFobFcNw2lo?=
 =?iso-8859-1?Q?wDkQSunXeFwIyhk2m5Nc7cvRT+9+KRUBGd7Vg3AWmW6MpdmGu69wpx6Okm?=
 =?iso-8859-1?Q?zhJT78p2vGIM/i8cGDgXPjniF0OKHWuChaJ12Jo58DdEthOp747khVlFIG?=
 =?iso-8859-1?Q?buDlmVNxKyYB/b6+S2O6IOnJTy3wY7d88hSPCoF0GTaIbemd4kfvHyZ+zm?=
 =?iso-8859-1?Q?aucQwWXAWUJnhLTzbVkZGDbhftTRPW0Ns6ARX91zOEpriOS2s6urvpioW5?=
 =?iso-8859-1?Q?PswradQ3uKdChmxqIA1eU+Vkul8MlzS9/E0npsVNK0f7X6GrfsRfMuD3IP?=
 =?iso-8859-1?Q?SZSoH9EtVxW+ktkQnL5UxbEmf75RNuiJqfrX5jttAutoCcVqGYOuOsgQR1?=
 =?iso-8859-1?Q?vTiXCa8H8qAzH88MbiO7Mnl9eISERZTfscEIFgqJoO3F7gzy8Okp2r0FLz?=
 =?iso-8859-1?Q?YJkq70v1uRvDEYIA78yI7lQ1+l25rEUOZzZ2A6xN8TtHlgnuD2dMPF47Ex?=
 =?iso-8859-1?Q?voOt28Z7pocAYhQjs4xFf9Zisf/B/BJdZtH5soWUyCA85tRB+xkJPiktNq?=
 =?iso-8859-1?Q?kUT+fxM8BMhSK0aqju1NdZiF/dpMZ3ZCtkGRN4zbeAltjrI9Lm9/6W0Ra6?=
 =?iso-8859-1?Q?4zzTh/88P4X5g6G/1e/WcbQOyULO2Tn2QtjvFWAo5/45sjmlUWBGkcpC5v?=
 =?iso-8859-1?Q?qcq+0adp6u2F3qq5UMpZfuIAuig9XLWCPQEGa9m2C1VH5mdRMC+hXejJP5?=
 =?iso-8859-1?Q?lp+wWWZaRSidsHzl25ajbOYMSv6BbxVw+FQ2PKC0XmkgXeq4jlm+NTRY/D?=
 =?iso-8859-1?Q?9/OdIwsIXsHhZ8fC9310VsVXjW6s04Fcglex5f4k06b4SUIx5F2S5A5I2y?=
 =?iso-8859-1?Q?+YgtCeOcj0X/LxCRbTc9s4/pnlvVj67GsYP73bRmnkPf14mHn6WiTKFdHT?=
 =?iso-8859-1?Q?TRpiVjFxKiScw6UxbVloY2HIco9czRJsQzO+j73zrXZqjBxRG6AujOV5KC?=
 =?iso-8859-1?Q?uTeD9DTaA0L/7i62meoJhVgEDESNAOy53Ck3g89w4cwPvxiqTgNHmK6vOC?=
 =?iso-8859-1?Q?mRDE+zFDSlrVE33FApjom1COBgFnNlVMUG0TpKNwN9RM3bKY+jwn7iBFUe?=
 =?iso-8859-1?Q?YmBm3XuW6GqH/uV25VqE7ARzchddWnf3l6A53jPVEpbsyPZsqmuYFpiFTh?=
 =?iso-8859-1?Q?JF?=
X-MS-Exchange-AntiSpam-MessageData-1: HLlipyHbu6yqYg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c385c8c1-b3c8-4655-82ec-08deb6834c8f
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 15:20:17.6180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eTVm/2d3fCQSmd5fytap+wEqwJac+az9a+yuKziHQ+ZvOOwWG065tCPWUtheZHYzEZHW/7dhoMsqYnslhvOdPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10808
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7676-lists,linux-can=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[32];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.infradead.org,kernel.org,linaro.org,lists.freedesktop.org,vger.kernel.org,lists.linux.dev,microchip.com,rock-chips.com,linux.intel.com,suse.de,gmail.com,ffwll.ch];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-can];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8E9165910AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Heiko,

On Wed, May 20, 2026 at 04:21:24PM +0200, Heiko Stuebner wrote:
> Hi Vladimir,
> 
> Am Dienstag, 5. Mai 2026, 12:05:07 Mitteleuropäische Sommerzeit schrieb Vladimir Oltean:
> > The dw_hdmi-rockchip driver validates pixel clock rates against the
> > HDMI PHY's internal clock provider on certain SoCs like RK3328.
> > This is currently achieved by dereferencing hdmi->phy->dev.of_node
> > to obtain the provider node, which violates the Generic PHY API's
> > encapsulation (the goal is for struct phy to be an opaque pointer
> > with a hidden definition, to be interacted with only using API
> > functions or NULL pointer checks, for the case where optional variants
> > of phy_get() did not find a PHY).
> > 
> > Refactor dw_hdmi_rockchip_bind() to perform a manual phandle lookup
> > on the "hdmi" PHY index within the controller's DT node. This provides
> > a parallel path to the clock provider's OF node without relying on the
> > internal structure of the struct phy handle.
> > 
> > Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> > Reviewed-by: Heiko Stueber <heiko@sntech.de>
> 
> there is now already more stuff depending on this change [0], and
> the change itself also is sort of independent of the whole
> phy-series. And somehow this series itself sadly hasn't gotten
> much review yet.
> 
> So would you be ok with me just picking this one patch for the
> drm-misc-tree?
> 
> 
> Thanks
> Heiko
> 
> [0] https://lore.kernel.org/dri-devel/20260518193748.2482823-1-jonas@kwiboo.se/

I am currently out of office, so I can't look very closely, but yes,
I did agree with Vinod to try to reduce the size of this series by
submitting some of the changes this cycle to individual subsystems, and
the cross-tree remainder the following cycle. So yes, feel free to pick
from this series and I'll submit to dri-devel whatever remains when I
return to this activity.

