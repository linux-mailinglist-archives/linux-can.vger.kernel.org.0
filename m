Return-Path: <linux-can+bounces-7274-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 00NaDXrTxml7PAUAu9opvQ
	(envelope-from <linux-can+bounces-7274-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 27 Mar 2026 19:59:06 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0D13498A3
	for <lists+linux-can@lfdr.de>; Fri, 27 Mar 2026 19:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 61E03313DCC0
	for <lists+linux-can@lfdr.de>; Fri, 27 Mar 2026 18:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB7938F23E;
	Fri, 27 Mar 2026 18:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cQd5Oy+i"
X-Original-To: linux-can@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013036.outbound.protection.outlook.com [52.101.83.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1836F38C2D4;
	Fri, 27 Mar 2026 18:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774637340; cv=fail; b=CcqTz5nqJGXhtXpyboN1mhV1AkYvIUwkc4yX6N2nR8cPhmbj8Rm+is7Tf1mSiLa85eEaIQuKJltOQTi+ssxv8Ct+Z1bwsQCtdeaIym7B3pwxdlUyyiQFIs7EvQTJCBIloMNssHVq6Nj8oKkiL6npJa36x3IyJ7+BlnOFwywqCIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774637340; c=relaxed/simple;
	bh=xSiJoAaiLq/Z7hUV3pXZeuMbfcK7M2P7cNmla1yXVr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NbV7SG57GaonWJLvbK5+pGfzcIV87s/RMBQtf2ohlJNT0/m+PhxBG/LNkIqQDZGX75zyHUXn3ZdmSzlmHqQiCgYA7dNDFy9cBI2yKifd/CiNz06iFISg0Su++8nfGHURPBlGuC+IKEKRjATmtMPyEuqHkyrFJoK8xHkL7q3z5kc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cQd5Oy+i; arc=fail smtp.client-ip=52.101.83.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I8fw/fXalEIXbvmPZOaRdhh3MtMAwPc8OhhrxCpI0zc+b6SSL4HxSJLkyyDjVnv4tq4H/BvohAFsun27udNoJ3T2f5lPMR3mlBIiuKZW2WWy5P03d20irN4TZTA6PvMFlOsRQ5U9Oa+/ZUOen2ubmXbPv3cKth4qFTkKno2p1YSieMUFEDcDd1GeRjcHGPTqFMLdBYLbQFbO4lPdl5PJDtTYmVmiPacXKf79tJJLV7JL+beDahURDx77hEBcqDb2R4xHEIQ7/pInLrBN0fLqGmss6JFuQJxVJrx0VnvuZGotkCfN1QfrPtape57bRLLf6IahzQg+ST/Oaq0z3oUyEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aqdghs05KEu7V8VABAy5TygYdBGISgaWkwMnIha9YTA=;
 b=ctEUfCZByKFEDwsM8k2nUghU9YX4aH+UPHqV8NxiZpiahWMz5Zy+LxhcqRycm/uQcZRiw8uAVlxgpGgMH7sEcdkvdNYuDN4khcaC7LWVbzk/9Veg4rabnr1SWMovqLFy3eKk3B6OP3mxqDiaDYDZJfc++d4RCkNAADPOcLp+wBdKF49L3cWbwYlI8gsWD/LfomQgh7gP5DWSksUVRyuqoZ0hU/vYbZGxzvJRdAeVbdy5nEv4pCfOQZiCrvp+dXHsQm1QsSFnzHAOFEel6QsoTmbxrEu2kSqL7hkwB6w/+2M1uyHG0oUqS5iwQl89Ee9Sc9yyscV227ktb6QUwzwlKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aqdghs05KEu7V8VABAy5TygYdBGISgaWkwMnIha9YTA=;
 b=cQd5Oy+ir5beee96sDYJme4sZTJ5P/3dupDT8FstTV7C7SRJKbEopUpS7a0jCNX5IZ7KmUEcgqDnqKM33JJ2DhjI07eCzHPfMYbIG4pFL7eYKttxUwSlQSn8l7+0y62IF2vVIsItuVRqH7hp1ISe/TKVnaq7seZpkMsXeZ27MQXMdIcqBuwEXOpR75vzt0ya35rrlv+3nMlMKQllGElLd8X/lomW0mUwGIp67H5irPEXSOy6wtu4DCi0JirCyW2jFqHNq5ionwCibmGolqqJ0ZUzacKJdkvFr9Yqn0Q82FIza/TCBs/MaRR01c0Z9v4E4uJPeUDQsHBRw+2Xzhg9pQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8584.eurprd04.prod.outlook.com (2603:10a6:10:2db::24)
 by MRWPR04MB11287.eurprd04.prod.outlook.com (2603:10a6:501:79::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.22; Fri, 27 Mar
 2026 18:48:51 +0000
Received: from DU2PR04MB8584.eurprd04.prod.outlook.com
 ([fe80::3f9d:4a01:f53c:952d]) by DU2PR04MB8584.eurprd04.prod.outlook.com
 ([fe80::3f9d:4a01:f53c:952d%5]) with mapi id 15.20.9745.019; Fri, 27 Mar 2026
 18:48:51 +0000
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
	Bart Van Assche <bvanassche@acm.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH v6 phy-next 09/28] scsi: ufs: exynos: stop poking into struct phy guts
Date: Fri, 27 Mar 2026 20:46:47 +0200
Message-ID: <20260327184706.1600329-10-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327184706.1600329-1-vladimir.oltean@nxp.com>
References: <20260327184706.1600329-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P195CA0068.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::21) To DU2PR04MB8584.eurprd04.prod.outlook.com
 (2603:10a6:10:2db::24)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8584:EE_|MRWPR04MB11287:EE_
X-MS-Office365-Filtering-Correlation-Id: cb4442a2-c8fe-4e81-28eb-08de8c317d56
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|10070799003|19092799006|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 uowyqYlh3ch3d6m2aBBrxdbS7zRuqzt9uducjkx2DbQ1y20xWuberiA0ZgAC1Jz1/TT6pZQHor+TeeQE4GVYj0Go7e9HhrgLnioDWB2ZfS8EhVllEphk3g0ImSd+bebWCLFRUkF8vy2Lij1t0FsNkhG9qHIH3BbvcbwiKrqXtkyuHxTFJMKLBMb273iUIi9dgGpfG+lgvmsGRbdTnuR6oc05pFy4MEN83HNSahLgrwX4QR5XPMcGSA6utsP9DUuPw8vmm0dun/+fHjmvC/LOHjGM3qVbBocvdF0Dsz/65r+U3f8KbtFjMlimb60elqDJ39Rn88IYmt++V+V+3w0Wu5l3Evjk0MjIDymp8mChO5aD5iXF9jzBGe5nqaVvyvRiUwacQUbQHLZtklXnw2+WrJNvsTOavLBiXtlMR4dskElsde4RwGj8QsLKVrxjwF3VhuG9ROqd8vbfPCdETRnEFKE2AkyWgepvjt7LI4kCa/PotLU5WCtuSkEGi1yAfZYY7sU90/mCo/5JreqLLSQKMBEe3yYGDFnnkIfqWMAm0LZja1t6AvgvfuPQfTXBgfIJOcHyZSKDBlZTgdQ2EV2G39zh7iOSiAExW3FEPSymudJ0rt6Skr0j/Y3k/Nf8JdXDtCiyOpfxoq3PetbohLhjs2mUMLxBFYO5JG6ruPI3P0zA1IUjnU8tJCsmjuL9Nqau8XqqfLmroub8wgXtmaSb6lvoQvFRt/5Dco3ZsPTbr7I=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8584.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(10070799003)(19092799006)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?erDN0Onkhu2DZzWyMAOMN7kvT1UKqrHJVca26YdV8AH/GUthenaMr3ogyh9X?=
 =?us-ascii?Q?z3kS2/hGpFynJ6uSQMSeN3pCJCHFc+R8NnpT4h/sgHSz3v2UpdwE+SOh/PLi?=
 =?us-ascii?Q?Xyozov/aXbZSNqCjUkP5S5/H0drerTprS9+Paj3iKD5Z57sQ+Yj5fcLnOso1?=
 =?us-ascii?Q?lEfG1cMnviamxIVvxdMcFGDJkwkk6Asxm1BeDRPEjGvMYwKLIvP1cRy6TgUm?=
 =?us-ascii?Q?nHf0gAx/1mPJnUf1RHC8UO5G481FrUhg+VWFLxjBCTxLfg74oWaEQoDIk310?=
 =?us-ascii?Q?B9GYAsksM2mTwMrbHzDAc4gj3IH5Tx5DJwMM1KWEMm7mhoAqJuA1e+/I0/2G?=
 =?us-ascii?Q?3xV8kIVfD+KVifFOj8ZzTS4A88EZAMYpXPPfc4+rQMai6/E3gGQVIG3lZFQ4?=
 =?us-ascii?Q?ywFyQRUN7FaD8eDlJQD1dP00cSwCUIBgNoeAxDaHOXjUOVfGieoyV2lhSne0?=
 =?us-ascii?Q?RVGQqJc1mq5RiXb36VgDPoIF/+bhDWQiRuaDEtA2sZhvw5XJmFoVLHRj1ZKx?=
 =?us-ascii?Q?fS8JhJdQ0tGGb71Fb/mbhVK4rbt8TUgPvsKpe1iww80p44PUfos4ywSq9Etz?=
 =?us-ascii?Q?NUjN6iJAVg5CXXJMw8oWpZT6b87m0+s8UqgDFw6MvzQNzwUh39Y9yU9ibO3d?=
 =?us-ascii?Q?LsExWm8qEkkdtjD6f0mkf46sN7JC07eXfRDOylgFi3jmTK99AjS284E1hTjF?=
 =?us-ascii?Q?q+PzIQnpyIxZHvH+aHQ3WIYMcZP4haxmT0Oi3aDEJMspFLRS1Ox14FiDLdk2?=
 =?us-ascii?Q?IBkBSHrsB6wkAlCP30svIB8enJbpAMcHMIW09XzsqEhUG7w97HcCw2djlT5n?=
 =?us-ascii?Q?Qd1fPPpJoXhpM8R6jhm8y+8ULEwonSMutNeBZG0C/50yjt7N82udSAvTuWi0?=
 =?us-ascii?Q?00vabcZNZpjpDPXCVjWXbziLUeQTAJegE8+C4qxMz6QV/kVX2OcCibkb6VXD?=
 =?us-ascii?Q?QpjwxT5cWptV7iJpfzZBLCFrnq7a3HfWoFpHMptmEeK3zAYXL6q3oR6rTG7Q?=
 =?us-ascii?Q?xyoSmBS4u04jUhEqzLA/h/8LF7Ux3HE5A8TmG7obCADMvDzNqtJkAGrksWh0?=
 =?us-ascii?Q?Ho4ibm58b4atA6BQGxsiCKnK3HtvY2YwrNzg7pHOJgOyOW+8fXloMctXar7T?=
 =?us-ascii?Q?8Dc7AeQXbL0uB6gZp6S0GMABwwwCyiGuVGXHwOmB5WfNK/KphpNzYi23NADw?=
 =?us-ascii?Q?xUvaNUR0o+oBichrbnj9XSW9CaBppyOpQHCShiCM+5juQz3Sg6j2sr5J5ZNH?=
 =?us-ascii?Q?lcA7e695hD7K6Fb7H4Tl7pp718Qw0vyliKROCitX2o1VETOwY42iG70QSCE5?=
 =?us-ascii?Q?7wI3hEh3DWkxBeCRE4qUwURZ1hCv6LpPMgYYhSAtLBDJV4Z4/2tVsRRE16h6?=
 =?us-ascii?Q?nmdTJRFTn96h2HkfI+vJQHlqpB8iKt4IrbiSezytXnpL7HyZEwoyC/GtKMub?=
 =?us-ascii?Q?i4LZ7CPYklDMqhQ+whi69DclMEmshvqLae1ZUvZPB6WAodYAE0+HIEN26uO+?=
 =?us-ascii?Q?CjEoXlYm9OoUOdpfiLqrq/456Dr+6kwsVEMn1VhTzyaPxwFc81l3GSvggcf8?=
 =?us-ascii?Q?U7D3r2lr0lSUJMSREw0QsgzRvRV4rYxAsYLPaR2Is6d9qtLZsC7lhw1zRvR8?=
 =?us-ascii?Q?OF+4ElJajS+OrfN8OgIMattzo0bwPKkISVYjBK0sZ7XU6KEGPsrfd1/HwEUU?=
 =?us-ascii?Q?zr5qJCol12y0MpMBWC/cpSGCQIXQmxfxaTFx0vJ/SDWqcKU0a/fFxFo7XRa5?=
 =?us-ascii?Q?QGvom1To3Xyx/cZV2yYV3yRipnc6D67mGy3oRJC75w9b47Fg/e1RhtF7pNNk?=
X-MS-Exchange-AntiSpam-MessageData-1: 9F5Efq5uQB2m4sknm/J2y4a1KVE0rKKUaAg=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb4442a2-c8fe-4e81-28eb-08de8c317d56
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8584.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 18:48:51.8305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tIZPwWsiHd2d77fZVE3INE99HhNDu6p8F0kq/ttBNalBEOly/YNJCvHX0fGZq0MsqOhyldSkhRiZTVjE7PxKpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR04MB11287
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
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7274-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,hansenpartnership.com:email,samsung.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,acm.org:email,nxp.com:dkim,nxp.com:email,nxp.com:mid,linaro.org:email]
X-Rspamd-Queue-Id: 9A0D13498A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The Exynos host controller driver is clearly a PHY consumer (gets the
ufs->phy using devm_phy_get()), but pokes into the guts of struct phy
to get the generic_phy->power_count.

