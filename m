Return-Path: <linux-can+bounces-7117-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKiYNQHfuWnNOwIAu9opvQ
	(envelope-from <linux-can+bounces-7117-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 18 Mar 2026 00:08:49 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C359D2B3AFB
	for <lists+linux-can@lfdr.de>; Wed, 18 Mar 2026 00:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2C8B5304F5BF
	for <lists+linux-can@lfdr.de>; Tue, 17 Mar 2026 23:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537583FF880;
	Tue, 17 Mar 2026 23:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="R+Je/vHU"
X-Original-To: linux-can@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013010.outbound.protection.outlook.com [40.107.159.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696463FBEB3;
	Tue, 17 Mar 2026 23:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773788762; cv=fail; b=m8vy5KIhzX2xUt51/3Ge36WhaaQLjycLgzz/a9gNFK0sINoG6kh+wkKrKfKxCy1GPj/TVAoxsCWs24Hbk9pWlADg4vNIB1iW9/G7ZJYe33dF2PLFUdOj+0Mx7tfQmiV5+Jvz2b36soQOCvSq/k21BtjFa5n5tBqaiDTPxarjCWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773788762; c=relaxed/simple;
	bh=BkweOs5cd13ezmZ52j7gqQ1sNW9iIJ48k5Sjxg8Uylc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ILgEYcs/ApTqlXKHbLnb4Fl21R8O0Tk4cWFOZ81wLNkbdlRUmEQg/ZNjA+ovkzt0d586PHJzPaF/8kypm+Jan6XOj2A9Q4u/MXh3ANiCiyCJ5J//ftQi3I4scZ4Li5uMU1gvJESZyYTp57QRcOC6ffKjE/f4ZjK25/CUk5Z6obs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=R+Je/vHU; arc=fail smtp.client-ip=40.107.159.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E4tRsvhQ3AuWT2u3w5QHUUtXg7LGYeSc/Ot4c+kEdiLgaw+SHUy/stABTBxQXhlY1X9qrvnm9JIiUKhEOTtLZjugZ+8mtabdQF/r20M2OKHUKHkwZmsvx7qSmmh9+WAIPd9uhKGpbyXIBWwEJcYt/WPE3FkGcdqC8hOmjNDzM6rMWVDHQMskq9auRBiI/WiQtyErnDKothygC6B3UxbvSi+kNpQp9BklwmabxFGC5UkaTSCz74cHlwz8DCMv59a9GbVJ62cHKj5Qi46LW9YhcYoZ8gVIFQiHfZjzhRfd483OlgC/N6+mw+mF8p+zRufPh3e2/Zm5yXpyXWmNSEVQLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C3xJGUAeDn8aEd8m+j7PLlWLx1NrgWNapQF0jrRDRkM=;
 b=e2prLlCdTj7cKxPLZI15KLM6idTLxQpSlgGp4kOJKIejD2WnoRdxVpNQY2qsEyHcII1GN///0JxhqYOGxLKoiLqIHjwNUI0K9VMRoYIBWKjdlJFShKTJPQv86XG2tE6MG9PfQq9k9fm/5CiifbiqyVEeIbZDiyI+F4HF0KK7r93TEkx7bo5yuzXKnVQNABmKsv4O5eMA4VPPlosC7mpiVJQQ1GTGS5jzv10CWuR46aA70uu6jyDrWuZ1K0haau+0e8uo08sct0w9TXzn7tNOMLLiafAdN92c8dqtZIinJPZPWB1HqK1B5D+NJqUyzaaKYS8d1iyoN3hrVkH6rn459A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C3xJGUAeDn8aEd8m+j7PLlWLx1NrgWNapQF0jrRDRkM=;
 b=R+Je/vHUXgZxoROQpn2LwAPKKrkPy08qlk9yoGM66GDt0tfGnmJqbE99T/l+oFFsD0ATntfJmGqEqZKPldvPE7wadmPbHb1VdZ1Sg/9WIfroGS7hyNuoTtLl+6KWIXHxOguf9AfaeDPAmKti95lxns7Fd5+JBbT49KfFxG1UwFtoizcA3aufPSkJQqs7apl9BRYaMQEIc/6yI/Xdk4jsKPpxnm11rzgsDlShWWhVL5sqo+O/PhcgJHEVySo943NCpTqg68VG+aUNBI92DYwj1TaETqz/ovNsDlM0jmXk5dHAWZFpq5J55/Rcw4uzUR4egmQPBqK5KOjDtOz6tlFQeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DBBPR04MB7643.eurprd04.prod.outlook.com (2603:10a6:10:203::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.27; Tue, 17 Mar
 2026 23:05:43 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9700.022; Tue, 17 Mar 2026
 23:05:43 +0000
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
Subject: [PATCH v4 phy-next 16/24] drm: bridge: cdns-mhdp8546: use consumer API for getting PHY bus width
Date: Wed, 18 Mar 2026 01:04:52 +0200
Message-ID: <20260317230500.2056077-17-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317230500.2056077-1-vladimir.oltean@nxp.com>
References: <20260317230500.2056077-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: WA2P291CA0018.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::13) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DBBPR04MB7643:EE_
X-MS-Office365-Filtering-Correlation-Id: de73acc1-73ca-4a3c-35c1-08de8479b71a
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|19092799006|10070799003|1800799024|376014|7416014|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
 1fEzR0XOVOTfQF7+ESJpfLfZ86ivJrCKLJbDY4APGUnp+tsvCghJk73TXnHsvMbS4LRL7SSkxvlCkcppNjwccRTg3vKQheZLbHAYfxXjozDoGvluMoek9qz5ERQJqaQqI46MzVcfHYUVpAQpmZdM/BJNYuM4neytKzyqSGg6YXxvl2eV2QccOezMLrV8SdpcEwR4Hg611xs9PJNZseUmRqONCWCmQj+7Fev6BxKEGDTstoh5rNZd4kQoBVz/4TTbKQvzWsCW1WkuClDtffN/gNzFTrj+IdUkZ8UXeigsG13+gDlo6U7eEoPvNZ4E1VncByvSP+eCth3dJU3IYWRcMBjcA0uLLsg8Zoc64xotZu1Iuslt5/giF4dqD3nMo5GUKMxdpGNwfglsBwiY2nQQNusITOLZa+t/uSkSQoLkhqvtkjaJuOIxJvv8OVCIqpdq0/Xex+BUdG7z4eHbGY9w3oMb4nPCjppjBXEHOXjRl7Z/MCAZfC0wLOARjVboSiGCAWI38pNMU6R0LdRS3SNq/vrXt/wcFz0KNMWV07/JRFCwWIjRf40ua82v/KU0FBsANx0oO4OwCRPiPXRuj2MoTQNhDaYISDDzFQbuEGqIQ56N8905Rze/k2yYPEIc00Gjue6yNJW+0M3kJi7J5wulSJsjYl9iywAUFLk/X/zfP+DCPqukfNXzG0XooZ63UmMND1m8BMjU2t3hLknng1ROsfQpRPfzr01iEfvzYx4z+lE=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(10070799003)(1800799024)(376014)(7416014)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?xmmgYEo/2nq1Rm6mPpahC6Ifc/ZRTaMJCq7lCw7A8eZFQSjYBQk7aIngv5kv?=
 =?us-ascii?Q?j6+HVx683QAss8efpJ9i651VXSiKjvD/6Ki64fL/f6+z7k7XBudUY22yRDxH?=
 =?us-ascii?Q?xCc8Bla0TU5UjVyfVsJL1EA1wMQdFhlJKyEcg5YTQYlAnRbFF1UZJG5X+wNj?=
 =?us-ascii?Q?b0jwjCyRmfkH7Q8dC6/AMgpm62N8p9ZjeOWzAzI/iJ6BgRZjO630CCgbXixc?=
 =?us-ascii?Q?C91kZYW457xYzEsM1KZvp2qNUfFZcdFCC5rgJJsfkKPk4g8qw9YPwBk3twq6?=
 =?us-ascii?Q?v+ex6wJf0Z6xuSMnCMzhz755vs1934zu51GYBip7sloj7oWu2ckdlaHa0UVL?=
 =?us-ascii?Q?8lVPBzwHdHxmycBL9XooSlkTwD1WGlOOLJSyzD1a/L3h5xh97Hx0k8/YOD8k?=
 =?us-ascii?Q?2e2hgCSEDHV+N/8F34QcK1OGAjfXhvNboUiVt9/H7CFlFQW8VIhPpMwR9EuO?=
 =?us-ascii?Q?u+SWJMbZkFC2Qeua4CJ011Fhdp+toSVjcoOZHB5Rrp1U1wZ/Rt0MVIr4+pUN?=
 =?us-ascii?Q?4GH7Cn9s1WJbi2jyLI8VtYZbKyk+0jR+qW7hEKeCfk2YtIwGENylrXsZ5o05?=
 =?us-ascii?Q?JmJzgZy596xa8Qo3fK9NtT/FKLdSCy5xB62qulaS73OuelmNGhv31VuSrUN1?=
 =?us-ascii?Q?xeFr6hEKRFoLqKpBwV/cb98fKtEZoyOyzfgNm7oCOZTNx876617H09T+6Bal?=
 =?us-ascii?Q?WCww+YiptxfayobX42KvB9jH0oLR4At/bipybXZ/PUAGMQ8mYsxOnac3lJeO?=
 =?us-ascii?Q?JRP4ByhvIQZVBMnw0AT/DZlV5q3mTrA0jWpFpe+ab7JLrDHupcKVkBoIe7b4?=
 =?us-ascii?Q?AjFLBwTFTlppXKO2OF/DWLibw9vr6T5Pfg4Fi2HfeenbGcroUaBKrySiJkx5?=
 =?us-ascii?Q?LVHfgAwqXmePdx8k5bbFdXY1hDPHtLnyPilnrYVTPSife68dxD7897/yQWE/?=
 =?us-ascii?Q?dMg/R0rnr7GzGqK6g/VVAfPPaw15YLFYhJLf9ZwwIMAPHYgsZKWBMS0eHS4E?=
 =?us-ascii?Q?HWzWHLNgvzVob40RkYvcRH1vpKfzevQtkAaGW/9hQMCBBdJdV8zGY9FCsRm7?=
 =?us-ascii?Q?Li5SIi8wxlHND2rBPueUpwcEyp/BYBxj9HJ8KrIPJ8Pyu/N2o4ggth/fOb5U?=
 =?us-ascii?Q?fSl32408ZrW6bsPBrD4OCJWs/PSOMkN15gC3aXO19X6RaEMbL6m/TT6jBf/1?=
 =?us-ascii?Q?Nmo64ApZpBjSo9tBy5VqKnxqF2jZclcXyp3mibHh8FAmC3JIRB/FL809Ic4N?=
 =?us-ascii?Q?E7gh7idGIEMPKpAK225ZZA8OZseyzPPpkDeIFwrU+sY4m2weFBFByj2iI3ky?=
 =?us-ascii?Q?pTmYhqRYH3XAaLg3zvmydWM902vSgd6/6wrf02MXfZmFr/gyH3+RyudzBzkf?=
 =?us-ascii?Q?JL6YSDLwAXbMuCiqmzVXtijMJd9ZoKlDPVWcyLY2mF6O6sTkjG9CL8Q1668H?=
 =?us-ascii?Q?hQ4y+LUBP9ksIgxxSN4RoL4gGp2scYkAPWTY4wQV1gviEqpysfoP7r3KV3nd?=
 =?us-ascii?Q?/eMeytvZgtuq1x/GgukWpZuXpVpBcFQeLsawY2zEpdVlTkmFcfboifcRN2Sd?=
 =?us-ascii?Q?4aNlOofoPDfojX9W5mJgGcc/FNb3TJyRa9NVwRJdKmY7uQPKMOnWGTaM8fvp?=
 =?us-ascii?Q?TFAimxCsDbURtsJV5bTRpRsDCVF+n3Gqoo69bkm5T3tCBUNIbzQySnMVFrM7?=
 =?us-ascii?Q?hUWBdxq2lfQEuEnrdCxuy62xIWnEjbv5Hemra4FpdXlVENQdn5Ne+YQa1aF3?=
 =?us-ascii?Q?LzYV+8LGvOiqYnF6FSZonvS6JL0mGQ1CsI2SzHn5jHrFyKL0McbB5BVTVt+W?=
X-MS-Exchange-AntiSpam-MessageData-1: gH+bg1gqzA6CNQllERacN/mICV1gWKLt2Wk=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de73acc1-73ca-4a3c-35c1-08de8479b71a
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 23:05:43.1971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rMN4+6oCibhBHupJnOYGX9Sp4U4vCzuvnry3HQ/NN/vpk/qrmLnbduRbxRZ4n29RHLqksmV8VoFtje2oTfgBfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7643
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
	TAGGED_FROM(0.00)[bounces-7117-lists,linux-can=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid,linaro.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,kwiboo.se:email,suse.de:email,intel.com:email,ideasonboard.com:email,ffwll.ch:email]
X-Rspamd-Queue-Id: C359D2B3AFB
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

v1->v4: none
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


