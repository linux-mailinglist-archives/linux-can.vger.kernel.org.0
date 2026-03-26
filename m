Return-Path: <linux-can+bounces-7252-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KEUkANnoxGkz5AQAu9opvQ
	(envelope-from <linux-can+bounces-7252-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 26 Mar 2026 09:05:45 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DCA0330D77
	for <lists+linux-can@lfdr.de>; Thu, 26 Mar 2026 09:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C85083009F2D
	for <lists+linux-can@lfdr.de>; Thu, 26 Mar 2026 08:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D904B35AC28;
	Thu, 26 Mar 2026 08:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iyUCviFq"
X-Original-To: linux-can@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013036.outbound.protection.outlook.com [52.101.83.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65B234AAF7;
	Thu, 26 Mar 2026 08:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774512295; cv=fail; b=ndk8PqVSRCCEhOSieNqvnDAfMtbCZdNj+LwZQuLU3iPBBQazT3baHwaLU2NMNfkJhOE6Ou0lsBMYRUyzEaXXkJbCzA7549RILh+NUgfT2rD6FI7P2lD2LmCFJJIhMkB16E3d5S3aoOtmxsgzPMV7KV7GjPt/aE45gc81X3QhcYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774512295; c=relaxed/simple;
	bh=F4XpqD51Wf4pWGBzQiM99GW+7aePCBC59Buaz4ZpDvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=msqN/GxCAGQ/aTtqEvZ0qMO14qzXdyD46deEbEa0Vnx5iOES6sr9Ygr3WOp8uZutXkgZvi9e4pAPYuaTvn0GMMxTdYhxwoEsVguscGuBkLq2NHhRBP+PJk45UZ7j53iaplcdIR3maHxPy5ZW21bjRZs5AfgMoe1vf73Jo9uqyN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iyUCviFq; arc=fail smtp.client-ip=52.101.83.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tEwGtr5YchncayJaMQPC0Lp4aqCG981bo/8wsk29E1FeTB9y5+YYSv0W3CHIW/AejncLBQZ3LeTm3PM//0fVLOmgVbk5mSaEQAVblKjgn0Kg6TtL5GwcPfaJXyfoj6oMbrqvPy9snD9V1Zxq3GCDpiiXEjfETNZWlfDbGm5rI/4b1u+HW97z0gXOqX3qgFNT9/FOF8ixa44pBPmT7Lrmt3xT06dPDsw/rcUuHWUG7DQ1Cf/2IfLe9TonoREVkpXrr9vmoRfbzB0nMHcb4r/BofNFo37HjHDeEd38oPiU0R+dKhf+6mHcuPl5g88wLc8AGCWqcQdpEdty8RF1hAWkTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tRjT+jRvfqfKANEGJaIAZo2o38IyIaEZvfeg1A7/QFw=;
 b=xz5ZJcwWYxHaskKNvx3L+tYJLEiyXI+0F7ZJVLSB3U2jHCsfEAjNqicZCzDOZpgvy+mYr5o38nwM8cVTHNO4Rilpz6QG436wYOl5FnvpZaG4ddWOEbOZ4WnJdPmLNigzDleuKTlDABIiOs3R4Lqo0t2NwS92E3AaBwkdLwYx1t/fbCB2DVilzT6gIRGeZ82+KzmD9WeSwWUt3ZGD1VO/l8ljaAQVsKnGUVUlpgeBrj+AlH48eDY9eTK6Z9PVfd7yrz6UR+YVdpwhakx4W9a6PnHo8AdxDW7ehnxezXXAd52UA+yVIQtSqhAs7M7+Yz2Xd05ChMtehx859AOFYJQUgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tRjT+jRvfqfKANEGJaIAZo2o38IyIaEZvfeg1A7/QFw=;
 b=iyUCviFqDrHn1EoAkK0LME37U+93AQfn18XinVq2CjZpIHXxo//uOK10GqHvrF2McUrpL9oaKUzAJ2qfPt0PpPHgAlES1UeftKiaY+XDjr4ER75sMWRU361IUDLn2PlZOuGHQ2/oYa/VMJ55WvTBN1X7leLFfz1jfPJopSKznx8sfcmJ2Oe6Ooni7dabl2IyWOFfAcyumNdSth1QxoErnIcbwm4ulzre4urg4DoomIGkixY0FPr8bmpv+DCTp+52dWpWOrU3o8bzW0103jCQdf17B6f3TZ1gJFkIP+p3Y2cFORM6nZmGqg5/YbXK17/2ot+w6jOgfLppMdIxpKzlyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AS8PR04MB7814.eurprd04.prod.outlook.com (2603:10a6:20b:2a1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.22; Thu, 26 Mar
 2026 08:04:49 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9723.030; Thu, 26 Mar 2026
 08:04:49 +0000
Date: Thu, 26 Mar 2026 10:04:44 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-phy@lists.infradead.org, Vinod Koul <vkoul@kernel.org>,
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
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Nitin Rawat <quic_nitirawa@quicinc.com>
Subject: Re: [PATCH v5 phy-next 10/27] scsi: ufs: qcom: keep parallel track
 of PHY power state
Message-ID: <20260326080444.gbesciaa5zwvcgoy@skbuf>
References: <20260319223241.1351137-1-vladimir.oltean@nxp.com>
 <20260319223241.1351137-11-vladimir.oltean@nxp.com>
 <ezrcjjwtg5n76w4m65l27szu5mywx66ti3xuprkfcp3x6quvbf@2rew4zrnnbt2>
 <20260325114309.3k7xkfrffpxp5xq4@skbuf>
 <vu3cxpynr5mu2fzkrtmjcwijc5jz323wlnbc3r7lp2wxqmhydx@z5xhgf4myw2d>
 <20260325115731.genmq2yew2p4dvbs@skbuf>
Content-Type: multipart/mixed; boundary="a4enwsgxq6r6cc7o"
Content-Disposition: inline
In-Reply-To: <20260325115731.genmq2yew2p4dvbs@skbuf>
X-ClientProxiedBy: BE1P281CA0439.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:81::23) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AS8PR04MB7814:EE_
X-MS-Office365-Filtering-Correlation-Id: f840a32e-0df4-4f58-6577-08de8b0e5990
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|376014|6049299003|7416014|366016|10070799003|4053099003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	csCUPcolJzm+0VI37kbpSWVm9QYVUJBx0CDMAVqQpFeDrUKpYUJIdKR9yMB2CaUlZ7WqhSSEqWCmnhoP9ifdnHsS2V5QUl46e8UsbbdFm7QYY8pIUjnAIbzhYzVzcvYwLqwpvc2Y4lHd+w5T/ney5w92NEVsKPTqhNJn1HSWjRA58MJ9JE2J+a4iRRiIJ+ru5AY/J0QnLZv7wEAkkxslisWp3uVH8DMyK1fhr63jNCvmYVUW3tsGzN14f7GDNPm8lMaa24zRoXxLKoMfx0L1iHNa/8O81lziG3phwHeeWA+r2139NlYrqNZjk3EdMEHUN2stWAaija3ZnFHAhhfDti5z3v6g2DZpy1b8noOROIDsUgM5XFRjBH4UkIfZIKsf+9M7eW2gIVhl5JswleBjz8R1N3GAARZfID10WgiAAmRhGDPZ5tg+0HDhuWrOJOEqKxtDPuDoRtzIjGz26o6qVCBfygCauy5lkLtz28uHEEPsZ72Lr5egG6QH6P/R7YKRWN+XApU9tbq1RMU1lgUhfS4BV2PdYfgGlFzjUfwmREs4R/P6nBy2M1LvdPnmJCm6sBkrEBg2HepaXushYxJzA7IHzap4UdQ1rIU867H8sLk3xsABMTzCX0IKCQKWwNfgu3pgiWeuVQMFGQKzDQBGnJrhWox0RLMKaC9HA0Dwx7EkzrzCWOKdLKGInZ6sT6iRilXj/moeHVf4i/djOap1tSTmCzxdFRLkf9zNXJswwm/PKiQL0CHEIfdQXTjzWXsI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(6049299003)(7416014)(366016)(10070799003)(4053099003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vC+6/uYwZTIckYbcixpzKytcO6Cw4nDldrniCapqlP3sZd4vkfJ8kCoJpWvA?=
 =?us-ascii?Q?7eliQTgzeuU3UhyG16F7vTHzDNnLFxKespsbzZ8l9ON+6eZsCI8IJzqkhJPG?=
 =?us-ascii?Q?J18+/AZqtN/xF+EoJ2iXTD4iDelWxvLHyx8GM1hxT0ezdUlSl5OUeCP5/Uqc?=
 =?us-ascii?Q?sXbZH4ZN45dGe/s/eV3ZYGJn2nQt73uQiJB14aKbBWG63mIZH4b6GKRRMros?=
 =?us-ascii?Q?K5pAhoa79w3W+lSN/V91Exs3hHJZ5QQs8zP1jZ3zhRqI3rktc/AhzTHDzcBV?=
 =?us-ascii?Q?uHh3JBnDJbSEA9tR4pi7xBChG/vuuOs7tx4EGAqc2GAmSIDuYeOdV24nNLoy?=
 =?us-ascii?Q?NxZfwtI6u+C8WOZ5HehJAGqcoxh2vc23ZI+VfhsWHbVhgkXPfYAZKJtjz+za?=
 =?us-ascii?Q?PPusfoI7ZP+FFjZWo9TVTKJWc5z4diBi9unZnTStbA/8KV9XkScZ/KA4FYgi?=
 =?us-ascii?Q?wg5/siKcqcJSB4xqlRHaVA67JDHSfZDDyey/CvXaBedKoIN7WDqBeTFtwonT?=
 =?us-ascii?Q?WnM7DdtfGdlD9XdNEBRTLfq7wOL7Wvwt7SVLVkJlETKzxlU9F9ZzyQotdc81?=
 =?us-ascii?Q?MnTyW6xhUGODXoRG3d4NCjCHMAwu4qg83GwYRG94SPoXNM1kOFzEBFO3F0TK?=
 =?us-ascii?Q?bKc849HdebFi609wiUmFO20c6wjE2coPn3+04c2vY+Qag+ONg78PrM0MEzK+?=
 =?us-ascii?Q?kzXXT6rIhj7d0W0kYQvPBwIAUFfm85+dXr7Jf5HnQnG8kbc+fYwOI9UH0iEC?=
 =?us-ascii?Q?dAi1dSazmAn8FLxumeZ0BgNZovV2qhT+hdbzu5VOX5I/wpIc5WX9//3Ijl3E?=
 =?us-ascii?Q?CIAmReS3BmYWsxBoSZO/LhUoGXjaKH3RIT1l3dNcweWr6LNzYXcHA6mV/mwZ?=
 =?us-ascii?Q?fNSTIAs82FtUgM6z9mEKuZl3TozBawFzR9Ytl4RNMJmfaMFUQ2Rqe1b/iHfe?=
 =?us-ascii?Q?xj6sdrj6lX74m9V+WF2o9L9d2QcP+E4+AMr1oAF84FkYtvgv0fID6wAnsjUi?=
 =?us-ascii?Q?5RPOvk/KRDRmsRFl4M69/Y388DHlTBs/Hg+Mz89LwmvYPBwxY4ss5EzgyWyH?=
 =?us-ascii?Q?9OR0weBe36UdkU20LezVDOVw1Q66ly4ErhS686CyhrJRivf7ndsoUK9wtLOp?=
 =?us-ascii?Q?sEzA4gem4WUXjG0rFKMjWRWhFVAeYoSDAVst0ZmbafDT3Il3Z7a1NDeKLIpo?=
 =?us-ascii?Q?jJhzPQGrgl8TowUdMzO0c8afBx+JQ9G38Jc+bCgAKhUlHpnnqTPcA2XGxayJ?=
 =?us-ascii?Q?ufdLdvvtTGtrGT06Zae9/wrJ1vJJLAoh1Y7BdXQ2bnNS8h8N7l1M3kD6JXGc?=
 =?us-ascii?Q?s3tJQorVvFa4zKKNBrTyik2nDapb2cD5ijde4QBRGh9r1dljFMx6ZrGbVn5f?=
 =?us-ascii?Q?XPMDpu6rJMSz55TRGyQ4ZvTeN9PzbOSax6NwyY9Ppw0S0S7rPoJMgeKh5bDR?=
 =?us-ascii?Q?K5gTTjalyMw31pSr/41zbQXsvOaSkrpDSYXvHDkf5ZBAX5EjptCC7EW57Y/O?=
 =?us-ascii?Q?11oeAszzSKuNBnRWEHHJ/G16YJYXF8PzGwafsnCobc8hYWP/Sy2jGMkB/8k7?=
 =?us-ascii?Q?U8Oo/yhaIXiykeyetmrLRWRV3fASPAGZOQQGshiQfG+ykci4FzNA7aI9U+Rn?=
 =?us-ascii?Q?0UkhfC9n2I2YGYtPG0ZCApRC3Otf0mAjhlNgWUqvShezS/52cizXsRpIl67a?=
 =?us-ascii?Q?Oe5LrEP5Tj1d+ESwC1sH1D2WY+sc7j6BH7tRFRqp6SNDpU4tD5nETQiK6Hni?=
 =?us-ascii?Q?MvUMwUPPkENaTv8WTQRAmY4H58GPbTqZbqdMglstCfRxMYpgJUmNyZy9Zdkx?=
X-MS-Exchange-AntiSpam-MessageData-1: /UHHYE7DwLCbITtqgENAjqpRpb8fCd9brn4=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f840a32e-0df4-4f58-6577-08de8b0e5990
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 08:04:49.4753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uOz1ZusyfzkmEXJ0GnhbBLPbvhvxHCGZsOlerWGNMMrnIipBUcghnCjMG44S4+eE5YuDkPONEXfm5uwZOvZxQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7814
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-diff];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7252-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-can];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,hansenpartnership.com:email,oracle.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0DCA0330D77
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--a4enwsgxq6r6cc7o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 25, 2026 at 01:57:31PM +0200, Vladimir Oltean wrote:
> On Wed, Mar 25, 2026 at 05:21:14PM +0530, Manivannan Sadhasivam wrote:
> > I believe I added the power_count check for phy_exit(). But since that got
> > moved, the check becomes no longer necessary.
> 
> FYI, the power_count keeps track of the balance of phy_power_on() and
> phy_power_off() calls, whereas it is the init_count keeps track of
> phy_init() and phy_exit() calls. They are only related to the extent
> that you must respect the phy_init() -> phy_power_on() -> phy_power_off()
> -> phy_exit() sequence. But in any case, both should be considered
> PHY-internal fields. The "Order of API calls" section from
> Documentation/driver-api/phy/phy.rst mentions the order that I just
> described above, and consumers should just ensure they follow that.

