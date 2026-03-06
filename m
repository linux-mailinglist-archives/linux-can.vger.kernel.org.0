Return-Path: <linux-can+bounces-6970-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MD3NG3Rqmn3XQEAu9opvQ
	(envelope-from <linux-can+bounces-6970-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 06 Mar 2026 14:06:53 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB0C2215BE
	for <lists+linux-can@lfdr.de>; Fri, 06 Mar 2026 14:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9629530168A6
	for <lists+linux-can@lfdr.de>; Fri,  6 Mar 2026 13:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A51625A655;
	Fri,  6 Mar 2026 13:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="N+M+CvFV"
X-Original-To: linux-can@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010017.outbound.protection.outlook.com [52.101.84.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263CC1F4181;
	Fri,  6 Mar 2026 13:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772802409; cv=fail; b=Wa7odwtzRuwodRHE7EDocnmiadmDIXf4CEsuu6n/8KvD1+AzkyVlLcNqestPXBsLAhyeKBzOK9Gi2RKpufrlL7KJm186MMJ1EBD/NC3hl7H0hRdw3tELYH8TwDQmRvnsUMyc0YtLICoUxfVEa/3GtVkNA/g5EdpOKlkUAl1njA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772802409; c=relaxed/simple;
	bh=DFHpS8wrGLwTtJB6ZrpmYiVGI0vRRP9QoX83ZxZYhDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SE73XB/JTY9JHzCAa678BdlH+GcOHpTfFlDoYcDulBO0oz9B6lDqw5ODkjtNoyBCdAkxjpmbB6OQD1mf4ytkERh/woDtux6qi0DkuUqgXkYwGQ1uo9byqH3rg7/1NJQ2j+l0iMzTMB1VnVR5BSk7wIpYkzoVy0XGGZDvjcnLzQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=N+M+CvFV; arc=fail smtp.client-ip=52.101.84.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BUufr0a2CxWroACoC0VGpBjaGzg6zlFWBsUeGHPLpeN+/Ho7RJzFPz2Exvt3Y8Edp38v6BsUcSmfVtFtEXTiAPo07/vLRvejTWRiUgpF37L/59b66trBsZMCSebH9VrDqYKLA6p2j1K2Mh5U8G5+jHntUhKkICwEv/8gIcpC7TpDxwoisDXCFW3dlHbS2frKq14jttAOC/CYBzjwH982ayQ8Yzrdk0MtsaYkUYQJYp2HV4Aj+1aYcVhBQMD+HThn8LUPBT+FDYs7b5aRRvXHmHdTMKLu27yHCXMxHFTFqHDYdAPZ5d65WqGY1RtFCxZ3mOjmzecDWer+nhjExyXZkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y3Wm86uYlGdv4LY1I/C5jtWegO/XTbwWQa3y/jTLQ48=;
 b=Gca2JibTiouhRv6YhzEjxY4GUH4+A2wMMOS+qvnMfEc4FY+cbJH10aFPaNOUeaKksGgUbIm1ZNLyPWGhChB9eeyccBIUS4iAe55W0gg2xbs7KCL7eeFXHzyCKDWq915RCzvDHSlTSefkZKx7OqTc6oxe7BXwHThFRJU5Pyejh57X7ybKMbG1Bgyubsyj9KhXTmzNX6v7UXYjRdJF0vlOlKW6wkzoyLZt9+3hvGxs409NFnJMy8rUuN+4J1VAp4ilMX/25XeJQJbH6jLs2oHpeJ4GBFwBMmay4c39IWrSpTKZZCkYQ3YNBySSsu2IlrY6fq8ha6OA9UJ/nfiZ57bxFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3Wm86uYlGdv4LY1I/C5jtWegO/XTbwWQa3y/jTLQ48=;
 b=N+M+CvFVUnvVFZQel/sy1TYU6MRYacg1H5PZboUIA3ZMgjoeal+G/uDtWM62Atx/a2ebIGRD8FTDN91KMubyojepsKbQnxSrach7i63R4ioXBg+2nkrC8h7eYE6C/hlUQi9IQeH7k4GM/vQvCPIfYdEYzvOOVxmEczPTITy2AuXcxktxHgncMMt2gJ9E6cM2fVyC2j8oNEesNOND0stbzsyUrjmW9XUOFurhBZF4BXhOLn1oGWIpesOw+52mHPcAgXdFvGglFp7XR6JY1aOBVI4o50ZMRWA37NNLPXXYlaRyTv+DHh/Ye4n/TKNRk72t8OabV/4vA9EJeiCKnMc3wg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by VI0PR04MB10853.eurprd04.prod.outlook.com (2603:10a6:800:26c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Fri, 6 Mar
 2026 13:06:42 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9678.017; Fri, 6 Mar 2026
 13:06:42 +0000
Date: Fri, 6 Mar 2026 15:06:39 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-phy@lists.infradead.org, Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-can@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, spacemit@lists.linux.dev,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH phy-next 20/22] phy: include PHY provider header
Message-ID: <20260306130639.ae2d2aqcqambnta6@skbuf>
References: <20260304175735.2660419-1-vladimir.oltean@nxp.com>
 <20260304175735.2660419-21-vladimir.oltean@nxp.com>
 <20260304175735.2660419-1-vladimir.oltean@nxp.com>
 <20260304175735.2660419-21-vladimir.oltean@nxp.com>
 <7b44322a-5ec9-860e-6698-bbdc62b9a292@rock-chips.com>
 <7b44322a-5ec9-860e-6698-bbdc62b9a292@rock-chips.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b44322a-5ec9-860e-6698-bbdc62b9a292@rock-chips.com>
 <7b44322a-5ec9-860e-6698-bbdc62b9a292@rock-chips.com>
X-ClientProxiedBy: BE1P281CA0250.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8b::17) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|VI0PR04MB10853:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b5fb674-c7f8-4402-55ad-08de7b813625
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|10070799003|1800799024|19092799006|7053199007;
X-Microsoft-Antispam-Message-Info:
	LyEnsBSXm1a7qJFsrROgPhByZ2ZLoO/030b524ANNAbRvOI4WLMBuV8vzikOa8hUqSTLNVvVU97DpV2dsMySUCi2PSIwUR2gFnWE0YLOvaM87PJl51BWj1TvgFMQd2KprqhoSlHDERuTYuXn1IkCVuIzViXeaUbUX4ATu+8FpvdqyZSsI9u2K6XnSd2+iNRUotch6Ot9c32NFGvEPCXl8v1T9+iHWeVLsIVzYIR8LbtAv4JZv7pVLIqB5uxfzst9uGE8Kb0H4QpcHoCd48rUWZ6Uv9K3eoVfaDj1IYbv0kOxdQTUnTmOCmhYf3U0TX9ndyU10CnrUmFKdbfujwIAKSwCBrbty66bFdxT1uzXOJHnjto1Eo+dQnvxVhi4Kd8rmGRPc2rduzmQ8+i9iIYBM0w80CquE3FyW3UsVQE132uspdcc2OUq7oGQhOKDl96TSa1j4eIKHTr28koksE3XHOz/odln8J6551VZC9tCLGtPbxZllfFeIWFDKCbYZdTu8GuGocaAZgSF+1KP+sleiBKZFBkeNu/4a9BZNlI3GghUSlB0wPnrM1Sgm5h7nh4xDQPyuSrFgtD6n8hCDV/5hftsS4BacIQsO3tDOYskacnET4kseFD1omtRP52/P2mV57KtFcRSV3jtTmGoC5r/vb/KUyJ8q6CbEqaN1GxOO912RHatSS1zLLdgGICdA45SwIG5iRDD9ey8hcmrNw78B3vyfPippZDsASSzm8LhVpA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(10070799003)(1800799024)(19092799006)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FvDsrmLcpE/S3YUr29BmnCra7Co7/teURt0RuScml/44oIOM8yeuFpqcGZCk?=
 =?us-ascii?Q?F04C2VlVDyqfXQ5c2889PqVw3WxIoe0K4znukd5b57zF5J9AyqEZChcHGHai?=
 =?us-ascii?Q?XIDdt1A0JlgRCf4WlrkHEhJQ+79lriMzI6NjbPzUM46UUrjxViSlnk8KhUT+?=
 =?us-ascii?Q?exBzbJ1TBP3bNwXL7oO9oU5MGJba7FS9iGm0BSAXCl64eDdkEM7zeRRWOwAS?=
 =?us-ascii?Q?2EcMDbj9s0I0VRQ9SKBK2JSxVECLwIC+SK34xImQyMyfdmtqdqk4oO9+DOcY?=
 =?us-ascii?Q?H+e7ru/BY43j4Yrh8AnjE1R5DtdZleJFnEhDizATfJ6ybaIp8DWMd84DzlZ3?=
 =?us-ascii?Q?qBJQrCSL7huoSWwwWqpiUhRrcaTSdg3jOYPibCnChDI4vzftUk9wxl9gAz5P?=
 =?us-ascii?Q?VKwWSC3K1aVlDMfPqhto/zwNJ3tRUh2i5E48FhU8U8Tw8WAcsdaip/mBeONr?=
 =?us-ascii?Q?8b2HFUdYglirJu84dZB8dbNBStl3DWsKWuL9hk7aBINHJFKSO1Gapjg61ouK?=
 =?us-ascii?Q?9vQql/iUm1Xxo/12kPu0le+AWubOgpedJf43AsUcSHTGt2WHwZuPMPqgb2PI?=
 =?us-ascii?Q?fCLeOgEs6Sc8piWzvJ79qqEKmKz/fcQEPqU1jPuF/GEKuaXqUn8olGJeqFlG?=
 =?us-ascii?Q?ytxEuCkkiulta4JSK7oowtLltlTjvxdVK9pHBG1gNBq8UliPo/ab3Fnlh6si?=
 =?us-ascii?Q?4WwBwfBOS9h0AbBSo9A0WKfm2kWim6xipOlSSBz38JnCmhkldWroPEchqgso?=
 =?us-ascii?Q?eKI6xGEJEZu4oelhKVjc9k3JCxMJ3/os78BO/h1QNH4Gv27Y7gRKhHSlqVMB?=
 =?us-ascii?Q?QqJOCNGM6XfPkehkxaVeVK77NDpDPzC1n9Ofnsx/8/fYlgN7tWr60aq4ZkqL?=
 =?us-ascii?Q?lkG+kfFDyOFZzON6WlKEwXQdbRGYN/9yVnUTmvegbxWz33QLDoQRPQRlIwGd?=
 =?us-ascii?Q?KnwpP1/a4KI17g3ohO/ZWKerZebr/e6MOiFB3z+C8k3SsK8TyuEpRTLWSNXs?=
 =?us-ascii?Q?TQccPTTr9RDlBMbpxRvGWImecQHT9RTvdcQv7lXCK1Iwl00VZ0msEFj5UCRX?=
 =?us-ascii?Q?Wr3erHN1gT6zC+WFWbGkoBt9B9MoWu+TioV47/5UKiFe35PucgJdsgbCmeaY?=
 =?us-ascii?Q?9P/q+s+7X1xoPFDT1oFhUiFMqtGJ6iViwsXQTT2YvBqXOckHXghncPGs7I2p?=
 =?us-ascii?Q?mtYV6LbGwuvkBP0qtVNrjArwokOPV3alu6LLmDo4MzNQ/fM9tRAeVNw3rC9f?=
 =?us-ascii?Q?ChkIdUjs8EUCNq8+5fYdlgjxOIYwv3cxoNR4zzW7cmbEMtW7BhIr19ydT6E1?=
 =?us-ascii?Q?YSr4IOnzp+xrpMK9h5eLW9kjw38qRyf9Ns7dD5IoKSLKI5UZPPIsUEZBCWXc?=
 =?us-ascii?Q?SNPxD/aPrn3X+Qp3FBHkqIq1n9Et12t5hfluglfsOXFiYKuSXfMcEX632b4U?=
 =?us-ascii?Q?IuyR/XoCKCceeV8RRvumWO/xc4DPS6tFGCKUCjz2AJL3OrKCprYeh3Fi3CJz?=
 =?us-ascii?Q?YQe69pA6swlLA3F2xK8aX7uhQoUzKMDEqHrNHCiSK175nszO6nh8D1rNMG/Q?=
 =?us-ascii?Q?yTXIvZwLtfdkYruZoN60gObuv26bkSPXIaj2rPTD9z5Vwh5kLGt2cOtUEPd7?=
 =?us-ascii?Q?bT1/EviLVtXhJn6bWu8Bebk+fM1MxOrD5dOO0vVExtt55MbRp5YXS0vz285I?=
 =?us-ascii?Q?6tGd0dzsD8ZEvN4qnQhULvzmw97uVVg2G8MwaE2nZ4+yqhK8LXaNM7EJfC0I?=
 =?us-ascii?Q?7WUJpztzTXApIZtVnLWklZsJXIzu9VchVK2zQRt0cXS9JUL+XCZz1p/WB+D/?=
X-MS-Exchange-AntiSpam-MessageData-1: O78bT1dWZ/9JsXGWgO17oYNKauK4gWgfB4Q=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b5fb674-c7f8-4402-55ad-08de7b813625
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 13:06:42.6084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sv6bop/3BCPYVPLa+u3xDqHTp0OZLlyg9fCSuCQPFNITsrYikxZGhRjxhAkbO4BjYlKKlANsd8jBI5BmT8HQ9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10853
X-Rspamd-Queue-Id: 7EB0C2215BE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6970-lists,linux-can=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-can];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,rock-chips.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hi Shawn,

On Thu, Mar 05, 2026 at 11:22:52AM +0800, Shawn Lin wrote:
> For rockchip parts:
> 
> Acked-by: Shawn Lin <shawn.lin@rock-chips.com>

Thank you for the review.

This is a large patch, please trim the quoted portion when replying.
I had to scroll through a lot of text to make sure you didn't have
anything else to say.

I will split this patch up in v2. It's so large that it didn't pass
through the linux-phy mailing list moderation, thus it didn't make it to
patchwork and the incomplete series didn't get build tested.

