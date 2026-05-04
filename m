Return-Path: <linux-can+bounces-7478-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKpUNZBR+GmQsQIAu9opvQ
	(envelope-from <linux-can+bounces-7478-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 04 May 2026 09:58:08 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD144B9C18
	for <lists+linux-can@lfdr.de>; Mon, 04 May 2026 09:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 96C643013ED1
	for <lists+linux-can@lfdr.de>; Mon,  4 May 2026 07:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94141314A82;
	Mon,  4 May 2026 07:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LBxmIe4j"
X-Original-To: linux-can@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011049.outbound.protection.outlook.com [40.107.130.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6B228C2BF;
	Mon,  4 May 2026 07:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777881476; cv=fail; b=YYHi7Tq/B0Jnqi8DjvXrzmJQfEUmQg1e9CvFJwNQg10Z+aq3bimjlu8G2oafl5UKxxY09mPjahCozYWtk+VcixNmqF+6J3EVHGP3Qk2+WG8Z0awZBqOdp1TPhLFCHKyRALDN/R3pADM+hrNXFY7Xl1LfCCM6CJvvIFI34eO3Ni0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777881476; c=relaxed/simple;
	bh=FI5XCipd6lQkpvf6m9PRM3D5ko1TWpCFe9sg3srFwz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FIyvOZOW5LBRyZQaLTCjV91N9UsXXwxJ+/KATjwWHD4qG+rMN2GocwNILlVY8QwCA8s0Le0Olh7Vn4Px/mPxRBIbYtEnlmxCPKYdd2wH1Ee6BySC+wwacvIIUkFhsyp7/M2XjyqvYLsEp/wanfGgn5CqW+mdXKNHJvWRXm1ydtQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LBxmIe4j; arc=fail smtp.client-ip=40.107.130.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pNnSjlgqQ9mu64HM93qhv+j/BPmjKWq06Vw5FUl/MpiJK7O48Y5ZkdGpeDr+RLAsG3bD4m1MQj++jsqYHDhFLmSZ5zpMQ8jqAy3ZTKLMriPOi6faQk2E6kzM96L7OPWSvp+JWM085Q1lmk5RRrQOeSLk0xO4OiU7sqhrtqXPyJv2769muBydBuIzOb+Y2T+yCqqNpX1pq6fqhbmZCdZYovkoMLuMKF4YDRe44t5cNGg4sMDtGk6GXjcFlUhFIQuH5ZRhfaUs/tszMI47wKm5VvrDOVSo3B251R8iTs24txl8YlwZcJss91IFDm1kJbf+3HrOefgLyrqZ3jbW2NXd6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mIyqoNMaqF7PcSsq3Vf4/2r/EknapHaMFFAC23Z0fWk=;
 b=u/5vHVU/ZwWk0vXcfhC+ZvVj8TSqXPilWXe4zkw8nJXsnptXkI4ThoxIr0qjkFcBaQrdNu3mgiq0LeVT7yP8R6450cWoARy9vT0s0FG6X1duwz1EmElLoN4b7Xu2ubhZ5ZVowjf2F2KcMlQlzrG4OQDlFwzRW3vJWVV4e/2+A0jL79gLCNsXVMdUW3e7PHOZzud3P2DXNv59hKBqcDMJDgKnD5ysdtOX27rA7t+RVsOZ0Kllrj/49y6yCyEqm4Faqh0KjsN1o/xAx/+iowsYAG6TSrNh9u/i+qZiOs3lJmEggz4Oxil30mlSG8yW5FEo36P9vhUhX4+fr8ujas7lJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mIyqoNMaqF7PcSsq3Vf4/2r/EknapHaMFFAC23Z0fWk=;
 b=LBxmIe4j4c0f8XCDOmIwHQsDwUevTUlG2XSG5rVjJwhpeujlIC35stBUnSYac3YgUbfWXU/Ium9MufmIzh/C+KhNrkBY1ZDnp4CYpRingmBtEGzB3SfBK52lARJku8VclM7COSg7ZsWfCvgZk2E4fYFebSvxLc+Q/yrR1Gl4kGJAEQloY9aurINdIdFPw0k9ZA36UuM5EBsnJtQcc9n4cbBYLXGLUsYbsmVfktuWW/kofa4hS2LLo7iYd9kWfAeKOQ6906aMVPLLYIP+Mi37NRoNNzDN/ToqimoCrHJ/Jbmdpw03gWsxeJwcgrSHG/XQtN77oHVntlLQXVY5+pxblQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by GV2PR04MB11800.eurprd04.prod.outlook.com (2603:10a6:150:2d1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 07:57:48 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 07:57:46 +0000
Date: Mon, 4 May 2026 10:57:42 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: Vinod Koul <vkoul@kernel.org>,
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
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>
Subject: Re: [PATCH v7 phy-next 08/27] PCI: Remove device links to PHY
Message-ID: <20260504075742.ixt7phu4cpp433q5@skbuf>
References: <20260430110652.558622-1-vladimir.oltean@nxp.com>
 <20260430110652.558622-1-vladimir.oltean@nxp.com>
 <20260430110652.558622-9-vladimir.oltean@nxp.com>
 <20260430110652.558622-9-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430110652.558622-9-vladimir.oltean@nxp.com>
 <20260430110652.558622-9-vladimir.oltean@nxp.com>
X-ClientProxiedBy: WA2PEPF000008AF.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d8::657) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|GV2PR04MB11800:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c875e1e-ca31-4828-710b-08dea9b2d44c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|7416014|376014|10070799003|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	HEAXu0UJ9P3VzL00TQ5M3z2crujXl382jiCiUZ8AjCp92Sg3OB/js+tp8eYXGFCwTg4KC58dkU749B4w9rSUDmOeHKbS0d1VunRrO+0OtdmhVfIDbyWfd68zd/UwthW2bRoM12WmYcfW+QITvv60QYEZ3Kg4C9ooCFWab7uNzFwTYCMVln/v4nDI7PA+84MsJRghdBRjtrzVdqUpokYrKrv/vPQ8UdETapxfYG4x02T8oJJuR8rwqlgl1y/1JCDwDYxOrDpVfe+N/b9b2OMuKXyU8kTLFDV2up3MVC5GOnlCnnlwO+8ZalNICpxGxx4yrr9ReK56HR7wQ+EleiGOwqmjXSseI4g7FzN/Bm4ILnOoxXySX1YImvrFAsqP2ONeZCRRLqDcEN2K+zjhQYoc9vIaUwwAH1owrJMiNqLPK1BBMV6XA4WG3u1dohQzwWRk9J6ZB3Mq9zeKK39RKMh7AVi9wOOTuYnE26otczBMnVKu7BD58vY6ONRIqYZiqnt/i1+rsMLaDWvZTybIZj8YOv22IJFCrUZq8pvT2T2vn4k5ykcL4wBm5+ReTtYtHnCrP7+s6kJjJcCVv/9pxQ51KpGJL1D7rMiYVbvAYjGTnZjLEkc3qSGjgZbvixZN6L75/bYZOjGOt6ePctFGSO6QX6HJX8OyaoKsPtRjRZPN33ZGE71bvSFRxzkCOrB5x2Bz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(376014)(10070799003)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RsEOHz6cOvr61ub/jxNnNVotOrCIljo7elUReRA064caS/5whesT2J9KGG1W?=
 =?us-ascii?Q?0L4rUUrOsc6Ddsc0U9zeiJJ6LTVI5b1GVFb8eTU0+6LuW5h/yQgVUJr1EInh?=
 =?us-ascii?Q?h3qoiM4jWG/uDASftINhtbByfh3a6xoV/kg8gRbeKBjVV2gNyAry3SA5nj4N?=
 =?us-ascii?Q?KCjDY+RNqRFoI4CzsYBaA8Xtc3HoOPpWw4m7TCLeoVjN0SnCPZPUiHzUe0Ku?=
 =?us-ascii?Q?uEdZbRJoc0TSiSmy/v1wQ94hyS0eGVKAgbCemhE32p7jBBUgtIA0m8eTnakr?=
 =?us-ascii?Q?m0cP7Dg2Rgwdxn7Htvb29f2qN+h6gLjG+Z664xypN2PMh3YLasYwpaSw2/TU?=
 =?us-ascii?Q?bw5aX6pbPDj21gqqtcD307swHztnNZfL/1dTTTOyGSIk+QiGf5HJV3w0Mpry?=
 =?us-ascii?Q?JpJarUj9oRVOjrGtKp/vY9tpuo9YY3vnT8M3X+nfOsxTlKWyquIqkJPWpVmz?=
 =?us-ascii?Q?VOavSuUc4gC6hW7c9IcLsof89g+BkZd5zg5T5ERE7Ospd/knF6e9NLD5mTR7?=
 =?us-ascii?Q?jBOgYJoaUrf15GXhmW74pfE25hnfa9hP4J2aVQ5pwuTWEeN0LJqZRS39I129?=
 =?us-ascii?Q?3rIi4E5g5x4hDYkpoRt7001EdShWNGsyOkDcJ9H/+0syBS/du94bxvTKwLPH?=
 =?us-ascii?Q?Q4GnTHTU+7TxqRDrsv1QcAQIzI7jqQ3fT9B11Au82fQ8GuGLcpmBkRg+vut9?=
 =?us-ascii?Q?pH4YLzfQ95YVVl5v0/TYyT1S3CA/lQJ25Yqqug07H0lHJnmtxejGsraBekx5?=
 =?us-ascii?Q?y41Rcf2cbgkltnYu4p1dF0uMYh39FoeWXDtpN+ZIPtfJIwEcmcK2nptUQ4sW?=
 =?us-ascii?Q?3DzsXI4fwDver+dSZUKzoxLnMgBGix83Nz4yP3H591HzSGqCJq4Ahq6aoTwO?=
 =?us-ascii?Q?vdkKRgJFouBysTNrWXm3Dhzk4TnLnT9odECnZdpEQXPDPHJR3IP9bVK+zT1J?=
 =?us-ascii?Q?fLAVSpZnuQEMH5z5QzO/tQlLnYggNWfN/av4tmiEG5CnEop8o28JSu7G4Awa?=
 =?us-ascii?Q?up8YeGzW63waghEtGCWWKM/nzOeGz5zZpKi9SP/1pyp60N4GqqN22qQyhYzp?=
 =?us-ascii?Q?aCKS10hT18/N0yhdpk7jCf4i+yQ6DEEAq2pIERPpC84+uRhnZvl3ORsF/2K7?=
 =?us-ascii?Q?mWhMQBv5m16eu1/7qrqQY/YIG+HpoNDlyao1iUd1MlUjvKA9pYYsn0zBnzEr?=
 =?us-ascii?Q?r1/1FKCk64nnJ3XoYYg1n3aWkPPcrSSmZ/1bVrtxagz/tGXcS/mMFYMiVeag?=
 =?us-ascii?Q?wHnhQh64Gzqb3nJPvIkn36Fh08SWpSAziFlLTy0HZcxRbhHAkSGjGzUhuPYt?=
 =?us-ascii?Q?mGgO74dOzXOaE/PgSGHRsgx+VcvSa9fvXYMfTz4uqunO/H45oI6UyCu3J3ob?=
 =?us-ascii?Q?rYOgwDx7iyA4v/06pCB+/WSx3UQJn6x7h/Lbra8FvBlwTHLti7Tlf768GM91?=
 =?us-ascii?Q?zStbCV1u7IAwq7cFLKsf0tCdwLMzckOHhgor23phsP229u+/oB1kKARQWlsE?=
 =?us-ascii?Q?F4CeMARInjuQNYzC3iRUYHMZwA1WmAc34VPcgN/mRwZXJsRUKcY8Yf8fFdyL?=
 =?us-ascii?Q?1Gg/0tnWaNA7RjxqS5Tx9Ovad5xiHpTKJPEPofz6T7e0SU+svwcatycFidc/?=
 =?us-ascii?Q?HPIpeq7CsTfPh2qupxa/DBLR+lZiUAxA3J4I759eadMjgtywW2aXkJ9oQ5zX?=
 =?us-ascii?Q?7PG6hJ42ZnL1f97rlTIMOg5vJghuNVEfuxia/ORrTh1o5pTLCr87B8hulxXf?=
 =?us-ascii?Q?mpHVVmdt5W3ZcR65RWqjhzxD83ghUIQ56YzAk+fEVJPF4Vwe2/hEMHSwv46x?=
X-MS-Exchange-AntiSpam-MessageData-1: qAbWhMSQ+tDz/g==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c875e1e-ca31-4828-710b-08dea9b2d44c
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 07:57:46.6958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MKHLfxUQD4j6O1JnGXUiro3PKaKtFhDedU9fqi7AkBqWytZKCuHAp76HHMA+3Egs5mL1VqDhZ+adhJvqpx+FhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11800
X-Rspamd-Queue-Id: 8BD144B9C18
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7478-lists,linux-can=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[31];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-can];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Sashiko says:
> commit e4f495a9118b40f8a77e8dc097821d2c846ed1fc
> Author: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> PCI: Remove device links to PHY
> This commit removes device links between the PCIe controllers and PHY
> providers across several drivers, since the PHY core already creates consumer
> device links.
> 
> > diff --git a/drivers/pci/controller/cadence/pcie-cadence-plat.c b/drivers/pci/controller/cadence/pcie-cadence-plat.c
> > index b067a3296dd37..fc39c01b79648 100644
> > --- a/drivers/pci/controller/cadence/pcie-cadence-plat.c
> > +++ b/drivers/pci/controller/cadence/pcie-cadence-plat.c
> [ ... ]
> > @@ -122,9 +121,6 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
> >  	pm_runtime_put_sync(dev);
> >  	pm_runtime_disable(dev);
> >  	cdns_pcie_disable_phy(cdns_plat_pcie->pcie);
> > -	phy_count = cdns_plat_pcie->pcie->phy_count;
> > -	while (phy_count--)
> > -		device_link_del(cdns_plat_pcie->pcie->link[phy_count]);
> >
> >  	return 0;
> 
> This isn't a bug introduced by your patch, but I noticed the error path in
> cdns_plat_pcie_probe() returns 0.
> Does this cause the driver core to consider the probe successful even when
> host or endpoint setup steps fail? It looks like the device would be left
> in an uninitialized and disabled state while still being bound to the driver.
> Should this return ret instead?
> 

The condition does not appear intentional. Commit bd22885aa188 ("PCI:
cadence: Refactor driver to use as a core library") changed
cdns_pcie_host_probe() which properly returned ret on error with
cdns_plat_pcie_probe() which doesn't.

I will add a preparatory patch which replaces "return 0" with "return ret"
in cdns_plat_pcie_probe(), blaming that commit.

> >  }
> > diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
> > index cd904659c3216..9c1aef4d0bd1c 100644
> > --- a/drivers/pci/controller/dwc/pci-dra7xx.c
> > +++ b/drivers/pci/controller/dwc/pci-dra7xx.c
> [ ... ]
> > @@ -852,10 +840,6 @@ static int dra7xx_pcie_probe(struct platform_device *pdev)
> >  	pm_runtime_disable(dev);
> >  	dra7xx_pcie_disable_phy(dra7xx);
> >
> > -err_link:
> > -	while (--i >= 0)
> > -		device_link_del(link[i]);
> > -
> >  	return ret;
> >  }
> 
> This isn't a bug introduced by your changes, but looking closely at the error
> path right above this hunk, there is a call to pm_runtime_put(dev) immediately
> followed by pm_runtime_disable(dev):
> err_gpio:
> err_get_sync:
> 	pm_runtime_put(dev);
> 	pm_runtime_disable(dev);
> Does this sequence create a power management race condition? The pending
> asynchronous idle/suspend work can be abruptly cancelled by
> pm_runtime_disable(), leaving the hardware in an incorrect or unpredictable
> power state.
> Should this use pm_runtime_put_sync() instead?
> 
> > diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> > index fe4836925c4e3..cab9fad212add 100644
> > --- a/drivers/pci/controller/dwc/pci-keystone.c
> > +++ b/drivers/pci/controller/dwc/pci-keystone.c
> [ ... ]
> > @@ -1337,25 +1321,18 @@ static int ks_pcie_probe(struct platform_device *pdev)
> >  	pm_runtime_disable(dev);
> >  	ks_pcie_disable_phy(ks_pcie);
> >
> > -err_link:
> > -	while (--i >= 0 && link[i])
> > -		device_link_del(link[i]);
> > -
> > +err:
> >  	return ret;
> >  }
> >
> >  static void ks_pcie_remove(struct platform_device *pdev)
> >  {
> >  	struct keystone_pcie *ks_pcie = platform_get_drvdata(pdev);
> > -	struct device_link **link = ks_pcie->link;
> > -	int num_lanes = ks_pcie->num_lanes;
> >  	struct device *dev = &pdev->dev;
> >
> >  	pm_runtime_put(dev);
> >  	pm_runtime_disable(dev);
> 
> Similar to the question above, is it possible this asynchronous put causes
> a race when immediately followed by pm_runtime_disable() during removal?
> 
> >  	ks_pcie_disable_phy(ks_pcie);
> > -	while (num_lanes--)
> > -		device_link_del(link[num_lanes]);
> >  }

It seems plausible that the pm_runtime_put() -> pm_runtime_disable()
pattern is ineffective, i.e. one of two things can happen: either
pm_runtime_put() runs to completion by chance, or pm_runtime_disable()
cancels it. However I am not very familiar with the runtime PM API and
its effects, and unless a maintainer tells me to, I would prefer leaving
these code paths alone.