Ok, so we can close this topic of "checking the power_count not needed"
by linking to the conversation which spun off here:
https://lore.kernel.org/lkml/20260325120122.265973-1-manivannan.sadhasivam@oss.qualcomm.com/

Mani, I spent some more time to figure out what's really going on with
this unexpected phy_power_off() call. Do you think you could
regression-test the patch attached?

Thanks!

--a4enwsgxq6r6cc7o
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-scsi-ufs-qcom-don-t-call-phy_power_on-before-phy_ini.patch"

From 50dfff3541566eb094e931bd56c80011f29b9817 Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Thu, 26 Mar 2026 10:01:55 +0200
Subject: [PATCH] scsi: ufs: qcom: don't call phy_power_on() before phy_init()

The Qualcomm UFS host controller driver violates the Generic PHY API
expectation, documented in section "Order of API calls" from
Documentation/driver-api/phy/phy.rst, and then tries to hide it.

The expectation is that calls must be made in the phy_init() ->
phy_power_on() -> phy_power_off() -> phy_exit() sequence.

What we actually have is:

ufshcd_init()
-> ufshcd_hba_init()
   -> ufshcd_setup_clocks(hba, true)
      -> ufshcd_vops_setup_clocks(hba, true, POST_CHANGE)
         -> ufs_qcom_setup_clocks(hba, true, POST_CHANGE)
            -> phy_power_on(phy)
   -> ufshcd_variant_hba_init()
      -> ufs_qcom_init()
         -> ufs_qcom_setup_clocks(hba, true, POST_CHANGE)
            -> phy_power_on(phy)
