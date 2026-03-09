Return-Path: <linux-can+bounces-7045-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GF22GkQcr2lIOAIAu9opvQ
	(envelope-from <linux-can+bounces-7045-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 09 Mar 2026 20:15:16 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C0323F7A8
	for <lists+linux-can@lfdr.de>; Mon, 09 Mar 2026 20:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F2572302CE81
	for <lists+linux-can@lfdr.de>; Mon,  9 Mar 2026 19:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2E7426EAC;
	Mon,  9 Mar 2026 19:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RWSU4mON"
X-Original-To: linux-can@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011009.outbound.protection.outlook.com [40.107.130.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCE0426D2E;
	Mon,  9 Mar 2026 19:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773083404; cv=fail; b=NfK+BJuQehS4v7zyaIE7H/E0V49akRrSfjM/Fwv+9Geo9fHwsxtV2lmWadItdSXRNef6LgnGPkB+ixK5kz8JAZCKJH2n/GBifoDzBBxF1PXYXy42EHRKezT9TJwqHN6cLp8+LzSBTh/680D/Z+Xuk+N8ThXvpo36t5tDVNZLkkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773083404; c=relaxed/simple;
	bh=Yr7T3zdhMG4RZfu4fDdFV/LnjjXG4UCOPw7m/t9o2vw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Hq3nveDnqw8yy6mSfvQuCAlpyYpvPAf6Y0oRZwBakX2u+SC4j9UbqjchNTBDv/mXpQvvT2MYnn1qjNjghjl2rPjVB1RLErxaPg1napvwVpVq7nsYha8evlmPaRELKKpx5A57xPz76wBcjWjU59Z1crAsORJ9k+bjvDG91gwpbvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RWSU4mON; arc=fail smtp.client-ip=40.107.130.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ld59AWcqrqPE/71Pv41B0QjuKmpk/E/KnldzXeJ2RH35Z6Sk7R9NbZoDjPEOBVwOK3FsFXtioW8NWryx7XHqfNTfnEmRLqGPDovDPze3lsMU4Skh+yE/a+sOKySrWxMEH0UbhxYs+VmuZuHHfpDSj66PxxHMcjRjgsWHi0J1cq0tFmrjx26C9f9wOr87hKqlPR4AoxndaVK34eknGF7P1JmL2TQlgvKnYyISVZBe1Fw4Lhc69fJslZn2O3/RJv9efLBRVtz4WHURKG3D4A7J8rU2/4DhAFQ5xbFiQwsoKhBcTz1uR1JoirIkK69azeQSd1DvccpxZVEWEhdFMWwBGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YjNn2aqU99uBBcSkkZg81AKQQ8jwCxV5n5wGBtWX34M=;
 b=QK71/14+mK2hkxmLT4iKP13eiR89qFCBBPDb9TZRQMJ0+xXzObTzjOmplnjEXWv4jcyAln+Yb1qyrQafssrQx43VMguscje7+rbGBiweCOK85GfQS3hpw57JZZiGmsSUeQh+vwIAdxMCn5EkdbvRBXuqWUzomEIAfOEa19+/bIdZoeH5c4t3SGo/qlTTMwXBOKd1b4OrngVuYWkQGRi+ywyQ5L0D0jnMkquynfPWMU4mo4QyJMFG4IqKd8gJzCeLNPXPeJxJnGwaB9jEkzXs1t2RW8fLN5bkNLUoLtd/CNKS0MxCyq4nhcgIxjOOne1eh1rJe0TSuMawrUvJqTUdtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YjNn2aqU99uBBcSkkZg81AKQQ8jwCxV5n5wGBtWX34M=;
 b=RWSU4mONIi9yyS2TZoCf0fZ0UCrAe1/LEKb8B5O64ctdP+DuCTM4f+VwHo6xoFNLGGB4OuSNm6W2LeiKctI/IY6353C6sq6DvU9P50tU0T+VWVd8QQQE9d+SIIlgLIQKuU14ZH1iTmHrr/BgPQns3WP6SImHrSsSJgN0vEjdFb4MV1i7kNVnskbXJ48cxP16JjkCx+ojgsD1P7d8D84t9A9fTSvh5Vg90t3vUDibVUmcgu26OxyhZJnl0qBlpfq0OT600Kb1Df1JrFUOeJdvkhcqh7Soz1FbWF0dxfs8hjWsbh3z1vnNeKWu80G4aSgWYi/j+KtK1+zlHEglBqBK2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DB9PR04MB9841.eurprd04.prod.outlook.com (2603:10a6:10:4ec::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Mon, 9 Mar
 2026 19:09:59 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9678.023; Mon, 9 Mar 2026
 19:09:59 +0000
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
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v3 phy-next 16/24] drm: bridge: cdns-mhdp8546: use consumer API for getting PHY bus width
Date: Mon,  9 Mar 2026 21:08:34 +0200
Message-ID: <20260309190842.927634-17-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309190842.927634-1-vladimir.oltean@nxp.com>
References: <20260309190842.927634-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VIYP296CA0002.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:29d::7) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DB9PR04MB9841:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cedc358-87aa-4172-d9ce-08de7e0f7583
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|376014|7416014|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
 4i0zQE0vncNln5VQDPj5GGMRIRksrpJoDJHj4rPSNWBvNFsvVjb02vh+tvIUxQ/ij0c8lEAOoSghbU+6H+BsGSBs/1HABFDAxJnsXltrnNSvZHMKrQyUkrugq5YcYwkEe733fHey6tvbJO1mDpAWUFz559LWGv/Tdg6XVVm02101ijWEPGmN1Zn7cxVM1+d0EprtATCOooO5pZRT7MZJxYrmfgRz+sFocT28jx7K1dskVlxai5YVRnBZwwLY2scRIcPXEcEfsrVStTy7nWKrCkYhDB9UwIXJtHOvzm652nIFRYKGm4SWq/BsULKazjk71dL1kNXuqJikZMVyM4eLLu2Y81qIjIaYv0B9K3iW2sIz03R+i0UzGk0TZvIMG3MkwrraBAchM0qJEvIaVJaUu6tZsXuLilunCNp0HK26YEgLEaG9OiqYxHmMNKHdvUuOEArI/EqC91XwPRJr3zecsJ1J2VRxMfwOyRDopZ/cqVzpm9kmmBst7nTN6hvkBj7hvHi7EjObw8nCg7YBUI+qMPBWw4wEiRC4VPQEMz5x2AD2ToO6B8m0Vxb2c8zhA8apTbaO4UM+Wa8lWaNtSyuM3dIFxsmBANEv6QEEs8QP2w/SzrbqYi7p1tCcnNtT3D1ns37dPrhKiTB7uTPhuJVz3CWmNf/saG4rNgIgALQFjZFrrF9jtQVNYuKAWHXshCF3mLBTOrZgebOcrqTP4Ddnb3eyWIBRp9rayfvjZeX9gqw=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(7416014)(10070799003)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?2LLFVLrN3KavDiPbKuvj9JfbFL4riQRKKGNNbpol3nFoT04dmZOHT2B3srBZ?=
 =?us-ascii?Q?7gps3WokzrNlIyBQ2sN87qzCdh12m6nbUyYcRY8aUYjVF8sFI/YxG/maU4GL?=
 =?us-ascii?Q?Z8UfcSvMugV6U6BYmrIl0VjKjA3FQQsfJl6D5DBVtAlUzeczbMSz0cFqny/g?=
 =?us-ascii?Q?xcBRxFiJrrvpwzacwKMdizflL9khPqX6NY0Zi9nPpQ0NRjLW7cuLebXcM1sN?=
 =?us-ascii?Q?WDRJpGfaBU1zn01JvQImfbz3lMPxNsiJgb8fHd2Zah7Y3FNrxx44lXwKLqHq?=
 =?us-ascii?Q?X/yT6foqJDi9ijY4d61dS125wRC66gjBGNS0R60A1xpshRTjDQo2BwX5DKOT?=
 =?us-ascii?Q?Pmec16OkUtbLWI2cI3IL73m99841ykuRwLOY28ofMU1b8jyDEBKFoq4ADHw3?=
 =?us-ascii?Q?+p7fCUaNL72A/4sRzeWDtnJH7Zdf4nkrge5UL1r7+9oMLOzNHznXSq46RkZO?=
 =?us-ascii?Q?2tvW+tBXeKqOaJdSdwWWwsDRYhi/m2t3LQA+hY7MPcylRw2ZuW7XapAPi9Ms?=
 =?us-ascii?Q?oQNIDT3ASatEA+YAilRwTVba7InD/FcAvYF+jlfGM+hpsH/35L4Xf7JRiOU/?=
 =?us-ascii?Q?ezYsfCjUoMcpA4UbKPWCPoz5fQ7A0Av4Rn4hYsPl7zfPVD8KM2/XARl3t7No?=
 =?us-ascii?Q?EQxU6zJqef2t/xN7Sv2VvuhlqTr7BD4kYRhKnID6cVTbFtkUm2O2wUS0dDWa?=
 =?us-ascii?Q?n8QRzxxuOxLayxaBwi64V5a1VXpk7odHZv7yncasL52/OXni0Pecl8xzHyBT?=
 =?us-ascii?Q?siQXQghV7yW5EIuFr/ok9UF8DwABI2mks513Ojs1w66hOcF3RAiEwipI1uV5?=
 =?us-ascii?Q?Ug68wWv+yrN88bNyKZEbe+9viWnKT4wc7QqbT52/fWeSrRkaSjeTHZpmGOYF?=
 =?us-ascii?Q?80njEdXJfSsBNDbxKA1NCQVn4IkZHNi7nAUjvAP4H2s4uiSKtQ62ilu3Zjpu?=
 =?us-ascii?Q?8UTcdwRNk0uItNAeJV2i+JwbWnUict+IW07/TbT8ZJH8EjZvb5tijNHyugGr?=
 =?us-ascii?Q?a6G8GsDs/olQUL3Ro8osIXBaXZPWlNBdEr3azswJRzWZgaRc+DPnuQ1pOUZK?=
 =?us-ascii?Q?ND0xlJ7UPtmPuISBgZCKbXSlTczMs/dL4b66mK+ng9JgOii2vxtwjj113iIv?=
 =?us-ascii?Q?mM5rZCOAkgbZnKk7CQ6+U9u42daV9lM5734DJOTUWSC/N3FLlPz+Dqvu9YwJ?=
 =?us-ascii?Q?2odtXu/ayx82AueC6CsoZIHr7w+Djhk7HI6UpDs5OweFZH6svQeob9EcpGsa?=
 =?us-ascii?Q?QB68RDqD9RNIXiGAdDsnLKUpoAzNe8gjpIwUaOObKO4/T2JAxo7ayRQxsJz6?=
 =?us-ascii?Q?m5+AUbaR3VApGW0ho0H4Wtdhkc1h0Itmjk5MvG4eoeLnzMwnMd1msQ4Vp3s9?=
 =?us-ascii?Q?IrDpHhezygIWIblHnvogjqElqtWl5CUlmHy3ZViFWM/nIKzB04+hiVVOUrJT?=
 =?us-ascii?Q?WNhBBqODI/rs3vWqnTQRkdKq2ESSyvUIyE6OvGJGso+IT86j1yCpwRX0xakE?=
 =?us-ascii?Q?mGYbTUabDEXv7iLjVhmyigg2I612VyWvvU/ivupQnMDXDh9IUYCTEFhPBoOy?=
 =?us-ascii?Q?0FCkWku41qeLVF6LDZyl/eM8Av29PPI8uLWSO63bQX4q3WBic/8ipYtiZHjY?=
 =?us-ascii?Q?3yLUsgjbvi2+hop1vQuJ6D7VPM66eW1UJ9AvyP3oc+yy4bvwGlG9CKHrwSdS?=
 =?us-ascii?Q?zQtWoTQdimOB84m7xUnNDpsbqluHTZ5PXmM9v7SY+lziyjL8zTMemlbEbCaZ?=
 =?us-ascii?Q?IB7Ae5KtbrZx4+xroxQ3WvtTfTHey7n26BRFfGNh5Y+WX0CmhECuUFsyocfM?=
X-MS-Exchange-AntiSpam-MessageData-1: Uo1Rl/bn2cq0DPbLVAd4f4ROtlOi+6thMrA=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cedc358-87aa-4172-d9ce-08de7e0f7583
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 19:09:59.5561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DAQScbCHFTJs1YsVPqn4Uyg2DGFjfhJ8Ra8MYFmN9UB8oXg3GGnDVFoByiYLTNOJPG3edJZdvulrRIwCB4uhNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9841
X-Rspamd-Queue-Id: 53C0323F7A8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org,lists.linux.dev,microchip.com,intel.com,ideasonboard.com,kwiboo.se,gmail.com,linux.intel.com,suse.de,ffwll.ch];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-7045-lists,linux-can=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ideasonboard.com:email,kwiboo.se:email,suse.de:email,intel.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,ffwll.ch:email,nxp.com:dkim,nxp.com:email,nxp.com:mid]
X-Rspamd-Action: no action

The Cadence MHDP8546 DP bridge driver gets the PHY bus_width attribute
(holding number of lanes) directly, but doing this will no longer be
possible after the definition of struct phy is hidden from consumers.

Use the phy_get_bus_width() API function designed specifically for
consumers.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Cc: Andrzej Hajda <andrzej.hajda@intel.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Robert Foss <rfoss@kernel.org>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: Jonas Karlman <jonas@kwiboo.se>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>

v1->v3: none
---
 drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
index ed7ed82ddb64..e3f8a281f147 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
@@ -1304,7 +1304,7 @@ static void cdns_mhdp_fill_host_caps(struct cdns_mhdp_device *mhdp)
 
 	/* Get source capabilities based on PHY attributes */
 
-	mhdp->host.lanes_cnt = mhdp->phy->attrs.bus_width;
+	mhdp->host.lanes_cnt = phy_get_bus_width(mhdp->phy);
 	if (!mhdp->host.lanes_cnt)
 		mhdp->host.lanes_cnt = 4;
 
-- 
2.43.0


