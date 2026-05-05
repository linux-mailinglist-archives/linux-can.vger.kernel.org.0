Return-Path: <linux-can+bounces-7514-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WD5JIAnF+Wk7DwMAu9opvQ
	(envelope-from <linux-can+bounces-7514-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 12:23:05 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F494CB110
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 12:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0D3AA323C805
	for <lists+linux-can@lfdr.de>; Tue,  5 May 2026 10:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33218344040;
	Tue,  5 May 2026 10:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eT4kOB2t"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013037.outbound.protection.outlook.com [52.101.72.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1D144BCA1;
	Tue,  5 May 2026 10:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777975602; cv=fail; b=TeB3q4n3anAdi52PrCag1BZQlCLIuk8p93ZSrNjwKxtpia9GlzIv9t/ldrVaXtSse4/vqdAev3ecAxRH4jFNHFQ6ZWasOsf9uhq6hEedxxFVhKzAMtpkPYCOZSAYJjMyW02TCXxzNp7bnGbzdZjWs2jQGrZGUplr/RjQHQkX8b0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777975602; c=relaxed/simple;
	bh=jsE+1eNwD4qZeFBZl+gyCyFS7W9Kfa29dubkDs2pUvE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jYJbItYqloTOHeInEf753LcP1/POFd/5e2x5cmdT0e8CtwRyxdNRweQ7xqiBCV5Nwi3kani0yUzQENYCEi8mE6POfgcoKQHjPn1xpx5r+G4Cbv2ulJUWU8LmFre+ppbYb8KIOu2LIZovzcoU2UA3rrM2BjpTVAB/2IStMxDn7j0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eT4kOB2t; arc=fail smtp.client-ip=52.101.72.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qq4KvgzhDTAw2zsUPLD44srZjeE2tu5nBSlaJ1yICe3HpkL88twO/m/rhnUP2oRZuTmbGs9ndvRTccZOHSECqNZossD7MklW0jM+bJ0jqskObDdYBsYJAKu2Uk4ZEhY5iXQ0rT1mAwGk5y3+mlxEFu1FQuQUVYPGNt31wnDN8U3LbgLlDQCRExMtRZ54tu6WbPVYnrPMiFTPDmiAXQ2as9xlEOSwmN7YtUjFhWu45YWfoZrARXxvJBTYsDvckJzsnjsTQvv2Dk+2F0eithH1vz0admb9bRUhrdT5Mu+jTViLuR3oVy9q6pWxbptKA5jpOxcpFsMQnNZYCIZ5tii2rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hh1gHGL8B72msTmFomGL00btQ91io1tcbm7Jwxq+oiU=;
 b=eyFczWrYoqAYrOTEYE+X80f/RurwqnEOMzXZH5Xspu4bErG/KRkqlsYKkxVU8eDRuyoakHZaKeqYw2ObfcNWaMS2TW3biGTlvnGyfeOhc1GLGfc4iTGINIWyoVC49Tmp6Wly8bRGvRp1mPWV+sc/pH7lCk6tp08kH0hYpNmFjh/GdsaaZ2jlXtR62TOJHHGu5jgADYULdLd5QWnj/p8IQ44Ky9K79QHQE11tWbfVkOheOrDmeRFDk8+XZ+5lLYZeqXTG8fDD71LxCRagkEmO30Rt5GDQgWCd/8XrrBJlddk49T3eP8LQyIAmQL1td5EK2e9KaBMYcSo8Sv+NFkFBkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hh1gHGL8B72msTmFomGL00btQ91io1tcbm7Jwxq+oiU=;
 b=eT4kOB2tVOLATR3FT9J7/YLskT0T3rpG+MyBPMhQvGfvtIb3ftVineU6mpFQO/HOkfNPzDDEJcQamkmGlVlE8gF3WPxfsrFdF2wl8f9f0jAM3u4xTI/x9pMXDX8XdgCW5FuL4WEWB/+MJKz1NbmIOCRWymWXGLQzg4wax7Gnydo963QDFy+fLxOqCKij+l5W7pFHwxqgbqj8dPGhFGhylQrwNZfPCOTq105q/ooNkrHrEyT/1JIC/gKYLMiuhcnQwD5Ps1n5a+uL2U7hy6dGZ46yO3HQwMx/ISSjl0D7wWJqV1G2Uiy/dJqPuNvcQ1sXSdT4MMKFkwxeOiuiZ7KTYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DB9PR04MB8363.eurprd04.prod.outlook.com (2603:10a6:10:24b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 5 May
 2026 10:06:30 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 10:06:29 +0000
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
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Michael Dege <michael.dege@renesas.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: [PATCH v8 phy-next 24/31] net: renesas: rswitch: include PHY provider header
Date: Tue,  5 May 2026 13:05:16 +0300
Message-Id: <20260505100523.1922388-25-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260505100523.1922388-1-vladimir.oltean@nxp.com>
References: <20260505100523.1922388-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0170.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::11) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DB9PR04MB8363:EE_
X-MS-Office365-Filtering-Correlation-Id: 896e7c3a-0a21-4c6c-7a24-08deaa8dfa24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|19092799006|7416014|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	GjEkpxGTMcb1tRmaPQPv8Qh+Up7TlJZs3vuCItAeIEKQbwmChhkH+Wpx2AC712xbkvbi+YhPUByM8pAWRX2xuAbcVL9zRrxT0yv8CBmnWKrqMFtnZoYRv65osvyKfh223o5DHOv1sTsdzU/cB35XsSpKEEozlMM5fWYnZ7vytu10oHi3KxLd4paiQrZbkGrWrbVtnYZegVGxNWlrMW52tGs1DvTuWUqWHEmHQD1RqycQ/lCTv3pPveeYYZ7m5T55Ry7FqqS+fkSi2TH7iwwzJzzfAdUCjlLHGfzfyyvpitwdyxHB+anXpNxUnqkp/x/ZZ8QQsrlVU6BNSKrg/6+2acv92M2Iq8lO8JfBo75yMT/EUQsSRM9sB88v/6TsiXXgiRgVh65yIXmMKMojSCuQwFuKULdi8jO14NuUT+S/VPrax+oxbVUjC7XSGt+lvYPslwUj8tey7I+e7ICxREt05IsHhdpg+nWoEsDXtghS37qVUFWrptatTfPaOmlNATQV/lN4QfGQfXcX8sfJPhuXIFe6xCP2HM4olZcbgNOzpjYzNLfZnr06S/kMHkcPxaoDYkGIYRUNciCN2AkS/iibryQ5I+o3v1IHYJ6/LeqZ97vi2dfc1mACnJ7gxfzvoNTbppw7zbPNs+viyj23XbiTncqx8xIodDOab+JYNUzwKwADkOzu4p0mfG5F2aYLuemO4mUZUhSe+w6rF35EL0xm7A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(19092799006)(7416014)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2LcQCnYDxKf4tXI99fR5kHkneUlizCk5LHlgqMkm5hZn5pihsdCujKOsGxqy?=
 =?us-ascii?Q?ACr4Ll9QkgvQDeXlM7TSvt9efcEpwXJAKjcWVhj0dazZH0LB07oG8cNz9tC2?=
 =?us-ascii?Q?/oaLWFCX55Bbr6gqjqKWvpQC6xR2kTqB4iS4YCSg3c3iXSrU40jrfsUblsaR?=
 =?us-ascii?Q?GBdHJSe8JOYRNElQhI2uVcS88qTKTvBjk4ZfWHcdvUo86v5N84IZ+PhiKhta?=
 =?us-ascii?Q?/xuGnfhUdC6zYCsvQBHxB8K8+EEu1pAs0cGF83K0PSzHZ+1/t/C+HQqiBZzp?=
 =?us-ascii?Q?pSKVRSBL+M6ysdsk7L5blg+NWit00QY1wtIboaSQZSqJ/F5ASCFC3xdg7ll7?=
 =?us-ascii?Q?02lKnAFpGEY1aIkvYw9FUlRq2J0lchdbm6pxAdaEZ4EEA40rPyuH3RIEYeoF?=
 =?us-ascii?Q?bjFJHYdnE7NBUKy1RCRB6+QJ21vWcdhcSktXz6+qHGVjmzAZy33k4siUKL6h?=
 =?us-ascii?Q?RANC0LWr8+pU0PXI+3kJ/vo8zMMuAbcn6nMiZAKZomKPpnI+pfWGRcXTaMMK?=
 =?us-ascii?Q?7y5L+cjkjEmiM4acD44jiJqRvPawzy2nknkK7nA5WO0lRcT74790/Vns22hV?=
 =?us-ascii?Q?bmEdKSFBwnuPT5Q89/XDc1pLHDdD71ba88Zy9k9tFcmabr3YePvM1H2FKAt0?=
 =?us-ascii?Q?qp+bzURLS3u48oX+O7cGKpInFt2s6LpSlh50A61i/pYEs/1OWu7VGAoYz32p?=
 =?us-ascii?Q?5R9EJkMwPMU2q6lld9cIGDbV/LPPSoQee/KaNBTMzPaqU6yXXrzBj+/x2TyJ?=
 =?us-ascii?Q?kcdkUfijiznMsofjWi3GERNYX4ew50BHPr9bgymaaSgs7m3r2F3uTmbrNLfE?=
 =?us-ascii?Q?swRDK6GkB0DoRNuSa7qewTDiVurJlsCzruTweVesdb2gZPlJjccmvu3wlfzA?=
 =?us-ascii?Q?pIAq6aMKOfQO7XCFekwdD9+za8lmAjTL2ia1FBjPM1dijDOr6z7pbhhapPCf?=
 =?us-ascii?Q?OZ+ojcMe0rLJNBwKRgUYB0TwUSof77YPDVZtwshSv/hkwOAwtB2eayaZsorS?=
 =?us-ascii?Q?O+In8GkjN41yz/bUPLR7pvPTdd8/LylQZOKrTs68I30QyFvM2W2XwtN02Fy/?=
 =?us-ascii?Q?V6zvrldOw1bf47kqgkcCtSUiINpxUAbECZ4lYr/5IABkburju+SgOZ08TY6R?=
 =?us-ascii?Q?wL93MJLz05uuEbmrRW05Qtw18JkC0S3CNXuver+vU7eJTwoRik7i2YjMly2u?=
 =?us-ascii?Q?lO34/8SzXKDzZlHV943VPFXwGMnyEIX6tfSuROZDbQASWu4vu7ZqJEySI8Ir?=
 =?us-ascii?Q?el9jXHJoY1BrRk9J7tTXWpXGGCWYbKiaCkiCZV4WmiB66xpgWaMSJgge5MAS?=
 =?us-ascii?Q?y75jrSn6YakZaVOG+12pao85JSq5uZtXmCnmyZU/t2jenBX/zrYMszWQsKcA?=
 =?us-ascii?Q?iZCQ4CzuS5NPUkaVRLKSdITPt0CjbyOaCblLjqsWg20TTHhNxW0CWaX7U4+P?=
 =?us-ascii?Q?hx/6TRfswgqKLWag1tDi2cOFZbQiDrjPG4oDKATGfIXjpgU++vs3mQlTUteb?=
 =?us-ascii?Q?EceuR5mtueIqR387xg+agTDu0BN7LZlbe9YeaV+TnreXCmImxNX35PrjUJzE?=
 =?us-ascii?Q?kYKi6CYQOK27YspdxrBUDYnLsfZUJYvhWNYy1uiNcSXUfhW9kN5kGYTgp7bc?=
 =?us-ascii?Q?O8e97B3Q//J1nZ3OVVOhtKFkpfA8rYacZC8F4ZQxmg51v0agSpIg4A+gbwp6?=
 =?us-ascii?Q?JuKgR74SFjTvfKkI+STKXQFTCPDxPWQMJjUuNT2qJB6O4YrP8HkJPN9+loZ9?=
 =?us-ascii?Q?a9iS0xKIEw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 896e7c3a-0a21-4c6c-7a24-08deaa8dfa24
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 10:06:29.9215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bU/weWfJ+oQdMIHR8BKEwSaCtJvcZ5VDHA7K39sUFBwDk20C8wf91k6AVrz/gya1xBwoKHZow8TK0Jc32gEQPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8363
X-Rspamd-Queue-Id: 39F494CB110
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-7514-lists,linux-can=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can,renesas,netdev,kernel];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[glider.be:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,davemloft.net:email,nxp.com:email,nxp.com:dkim,nxp.com:mid,renesas.com:email]

