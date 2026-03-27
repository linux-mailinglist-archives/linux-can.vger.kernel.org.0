Return-Path: <linux-can+bounces-7285-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDcnLo/VxmnOPAUAu9opvQ
	(envelope-from <linux-can+bounces-7285-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 27 Mar 2026 20:07:59 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 33363349D46
	for <lists+linux-can@lfdr.de>; Fri, 27 Mar 2026 20:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 877BC310EB04
	for <lists+linux-can@lfdr.de>; Fri, 27 Mar 2026 18:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57831280336;
	Fri, 27 Mar 2026 18:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GzkSzKXb"
X-Original-To: linux-can@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010049.outbound.protection.outlook.com [52.101.84.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A339A3B4EBD;
	Fri, 27 Mar 2026 18:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774637363; cv=fail; b=oxjrTiWu+Tgeda9upTvSQ/vgQHk3E3waPkLHOrlITO9OjM7ADj2SGKNndmWRf8RdGSMj4CblZIiJyEEYTbQXjKZaVB+4c0gZs/hXI/a9fQTuKhQMBTRI+pfhliqv9QFwZDm7UuCc/zKAzBFDlwyYO7q9FpKV0TmJAlg8ex7mV/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774637363; c=relaxed/simple;
	bh=koaDtbAKjGFPdNVSjwKyRwT38gWgo4FihYsVoHg/B7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SGv1v/CKZgPRFUXZgF91dLSWI4WBSlw02i91Kt7HlhhzEF2akFT87zHFnkpEvDGo27IpKVR+aC8pz1YtO7/kGVB4l+V68xj7+0wSe5oaxj/Q5Ysfy4CBWvyyTbW7Vs3HuHrIMQhsmPzq7Bv4eE+AASMqs34e7yXbgAyypApXIUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GzkSzKXb; arc=fail smtp.client-ip=52.101.84.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b8CVd8ew009LpEnUc90agwU085aVIyr6/SWQmoKimHx3P/bVg+ae1Is22Aj0foDGMNmLyamwnru0NEMKGhg9E8wAYfSgEBp6EglEuj0rvE5Os963wuOoY6keruGj2oL+e/9lyQwVKvyeb9SvKkr0eRsNs7pLXi/gvKZnVHl06aCzMMk9AnOiECYr9vObCyryfSWLOxOp2TYBwHAChLxEzkZjCk1PbTG8fY5TeTqSKQzlpsd+PKprlGZRZm90Msehq4cCkNmJLtmxo9kB0IdzMIqQDqIQ66XIlZx/F9MzJHXQ74Sf0jiNzh09q2Ls2KNlYq0uaKU1pVPCPrNiEaUDRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GZotjQ/zeHqQed/F7jD2j58DZCDhCVrGw49xA4kdzhg=;
 b=v0dKKCHFODK3GhxONHaHP8yqEiYTEo0rtav3LROwTh/Nml2LLfZw6r6zId4GGB7hSdrtByb+VjIC3zSKpN3yoRVwcQmbTvV/4pbTlQa8ovX8Ou8RWTJtIayovpO9yEUPStJO2siKVelH7Ud5AmUy26XPf9ZTpROpN8sI2AYoklDgqPMZuIYpO7r+EQrDzVoPbQaNlNW2KhwChjziQRH6Pqcb3PyXINNpvu9kQtoZE+dqg7gIMIPR5t78REtaDMrleGX3ZDXUENEV1l8T3ZXRuK+Qs+SHILzsIm6PyfrN5SlWmpJzVzIykBQ+3uLMiq10fKJjZh7LCffH4E38ek38wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZotjQ/zeHqQed/F7jD2j58DZCDhCVrGw49xA4kdzhg=;
 b=GzkSzKXbVP5Z6OwLbWobvMRBbN0IexqaBXjCwc9J2OcoNIseakX3B6rWI2j4lQR9VfWevv47nYkpgHNemor7OyBwJjfcMgPDpVh09yABfVt8cRHA2G7eUixiFDF5WLbG91gpchgx81ZdDZOC/68ZILH8pBJQA3wBIeKdaYEom3hZtTVVpEXxhvNll6vjk4SuzCaruPj0VwxaOUTYPHZ7UvaS3UvKvBjmQQRqKaPlgZE2gLUzQRdOhZVomhmKlXB8SbZWxHOnIzMcRI2t+0Sxq3Q2pqMcIX+O6Yl2ZWu1ua6ZWNJIEhpfW3VtNNBvsIhGcokGK3y9P/ZpAcIdpZPZOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8584.eurprd04.prod.outlook.com (2603:10a6:10:2db::24)
 by GV1PR04MB9515.eurprd04.prod.outlook.com (2603:10a6:150:24::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Fri, 27 Mar
 2026 18:49:16 +0000
Received: from DU2PR04MB8584.eurprd04.prod.outlook.com
 ([fe80::3f9d:4a01:f53c:952d]) by DU2PR04MB8584.eurprd04.prod.outlook.com
 ([fe80::3f9d:4a01:f53c:952d%5]) with mapi id 15.20.9745.019; Fri, 27 Mar 2026
 18:49:16 +0000
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
Subject: [PATCH v6 phy-next 20/28] drm: bridge: cdns-mhdp8546: use consumer API for getting PHY bus width
Date: Fri, 27 Mar 2026 20:46:58 +0200
Message-ID: <20260327184706.1600329-21-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327184706.1600329-1-vladimir.oltean@nxp.com>
References: <20260327184706.1600329-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR09CA0170.eurprd09.prod.outlook.com
 (2603:10a6:800:120::24) To DU2PR04MB8584.eurprd04.prod.outlook.com
 (2603:10a6:10:2db::24)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8584:EE_|GV1PR04MB9515:EE_
X-MS-Office365-Filtering-Correlation-Id: b27d172c-f5af-4874-1413-08de8c318c42
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|10070799003|7416014|376014|366016|1800799024|19092799006|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 GZiZs2FAJ7QtBfK0axiDPbArWil1GleSSgljfjSpTArljclujKxHalqB+8+aUld6y/9oRd1EvZFEl5rjexnMzIF57gWAW7oqkqzSM4W7sfkrs+FZkvJZB747DvlVOG0raKoXuKzjFAWjoBe7v8Z/z0d6PZbHLKQYyVWKyhMWdx+CkYbLfNte07GjKbf2nqzK00yIRhrX8F2jI/ZorcfdAf9iP+mPMRcRh0QGer+mBl1I7A55KegN+9wzFlQ+DZoMBEbixPpHhNV5TS/UpoVl0ywN5OqSy1sTLYoc3KBaNw9K7CHK0LBVr7YDTS5BKtikBEbS8tiFM/d1yEdN+E0pDjHcmL+gDs6MKP93/Fx6sQd4Z2eTfo9S0hdzcu5Wdq3A/37VrKZCZEiI6zHMfGK1YXwqFZ9GMuFRZwQl8VDhC8NouzJVRWQkPaA7I8Hog330j2ALKEYen4c5Eg8tTUjZ/3upFxMHcLzyrCjfgFn2RtvfBXJYogKx+YMevtIMaoP4NnrxGQthxVkyMUtis8cFk2ulue2bCNgdAsTov+IJGVYF2KYbcYIb2EEGp5zG7WQyctl7D6Ra/PGzH2Z/48tuOtGM5AyqZxYTDIVLILLfY+8zmsNoBbIKPFbxSDEUonnWGXkwXXqEukVw43QIbWtWFOPy3U22t1wJphmAxBeXCvFVWotXy6V65aotPLhVNyXzD/ondwyWxu/YBC+cwtwO4cCukougqNQcKBdMZJSAz38=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8584.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(366016)(1800799024)(19092799006)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?vfadGHPsXwMylkIJxlU27ah0s9/VEbAuibNqBOYBjMKML1f2XPVV5gtxsjRb?=
 =?us-ascii?Q?+Yfpcu5vBZFrBbJcILPaCeDXZvl/D46x3frErgx26W5JUstVdHabIkkYKqH5?=
 =?us-ascii?Q?NZcKi7H1AolOFXZN2kc0bmAhya9BYHzRdYMOIZJjq0xdQ/d0/t2UklX5HqTI?=
 =?us-ascii?Q?gOp2Dk0YQ5OXBwazwDPfAM7pXxgAftzH4849fMJ5dBYGC3gHCCNbaR6FMzh8?=
 =?us-ascii?Q?irTQPFPGvvxBGZia6pqRHo0AQ3HUQ8MRZfG2pDDyu5Z7X6krQnqMCS0pIPmh?=
 =?us-ascii?Q?0uzt7cDJhidx2Zx31NraO0aDcLis3f06anVji880dUMG81XgtmrJNAONOwBV?=
 =?us-ascii?Q?oQflbTNHmDuxf+hHj/UiUj1pXIJHzUQYeo68AUvM1/Xuz3ucZWGz0VwSs9zr?=
 =?us-ascii?Q?rZCLeWPZt7F9X15bneq4Qb5uJX8OPdZmCuUO98UXHtX0kCVJ9QQh5plbcL9Q?=
 =?us-ascii?Q?Zy9YflUUpe3JophY2LLIPvyWlM4io+cyEs5oQINMg+Az13TSDZ1WUL9KdgBa?=
 =?us-ascii?Q?EIo+TYzYNbwBBcZa5hBkOwoGUOOQBT90/INzF+YyZKchryXqtkilLIN506/+?=
 =?us-ascii?Q?P0HkWJ3aB8Tc9gs7aW9PGYkIAbhrCvmVHT2u7rhRup1R2spfkITU4CcswK8Z?=
 =?us-ascii?Q?LTBqG8ywVG1jx7VsJ23GEUYkSTMieYF72o68vVXxQkVizD2zsisX/lDML+G5?=
 =?us-ascii?Q?nKLZaAVipodmUeVYQMI+L8Flt6dqHbU3QKV2ZGfW2bAkvFQ9JmzM877MLY7y?=
 =?us-ascii?Q?OIzRn3Erviix86an942doecPBVrHPICrq8MkoLD2CqBnBLGWuOo7et7NHX2T?=
 =?us-ascii?Q?EhmDgC/25Fa7af+9ifwJmn8tW/D3NluAVeVdO+x96Uqa6aGooeV4ADfe5cnT?=
 =?us-ascii?Q?j9EWfOsq/nF1EkbtGHIAFP7ZZ2QUwV7qfP4n+QS0V27ciFjgfIqhlAThS9Kp?=
 =?us-ascii?Q?aTehYGMeFMRFGJ0uNB+p6xep8uOq53HfEk1EaUKZVhoMojHPmTA2T0VgiwnD?=
 =?us-ascii?Q?NCkN7D+TizoRcO7bH1YkSYcBoltkcR4SPiPmg6AfzwCHTV5mR0TB5j3l+458?=
 =?us-ascii?Q?ZmtfwZQR9vwtNdI1yPE57z7p1fWEYRxuiIQuT7AlWG9gqwoS8BfvmxrlP62s?=
 =?us-ascii?Q?zVkPYGmkPFr7hEfYUz3qGRpSzjojVXcTPkgxiEXOrBiGQRueelsFiIreoJU8?=
 =?us-ascii?Q?/wm/XtJRMGGCowre95Y+0eCpOaOOpTxNZaPNwNtAhwI1B+ZLvJn6XxmRnxeN?=
 =?us-ascii?Q?frsYQG2I7fKUAH8dsqAgIuvoKNCpjOe0zAzLCQrrT/Eh51oYTWwz8I3dKiXt?=
 =?us-ascii?Q?RD3BqVh/J58/BKDTLMkeh9rTRaedScET8wdxGpRlaUTFG5E94qUyu4238Dfb?=
 =?us-ascii?Q?XdlzxJm9rjPazTxMK6tgj6KIbdIQsJQ6OtxT85+0M5bioQHwXWz/Gzowsefk?=
 =?us-ascii?Q?iUj1P14JPSL/Q52Vf+tje7j3tk3UIitJl6MQEsHa3AO2SmCAlbWDobuikzLz?=
 =?us-ascii?Q?oBjUjUqk/674+pmLGIrwHP1P7GlY2EC9b1m+i9grtgP5zZnTNJ+OWffAo8RP?=
 =?us-ascii?Q?GVQIEVpJPCHjPQ8AXP44NpHmw2/goUpXo4quCN1ff1QXbkgcu/ZKwvgvPw8B?=
 =?us-ascii?Q?DW2090Arlen6yooubhEd9AJ9yQeH+8Nr5sVkk2dNfyHjb6seavb9xGAO/Ls+?=
 =?us-ascii?Q?4Kr3y/6INZNs8cELC7rWpTdRmvARlxXmDfHb0zkbXyPzWYqL/pyIASQzNio8?=
 =?us-ascii?Q?l//uB7aimGFPlRdoomoADr4l1BxLzGx8qRkM7Fi3RUQ8WQpmMc9x8RUKwp94?=
X-MS-Exchange-AntiSpam-MessageData-1: gLxWVKVt/OxcnOnLcjfM+f6rDudGjJ90kTk=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b27d172c-f5af-4874-1413-08de8c318c42
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8584.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 18:49:16.8568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JUov5NtqmvJERxToCXOgSKOPB2t2T2No1D3kYmfbnG/XYMW5S1+RdAHeI/CkYp/hIAHBAuc0QaHX7w3zjQJJXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9515
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org,lists.linux.dev,microchip.com,intel.com,ideasonboard.com,kwiboo.se,gmail.com,linux.intel.com,suse.de,ffwll.ch];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-7285-lists,linux-can=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,intel.com:email,ideasonboard.com:email,suse.de:email,ffwll.ch:email,kwiboo.se:email,nxp.com:dkim,nxp.com:email,nxp.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 33363349D46
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

v1->v6: none
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


