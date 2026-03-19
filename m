Return-Path: <linux-can+bounces-7175-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6B4KCE17vGnOzAIAu9opvQ
	(envelope-from <linux-can+bounces-7175-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 23:40:13 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FCB2D36AE
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 23:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 253D9307647D
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 22:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A786740F8E9;
	Thu, 19 Mar 2026 22:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DZSaBjNf"
X-Original-To: linux-can@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010071.outbound.protection.outlook.com [52.101.84.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1822A40627E;
	Thu, 19 Mar 2026 22:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773959600; cv=fail; b=TOgHE92dDKuhwoOCxcG9kDQyVUp8ZsTF5KN2BPYpSlWdbkfFtYqiz4NIa8f9KbdNl+Gb4lVnkzPpt7LEY3n9qi443zaWDff1bwgT2S6q6ltooxHu641ZyMKYyylKnW9FQ5KqMkT1E24Tm9+QgVEFPfKQg9WSSVGc/zkCEAZpYuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773959600; c=relaxed/simple;
	bh=qlakZG23SVKcOy+FSIzGdecTeQ8n+BsuQbH9MWlVCFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CwSUVgJ5AGJtW5HkUn1ohLqXhON6/V1CFg1w0C0510QW/C5N0I6UFcjM20405aNdIreZCTD9FovlxR4OP7rO8Io8gKmGO6Z+uNMjYpvc/H3zrL+wqlEEHXndbHA/5MSEN5Zw4MvgkA0DhtpF51P+1gnXvRWxtEi6kLKL85B++8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DZSaBjNf; arc=fail smtp.client-ip=52.101.84.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wt8M2EqX+GtzNNRWwm0fJLxUlmaTFMyqDlKL1Sea25erXQF4hFQPjf30cxOYqF11X0+P3z3Nvr5Dl/F4aumzW3GlR2avvrs+W02TYwLVsMnVZ2mGVbzpTfHRJvI8FAxebRvh58MsuJsl2Vnf5SSf4vEJhvpZkeZ84evkbPHfKR+H3B4X2C441FvYluwq5i9SHf/iGucrk2ZeMmbjaTZpm3ayUMrsolBp+9Ow5vfv98WI2rEU3ERwgr+7MMCdaLuZ0+jr81n/HHnqMMDHw92OFT0j/oxv2+EBgY1m2rYDFdl8SMEBxwZlnngmB12DYYbqjoQEttF5Xc3OpxxnkBPO+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NwPzCdR9oQFjNkW2qTUlpL5D0InEz/Mg8gojRKQDHGg=;
 b=jUABx9V8dO0sNl0IfhpmUAclf6S5LxeJ7jWRrBC83d28u2pdz0g6gaE8+qLNdVofL9na9coyQsZ3JMOrOhdPazI07DNYdn4PKoM5CxdvRQ3bgZIcgGIRx8SNOSAXU9Sc26Jeh+M9m4kcpSicmxqy1MlH7onfAKBKGfYUCvqRQmDvwpjrim/A/wwgOc5HLQ9tdUpQkhl4tn49JfB3hZ7eOafvIwawWLhcIOYkykJoVzqv0UfI/HOxyhMn2PKmtdTbTsDNWbq7EuMQd++rlkgXqCKe41EhcmC/0Hzpm0Mf54ghic5BGq9iwS351oAQJGoviV+MS222Wf5bHO4Ve+C1cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NwPzCdR9oQFjNkW2qTUlpL5D0InEz/Mg8gojRKQDHGg=;
 b=DZSaBjNfMCkjPIsLbcfwEHxETfJDo7fN0hTG4t4ArXHGeadayztoQMTGUP2PqJ1/n8bbUkPBiBVEXBonh4/mug9IZz0ALyVHb6N+avapE9PkmJ6QVwuy4r5ZHF5aRUUjZhnAxTu7pDXDZL2ow86z/XSnz5fN/BibuJqiygp78ZzVtffolxUF1bC3ygqpVgdZUMub4CDwJVTsDvGiiO0IZyTY6dwjxlzunMBQg+26Nv/E0f4H5KdqW08sspXO51jabRFhC5cD357Z42ka4xXTnOC7hdthdTOo4I6kVXevLibT9i2lGrJKaHeTGoieGt5LyzRvCg9dgJkNLBo4xGmECw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by PAXPR04MB8079.eurprd04.prod.outlook.com (2603:10a6:102:1cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 22:33:09 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 22:33:04 +0000
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
Subject: [PATCH v5 phy-next 12/27] usb: host: tegra: avoid direct dereference of phy->dev.of_node
Date: Fri, 20 Mar 2026 00:32:26 +0200
Message-ID: <20260319223241.1351137-13-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260319223241.1351137-1-vladimir.oltean@nxp.com>
References: <20260319223241.1351137-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR04CA0119.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::17) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|PAXPR04MB8079:EE_
X-MS-Office365-Filtering-Correlation-Id: 251bb3c8-3389-4c48-f012-08de86077c3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|19092799006|10070799003|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	rMLN4RFtjU8pfh1gNeT2OTHrnlNJhhJdFl3yqgchmuoQwG83ytKRPt9859F9x5bNiiiJDzoz2yE4BHJmkLlaT5nGrWtDLqyYPyklrWOIRuNDV7h7WEmQk60/2eu+RSRL8niao+SIBimXT7e7/iuG9VcTR2P920S7pRX+VbcMJawZBOGbCF/pBsFHGpUsYY1cPFneMSEeJOrlEUZJ7xR5NwQq01dSGakvWMkZKudVgxSkuHNwFNALTWM+rQpPiF6g7cxeuv+JpFfZ1vwUaWfxu8GvgXEJdvcdYMBPYeShAQwEq3dWE3fgNxjXWOhIlzfbnhl5Kp0q+USyoRK8l6ATpidtbO1c1uIG2ITl3emTIk/6370ibcCSCXfjE4DdKlF/q8VHPydtcEOflHlqCVtnWC7nWnxh11BW9ywV1ysNrbzRxkv4ng1hmUzNTAhohbcKY688ghxBT51ghR6l348M0MJhUVD5/BQG5MRfXswA1Y1ukjPmhXRveM7v43M+kB/5uO9l9IlcwK1+mckU3MsGIUat7k7eXeKkkEmEBK9PWOxnxi+ywfTioFZ6aXgj6IcNAl8QF4pRi5JoXPNz33sK9HBWdWnnFQQ8VwJFc+wOhppV240PLcftM4BVRpEPmr7xPwJ6Oqz5bEPNzhNQOLpq84pNmKBWohwbFl4ODekE/vLEiBUhk/ktU4OokO2NqF5qhD5Qg2Rtr2Z6TgpTzxKwtvfEpTx/1x18Ytzh3DI6G4M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(19092799006)(10070799003)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gKVhi07LsqkxdWsWyf1mpt7pQ8eFb1MEsubi1jjZL6eK93eZA9ym40fFR/Gd?=
 =?us-ascii?Q?b93J6oRca5I7ujTyBfkyOYh3lJx8IBwk+HKUDPaSyCnYrjXNwlA17haBQnJ8?=
 =?us-ascii?Q?XJwTsZ4VrrYN0jWJTTG9SUCNUUOISrZ2IuT1oWIEX5/1xez7kaxcim4ay/+d?=
 =?us-ascii?Q?k4BOxVMEVPsaLkXOC3MidthN5vmnK3J8OeWcJYIPI2ldSZzQCOHuRQW/CX6g?=
 =?us-ascii?Q?0Siidp8d9Xxq9cFtUwYZ66yhCcZcoMjBvhrUJlYIb7PtrXtmbwiQsdK1j7yY?=
 =?us-ascii?Q?uBRnuL8RlzP/c1q+xqPuE411n6u8d62+dHZAJP1zJQciePtAsMjX+hUO2KCQ?=
 =?us-ascii?Q?sVpe04mGROng7v0PMaxNsl0dx2Ws/QgI2uBqPz9TRpLHMEFLe6k3PgzfwCzh?=
 =?us-ascii?Q?urNk4F4dZvZzYq5ZhNov7SpIb0WD9JtyjbBsIjv3Z0QKgX6vi80fVNLjJgZw?=
 =?us-ascii?Q?9EU3hF2ZUVYHjvAuaVQceAMeShIb+vFmVyhlUt3Co4P86SXOU6njHAoXFFKJ?=
 =?us-ascii?Q?ZGRtDJxzfglzxTuqjwSTwgf9FVFDOqqX46DBsKZl0orBbaO+8yBIs1tjjeti?=
 =?us-ascii?Q?hJR/Enz7KJ/bwFuNMP/o/SCKqCxS5y1XByU1vp4FyLfIm2kcafXwuFiKvQp7?=
 =?us-ascii?Q?oRZbpT7hp8QjN3WMXbATxfIVXNXkfGIAmE5t9Yxk8/58NeUCjKogVONfAkmt?=
 =?us-ascii?Q?BKKmnvgm0QY0Gnwci+4Sa9qmbYQpkpfs4jLhNDlDf+pBPDYKiEpeVc2u0ntK?=
 =?us-ascii?Q?bwBnVx/W1CKYfN/Gw/2C2Zzc5A27ckIKTtXfew7YqmbVqQNNj9Ri8trHIGlh?=
 =?us-ascii?Q?A+R81qc9DKocs2FxD2WsoCmp2ivJfQybjVlv76xEeFu9zmy1kmgaePfuRT7n?=
 =?us-ascii?Q?/S/vAzpLPp/aH5KHVwc3A+pGFncq5DklBjUCM1MF7iqNPr5SStpF26GEdu8J?=
 =?us-ascii?Q?0QcRb9XDV0jDcFldPXAVP956e3OZ3kGeb+MwzPKvuWaxq3TIs8aZfTN0sGu9?=
 =?us-ascii?Q?oLjeWBBx8gPm2I+ceild1pZjFRqm5ijm9bLZBu3PtA33xWWnx0YgxPN9K9gD?=
 =?us-ascii?Q?FT/5auD9QGvHPFOIGFgWNosa/HrXabcnI1/6+ijCbN35VsDmxF21ehoMUrz5?=
 =?us-ascii?Q?iepdgubZIAje/zASKzygimwA69ffc+hm/XWSy4YbqJBidOCCcM1dvw6UEi6s?=
 =?us-ascii?Q?aeXxZd2XcQ/B7BjG58uqr5Fs4tvqN0PKmsd0GgaN7OxF6U+dlskAu4IDFlq0?=
 =?us-ascii?Q?ClBCnH//wCEHzDB0YNvOErjnr4LJA8q2VHofCWpC/bQDxVuovCOxPEE+4qys?=
 =?us-ascii?Q?y1mZforchzdSWViKSonUsIITI93SeXtoBovhgtTUhmFN0/MMj1WhMzpk736g?=
 =?us-ascii?Q?xppT9A868vkR5flieu+lJtU9NzPFCCu3J/uLtKRxTtJonXm72Zm0fZd32k8O?=
 =?us-ascii?Q?ryJyooeHFJSMq3YFnQTvgf02YWcZaZIjyWjoGX8JwadY/+FtLVu00fTU78CY?=
 =?us-ascii?Q?yoh1LgWjt+OtI0NAB1AkdojdXGOl147MzZJg8RFt0YCwFj8+I/iTN8ok+KrE?=
 =?us-ascii?Q?ZTfTZeHWEcf1Mj5fcbrEKM0bQN+sldWmldfbvVp3QnjDiUV+zOEQsE7L4e0c?=
 =?us-ascii?Q?/Ito2EIaIt0S8DRKtcsUReMPTX3p1W8+TXMNsaE4hiT3Ji4Z6Sk7LDRaLypM?=
 =?us-ascii?Q?WYHE/wjz+T2WdDwWxiudPcIHfuJF8g+DuekELaDpfY+tKH65LBEhktmuMeg/?=
 =?us-ascii?Q?6NErwXTIUmqyii/zUQaviuaAW8YeWgv/wekcd5kEaetyeY15l8e7Y05pSFvf?=
X-MS-Exchange-AntiSpam-MessageData-1: p5C4czHjKYd37j2Rijoel3nOOOfRS9t4tUs=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 251bb3c8-3389-4c48-f012-08de86077c3f
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 22:33:04.1720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SPRyChECR+cvfihEzs6ZwNpCxLvEDzcBIvKr58EKZmlUJT6tjaqJ987hQH9JRhqg/xHbBWRyqbcHqYXKR7VDwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8079
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org,lists.linux.dev,microchip.com,linuxfoundation.org,nvidia.com,intel.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-7175-lists,linux-can=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.945];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,intel.com:email,nxp.com:dkim,nxp.com:email,nxp.com:mid,linuxfoundation.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 59FCB2D36AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

v4->v5: patch is new
---
 drivers/usb/host/xhci-tegra.c | 42 ++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
index 3f6aa2440b05..46fee219e09a 100644
--- a/drivers/usb/host/xhci-tegra.c
+++ b/drivers/usb/host/xhci-tegra.c
@@ -1495,6 +1495,7 @@ static int tegra_xhci_id_notify(struct notifier_block *nb,
 
 static int tegra_xusb_init_usb_phy(struct tegra_xusb *tegra)
 {
+	struct device_node *np = dev_of_node(tegra->dev);
 	unsigned int i;
 
 	tegra->usbphy = devm_kcalloc(tegra->dev, tegra->num_usb_phys,
@@ -1508,23 +1509,33 @@ static int tegra_xusb_init_usb_phy(struct tegra_xusb *tegra)
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
+		if (IS_ERR(usbphy))
+			continue;
+
+		tegra->usbphy[i] = usbphy;
+		dev_dbg(tegra->dev, "usbphy-%d registered", i);
+		otg_set_host(tegra->usbphy[i]->otg, &tegra->hcd->self);
 	}
 
 	return 0;
@@ -2172,8 +2183,7 @@ static void tegra_xhci_disable_phy_wake(struct tegra_xusb *tegra)
 			continue;
 
 		if (tegra_xusb_padctl_remote_wake_detected(padctl, tegra->phys[i]))
-			dev_dbg(tegra->dev, "%pOF remote wake detected\n",
-				tegra->phys[i]->dev.of_node);
+			dev_dbg(tegra->dev, "PHY %d remote wake detected\n", i);
 
 		tegra_xusb_padctl_disable_phy_wake(padctl, tegra->phys[i]);
 	}
-- 
2.43.0


