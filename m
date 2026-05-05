Return-Path: <linux-can+bounces-7505-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FeUCozG+WmmDwMAu9opvQ
	(envelope-from <linux-can+bounces-7505-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 12:29:32 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FE04CB4A7
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 12:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C495E3067ED2
	for <lists+linux-can@lfdr.de>; Tue,  5 May 2026 10:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECB5426D26;
	Tue,  5 May 2026 10:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QoEgxe1h"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010064.outbound.protection.outlook.com [52.101.69.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FDB42314E;
	Tue,  5 May 2026 10:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777975585; cv=fail; b=NsH0aZMRiQl6+2iGVJ8uCApwSFgH0325txzfHEZ7f2SNaI9N7t3RH7oe3o5QvZxdnt0F/JEe9iaEaiIy4nE3BwKqdZ2IoFIIZjTYY5Y0CSvar+2mbviGU0lZme4VQcGgXkiLOej/DZp9fLE6WL9BJdqPKUa7oz56f1z9BcY+AYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777975585; c=relaxed/simple;
	bh=WpIWITTsUIfeE0CoYvQbWwZ2MbBnRWq69v8WJoJI/OU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z8x1wNJgHgl8wjTlCWQsQ1wmOW+UgQ8poYqdRYNepWZx2OcFNSIP8t6+WXnEGvOA9tLf+wb6lzTaPiYOXYxAAZjgLdoh9fgdQk9ar13j64DZPEX7stIhpcnvi3dKy0TNX4eQsRdKtasmJN8tQ0SY15AprrVZdp8hYlPgYdo95Ac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QoEgxe1h; arc=fail smtp.client-ip=52.101.69.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RZE4cQEM1/2ImQvHPkl/8EHgazHQ1lPBi3H1IAvWWd78QglcRcOlWkiXMj8izwgslCObUFSGnXpEbBorp+FZo2SM+2V7XweswgnO0RlIJT4sJw1wSEOWJvT8hFFI1/TnJdZWWv+/ambgrSbd9tdaaIOEhYg0peOrw/xrFRXbfN4rfgnrueK02ZsVt/ypzesa8tsVLRYxLS7F+mNDgiUuKBUtiBMSZ3jPdMUfhQlvQ44R3b8tZqx3cajrYKyyQCxXfnEBzmXp+W+FwZ6imHgnsdu/8zDL+SqCu2xd6L9tAPPA6kdd3d2sGuYfdSc3bU7cXirrusSCZj0zcwz5JvbsjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N7o3waI5FbchNnvXZdyzkDg7hgQMLHpwHSQRK8/XvEo=;
 b=mHDF64k+6oA+QFfMW3Zgwd3/nbTzHohtoNma0IcHDq2dWLqzRmWhW9ZiWqQ8QPBw6ZW38nfUI98I+OsqVbfwwcBhJ+urR+h091A5LB3SIxoc0imxD7OmOu9qhFakpe7M9IPE/ytrmicfY4NIrdYunMK+mIQfOHmsmyaiFGOuMePWQjdiY6iBhqFQDDwV/O82tNGF9z8b2kvk3tYdNw6AK9MRyUbVjaNCW/NX5nsGRoTLZJC1sQ4VpVq1bF1qhrygNAfd3WEXG4KE42fkh86/yfuz46F6t9jS2kWxE1DudsyWlyFlCcFzQzheCbdV+OWUofQ7nndz7DGgd4sDGCyVFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N7o3waI5FbchNnvXZdyzkDg7hgQMLHpwHSQRK8/XvEo=;
 b=QoEgxe1hRP4uF8soPSoD7NC3h9vrL2Dg6OPBNe8nmNb6fROKE4FyOrWgoLeXt5DKGC+G8WmAcDVWLNXRfo0G0AZwe6luxVg3GxE0DSkcwJQ22pzT2uoGMUERt/k2oPjobTV6+WLvF5ngouqjArA8XNiszuNOuDHs95MSVyyQWMlW2rCv2pWXAMtoMirXDlyxk3NX/4PCDIOz3WU+z7zcKYCDFmzAixzPsEv9OtdvkFdymypypfsV1R8gKJmU3ad8wCh8Ycdg1HacKh6bcj0lyVCU3DHI6nTqJ18Z2Eli5jYaGAmvb46ecL/YySLTr1YyJ3qq/bW7LBTYw+en27VGRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DB9PR04MB8363.eurprd04.prod.outlook.com (2603:10a6:10:24b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 5 May
 2026 10:06:12 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 10:06:12 +0000
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
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	JC Kuo <jckuo@nvidia.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH v8 phy-next 16/31] usb: host: tegra: avoid direct dereference of phy->dev.of_node
Date: Tue,  5 May 2026 13:05:08 +0300
Message-Id: <20260505100523.1922388-17-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260505100523.1922388-1-vladimir.oltean@nxp.com>
References: <20260505100523.1922388-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0029.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::14) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DB9PR04MB8363:EE_
X-MS-Office365-Filtering-Correlation-Id: 85101bc9-9f4e-4aba-ece7-08deaa8def05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|19092799006|7416014|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Z1RYYKKCKz/VO+uTid9KKTjcAHO+o3ySmvhph9kUfhA+zpKR51o1AnH6DfYOKnRZ+T1IeUvuW2pEBuWYCWsrDcVCjLJmby5jp4W3LUZ4yWJcLftWOozukU2ElsV3JkzryYfgkIhl9t6YZUe3DeHrGXHiQ4WCopa0C6aOU34ZPrNu8xVfw533csTYo2TAzfDFFwit/wNIyscGwjaOppaQ6CbhtBf8YrDnyHI22ks9uVCnFEBU4/fT7jvYGZtUVzo9BmRKJobOyl5jfRl59UfswuzgRAlqFmzyktfI2d9hon5Yhh5K/351dxJFLA4D9QScuG16TWAFiiU4mdKpd/tOCSMy/YWVFZPOHwGzRN+l7GtKSmBPHjewmcjIT6NnXzGfIhdV8yOTj40wD9tB7FgYIZhKywDAMin+61EBBjEVqWKktdXqc4HkWYDhfmvBPds6zH7pUbzAMLEBwg0H1XrtoQKSW3ws8+RBfR4hW8nJJxq12BVS5M8woKP4t3rMR0JKogvsWIdQwEFevfxnpE+yfA2U3URnUVarEUt4A3V1WWgPSX7Ys9v3lLkxRI/dZJEL3lHqnlxYEJ5MWa6wrW+x34+rcOuPVpf5ZG5drsAwheJql8ixK4gyJmoY/yOCNDjoCTER7ZcsYOuflbaOUBZXG+2Zq4qK/vlGBwNgt3r547VhmwCOJzVapclg8C5C6zF0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(19092799006)(7416014)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S4QM1i+WO3VTisiAYzK0HsrSs8uQa8DSJOycel8hlUGYszfBUv/4mvR3Vy3C?=
 =?us-ascii?Q?sImtcaI+Is7/sKrHMAGGmVcqMC9cSrYu3yy7ndRVMwwJtb26j11HS2N7jkZR?=
 =?us-ascii?Q?eQ7iogxlM8xtgYmf7LYKmt8bM0AjbG1cXReMCuBv6OVLqdNAhKkS+W2yIcVR?=
 =?us-ascii?Q?kamopEyn8cUOziHI7lgUX798zbG8C+lbpOmhNJWbaNY8XwiTo7YXFf2UJsSQ?=
 =?us-ascii?Q?aai6NIVuFCLfvyi9CWzw8meVzufLILbbxnQ/TE6vW0+7TKtzcqdttRMNxaB0?=
 =?us-ascii?Q?RBo9MlMMdCllCE57CoIY/NV6mw07r9ekF8C78oxjucNQW1m/zvx00UM+wQDL?=
 =?us-ascii?Q?+dz0PsimeEyLVDRDVzYFckbEJYHyjB8cyZIU13zvatFxjfaS0H/fRKvvyiVw?=
 =?us-ascii?Q?MVmdkN8Ni1UljYpQtWyGXcESJ0mPtQYewJ3OMUyHtP0sV3JObjJd0cOugLAE?=
 =?us-ascii?Q?XLrkxdzZUiD6+ATFCK6E8ktz6h5x6i3Z0T4SHYwTfDtC38n8mwgIaiUJOp5T?=
 =?us-ascii?Q?AKGxDR5Y7e37NwRfF+CjwA6YfCkojDuWQbdmLSM12s2G/UtGwrZuIuF3e0aW?=
 =?us-ascii?Q?SBuHu+enawoDxDQ25PEjB15+aHezu2FZQB3pVg0g3vh+kIcdiQdg2AqPlueY?=
 =?us-ascii?Q?0hu5F12Lpr9M2KODzCbolU02Ngy40cey1PgMau+BdyVKDu7cJmstf00mEYLg?=
 =?us-ascii?Q?Mz+aPjVy1XortoM8tKlb/vmWwc7cqAFJjvk52nSEf2Cn30ra8ed+zR/KgvxI?=
 =?us-ascii?Q?dBooGwvZmy6y2bYM402r5eVPJCCyRfuXunXdB1VTsIiBVkRyUaRdyQwAgCDb?=
 =?us-ascii?Q?T8JzQyNVQXTox7J7jkxUa6AmqnUZ/Gin0ZfK4od6OlQr9ldNNQ2kqTjc3ztI?=
 =?us-ascii?Q?2LyU2L8ec3+6rC54ta1qDPwnldJIL0blsCiDrCX+Da56xB6xyx0RgCR/F5Mo?=
 =?us-ascii?Q?KhFcc8nOlekV2vO0Q0Jo74t2wouoh9RFmOVzQ3ZavO4MDOfc8tSvhRdF/U10?=
 =?us-ascii?Q?jbSTCEo89hW6VP9EY3Ios8DhfMUtsUa6DnV7vSIgEQYHGybDkPat5eB19HQd?=
 =?us-ascii?Q?yid0qdbF9LRuXvRdRAWWB8b7atzQW01oWbZCBJ3kPkf31/JcuBXoP/OKbm/M?=
 =?us-ascii?Q?EU4ajoOJVhMCCCtOFsebfDjiSof64tkJbbR8njsr03Lk8AkE57bWzrg8qMgl?=
 =?us-ascii?Q?tupsw1KWS+6CnZA74fWNBTeI7zE9QIR5TzIZwczY2GD8abKOOfyXQmmuhKK0?=
 =?us-ascii?Q?6lWzVLeyi85ObCd+TRchgh5/5aAEG4Qfvz5NIDZw1nX7RtdhhBH9lrCz99zc?=
 =?us-ascii?Q?U7u5I+E0I/3GTAU3gcnsRsUE3cqpqQswe3YBjWax47NyB8fCpqUmpACV+nHu?=
 =?us-ascii?Q?LYJsLMaeCpYFBQwSmheJbvx+tY7/lWFvh7HH/yrdKEeDWPFExBSCHJkmphdb?=
 =?us-ascii?Q?p72YKYtzlO0dksQ7BEAWFSKt7ZlNZ4VlYmFbWtm5E5Obu2xYtF5y8p7aYBxI?=
 =?us-ascii?Q?V/eyU7JPxvwgs9YyJrgO6CEGnZ7Zmep/vSb+/3QoKg21rtqYM7fMw2VY5zcE?=
 =?us-ascii?Q?CnAd2ikbHqBP1YjWfxM+SRNUyeZ48pon/GxA+bijiSvs2jtfAO2x1movWSuC?=
 =?us-ascii?Q?SD9OGeuGzKRxFKHPqQH/E9LDInUbMUyOXXUoqIl0HFNA8JxG/GRHGCqX9fhk?=
 =?us-ascii?Q?DS7iyvxkEVqtFMRieaCZrZ4ogRHOMceNQ3f5lI6qHGVySA6IZL2rJEmL1Xlt?=
 =?us-ascii?Q?WBJyHQMxOQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85101bc9-9f4e-4aba-ece7-08deaa8def05
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 10:06:11.2812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lsJKMs5ZVBiA7FqFYDRl8rzADDRycG0u5BOC4GT1YkeHMYi/zcEcx0R1gKhfft2bA4T6a4LdhJtz84r+AhTgrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8363
X-Rspamd-Queue-Id: A2FE04CB4A7
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
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org,lists.linux.dev,microchip.com,linuxfoundation.org,nvidia.com,intel.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-7505-lists,linux-can=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can,linaro];
	NEURAL_HAM(-0.00)[-0.989];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nxp.com:email,nxp.com:dkim,nxp.com:mid,args.np:url,intel.com:email,linuxfoundation.org:email]

