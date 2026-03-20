Return-Path: <linux-can+bounces-7199-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gI8qFk4EvWkO5gIAu9opvQ
	(envelope-from <linux-can+bounces-7199-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 20 Mar 2026 09:24:46 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 00FDC2D72BB
	for <lists+linux-can@lfdr.de>; Fri, 20 Mar 2026 09:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45A5E3097A68
	for <lists+linux-can@lfdr.de>; Fri, 20 Mar 2026 08:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82AF371CE6;
	Fri, 20 Mar 2026 08:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Y0bTES89"
X-Original-To: linux-can@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013005.outbound.protection.outlook.com [40.107.159.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5249037188B;
	Fri, 20 Mar 2026 08:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773994967; cv=fail; b=g/Yl6eIzIOVszN4qjAaWx+McNqdBMSy87r3x8oSZJVAU551NJNs2eFilBQWAqOTIOZ+SBbcG3vaHIVSM80sboxO7wmkTD57mJHvzqIX+NWmpdz4bmTN8bfNdze5Uf9Gw4SM6YlM0Rf/rJc3PqtpV5xDFFY24jtPbSlLx5tDyAP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773994967; c=relaxed/simple;
	bh=c9RBJcZsPemyWEqrhhsaMpc/uEampX+Hd+YiAxpWpGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bzBCDvt7QYaCPuJsI2R6gnMTC5DR22o4v/04cepH2CQKtD5hx4YGdyjXgyGNYXJaoszWSvgdAcp796ZtSjle3Rdp6hhy1gwPsznf8NfNiHvMqt2PnrdTs4N4FexrZ4Ars5j+E3tw4Zn3DxS1YDdm5o3SiRYCpqOw+nEs0fdzzeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Y0bTES89; arc=fail smtp.client-ip=40.107.159.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YrELaGUKA5AMczp/z8XngTtQoSA2abxH58PllfABOV229eLx4wvq/R71ITyuf8Si9YFbwWzPSd9KqkH+LF1PFeTi91/FEKVKVohhprbAQrc9u9Q3IL0M95NP/desjTb16+V0AWBePWaN+6yxi3MnDB86ZWuV8jy6BKcQItbbXmEVrGvUKmNBfutZpZfNG4jlKMrRetFdtfu51hLQJMMrMPJdTXzdyZNsLXRSxhy9J0At4C9P1yqVJXonxJ/GU/3xDnu54u4fGNYOnQfWxrXRSXoAI1BFloPu1OE+KZna4ce99u3BZq+jomGlXnDJ1pJkRy5oDsKGNZyVXwko3PPQHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mesJYUtib9nKtwcaJlsnUUlULi/SAVVOAzqcMuQR7HU=;
 b=yWoeXBD9DDBrO/SORhms38l4WM1sHS23GaPvHqDl4eZxDTexbH0mITNOmGB8V/85VXNb9yqvoUtiSMCxTwfeo0C+j50yqnePz/4rI5VAmiGxwMm8LTLQfjimJVWMs1zNeTZnnbdeC4KUDFHtU+BjT8B4wg4y3BjkziEdAUJ0xpydz3ymuUFQWOP+st1D9QC7y8kBfK6ey8tArrlih8VZ+Y/mX8YoWJJ8soprnNW4n/F1L+ZkDL8tVKF0U0Iuee3r3CIGIYDJ24iGMhdl4Fmw3imM7jve9WkzGMe5dYkqj/Qzsa+XSLh8N3ROLw2WKbs/CpSCSTFWGtF5Ic0r2xoRHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mesJYUtib9nKtwcaJlsnUUlULi/SAVVOAzqcMuQR7HU=;
 b=Y0bTES89+uun6WZO1209xWTE5nmT6ngkJ2JSE9PSN+B4pFj+2Tzfo/653kiliIILb9QTzv+IrCpJVH1gJ7Ai1BebVDgmq/o1t+a/BjdD/cXrLlZqNrk1KskcI1lX5PY4YHSCpz6+VeJ5cCO1/ElWA1SOGl2gPgusR2+L97ZJhVMSl45rT8QobYyvwxig8SRQo8fdIeErfFW7HXzMhEPCJRJM4fFLOiCBvDa7m2+UHSFsyP4vsErL3I379KkcrbQjvPESEC/SYOz8SuF428NVjeSZH1YpjYTn/xvoPwuqXo+oYyeGwkTQKUhznbBo3aKAqACMGVNKx5wUb9iqxJglig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AMBPR04MB12334.eurprd04.prod.outlook.com (2603:10a6:20b:732::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.21; Fri, 20 Mar
 2026 08:22:43 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9723.018; Fri, 20 Mar 2026
 08:22:32 +0000
Date: Fri, 20 Mar 2026 10:22:38 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
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
	Bart Van Assche <bvanassche@acm.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Chanho Park <chanho61.park@samsung.com>
Subject: Re: [PATCH v5 phy-next 09/27] scsi: ufs: exynos: stop poking into
 struct phy guts
Message-ID: <20260320082238.mujsvowmf2ue62yu@skbuf>
References: <20260319223241.1351137-1-vladimir.oltean@nxp.com>
 <20260319223241.1351137-10-vladimir.oltean@nxp.com>
 <yq1a4w3l04g.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1a4w3l04g.fsf@ca-mkp.ca.oracle.com>
X-ClientProxiedBy: WA2P291CA0035.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::11) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AMBPR04MB12334:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ea7b023-86d4-46dd-fe20-08de8659d575
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|10070799003|1800799024|19092799006|376014|7416014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
 pkz7kcZdM+jAorJHtSGPO0qJEb94cBi7DqQt5NXq2LXJEzorOLVVjEATJbdzrkDmUviB7Xs/zMX2djYYaOorDypiHD4TrogzACnywH9Vad3K0QrFrkht1quwyNCJqy34g4Fpi3qakvQUBofnmTQwF7LvyJ1Zahn1aZp77ku1i/ikMXa5mAsQPs89XdrOAyO+ZXCAnldp7AzpisrJR5OK/s+Bz0vT0kCVz+VkLYmCm52sHlAk8n0fuUH7v6qXlkV+u5d7+xRvk9U81fPpZlvfIgHR/2GkNre47NYqvzPs3KLoTR46Hkl1rW/SJrZcXgwA3Jw3Z+5aVr1kTOwMNyIka05Lb2eCU92tj/x/xAYCXsRji77zr7HLqm9W95plT6bZ03jEZCVFYqWyzY4IY6ilP0RNhJ+z1qOKdP98vgRZvrjzHFf0DjHXNDX7XHbwHBxvkXKlk1JyPn6XcYCBvIxckCTk6gxVA2jlORtWoCcDQkHq6hoyJC+8Gl2yVSqabC0qcT85Y1V/eDo9ctDcbhXAK3xnwCcZEZKoZmAGmeiSj+9ipLus5G9jVOLyXzv0AwJS7VtZ6QsCKHuzAb5NdNYSzbknK+CtXUn9f/7KEr+k+FAI49TA4nfwPL90fRlLNy0vg1yuKGqCZUGT+HmRk+Hz0qZmXtIBel5OW2DrXApmMryOKFhQ0mf/3scdShljhIgz4G4n2M6Wix09H/+0yOCxlR1pxTFT4oAC7btACwBC5Ab1tR8eEMBH1j5eKujxdw+I
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(19092799006)(376014)(7416014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?GFS32UVMCc13GFvEY6o95RJxCw1BsDwd12hZo1tRFTsoB+puMqF/CKSDR7ro?=
 =?us-ascii?Q?2BXzyrPQqmRdoLMFNaysp8ZP8U1NBQorSuopcqm3fEkry46N0SBiBZB2i3qN?=
 =?us-ascii?Q?eFJdk52WFA/7BA37o/rmdmqtLWecOgNGg8KEMC9QhzX9CJt006l7RPxQvdLQ?=
 =?us-ascii?Q?eJLPvQyfBHqHWNqqQ2CmZqYwtIGCqHIL7oUsvHJqId2sWVRcHQ7ezA43QcvG?=
 =?us-ascii?Q?r0X3jV1iw9AjoMnl19JPcgtsRwO2+RyBbI/MJ9EfwYrWCd82CHpYmeDXqTK9?=
 =?us-ascii?Q?yisUCu6FIpWpKkkbNfJs3qR1/alKyubWgbyoziWSs2IzNx9iFG8vOad4ElHB?=
 =?us-ascii?Q?mGksILRv6ZMKdHxHF/GGmPUXoz+wZ1J0B9Kxix3VvS876LQY1Fi6G3EyV/4m?=
 =?us-ascii?Q?jF4wcmHqXvbgtNeYY/ByE+njLwJEJATtQPi1btcw8P6HzEIaXsM1cLeOXJBH?=
 =?us-ascii?Q?GPyuoW/1rPkBabmfLpugJZ7STo5FnadspL9XLZQTvnhJOcQMvzzXMAmXGMzP?=
 =?us-ascii?Q?b7oU+QCJ9xOWCcK4J+/E1cnqIlS36LvS4bzxaAPq6R1KXlMNwynbTh5Fv11D?=
 =?us-ascii?Q?+6hvbbay3xhF26C9fABe7PeGzFjN6vIXhTqHuRJN5Jpz39Dmh1+zxVytJKnl?=
 =?us-ascii?Q?tAYnjUHTK5blpJjmM9xNofdHcvNKZvui+R5rEY/m/YtSr9iOWiXSlPEnBzel?=
 =?us-ascii?Q?2UjajxLabwyaRzXXuvlxidLD0CUo+wuJhCDa9IBOg+lftRIFoARlqjRQZNwE?=
 =?us-ascii?Q?p1Yb4di9btKR51FND2EuesYk9Xo8sP4PW/qA7pML8qQNFAPGoEARGtxxonNU?=
 =?us-ascii?Q?644IiyljKZFakwAeCWUhZgRcilAUCFL5aJZXXQrHj/NHcRqpkXXXCX4/JAlT?=
 =?us-ascii?Q?bRuQUKaXP+eskFCrr+9IWvtXDecDpLCSx8ap5gh35kpO5ZRedm+pv3Hu4szM?=
 =?us-ascii?Q?dsx06/ww6EB7M4c/H3h25gKmDiJBbv69LXIeASWnv8ClteYLOGjLq7VniGtE?=
 =?us-ascii?Q?j5s82nH2VVzwuNwtdx9O5RYJgE/jxheY6DjXa+f6LUIXFjhdP02mi++dn8jR?=
 =?us-ascii?Q?2tuRJv3UbcIUmDYQbQJkue9UaZT6Y4lAzbWlgK3EXM7e3JRnAnWCp6S4yH0o?=
 =?us-ascii?Q?6maNcLouhJy60ik5YHm5KSu2RfIDE64k3nbl+jsCpo/mVSQBxhx2nrScTux1?=
 =?us-ascii?Q?AE/TTLb+ronEIgCs0tv+sd4q8TjPT39lU9q2P5u+9Jl9i3TlCCmzpEQl94bh?=
 =?us-ascii?Q?TLRXFc2fQslgTF/8i51Of1mhbhDQpAlIE9PpQcYJ4eqV1KQAmkkoaOcR8DIk?=
 =?us-ascii?Q?ZYht6ToTkdm87bRi3vSIYbUZBR2aBBfQjl3TUYrhlR9LJ8sCx5et2D3qJitw?=
 =?us-ascii?Q?O8PpNRzV1nF5TpqAO/diuN4KGWJ4L+wfLc4j/cMnST61k5S6ENdpeDdZt1JD?=
 =?us-ascii?Q?HRhU3HOJGY+nQbebdD/xEcQCHCrsm4adUoxCL5rRjzjHp51ZLm6yLZcPPqm7?=
 =?us-ascii?Q?IiE6Z9XtU//2XlcGLg8Wjzl7jwycwJdOQDiOc5IL2OKYpGi6ju9v54BFdG22?=
 =?us-ascii?Q?Y5ggaV3Ym3fSKrW7u2Wg8HIU41kuTV82BwO9tdrMDf+SwWwxoMThA2TicIg+?=
 =?us-ascii?Q?hhAkr5+gcc9ryC3zmPZh9lySj4DDzT9uGcoAh0KNHGoRG25cMA4+Sfjk7q7E?=
 =?us-ascii?Q?Smbxd+ZVMxk/Xp1+f8J3bHKOlFGub45uo9/y9Ar/tv3YZ7JjDXRceeloq1Mh?=
 =?us-ascii?Q?bDN58JpO43qndaYOjKyev08sgTppYVO+wXWwrqOrbBoowpfwZUjRKW7Yqw+8?=
X-MS-Exchange-AntiSpam-MessageData-1: lFVYL7pCYyUwwSBezvrndy/h+TxIiowhtNU=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ea7b023-86d4-46dd-fe20-08de8659d575
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 08:22:32.6361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d5rPahVXvK+7FABaVi349sVAUQ1hMPPNb+qGKAI52PcEmwPK1ekiNizxzafc5ddT7Q4oOotICuOonYruHcuw+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB12334
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7199-lists,linux-can=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.989];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-can];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:dkim]
X-Rspamd-Queue-Id: 00FDC2D72BB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Martin,

On Thu, Mar 19, 2026 at 10:15:17PM -0400, Martin K. Petersen wrote:
> 
> Vladimir,
> 
> > The Exynos host controller driver is clearly a PHY consumer (gets the
> > ufs->phy using devm_phy_get()), but pokes into the guts of struct phy
> > to get the generic_phy->power_count.
> 
> Ah, newer version. Would still like an ack from Samsung.
> 
> And I hit the wrong key, I did not actually apply this...
> 
> -- 
> Martin K. Petersen

Sorry, due to an error I did not CC you to the cover letter:
https://lore.kernel.org/linux-phy/20260319223241.1351137-1-vladimir.oltean@nxp.com/

In short, the plan is to take the entire set through linux-phy once it
passes build testing.