As a PHY consumer driver, the Renesas rswitch dereferences internal
fields of struct phy, something which shouldn't be done, as that is
going to be made an opaque pointer.

It is quite clearly visible that the driver is tightly coupled with the
drivers/phy/renesas/r8a779f0-ether-serdes.c, which puts heavy pressure
on the Generic PHY subsystem.

This was discussed before here:
https://lore.kernel.org/linux-phy/20260211194541.cdmibrpfn6ej6e74@skbuf/

but to summarize, it is generally expected that when a Generic PHY
function is called, it takes effect immediately. When this doesn't
happen, the PHY provider driver must change its implementation rather
than the consumer be made to work around it. PHY providers which rely on
a hardcoded call sequence in the consumer are just lazy and wrong.

The most obvious example is commit 5cb630925b49 ("net: renesas: rswitch:
Add phy_power_{on,off}() calling"). Problem description:
- Ethernet PHYs may change phydev->interface. When this happens, the
  SerDes must learn of the new phydev->interface using phy_set_mode_ext().
- drivers/phy/renesas/r8a779f0-ether-serdes.c implements phy_set_mode_ext(),
  but this only caches the mode and submode into channel->phy_interface
  and applies this to hardware during phy_power_on().

The commit author decided to work around this at the consumer site, by
power cycling the PHY for the configuration to take effect.

This had a worse implication from an API perspective in subsequent
commit 053f13f67be6 ("rswitch: Fix imbalance phy_power_off() calling").
It was observed that phy_power_on() and phy_power_off() calls need to be
balanced, and so, the consumer decided to start looking at the struct
phy :: power_count (the technical reason why I'm making this change).

This is also wrong from an API perspective because
- a consumer should only care about its own vote on the PHY power state.
  If this is a multi-port submode like QSGMII, a single phy_power_off()
  call will not actually turn the PHY off (nor should it).
- the power_count is written under the &phy->mutex, but read unlocked
  here.

The rswitch and r8a779f0-ether-serdes drivers both need to be completely
rethought in terms of Generic PHY API call sequence. There is no quick
fix to apply. Just include the PHY provider API along with the consumer
one, to keep working as before when struct phy will be made an opaque
pointer to normal PHY consumers. But this is a bad offender (and it's
not even a provider) so add a FIXME.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Michael Dege <michael.dege@renesas.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>

v2->v8: none
v1->v2: collect tag
---
 drivers/net/ethernet/renesas/rswitch_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/renesas/rswitch_main.c b/drivers/net/ethernet/renesas/rswitch_main.c
index 6fe964816322..132be5f15073 100644
--- a/drivers/net/ethernet/renesas/rswitch_main.c
+++ b/drivers/net/ethernet/renesas/rswitch_main.c
@@ -27,6 +27,7 @@
 #include <linux/spinlock.h>
 #include <linux/sys_soc.h>
 
+#include "../../../phy/phy-provider.h" /* FIXME */
 #include "rswitch.h"
 #include "rswitch_l2.h"
 
-- 
2.34.1