A piece of context which seems relevant here is that the USB subsystem
is transitioning from struct usb_phy to struct phy (belonging to the
Generic PHY subsystem). Commit 1a229d8690a0 ("Revert "usb: phy: add usb
phy notify port status API"") seems to confirm that this is the case.

In the transition process, some PHY provider drivers register themselves
as both Generic PHY and USB PHY in an attempt to bridge the API gap.
Such is the case with drivers/phy/tegra/xusb.c, accessed here by the
Tegra USB host driver. This USB host expects the PHY device behind the
Generic PHY to also be a USB PHY, and calls
devm_usb_get_phy_by_node(phy->dev.of_node).

The Generic PHY exposes no API to get the OF node from a PHY device, so
the Tegra USB host driver gets it directly. However, "struct phy" will
be made an opaque pointer, to avoid misuse, so this will no longer be
possible.

Considering the fact that the Generic PHY/USB PHY duality is a
transitional state, I am deliberately not planning to make the life of
this driver any easier by providing a helper to get to the OF node
somehow. Instead, implement a parallel lookup path through which the
Tegra USB host driver can continue to get to the OF node provided by the
padctl component, using the 'phys' phandle.

Secondly (minor issue) the driver uses the phy->dev.of_node again to
print using dev_dbg() that a "remote wake" was detected. Just print the
index at which the PHY appears inside the driver's tegra->phys[] array
instead.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: JC Kuo <jckuo@nvidia.com>
Cc: Johan Hovold <johan+linaro@kernel.org>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: Mathias Nyman <mathias.nyman@intel.com>
Cc: Thierry Reding <thierry.reding@gmail.com>

