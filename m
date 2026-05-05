Return-Path: <linux-can+bounces-7511-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CZONBnH+WmmDwMAu9opvQ
	(envelope-from <linux-can+bounces-7511-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 12:31:53 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A864CB61D
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 12:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A38E13227879
	for <lists+linux-can@lfdr.de>; Tue,  5 May 2026 10:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32FC44CF34;
	Tue,  5 May 2026 10:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ac1v3gub"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013037.outbound.protection.outlook.com [52.101.72.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D60D43D51D;
	Tue,  5 May 2026 10:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777975595; cv=fail; b=DJeE/ZtckiwTkkHv3AM2jYfxd+B2+hLSAtFHVI9jhLkf3+/IvHEmf6X33G53XQgLvArqVfwxDyNawdri+Zsz1YhtfXpdw6aDTiMZNjKhJxUpBaBaHbGEgI0hYK0d2hNOuH5eO6xLLI5cnhFaenKQ8r5GI89oST2gZ6QsptHglwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777975595; c=relaxed/simple;
	bh=ChoAMst+UxBHhDsHGsaOo+aTCNu+x/OAasy44vLPg2g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Sf71U0XuSOZR2XH1+gvW41qfbLuTbHb7ZI/9hEWXEK3rp+eV8r0KMSXs76/GMPOpjG/eRzJaUDcu+1VJPzEtp2l15sgaDdY2hVInV3gBNyqQEM0s5EFS3shPdJS8w4wJyzBvj2w9F63aMCZc3VKWe6MJzwFWBxYrRER2BbB/EVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ac1v3gub; arc=fail smtp.client-ip=52.101.72.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z/vmmA+PLksqphUca3qjVnz5C4XZ/mZ2nCsi49cCymNh6+aYHHfnFBwEiu9zdkzzNNhRGgPkSVYSVy3s3O1Hw67IaPL9iB67+6Yyc9Tkl3d2k0iKZJSFQKylzwfNw5c05YZjyJTsICoiQHvkumY5HHWqxettMZOWh6FyAw3Ar7hBogGJTfh0WG3QjhJieTm6K+90StJ9JjCg/7XBuiqM91pY03we47eb7UHsHZJ2Le3kFsn/W50zVm5ZW2HNCmCYGDvm/XkVVhM4g+hdEpKEiiNFMQDE0n5h18n3Lb2mchqO9ygzjVkzY0W1+rknJDXx/N2NaI4exjpazgszzRYQ3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+26l/62Iu91fh3cwv9yT3OOnkRHwHbtgRuWAhuUKkh8=;
 b=DzfiRO363Q6wdMQIqrmAP6WGncivjGN5qhEkSzFzuoGuQ3JZrR79x412AE+5br06KeCSUhbvDSea6Jh6xUP/HnZFwSqu2zaXOeglJKdPP2yLFrU6/0kN5sa9mHswJdXLqcm7LkhPwAxmRZoamfFgBGnqAvApGtEXRuH9i5SKhETW2wzEIdYCiU7JTSfDwrKazk13eO5HLtUJjqz/xW95ZL7wP49GCTaJHattJqnnWqtEf1TuWtNmTBrxSX7O0PrL3x/4l8Tzt9VqZ0z6qFxvTHWCrd1yMEnlQ4gm+7sp5/iYsoic2+FXK/AUoEU8r7Ku3xxYQpMXOY/nDHSx11LDOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+26l/62Iu91fh3cwv9yT3OOnkRHwHbtgRuWAhuUKkh8=;
 b=Ac1v3gubkB8mFKl1Z9RtBRUXq00w5LQxcyL9KVa6lE2inzMg8nzx5dutJnxtkxi2f4zeW6vXK+FM4pju1BzoYMMahXvEhLCSxQZbGfxQQu7SbyKwTxJkpVhpcO5QLKImXmtpD5SoltXITT9Sl5zyzdPMAnX8z3Sk3XGq/dv+Nr5nsdM4kqK53FWFRsHTj5EnJiHcePP846lTLO7cDm93PBIYK1BC5d2vMDRyd/i8PS6DoixQkOs4LawYeZGro/m4BvvmvuXWsWVYac7gthTwYf5cvKCsu/IiimLN0s9ks/bwDyUNbkWPUlQ7eebCajI9WlGbP3pXxyX2vGTCKipe3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DB9PR04MB8363.eurprd04.prod.outlook.com (2603:10a6:10:24b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 5 May
 2026 10:06:25 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 10:06:25 +0000
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
Subject: [PATCH v8 phy-next 22/31] drm: bridge: cdns-mhdp8546: use consumer API for getting PHY bus width
Date: Tue,  5 May 2026 13:05:14 +0300
Message-Id: <20260505100523.1922388-23-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260505100523.1922388-1-vladimir.oltean@nxp.com>
References: <20260505100523.1922388-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0048.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::19) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DB9PR04MB8363:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e76acec-be79-4e00-15b6-08deaa8df75c
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|1800799024|19092799006|7416014|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
 XOUo1HUU1tiJG3QhH+wtvnUnmdkRzG8RYhueH7+NcseBYGRiOc8876KqiarF/nQqnteI2r6ER2mjnrAqwFidldardxx9GWLNFSk9H2AKjpxbF5ls2Ksi/MUljfHMr0aP7468xKa9svFFT6pR0iuZndR+PzyqnqPG/DNnwbDHGjBDfUYyDSM67n11Pr/lolj6wB9snkwlkboP/h0V3HpgDGZsjOdH5rone2WqbAKYv5wtNpmTI95UZvKKqTZzSAUMUbB9VEDaaYucnp9+JY0QzgbiBO1GjrfUfC7Rql4GPdE2EhzUePcTzLmE6YE2YKB9OXVHbPpEsVRYjfrEnx5BcaqCjjrJae1GCv94vIf1D25Rna71+G589SRCsdAtB6HOeO/lZOzN2Bdo0iTwhd6Ne3eSARb6FoKzluLeFc/GGPwvZcy9/4rkuC9kbSSrBwCZBeHk4GpiugezwZLF/StPYm7xvQm848qr6hvJClzVAnhEI1q5CkWsj7pEQGMrfZtoBC0xH2KqviXkrJEf5c6RZXBcLFMCXlqCZp8CcVpfqeN4usT57GXA/IAVk1zZMHRoUdj1Fjs5dmCd7ovZd4hDJ6BtEJqofOrzX7ehdl4l7l14xaLuA2zybrPrzBCrdjMOk0aA8jFqDXnsmG7StW/NDEbJdL3Bn0tgLQfgK/kLPJv57+5YdD92KFDjrWNW9gaP
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(19092799006)(7416014)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?6DZLFM/+ZgdimC5IUI3PPET5kWmdyIfkrCkPI0o2A+Mba7mRsbZ/4G4YmBxS?=
 =?us-ascii?Q?eiXk1Ac46DjjnkoCYrDScixNLMsLXlHkF3VZMUlU57OrDe6pI1enTNoMgX5M?=
 =?us-ascii?Q?PhT4ydSjalX+6CWB6YplbEoZoTwXZxflvyzWUnLHjOfYvy/u0eVG/NzgaOId?=
 =?us-ascii?Q?ZQLILkZSdVSEj2M+7vFgY6HeUi4qclttmttakZCXVijJximkjw7y3PcJYqP6?=
 =?us-ascii?Q?8VsGLsngCkeew5G7Gyo1Grfiww1J7LSChSXSESpOq+bbmRDVojx6Laa4BGzo?=
 =?us-ascii?Q?7NyLGYE4nbePOwaa1sa7bVprrgr7AmOYfp8CGZJHshXvg2ztrZpsbyprvaP/?=
 =?us-ascii?Q?jKmZ/P7w0HCksGaAZxFcBSswI+Qu1IcGVwU+CUTueIZStNguq7sh4/bTAZ9u?=
 =?us-ascii?Q?5Ira10KoQuvBe0zZpAbxdjfnq8qWUnOlx43hkmUjEXObbcCC/Wt/CX4oIvJH?=
 =?us-ascii?Q?LtFbakAtMkjXcTWzABORF/rYjsR5ZMLxAWwmQIN+faXQnEirSeu7m6fSzcj4?=
 =?us-ascii?Q?pzOLdTwQ4fLLW99x/JeM3VZ+qJn/J5gUSCKqgULrc7Q8k+FupOIzvvBnm/HV?=
 =?us-ascii?Q?V3zYc8Pfa+wDQl70OTMkFV+NBViL95VoyCm3bny98OFPc7PHPKESAQrcSb5k?=
 =?us-ascii?Q?sSH9z2GlN+oBVQnRYGkIkgRZCBQUP/GF4DHZe8Lmse1q9caNUJ4t+NuMFWzy?=
 =?us-ascii?Q?iq/TIcq0kEC2TCcLlNu7xHl8om4DCMafFHWxKMx7RijF7AZuRaQ8evC36WSS?=
 =?us-ascii?Q?8oD9IjegkEMfmsqDPfkXqEDLV5FiKnYF58bju8UjOyR00at1WUVa4Gjsv8p9?=
 =?us-ascii?Q?JT3tTNZK7XWW9CqBq1SWjsFoN539X48q946RZAlYFyPMeXzPd4BLNRK74eeo?=
 =?us-ascii?Q?Oeev8dMxwWCbXATnnr65ep4BhvASFq4eab6rnC1DwtgeABZCcjlgdbPVsfP6?=
 =?us-ascii?Q?cAhjdqD7o+8nNK9fs8on/eE85SGP9ut9P2G7Rio2tLNfYptCshiQqzJXIlMd?=
 =?us-ascii?Q?JneqwrPCLokRBiHVyzOryLpAPFWT5+cFvlGgBvOb6AF1kixq26/ATN2RNZHS?=
 =?us-ascii?Q?WGpvV+bznoS5YePyP/GAT/doS9OGCFzY/3W5uwSlaEcSOTlcyp5BqZNQBWR5?=
 =?us-ascii?Q?VbYo5rN8idb3JpqhrWzSeXj2602WxjMwX9vpHpsEZJCVeLG1T4ZJNxL4OaaG?=
 =?us-ascii?Q?NOT6wHLXRcfpG1SFeVkjp73YEwlZSZavUagDzKWxguepPgRNedOnc0QvB0mG?=
 =?us-ascii?Q?lzeBlOyO01A8vfWVEfJnJMZ8uxtVxtDYjBpfT+FbzC+fiKIF6p+ov95izx7x?=
 =?us-ascii?Q?1bXIUO7jcRVRnKKAigV1R1xxJFPmZ1JvPDZmWdhvTFwQbFVizfQDiEkybmJz?=
 =?us-ascii?Q?r93sWxT95E6oHhRYhV6Tf/nx+wBEhPgdKMPiixwq5Ti0fZZeZTaoNoLhRbQ1?=
 =?us-ascii?Q?rj7ZrtdJQK8jTZpVikSihX6oCdyiRO3R4rSAC4ztUytWyKMMhtX2yapOcf0o?=
 =?us-ascii?Q?XO6DhDi6ixG65fJhc+RjhZjtHr6oLSwXsm/OV6w7lWx0UEBxVWSuXuIZ32+m?=
 =?us-ascii?Q?jx+2ykO2ehp8hDElNL9l4P0zQUAQbDX95mV+svXA2AAwAnjDrNU9uVE/gnHU?=
 =?us-ascii?Q?jEYlNsFlYE7xW+6uzF/40e+I50+p0BIfpyU2mgNX2nMzXssbk0/Qjovd02mq?=
 =?us-ascii?Q?DBjE+PIJWU2WAD2DErQ274LC3693CKpfCULHpciHo5o/1MvhJMCL0ltaeo/I?=
 =?us-ascii?Q?xP1sElJ2zg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e76acec-be79-4e00-15b6-08deaa8df75c
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 10:06:25.2560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nnzwX+rIZGcpQ8jjDywHhByqXKKdVaYWFDwoly5RqauFUlj2HmDcAQOw96IkmrO7Wt9YMlCM8smwro0uw4EBfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8363
X-Rspamd-Queue-Id: 93A864CB61D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org,lists.linux.dev,microchip.com,intel.com,ideasonboard.com,kwiboo.se,gmail.com,linux.intel.com,suse.de,ffwll.ch];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-7511-lists,linux-can=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

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

v1->v8: none
---
 drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
index 87847978c1fb..76a684d4be26 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
@@ -1300,7 +1300,7 @@ static void cdns_mhdp_fill_host_caps(struct cdns_mhdp_device *mhdp)
 
 	/* Get source capabilities based on PHY attributes */
 
-	mhdp->host.lanes_cnt = mhdp->phy->attrs.bus_width;
+	mhdp->host.lanes_cnt = phy_get_bus_width(mhdp->phy);
 	if (!mhdp->host.lanes_cnt)
 		mhdp->host.lanes_cnt = 4;
 
-- 
2.34.1