The UFS core (specifically ufshcd_link_startup()) may call the variant
operation exynos_ufs_pre_link() -> exynos_ufs_phy_init() multiple times
if the link startup fails and needs to be retried.

However ufs-exynos shouldn't be doing what it's doing, i.e. looking at
the generic_phy->power_count, because in the general sense of the API, a
single Generic PHY may have multiple consumers. If ufs-exynos looks at
generic_phy->power_count, there's no guarantee that this ufs-exynos
instance is the one who previously bumped that power count. So it may be
powering down the PHY on behalf of another consumer.

The correct way in which this should be handled is ufs-exynos should
*remember* whether it has initialized and powered up the PHY before, and
power it down during link retries. Not rely on the power_count (which,
btw, on the writer side is modified under &phy->mutex, but on the reader
side is accessed unlocked). This is a discouraged pattern even if here
it doesn't cause functional problems.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Acked-by: Alim Akhtar <alim.akhtar@samsung.com>
Tested-by: Alim Akhtar <alim.akhtar@samsung.com>
---
Cc: Alim Akhtar <alim.akhtar@samsung.com>
Cc: Peter Griffin <peter.griffin@linaro.org>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Chanho Park <chanho61.park@samsung.com>

v5->v6: collect tags from Alim Akhtar
v4->v5: collect tag, add "scsi: " prefix to commit title
v3->v4: none
v2->v3:
- add Cc Chanho Park, author of commit 3d73b200f989 ("scsi: ufs:
  ufs-exynos: Change ufs phy control sequence")
v1->v2:
- add better ufs->phy_powered_on handling in exynos_ufs_exit(),
  exynos_ufs_suspend() and exynos_ufs_resume() which ensures we won't
  enter a phy->power_count underrun condition
---
 drivers/ufs/host/ufs-exynos.c | 24 ++++++++++++++++++++----
 drivers/ufs/host/ufs-exynos.h |  1 +
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/ufs/host/ufs-exynos.c b/drivers/ufs/host/ufs-exynos.c
index 76fee3a79c77..274e53833571 100644
--- a/drivers/ufs/host/ufs-exynos.c
+++ b/drivers/ufs/host/ufs-exynos.c
@@ -963,9 +963,10 @@ static int exynos_ufs_phy_init(struct exynos_ufs *ufs)
 
 	phy_set_bus_width(generic_phy, ufs->avail_ln_rx);
 
-	if (generic_phy->power_count) {
+	if (ufs->phy_powered_on) {
 		phy_power_off(generic_phy);
 		phy_exit(generic_phy);
+		ufs->phy_powered_on = false;
 	}
 
 	ret = phy_init(generic_phy);
@@ -979,6 +980,8 @@ static int exynos_ufs_phy_init(struct exynos_ufs *ufs)
 	if (ret)
 		goto out_exit_phy;
 
+	ufs->phy_powered_on = true;
+
 	return 0;
 
 out_exit_phy:
@@ -1527,6 +1530,9 @@ static void exynos_ufs_exit(struct ufs_hba *hba)
 {
 	struct exynos_ufs *ufs = ufshcd_get_variant(hba);
 
+	if (!ufs->phy_powered_on)
+		return;
+
 	phy_power_off(ufs->phy);
 	phy_exit(ufs->phy);
 }
@@ -1728,8 +1734,10 @@ static int exynos_ufs_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op,
 	if (ufs->drv_data->suspend)
 		ufs->drv_data->suspend(ufs);
 
-	if (!ufshcd_is_link_active(hba))
+	if (!ufshcd_is_link_active(hba) && ufs->phy_powered_on) {
 		phy_power_off(ufs->phy);
+		ufs->phy_powered_on = false;
+	}
 
 	return 0;
 }
@@ -1737,9 +1745,17 @@ static int exynos_ufs_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op,
 static int exynos_ufs_resume(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 {
 	struct exynos_ufs *ufs = ufshcd_get_variant(hba);
+	int err;
 
-	if (!ufshcd_is_link_active(hba))
-		phy_power_on(ufs->phy);
+	if (!ufshcd_is_link_active(hba) && !ufs->phy_powered_on) {
+		err = phy_power_on(ufs->phy);
+		if (err) {
+			dev_err(hba->dev, "Failed to power on PHY: %pe\n",
+				ERR_PTR(err));
+		} else {
+			ufs->phy_powered_on = true;
+		}
+	}
 
 	exynos_ufs_config_smu(ufs);
 	exynos_ufs_fmp_resume(hba);
diff --git a/drivers/ufs/host/ufs-exynos.h b/drivers/ufs/host/ufs-exynos.h
index abe7e472759e..683b9150e2ba 100644
--- a/drivers/ufs/host/ufs-exynos.h
+++ b/drivers/ufs/host/ufs-exynos.h
@@ -227,6 +227,7 @@ struct exynos_ufs {
 	int avail_ln_rx;
 	int avail_ln_tx;
 	int rx_sel_idx;
+	bool phy_powered_on;
 	struct ufs_pa_layer_attr dev_req_params;
 	struct ufs_phy_time_cfg t_cfg;
 	ktime_t entry_hibern8_t;
-- 
2.43.0