v7->v8:
- add missing of_node_put(args.np) in tegra_xusb_init_usb_phy()
- replace %d with %u in tegra_xhci_disable_phy_wake()
Both pointed out by Sashiko.

v5->v7: none
v4->v5: patch is new
---
 drivers/usb/host/xhci-tegra.c | 43 ++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
index d2214d309e96..6724a777ca2a 100644
--- a/drivers/usb/host/xhci-tegra.c
+++ b/drivers/usb/host/xhci-tegra.c
@@ -1491,6 +1491,7 @@ static int tegra_xhci_id_notify(struct notifier_block *nb,
 
 static int tegra_xusb_init_usb_phy(struct tegra_xusb *tegra)
 {
+	struct device_node *np = dev_of_node(tegra->dev);
 	unsigned int i;
 
 	tegra->usbphy = devm_kcalloc(tegra->dev, tegra->num_usb_phys,
@@ -1504,23 +1505,34 @@ static int tegra_xusb_init_usb_phy(struct tegra_xusb *tegra)
 	tegra->otg_usb3_port = -EINVAL;
 
 	for (i = 0; i < tegra->num_usb_phys; i++) {
-		struct phy *phy = tegra_xusb_get_phy(tegra, "usb2", i);
+		struct of_phandle_args args;
+		struct usb_phy *usbphy;
+		int index, err;
+		char prop[8];
 
-		if (!phy)
+		snprintf(prop, sizeof(prop), "usb2-%d", i);
+
+		/*
+		 * usb-phy is optional, continue if it's not available.
+		 */
+		index = of_property_match_string(np, "phy-names", prop);
+		if (index < 0)
 			continue;
 
-		tegra->usbphy[i] = devm_usb_get_phy_by_node(tegra->dev,
-							phy->dev.of_node,
-							&tegra->id_nb);
-		if (!IS_ERR(tegra->usbphy[i])) {
-			dev_dbg(tegra->dev, "usbphy-%d registered", i);
-			otg_set_host(tegra->usbphy[i]->otg, &tegra->hcd->self);
-		} else {
-			/*
-			 * usb-phy is optional, continue if its not available.
-			 */
-			tegra->usbphy[i] = NULL;
-		}
+		err = of_parse_phandle_with_args(np, "phys", "#phy-cells",
+						 index, &args);
+		if (err)
+			continue;
+
+		usbphy = devm_usb_get_phy_by_node(tegra->dev, args.np,
+						  &tegra->id_nb);
+		of_node_put(args.np);
+		if (IS_ERR(usbphy))
+			continue;
+
+		tegra->usbphy[i] = usbphy;
+		dev_dbg(tegra->dev, "usbphy-%d registered", i);
+		otg_set_host(tegra->usbphy[i]->otg, &tegra->hcd->self);
 	}
 
 	return 0;
@@ -2168,8 +2180,7 @@ static void tegra_xhci_disable_phy_wake(struct tegra_xusb *tegra)
 			continue;
 
 		if (tegra_xusb_padctl_remote_wake_detected(padctl, tegra->phys[i]))
-			dev_dbg(tegra->dev, "%pOF remote wake detected\n",
-				tegra->phys[i]->dev.of_node);
+			dev_dbg(tegra->dev, "PHY %u remote wake detected\n", i);
 
 		tegra_xusb_padctl_disable_phy_wake(padctl, tegra->phys[i]);
 	}
-- 
2.34.1


