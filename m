Return-Path: <linux-can+bounces-7507-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFkHEIvE+Wn2DgMAu9opvQ
	(envelope-from <linux-can+bounces-7507-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 12:20:59 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B294CAFD3
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 12:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 30D17307203D
	for <lists+linux-can@lfdr.de>; Tue,  5 May 2026 10:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC27142B73F;
	Tue,  5 May 2026 10:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MFN1WmdV"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010064.outbound.protection.outlook.com [52.101.69.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED1B426D38;
	Tue,  5 May 2026 10:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777975587; cv=fail; b=RbP/x57uzyAt+fjqVkHgY8i1XBHJwVAv/qZ9EoercjmtQSbElOimK7X1opcU8LgRg05yvH7Je4OTgR7cJY6sPwB3/zv28XCyF3pmEX7m/YSU7mJNCuZYNhtQFs3hDAT7WFRiHmyi1AS7vewHMJjVO1KaNOMtLDyrLG0vDuZGyos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777975587; c=relaxed/simple;
	bh=kn5oBgxC3dF7dC+bTpSz1rwLb8bY8WaNMKh7MeNFhi8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=boUoSHq0TACsodo8ab3HWWADd/RpNXRaUA0Iap9BdyVJvnosFa4PSK+OYyBdLEOBY+LbLBdEOiZq9d09Je8bPUzbpuxSqJRJgVeFQGotttCP54CK0znZl+rL6tz+r04Zp4Q3K8CxsAR6P5aU6tM38jIJ982TVGTJYc3DC1aVG6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MFN1WmdV; arc=fail smtp.client-ip=52.101.69.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KnufvZLsCxODLLbbqgfwlwnH8mfKSHpAZyCW4vijBaG3Px72k00zp4lOkOe00LCO5gXdhIGWL269E7nKBEuux1vKzzJw5tMWhWetC9AbGk0+khPDhvUMgUNBeaC8uqkOjflfVHmyzZccJLMIMtl4vp7VozTPzuaGgTPCp/dHCz5BioBKXsZqGJQ+QSmvTPXf204JLoUrISwZ5uvNTGK0MvtjNwhBn0hHVH5P4ZgcnS8Cdtxlg7PISiYN3eiohkJwOktuj1TlVQOVqOt2RZom1U54XYu7uG4ll139djnKYxG7R90gw/yWcoAIGSj3WGdyH9wVhDlBRMG1ri5UoG7eyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wZ+isOtDBiGdaQngxwM8TQfr9FS5ZBf0bZ6sYC0op/c=;
 b=SBPCcXT82m9avpCK4ae+sGH9l+8JJJaQoF0X6fd4fltUeqgUgvvdmsxt1NE7f/Wba/taud49dybRhWEK5ygI+C95n3d68wLzIC2EXuG+zfVyiM66bS3kjVsxRDxLvDnMzxIrbyhtV60p6AbRrL4oOGQIEbY9N4Vr+Nko19jQKtTeWoEq1PMxyd04ITLBQ4DxKmd1Kt0ZLRCuzvKzKa27AyH9QptSn9OWkrxLwnNwlz6as5lLfOTGPA1fCCEx2u2ZOJ1cSBBe8SYFZnDIXl9NwN9pDbGegGL9zC86BR8J2OyUgQQHVESw1jlSmXRel8V0Jpqu5+0vyMCcnqCd1W6eIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wZ+isOtDBiGdaQngxwM8TQfr9FS5ZBf0bZ6sYC0op/c=;
 b=MFN1WmdVshKNOyKNArnKkrVRHeTFbU5zssha7inKz5Dp6FrUcLaPUJNSohwLRXMoUS5ZISWHP2L2uPmiBe0T8EUJssg2OKVrF8ibpsTHPlCC4RjYPQ8VIICA2EUv3kiW8air+sgmzO5H01Qs0O3/dQzq5cnvH0xGfyUT/zjNlnvI+e/B55YT3wXN6nedyQcQm0zVr8TLxCw4aljp9gk3OVPYfScE5L3auMNYXMerd05tfVJKZa3DEGNrhFCBpPZFsiRLpiq9kW2OI25s7sKWAtGF8TYor5hVKN09cVIXY9dE1UzVLZ1kpbw6Y7VaQEBkrdoUAOcLFSCe6QzO2gL1RA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DB9PR04MB8363.eurprd04.prod.outlook.com (2603:10a6:10:24b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 5 May
 2026 10:06:18 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 10:06:18 +0000
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
	UNGLinuxDriver@microchip.com
Subject: [PATCH v8 phy-next 19/31] phy: make phy_get_mode(), phy_get_bus_width() NULL tolerant
Date: Tue,  5 May 2026 13:05:11 +0300
Message-Id: <20260505100523.1922388-20-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260505100523.1922388-1-vladimir.oltean@nxp.com>
References: <20260505100523.1922388-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0091.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::10) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DB9PR04MB8363:EE_
X-MS-Office365-Filtering-Correlation-Id: c7fb6cf6-0481-4c47-edab-08deaa8df368
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|19092799006|7416014|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	/a//P5nBkCfqnRvVoqVpEyuC2uK6kRuN/SjgLATqCvebQvEexUyjif9ijWqEKYaxrGUhM4FLdD8r8+Jh50358uAnl7fFI5vSseQ7CZeMUz3n756j2SMTjW+sWqnip4I+LsRBR27Es03rLM+c3wcRQugrJ1TjCUDKJMYac+MbklMkXjmxy/BToGgysu5Yv13jxZpxRkvnFVmxFruIutWRWsrK9c0pVhAKWj+OdFalxhFBIRXU4nnjdyEVitG4nK6rQCy8ZrxqbRY4ve4yMU9eztI4RDisK/669z2oQOOFuCZoqzs0AsNNxd6wSH57NvZ8WlY0Z8l5upgtkSGlAx2NyHBmkJiGg2W7NX+JbaBxI5pawSkb3walqpkidvxlj6gSjw4XC1FTDsrEo6qiOK0gP70yhYmSTGvch91yQHaAz3waeXjQ2YyTEQIHKsHbgN2PQF+Kd3kYWq7YP9w/8M5VJsME+HcJm4ovQl4YPAXA8gdgXU37Nxlik/t+CLZY1Sv6SDQRlHAJ6c7piG0DrujWQzR0GpvSxH199vQfgk9qLUHsk0Vvxkyh3kn07NoJrNOu5pd8tSvBYSvBB6pKaojLW5tVRNtsIlL285IG28/Tk80wxgcsnAvmWBcUy5Sga/26K2jR3LpDuLJmkb/1Djgkz87n9BtQthMq6NP1kIAbRzzEmc62UVZaKUVGKuc2ms5f
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(19092799006)(7416014)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LCHm9hycUvjg0wZUFoqWtudJSUf2D7ImSw+SvVUQMxk2AS3PfdcUXzfjwAhg?=
 =?us-ascii?Q?sWkDb/SD/bRcEk/kVDdhz0+SeFIQNSCa1bckQRgQkMsf2ocN9YfDqD7X1g3r?=
 =?us-ascii?Q?HqZ7In9vKlnb7AvA+W1VHDn/wADnOnvkD52qnIqeC3vXehfHbIgtO2K+RzdI?=
 =?us-ascii?Q?gEHl94ANpM9OdtkER4PYzXwM6yUbzuj2J/i9XKuhv8vWSkecESmmSHV2N0CO?=
 =?us-ascii?Q?/bEsjAJG46EAX/+BHkq9uIWnUAWIyVyJet2snb9ekOlJ7/x0x+y3wmoU/XUF?=
 =?us-ascii?Q?KwX8E8FkvsP0iodZpvDlq1jm+Osz8GNZKBt6EAVcRIFhkWejXmyWCdIpMOjX?=
 =?us-ascii?Q?qldXMU9sZvZaPSa/ufS9gSniAEM5tYu3tKZ7mnyJFRhCFerkzdUMEHoUDLF7?=
 =?us-ascii?Q?eo4qUP1hvSh86ny4RNNt8P7AwsRfJoJhyCvSLROq90y/fQdUPjGuOly5fH7E?=
 =?us-ascii?Q?NMbp3x45dPVwwInzr3GPQUX41eJMZuH4Yvrte+++yo/D3uy2y9xsDM1oj6lp?=
 =?us-ascii?Q?oE7YXUUvnb8JwiSYUHfz+tK05fN9k7RF+DsZPzthOWTxST861tpfE6Fvnma4?=
 =?us-ascii?Q?pMxFGDMUVlFn+HUgfQ1nMWDOuMHQf+8vN2IPVo/YoGtFrRGNOSxjNttf5HRi?=
 =?us-ascii?Q?fRBRj5sAufWSQ+Iz0cUSp+tLt8r5ZkLlLCLNYLQ4RZnQD+HqP5DrIMXqkoAt?=
 =?us-ascii?Q?iKhBg/JIK8J8ZqlUElwujXoIR+i8WcUCZ7IbWrtSj5vF8yALIRxeYArkarRV?=
 =?us-ascii?Q?8BdGAWVSzH1WCZC5xEURQMg+/1g5pCpCb4YWFDjfuBmErPqS9TrWdpUfFs2Y?=
 =?us-ascii?Q?fjbNvMUL8PBlw5/pSlnNkbGNvtR6dKwROco0ChzI71ee8J4dk6b0+IZkIk6p?=
 =?us-ascii?Q?YMMOQhbWS4Za321/83hEFR/rBYlYCUeeSgyJApm7l8jW4/XwS1aYxX3hqUBC?=
 =?us-ascii?Q?9a7VqwD25lwPNDCwUk2tTwfBPisQiHUviaelzDOK3M2aYiyDbP/sMlc0clGN?=
 =?us-ascii?Q?cnOjjkakxknTnJnOnkmaZhGO7/QfxCn9ySvy6WOTipWF0yLViDDIqQZ/Z749?=
 =?us-ascii?Q?VVCSJvwO7iOfS8+5TS3J8VHziVgld4hKJnSCynErTNfcUv5aZKYqJ7psOmGJ?=
 =?us-ascii?Q?kim+3zPDVeDBZOw59GgHkpPN2dvam8dweyJysSzXDC2TG5Dtq77jbq+XjxTs?=
 =?us-ascii?Q?nUyBpPq07rNXmO+8EdCBtUInnyr7R2qR0Bm6D2rJVoplzStZrxAqGlAUf0Zp?=
 =?us-ascii?Q?EQFJmUWQ1A3VoHzTyx2SyWihEZFoR5YygelLkJOUQ6vJWLpmedSympmWp35F?=
 =?us-ascii?Q?FmkcdVrep7g5WH5v3rnt8CazH9AcsmclA2IbMa5V2pVvyQci7JVBivNc9OvG?=
 =?us-ascii?Q?siLzuZbSwlA7nkwDURufprTd2rVzSdIKeRHZU/3IGmgqs/kZz4cxwbYl4XGp?=
 =?us-ascii?Q?nxeJ3G+rS0p9REhJKLgP/fDYss+cMhOJci6Tb/fyx8572zbFCUle6GRg5qk+?=
 =?us-ascii?Q?UoobbqMZjJjw43QJnLdmoEK4tuwJ1MUUecanPES5rCSTZFpLihvDnBhbpzAS?=
 =?us-ascii?Q?0Ii/ufUhlz/Yw1Zl+oYU6dzuEY+el0xJRmXHMiNrRbC5UI+OdXO6m+p2zTFR?=
 =?us-ascii?Q?EMfIv24S+QsRuxukz0IQzvaMLGJ2uNRwzd5pxRj6AhojdXtOure5ldx5+dpa?=
 =?us-ascii?Q?HsZ8yZKZQHBjQPDdZqe4oBsp+GVek7V12frKITGp6LiAxt5N/CEncg0yR228?=
 =?us-ascii?Q?+2llez3yOQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7fb6cf6-0481-4c47-edab-08deaa8df368
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 10:06:18.6754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KvyEhIHLQnmLBRKszQMYOPkkkFVb6nyZ2yYGSCYppqzBghAF7Ues+fbv85bXGghMCX5WynQUNFKY3Z0hMoyCTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8363
X-Rspamd-Queue-Id: D0B294CAFD3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7507-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,nxp.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

The PHY API has an optional "get" which returns NULL, so it needs to
accept that NULL coming back in.

Most PHY functions do this, only the formerly static inline attribute
dereferences did not.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v7->v8: remove phy_set_bus_width() from this change, it has become a
        provider function which does not need the protection
v2->v7: none
v1->v2: patch is new
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/phy/phy-core.c  | 6 ++++++
 include/linux/phy/phy.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index fe933629286b..6cd33204d2ff 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -624,12 +624,18 @@ EXPORT_SYMBOL_GPL(phy_validate);
 
 enum phy_mode phy_get_mode(struct phy *phy)
 {
+	if (!phy)
+		return PHY_MODE_INVALID;
+
 	return phy->attrs.mode;
 }
 EXPORT_SYMBOL_GPL(phy_get_mode);
 
 int phy_get_bus_width(struct phy *phy)
 {
+	if (!phy)
+		return 0;
+
 	return phy->attrs.bus_width;
 }
 EXPORT_SYMBOL_GPL(phy_get_bus_width);
diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index d716e5e0584c..99d3d65da614 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -248,6 +248,8 @@ static inline int phy_notify_state(struct phy *phy, union phy_notify state)
 
 static inline int phy_get_bus_width(struct phy *phy)
 {
+	if (!phy)
+		return 0;
 	return -ENOSYS;
 }
 
-- 
2.34.1