-> ufshcd_hba_enable()
   -> ufshcd_vops_hce_enable_notify()
      -> ufs_qcom_hce_enable_notify()
         -> ufs_qcom_power_up_sequence()
            -> if (phy->power_count) phy_power_off(phy)
            -> phy_init(phy)

This "works" because the way that the "phy_power_on was called before
phy_init\n" condition is detected in phy-core.c is if the power_count is
positive at the phy_init() call time.

By having that "if (phy->power_count) phy_power_off(phy)" logic, the
ufs-qcom.c technically sidesteps the test, but actually violates the
Generic PHY API even more (calls phy_power_on() *and* phy_power_off()
before phy_init()).

The reason why I stumbled upon this was that I was trying to remove
dereferences of phy->power_count from drivers. This is a PHY-internal
field, and using it from drivers is highly likely to be incorrect, as
this case showcases rather well.

As commit 77d2fa54a945 ("scsi: ufs: qcom : Refactor phy_power_on/off
calls") shows, this driver tries to couple the PHY power state with the
HBA clocks, for power saving reasons. I won't try to change that, I will
just move the phy_init() call earlier, to ufs_qcom_init().

After the phy_init() movement, ufs_qcom_power_up_sequence() should no
longer need to do either phy_init() nor the conditional phy_power_down().

Because the UFS variant operations are not balanced, but the PHY API
calls need to be, create wrappers for all Generic PHY API calls, and
keep a "phy_initialized" and a "phy_powered_on" boolean, so that we call
these only once, and they properly get paired with their phy_exit()/
phy_power_off() counterparts rather than leave the phy->init_count and
phy->power_count elevated.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Nitin Rawat <quic_nitirawa@quicinc.com>

v5->v6: rewrite after actually understanding the core issue
v4->v5: patch is new
---
 drivers/ufs/host/ufs-qcom.c | 104 ++++++++++++++++++++++++++----------
 drivers/ufs/host/ufs-qcom.h |   2 +
 2 files changed, 79 insertions(+), 27 deletions(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 375fd24ba458..ed067247d72a 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -485,11 +485,70 @@ static u32 ufs_qcom_get_hs_gear(struct ufs_hba *hba)
 	return UFS_HS_G3;
 }
 
+static int ufs_qcom_phy_init(struct ufs_qcom_host *host)
+{
+	struct phy *phy = host->generic_phy;
+	int err;
+
+	if (host->phy_initialized)
+		return 0;
+
+	err = phy_init(phy);
+	if (err)
+		return err;
+
+	host->phy_initialized = true;
+
+	return 0;
+}
+
+static void ufs_qcom_phy_exit(struct ufs_qcom_host *host)
+{
+	if (host->phy_initialized) {
+		phy_exit(host->generic_phy);
+		host->phy_initialized = false;
+	}
+}
+
+static int ufs_qcom_phy_power_on(struct ufs_qcom_host *host)
+{
+	int err;
+
+	if (host->phy_powered_on)
+		return 0;
+
+	err = phy_power_on(host->generic_phy);
+	if (err)
+		return err;
+
+	host->phy_powered_on = true;
+
+	return 0;
+}
+
+static int ufs_qcom_phy_set_gear(struct ufs_qcom_host *host,
+				 enum phy_mode mode)
+{
+	return phy_set_mode_ext(host->generic_phy, mode, host->phy_gear);
+}
+
+static int ufs_qcom_phy_calibrate(struct ufs_qcom_host *host)
+{
+	return phy_calibrate(host->generic_phy);
+}
+
+static void ufs_qcom_phy_power_off(struct ufs_qcom_host *host)
+{
+	if (host->phy_powered_on) {
+		phy_power_off(host->generic_phy);
+		host->phy_powered_on = false;
+	}
+}
+
 static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
 {
 	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
 	struct ufs_host_params *host_params = &host->host_params;
-	struct phy *phy = host->generic_phy;
 	enum phy_mode mode;
 	int ret;
 
@@ -508,31 +567,22 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
 	if (ret)
 		return ret;
 
-	if (phy->power_count)
-		phy_power_off(phy);
-
-
-	/* phy initialization - calibrate the phy */
-	ret = phy_init(phy);
+	ret = ufs_qcom_phy_set_gear(host, mode);
 	if (ret) {
-		dev_err(hba->dev, "%s: phy init failed, ret = %d\n",
+		dev_err(hba->dev, "%s: phy_set_mode_ext() failed, ret = %d\n",
 			__func__, ret);
-		return ret;
-	}
-
-	ret = phy_set_mode_ext(phy, mode, host->phy_gear);
-	if (ret)
 		goto out_disable_phy;
+	}
 
 	/* power on phy - start serdes and phy's power and clocks */
-	ret = phy_power_on(phy);
+	ret = ufs_qcom_phy_power_on(host);
 	if (ret) {
 		dev_err(hba->dev, "%s: phy power on failed, ret = %d\n",
 			__func__, ret);
 		goto out_disable_phy;
 	}
 
-	ret = phy_calibrate(phy);
+	ret = ufs_qcom_phy_calibrate(host);
 	if (ret) {
 		dev_err(hba->dev, "Failed to calibrate PHY: %d\n", ret);
 		goto out_disable_phy;
@@ -543,7 +593,7 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
 	return 0;
 
 out_disable_phy:
-	phy_exit(phy);
+	ufs_qcom_phy_power_off(host);
 
 	return ret;
 }
@@ -1233,7 +1283,6 @@ static int ufs_qcom_setup_clocks(struct ufs_hba *hba, bool on,
 				 enum ufs_notify_change_status status)
 {
 	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
-	struct phy *phy;
 	int err;
 
 	/*
@@ -1244,8 +1293,6 @@ static int ufs_qcom_setup_clocks(struct ufs_hba *hba, bool on,
 	if (!host)
 		return 0;
 
-	phy = host->generic_phy;
-
 	switch (status) {
 	case PRE_CHANGE:
 		if (on) {
@@ -1263,16 +1310,12 @@ static int ufs_qcom_setup_clocks(struct ufs_hba *hba, bool on,
 				ufs_qcom_dev_ref_clk_ctrl(host, false);
 			}
 
-			err = phy_power_off(phy);
-			if (err) {
-				dev_err(hba->dev, "phy power off failed, ret=%d\n", err);
-				return err;
-			}
+			ufs_qcom_phy_power_off(host);
 		}
 		break;
 	case POST_CHANGE:
 		if (on) {
-			err = phy_power_on(phy);
+			err = ufs_qcom_phy_power_on(host);
 			if (err) {
 				dev_err(hba->dev, "phy power on failed, ret = %d\n", err);
 				return err;
@@ -1441,6 +1484,13 @@ static int ufs_qcom_init(struct ufs_hba *hba)
 	if (err)
 		goto out_variant_clear;
 
+	err = ufs_qcom_phy_init(host);
+	if (err) {
+		dev_err(hba->dev, "%s: phy_init failed, ret = %d\n",
+			__func__, err);
+		goto out_variant_clear;
+	}
+
 	ufs_qcom_setup_clocks(hba, true, POST_CHANGE);
 
 	ufs_qcom_get_default_testbus_cfg(host);
@@ -1466,8 +1516,8 @@ static void ufs_qcom_exit(struct ufs_hba *hba)
 	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
 
 	ufs_qcom_disable_lane_clks(host);
-	phy_power_off(host->generic_phy);
-	phy_exit(host->generic_phy);
+	ufs_qcom_phy_power_off(host);
+	ufs_qcom_phy_exit(host);
 }
 
 static int ufs_qcom_fw_managed_init(struct ufs_hba *hba)
diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
index 1111ab34da01..33b1b1521916 100644
--- a/drivers/ufs/host/ufs-qcom.h
+++ b/drivers/ufs/host/ufs-qcom.h
@@ -282,6 +282,8 @@ struct ufs_qcom_host {
 	struct clk_bulk_data *clks;
 	u32 num_clks;
 	bool is_lane_clks_enabled;
+	bool phy_initialized;
+	bool phy_powered_on;
 
 	struct icc_path *icc_ddr;
 	struct icc_path *icc_cpu;
-- 
2.34.1


--a4enwsgxq6r6cc7o--

